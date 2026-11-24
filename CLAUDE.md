# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## What this repo is

Yoe is an Embedded Linux Distribution built on Yocto/OpenEmbedded. This
repository is the **superproject**: it ties together a set of OE layers (git
submodules under `sources/`), project configurations (`conf/projects/`), and
tooling (`envsetup.sh`) so that one build tree can target many machines
(SBCs/SoCs/SOMs). The Yoe-specific recipes, classes, and distro config live in
`sources/meta-yoe`, which is **not** a submodule: its files are tracked directly
in this repository, so changes to it are ordinary superproject commits.

## Environment setup (required before anything)

Everything starts by sourcing `envsetup.sh` with a _project_ name (not a machine
name) in a **bash or zsh** shell:

```bash
. ./envsetup.sh <project>      # e.g. rpi4-64, qemuarm64, jetson-agx-orin-devkit
```

Run `. ./envsetup.sh` with no argument (or `yoe_get_projects`) to list valid
projects — each is a directory under `conf/projects/` containing a
`config.conf`. Sourcing this:

- Sets `PROJECT`, derives `MACHINE` from `conf/projects/$PROJECT/config.conf`,
  exports `OE_BASE`/`BUILDDIR`.
- Generates `build/conf/auto.conf` (DL_DIR, SSTATE_DIR, TMPDIR) and
  `localconfig.sh`.
- Defines all the `yoe_*` shell functions and **shadows
  `bitbake`/`devtool`/`bitbake-layers`/etc. with wrapper functions** (see Docker
  below). Type `yoe_<tab><tab>` to list them.

`git submodule` is **not** run automatically. After cloning or switching
branches, run `yoe_setup` (= `git submodule init && update`) once.

## Common commands

All build commands run _after_ sourcing envsetup. The `bitbake` you call is the
wrapper function in `envsetup.sh`, not a bare binary.

```bash
bitbake yoe-simple-image          # build an image (see image list below)
bitbake <recipe>                  # build a single recipe
bitbake -c <task> <recipe>        # run a specific task, e.g. -c compile, -c devshell
yoe_clean                         # delete build/tmp (TMPDIR)
yoe_build_all                     # build yoe-simple-image for the routinely-tested projects
yoe_install_image /dev/sdX <img>  # write a .wic image to SD/USB (uses bmaptool)
yoe_feed_server                   # bitbake package-index + serve build/tmp/deploy/ipk on :8000
```

Switch target without re-sourcing fully: `export MACHINE=<machine>` then bitbake
— but the canonical way to change targets is to re-source
`. ./envsetup.sh <other-project>`.

Common images (defined in `sources/meta-yoe`): `yoe-simple-image`,
`yoe-kiosk-image`, `yoe-debug-image`, `yoe-qt6-image`, `yoe-sdk-image`,
`yoe-installer-image`, `yoe-swupdate-image`, `yoe-initramfs-image`.

### Docs / markdown linting

Markdown is formatted with prettier and docs are built with mdbook:

```bash
yoe_format          # prettier --write on *.md and docs/**/*.md
yoe_format_check    # prettier --check (this is the doc-check CI gate)
yoe_mdbook          # serve docs locally on :3333
```

### Tests

There is no unit-test suite for this repo. "Testing" means OE image tests
(oeqa). CI builds `yoe-kiosk-image`/`yoe-sdk-image` for `qemuarm64` and runs
testimage. To run an image test locally: set `TEST_TARGET_IP`/`TEST_SERVER_IP`
(see project config.conf), then `bitbake -c testimage <image>`. For oe-selftest,
see the commented `USER_CLASSES`/`PRSERV_HOST` lines in a project config.conf.

## Docker wrapper (important)

`bitbake`, `devtool`, `recipetool`, `bitbake-layers`, etc. are shell functions
that route through `wrapcmd` → `dkr`, running the real command inside the
`yoedistro/yoe-build:trixie-<arch>` container with the source tree bind-mounted.
This keeps host dependencies constant.

- Disable Docker (run natively on the host) by setting `export DOCKER_REPO=none`
  — CI does this. Often set in `local.sh`.
- When running without a TTY (scripts, agents), set `DOCKER_PSEUDO_TTY=no` so
  `dkr` doesn't pass `--tty` to `docker run`, e.g.
  `bash -c 'export DOCKER_PSEUDO_TTY=no; . ./envsetup.sh rpi4-64; bitbake piglit'`.
- `dkr` with no args drops you into an interactive container shell with the
  environment already sourced.

## Configuration model

Config is layered; understand which file owns what before editing:

- **`conf/projects/<project>/config.conf`** — per-target settings: `MACHINE`,
  `DISTRO`, `YOE_PROFILE`, image fstypes, machine-specific tweaks, test IPs.
  Committed; this is what `envsetup.sh` reads and what `conf/site.conf`
  requires.
- **`conf/projects/<project>/layers.conf`** — the `BBLAYERS` list for that
  project (which `sources/*` layers are active). `conf/bblayers.conf` just
  `require`s this based on `$PROJECT`.
- **`conf/site.conf`** — team-wide settings checked into git (e.g.
  `IMG_VERSION`). Can override `YOE_PROFILE`.
- **`conf/local.conf`** — per-machine/user settings (parallelism, SSTATE_DIR) —
  copy from `conf/local.conf.sample`. CI generates it from the sample.
- **`build/conf/auto.conf`** — generated by envsetup; do not edit.
- **`local.sh`** — sourced by envsetup at start; the place for `DOCKER_REPO`,
  `LANG`, target IPs, and other shell-level overrides. Not committed.

`YOE_PROFILE` selects libc/init/windowing as
`yoe-<glibc|musl>-<systemd|sysvinit|busyboxinit>-<wayland|x11|eglfs>`; these
resolve to the `.inc` files in `sources/meta-yoe/conf/distro/`.

To build with another profile (e.g. musl), set `YOE_PROFILE` in `conf/site.conf`
(after its `require` of `config.conf`) and restore the file afterwards. The qemu
projects hard-set it in `conf/projects/qemucommon/config.conf`, which overrides
an exported `YOE_PROFILE`, and `bitbake -R <file>` is read after the distro has
already included the profile, so neither of those works.

Downloads go to `downloads/` (DL_DIR). Large git recipes (glibc, binutils,
webkit) try the slow Yocto premirror first; seed
`downloads/git2/<host.path.repo.git>` with `git clone --bare --mirror <url>`
plus a `.done` file to skip it.

## Layer (submodule) management

Layers are git submodules under `sources/`, pinned by SHA in the superproject —
this is how builds stay reproducible. The recurring `Layer Updates: ...` commits
bump these submodule pointers.

```bash
yoe_add_layer <git-url> [branch]       # git submodule add into sources/ (then add to a project layers.conf)
yoe_remove_layer <layer-name>          # bitbake-layers remove-layer + submodule deinit + git rm
yoe_update_all_submodules_to_master    # checkout master + pull in every submodule
git submodule update --remote          # update each submodule to HEAD of its .gitmodules branch
```

After adding/removing a layer you must also edit the relevant
`conf/projects/*/layers.conf`. Submodules are shallow clones by default —
`git fetch --unshallow` in a submodule for full history.

## KAS (alternative / recommended for new projects)

`envsetup.sh` + submodules is the legacy flow and still fully supported. KAS is
the newer recommended path: configs live in `kas/*.yml`, run via
`kas/kas-container`. See `docs/kas.md`. The two flows are independent ways to
drive the same layers.

## Fixing recipe build failures

Recipe fixes belong in the layer that owns the recipe
(`find sources -path '*recipes*' -name '<pn>*'`), committed inside that
submodule, not in the superproject. The exception is `sources/meta-yoe`, which
is committed in the superproject itself.

- Work dirs are `build/tmp/work/<pkgarch>/<pn>/<pv>/`, with sources in
  `sources/<pn>-<pv>/` and task logs/scripts in `temp/` (`log.do_<task>.<pid>`,
  `run.do_<task>`).
- `temp/run.do_compile` is a standalone shell script with the task's full
  environment. To surface _all_ compile errors at once instead of the first one,
  edit the source tree and run a copy of it with the final `do_compile` call
  replaced by `cmake --build . --target all -- -k 0` (or `make -k`). Then turn
  the fix into a patch and confirm with a real `bitbake <recipe>`.
- Patch files are `git format-patch` style with `Upstream-Status:` (`Pending`,
  then `Submitted [<PR/MR URL>]` once sent) and `Signed-off-by:`, placed in the
  recipe's files dir and added to `SRC_URI`. Check with `git apply --check`
  against pristine upstream source.
- Before writing a patch, check whether upstream `main` already has a fix; if
  so, backport it (`Upstream-Status: Backport [<commit URL>]`).
- Bundled third-party code: some failures are in code copied from another
  project, e.g. Qt testlib's `3rdparty/cycle/cycle_p.h` is FFTW's
  `kernel/cycle.h`. Send the fix to the original project.
- Recurring toolchain breakage: glibc ≥ 2.43 makes
  `strchr`/`strstr`/`memchr`/... return `const` when passed a `const` pointer
  (C23 const-generic, enabled by `_GNU_SOURCE` even under `-std=gnu99`), so
  clang errors with `-Wincompatible-pointer-types-discards-qualifiers`. The fix
  is usually to make the receiving variable `const`.
- Put the reasoning for a fix in the commit message; leave a recipe comment only
  when needed, and keep it to one line.

### Toolchain notes (Yoe builds with clang + lld by default)

- meta-clang was removed (superproject 18b6de66); its old workarounds are
  readable with
  `git -C .git/modules/sources/meta-clang show HEAD:conf/nonclangable.conf`.
  Prefer a real fix over restoring them.
- lld defaults to `--no-undefined-version`. Stale version-script entries fail
  the link: drop or guard them, or add `-Wl,--undefined-version` for that
  recipe. The gnulib `gl_LD_VERSION_SCRIPT` probe (also copied into nettle,
  neon, lldpd, tiff) fails silently under lld, so the library is built
  unversioned; use `--enable-ld-version-script` where it is honored. Detect with
  `readelf -d <lib> | grep VERDEF`.
- clang 23 adds `-Wunused-but-set-global` (in `-Wall`) and fires
  `-Wunused-template` on unused `static` templates in headers. Both usually flag
  real dead code; fix the code or linkage instead of adding `-Wno-`.
- clang folds out-of-range float→integer casts (UB) more aggressively than gcc,
  e.g. `d == (long)d` becomes "is integral". Reproduce with a few-line file and
  the recipe's own `recipe-sysroot-native` clang.
- clang writes `DW_AT_dwo_name` from `-o` without applying `-ffile-prefix-map`,
  so `-gsplit-dwarf` with an absolute `-o` trips the `buildpaths` QA check.
  Compile from the output dir with a relative `-o`.
- Pin kernel-class recipes to gcc with `KERNEL_TOOLCHAIN:pn-X = "gcc"`, not
  `TOOLCHAIN:pn-X`. The latter changes the signature and fails yocto-check-layer
  `test_signatures`.
- `clang-native`'s build-tree `bin/clang-*` loads the host `libclang-cpp.so`;
  set `LD_LIBRARY_PATH=<workdir>/build/lib` when testing a clang patch with it.
- glibc 2.44 `posix_spawn_file_actions_addchdir`: gnulib's probe misses the
  `<spawn.h>` alias and builds a self-recursive replacement (`jmp` to itself),
  which hangs. Set `ac_cv_func_posix_spawn_file_actions_addchdir=yes` in
  `CACHED_CONFIGUREVARS`.
- A build-host link with `-L<target sysroot>/usr/lib` fails only when host and
  target arch match (the target `libm.so` ld script has absolute paths). With
  Rust this happens via `-sys` crates in build-dependencies; keep them out of
  the build-dependency graph.
- When oe-core bumps python3-setuptools, recipes whose `pyproject.toml` caps it
  (`setuptools<X`) fail `do_compile`; patch the cap out
  (`Upstream-Status: Inappropriate [oe-core specific]`).
- CPython with OpenSSL 4 reports `ssl.HAS_TLSv1_2 = False` even though TLS 1.2
  works; gate on `ssl.OPENSSL_VERSION_INFO[0] >= 4` instead.

### Upgrading recipes

- For git recipes, check that `SRCREV` is the tag's commit (the `^{}` line of
  `git ls-remote`, not the annotated tag object) and is on the `branch=`
  (`git merge-base --is-ancestor`). Also re-check `branch=`, `tag=` and any
  `BRANCH` variable. Existing DL_DIR clones hide these mistakes.
- After an upgrade, run `bitbake -c cleanall <pn>` and rebuild, so fetch and
  build start from scratch.

### Debugging ptests

- Look first at `testimage/ptest_log/ptest-runner.log` and the image's
  `temp/log.do_testimage.*`. Per-test results are in
  `build/tmp/log/oeqa/testresults.json` (`ptestresult.rawlogs`). meta-python and
  meta-networking ptest images set `PTEST_EXPECT_FAILURE = "1"`, so testimage
  passes regardless; read TOTAL/FAIL in the runner log.
- qemux86-64 (x86-64-v3) binaries run natively on an AVX2 host: copy the image
  workdir's `rootfs` and run the ptest in `unshare -r -m` + chroot,
  rbind-mounting `/dev` and `/proc` (pytest needs `/dev/null`). It uses the
  image's busybox, so it also catches GNU-only flags in `run-ptest`.
- For kernel- or cgroup-dependent tests, boot the deployed ext4 with
  `qemu-system-x86_64 -enable-kvm ... -drive ...,snapshot=on` and an ssh
  `hostfwd` (use `scp -O`). The qemux86-64 kernel has no `CONFIG_CFS_BANDWIDTH`.
  Reproduce testimage-only timing flakes by loading every host CPU with busy
  loops while looping the test.
- Never `pkill -f`/`pgrep -f` a pattern that also appears in your own command
  line (it kills the calling shell, or loops forever); use PIDs.
- Yoe systemd uses dbus-broker. Ptests needing a private bus (GTestDBus,
  dbus-run-session) RDEPEND on the split-out `dbus-daemon` package. To drop
  `${PN}` from `${PN}-ptest`, use `RDEPENDS:${PN}-ptest:remove`; a hard
  assignment wipes class-added deps.
- Missing perl core modules are the usual meta-perl ptest failure
  (`Can't locate X.pm` → `perl-module-x`). Target perl's Config names clang, so
  ptests compiling C need
  `RDEPENDS:${PN}-ptest:append:toolchain-clang = " clang"`.
- A pytest collection error means nothing ran; fix the RDEPENDS and expect a
  second round of real failures. pypi sdists often lack test data; fetch it from
  git with a second `SRC_URI` entry.
- musl: `:toolchain-gcc` overrides follow the build toolchain, not the on-target
  gcc; musl has no `.eh_frame` (unwinder tests need `musl-dbg`);
  `ctypes.util.find_library()` returns None; strerror wording differs from
  glibc; and use-after-free that glibc tolerates segfaults. sysvinit images have
  an empty `resolv.conf`, so DNS-dependent tests fail there.
- A test wrapped in `timeout` (without `--foreground`) receives the signal
  twice, so programs that force-exit on a second signal lose their output.
- kselftest: fix tests to SKIP when a kernel feature is missing; don't enable
  extra kernel options for them.

## Submitting fixes upstream

- First read the project's AGENTS.md / CLAUDE.md / CONTRIBUTING.md for rules on
  AI-assisted contributions: don't submit where they are banned, and add the
  required trailer (e.g. strace and meta-qcom want `Assisted-by:`) where asked.

- GitHub: `gh repo fork <owner/repo>`, push a branch to the fork,
  `gh pr create -R <owner/repo> --head <user>:<branch>`. If the fork already has
  a branch with the same name, look at what's on it before pushing.
- gitlab.freedesktop.org (mesa, piglit, ...): there's no `glab`/API token, but
  SSH works (`git@ssh.gitlab.freedesktop.org`). Push to the personal fork and
  open the MR with push options:
  `git push fork <branch> -o merge_request.create -o merge_request.target=main -o merge_request.target_project=<group/project>`.
  The fork rejects pushes from shallow clones (`git fetch --unshallow` first),
  and push options can't contain newlines.
- After submitting, update the OE patch's `Upstream-Status` to
  `Submitted [<URL>]`.

## CHANGELOG.md

`CHANGELOG.md` follows Keep a Changelog. Entries go under the current release
heading (`## [YYYY.MM]`) in `### Changed` / `### Added` / `### Removed`.

- To document a `Layer Updates:` commit, list each bumped submodule's commits:
  `git -C sources/<layer> log --no-merges --format=%s <old>..<new>`, with
  old/new from `git rev-parse <commit>^:sources/<layer>` and
  `<commit>:sources/<layer>`.
- Write one summarizing bullet per layer (or per theme), ending with the layer
  name in parentheses, e.g. `(meta-oe, meta-python)` or `(oe-core)`. Put CVE
  fixes in their own `Security fixes for ... (CVE-...)` bullet; search with
  `--grep=CVE -i`.
- Run `yoe_format` / `npx prettier --write CHANGELOG.md` afterwards (it rewraps
  lines) and commit as `CHANGELOG: Document changes`.

## Conventions

- Commit messages are signed off (`git commit -s`). Layer-bump commits use the
  `Layer Updates: <submodule paths>` subject style.
- Submodules are often checked out on local working branches with unpushed
  commits; check `git status -sb` / `git log` in the submodule before
  committing, and don't rewrite commits other than your own.
- Don't edit generated files (`build/conf/auto.conf`, `localconfig.sh`).
- Detailed machine and topic docs are in `docs/` (mdbook); start at
  `docs/README.md`.

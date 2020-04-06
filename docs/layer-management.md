# Yoe Layer Management

[up](README.md)

All OE layers that are being used in Yoe project are mirrored in the YoeDistro
space on github. These layers are synced every two hours with upstream since the
global namespace is kept intact, there are no conflicts. We reserve namespaces
for local branches

- `yoe/<topic>` - Distro Specific branch, needed when we have to do distro
  speicific fixes which are not upstreamable, this is rare situation, secondly,
  we create additional layers e.g. yoe/mut ( mut stands for "Master-Under-Test)
  branches which are used for regular CI builds.

- `<user>/<topic>` - This namespace is reserved for developers, these are also
  short lived branches primarily used for development which are deleted after
  pull request is accepted in a public branch

## Why do we mirror the layers ?

- This provides needed redundancy and development space for Yoe Distro
  developers. Since we create pure mirrors for public branches and offer
  namespaces for development, this makes it a good combination for hosting
  changes when they are in flight. It also provides a mechanism for running a CI
  loop on the changes to be submitted upstream for specific layers.

- If a product is to be released one can easily mirror the yoe mirrors
  internally and keep a local copy, or one can use same mirroring policy and
  local branching policy to create internal branches. Just keep <yoe>/ namespace
  safe.

- For some reason if upstream layers disappear and we still need to maintain the
  layers, which can happen over a long life of products, then we offer a
  redundancy

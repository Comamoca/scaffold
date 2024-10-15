<div align="center">

<img src="https://emoji2svg.deno.dev/api/🦊" alt="eyecatch" height="100">

# cl-nix

Modern Common Lisp project template using Nix

<br>
<br>


</div>

<div align="center">

</div>

## 🚀 How to use

### 🦊 Use scaffox

Please install [scaffox](https://github.com/comamoca/scaffox)

```sh
deno install -gAf -n scaffox https://raw.githubusercontent.com/Comamoca/scaffox/main/main.ts

# then run scaffox
scaffox
```

### ❄  With Nix

```sh
nix flake init -t github:Comamoca/scaffold#cl-nix
```

## ⛏️   Development

```sh
# Into devshell
nix develop

# Launch slynk server
nix run .#slynk

# Build program
nix build

# Run program
nix run

# run test
nix run .#test
```
## 🧩 Modules

- [rove](https://github.com/fukamachi/rove)
- [arrow-macros](https://github.com/hipeta/arrow-macros)
- [sly](https://github.com/joaotavora/sly)
- [flake-parts](https://flake.parts)

## 💡 Tips

### Run the test manually
Synonymous with `(rove:run :mypkg)`.

```lisp 
(asdf:test-system :mypkg)
```

## 👏 Affected projects

- [cl-project](https://github.com/fukamachi/cl-project)

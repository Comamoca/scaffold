<div align="center">

![Last commit](https://img.shields.io/github/last-commit/Comamoca/scaffold?style=flat-square)
![Repository Stars](https://img.shields.io/github/stars/Comamoca/scaffold?style=flat-square)
![Issues](https://img.shields.io/github/issues/Comamoca/scaffold?style=flat-square)
![Open Issues](https://img.shields.io/github/issues-raw/Comamoca/scaffold?style=flat-square)
![Bug Issues](https://img.shields.io/github/issues/Comamoca/scaffold/bug?style=flat-square)

<img src="https://emoji2svg.deno.dev/api/🦊" alt="eyecatch" height="100">


# scaffold

My offen use project templates.

<br>
<br>

</div>

<div align="center">

</div>

> [!NOTE]
> 一部のテンプレートは[Comamoca/starter](https://github.com/Comamoca/starter)リポジトリへと移動されました。

## 🚀 How to use

### 🦊 Use scaffox


Please install [scaffox](https://github.com/comamoca/scaffox)

```sh
deno install -gAf -n scaffox https://raw.githubusercontent.com/Comamoca/scaffox/main/main.ts
```

Then build scaffold.

```sh
scaffox https://github.com/comamoca/scaffold
```

### ❄ Use Nix

If you have [Nix](https://nixos.org/), run below.

`{template_name}` is a directory name.(e.g. `flake-basic`)
```sh
nix flake init -t github:Comamoca/scaffold#{template_name} 
```

Get `flake-basic` template.
```sh
nix flake init -t github:Comamoca/scaffold#flake-basic 
```


## 📝 Todo

Nothing...

## 📜 License

> [!CAUTION] **If a license is specified in the included source code, that
> license will take precedence.**

CC0

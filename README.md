# FyerPower's Community Vanilla+ Modpack

A curated Minecraft modpack focused on enhancing the vanilla experience while maintaining the core gameplay feel.

##  Setup

Before getting started, make sure you have the following installed:

- Git
- [Go](https://golang.org/dl/) (for packwiz)
- [Packwiz](https://packwiz.infra.link/)

Install by running the following commands:

```sh
# Update apt
$ sudo apt update

# Install & Verify Git
$ sudo apt install git
$ git -v

# Install & Verify Golang
$ sudo apt install golang-go
$ go -v

# Install & Verify packwiz
$ go install github.com/packwiz/packwiz@latest
$ packwiz -v
```

Clone the repository

```sh
# Clone Repository
$ git clone REPO
#
$ cd FOLDER_NAME
```

Add local shell scripts into your $PATH

```sh
$ echo 'export PATH="$PATH:$(pwd)/scripts/bin"' >> ~/.zshrc
$ source ~/.zshrc
```

## Adding Mods

### From CurseForge / Modrinth

To add a mod from CurseForge or Modrinth, use the following command:

```bash
pw [curseforge|modrinth] add [URL|slug|search]
```

Examples:
```sh
# Add by mod slug (from url)
pw curseforge add jei

# Add by CurseForge URL
pw curseforge add https://www.curseforge.com/minecraft/mc-mods/jei

# Add by Modrinth URL
pw modrinth add https://modrinth.com/mod/jei
```

### Adding Local Mods

For mods that aren't available on CurseForge or Modrinth:

```bash
pw add <mod-file.jar>
```

## Managing Mods

### Updating Mods

Update all mods to their latest versions:
```bash
pw update --all
```

Update a specific mod:
```bash
pw update <mod-name>
```

### Removing Mods

Remove a mod from the modpack:
```bash
pw remove <mod-name>
```

### Listing Mods

View all mods in the modpack:
```bash
pw list
```

## Refreshing the Index

After adding, removing, or updating mods, refresh the index:

```bash
pw refresh
```

This updates the `index.toml` file with the current mod list and ensures everything is properly synchronized.

## Deployment

### For Players

Players can install and update the modpack using packwiz:

1. **Install the modpack:**
   ```bash
   pw serve
   ```
   Then in your Minecraft launcher, add the pack URL provided by the serve command.

2. **Update an existing installation:**
   ```bash
   pw update
   ```

### Export Options

#### Export to CurseForge Format

Export the modpack as a CurseForge-compatible zip:
```bash
pw curseforge export
```

#### Export to Modrinth Format

Export the modpack as a Modrinth-compatible zip:
```bash
pw modrinth export
```

#### Export to MultiMC/Prism Launcher

Export for MultiMC or Prism Launcher:
```bash
pw export
```

### Hosting the Modpack

You can host your modpack for easy installation:

1. **Using GitHub Pages:**
   - Push your modpack repository to GitHub
   - Enable GitHub Pages in repository settings
   - Players can install using: `https://<username>.github.io/<repository-name>/pack.toml`

2. **Using pw serve (local development):**
   ```bash
   pw serve
   ```
   This starts a local server for testing.

## Development Workflow

1. **Adding a new mod:**
   ```bash
   pw modrinth add <mod-name>
   pw refresh
   git add . && git commit -m "Add <mod-name>"
   ``` 

2. **Updating mods:**
   ```bash
   pw update --all
   pw refresh
   git add . && git commit -m "Update mods"
   ```

3. **Testing changes:**
   ```bash
   pw serve
   ```
   Test in a Minecraft instance, then commit changes.

## Configuration

### pack.toml

The main configuration file for the modpack. Edit this to change:
- Modpack name and version
- Minecraft version
- Mod loader (Fabric/Forge/Quilt)
- Author information

### index.toml

Auto-generated file that lists all mods. Don't edit manually - use packwiz commands instead.

## Troubleshooting

### Common Issues

1. **Mod conflicts:** Use `pw list` to check for incompatible mods
2. **Missing dependencies:** packwiz usually handles these automatically, but check mod requirements
3. **Version mismatches:** Ensure all mods support your Minecraft version

### Getting Help

- [packwiz Documentation](https://packwiz.infra.link/)
- [packwiz GitHub Repository](https://github.com/packwiz/packwiz)
- [packwiz Discord](https://discord.gg/packwiz)

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add/remove/update mods as needed
4. Test the changes
5. Submit a pull request

## License

This modpack configuration is available under [MIT License](LICENSE).

**Note:** Individual mods have their own licenses. Please respect the terms of each mod's license.

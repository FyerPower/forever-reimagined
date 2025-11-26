# Modpack Forever Vanilla

A curated Minecraft modpack focused on enhancing the vanilla experience while maintaining the core gameplay feel.

## Prerequisites

Before getting started, make sure you have the following installed:

- [Go](https://golang.org/dl/) (for packwiz)
- Git (for version control)

### Installing packwiz

Install packwiz using Go:

```bash
go install github.com/packwiz/packwiz@latest
```

Or download a pre-built binary from the [packwiz releases page](https://github.com/packwiz/packwiz/releases).

## Adding Mods

### From CurseForge

To add a mod from CurseForge, use the following command:

```bash
packwiz curseforge add <mod-name-or-url>
```

Examples:
```bash
# Add by mod slug (from url)
packwiz curseforge add jei

# Add by mod name
packwiz curseforge add "JEI"

# Add by CurseForge URL
packwiz curseforge add https://www.curseforge.com/minecraft/mc-mods/jei

# Add by project ID
packwiz curseforge add 238222
```

### From Modrinth

To add a mod from Modrinth, use:

```bash
packwiz modrinth add <mod-name-or-url>
```

Examples:
```bash
# Add by mod name
packwiz modrinth add "sodium"

# Add by Modrinth URL
packwiz modrinth add https://modrinth.com/mod/sodium

# Add by project ID
packwiz modrinth add AANobbMI
```

### Adding Local Mods

For mods that aren't available on CurseForge or Modrinth:

```bash
packwiz add <mod-file.jar>
```

## Managing Mods

### Updating Mods

Update all mods to their latest versions:
```bash
packwiz update --all
```

Update a specific mod:
```bash
packwiz update <mod-name>
```

### Removing Mods

Remove a mod from the modpack:
```bash
packwiz remove <mod-name>
```

### Listing Mods

View all mods in the modpack:
```bash
packwiz list
```

## Refreshing the Index

After adding, removing, or updating mods, refresh the index:

```bash
packwiz refresh
```

This updates the `index.toml` file with the current mod list and ensures everything is properly synchronized.

## Deployment

### For Players

Players can install and update the modpack using packwiz:

1. **Install the modpack:**
   ```bash
   packwiz serve
   ```
   Then in your Minecraft launcher, add the pack URL provided by the serve command.

2. **Update an existing installation:**
   ```bash
   packwiz update
   ```

### Export Options

#### Export to CurseForge Format

Export the modpack as a CurseForge-compatible zip:
```bash
packwiz curseforge export
```

#### Export to Modrinth Format

Export the modpack as a Modrinth-compatible zip:
```bash
packwiz modrinth export
```

#### Export to MultiMC/Prism Launcher

Export for MultiMC or Prism Launcher:
```bash
packwiz export
```

### Hosting the Modpack

You can host your modpack for easy installation:

1. **Using GitHub Pages:**
   - Push your modpack repository to GitHub
   - Enable GitHub Pages in repository settings
   - Players can install using: `https://<username>.github.io/<repository-name>/pack.toml`

2. **Using packwiz serve (local development):**
   ```bash
   packwiz serve
   ```
   This starts a local server for testing.

## Development Workflow

1. **Adding a new mod:**
   ```bash
   packwiz modrinth add <mod-name>
   packwiz refresh
   git add . && git commit -m "Add <mod-name>"
   ```

2. **Updating mods:**
   ```bash
   packwiz update --all
   packwiz refresh
   git add . && git commit -m "Update mods"
   ```

3. **Testing changes:**
   ```bash
   packwiz serve
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

1. **Mod conflicts:** Use `packwiz list` to check for incompatible mods
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

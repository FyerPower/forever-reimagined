# Release Process

This document explains how to create releases for FyerPower's Community Vanilla+ modpack.

## Automated Release System

The modpack uses GitHub Actions to automatically create releases when tags are pushed. The system will:

1. **Trigger**: When a tag matching `v*` pattern is pushed (e.g., `v1.0.1`, `v2.0.0`)
2. **Export**: Create both CurseForge and Modrinth modpack exports using packwiz
3. **Release**: Create a GitHub release with the exported files attached

## Creating a Release

### Option 1: Using the Release Script (Recommended)

We've provided a helper script that automates the entire process:

```bash
./scripts/release.sh
```

This script will:
- Check that your repository is clean
- Prompt for the new version number
- Update the version in `pack/pack.toml`
- Ask for release notes (optional)
- Create a commit with the version bump
- Create and push the git tag
- Trigger the automated release process

### Option 2: Manual Process

If you prefer to do it manually:

1. **Update the version** in `pack/pack.toml`:
   ```toml
   version = "1.0.1"  # Update this line
   ```

2. **Commit the version change**:
   ```bash
   git add pack/pack.toml
   git commit -m "Bump version to 1.0.1"
   ```

3. **Create and push the tag**:
   ```bash
   git tag -a v1.0.1 -m "Release 1.0.1"
   git push origin main
   git push origin v1.0.1
   ```

## What Happens Next

Once the tag is pushed, GitHub Actions will:

1. **Install packwiz** on the runner
2. **Export CurseForge format**: `packwiz curseforge export` 
3. **Export Modrinth format**: `packwiz modrinth export`
4. **Create GitHub release** with both files attached

The release files will be named:
- `fyerpowers-community-vanillaplus-modpack-vX.X.X-client.zip`
- `fyerpowers-community-vanillaplus-modpack-vX.X.X-server.zip`
- `fyerpowers-community-vanillaplus-modpack-vX.X.X-client.mrpack`
- `fyerpowers-community-vanillaplus-modpack-vX.X.X-server.mrpack`

## Version Numbering

We recommend following [Semantic Versioning](https://semver.org/):
- **Major** (X.0.0): Breaking changes, major mod additions/removals
- **Minor** (x.X.0): New features, significant mod updates
- **Patch** (x.x.X): Bug fixes, small tweaks

## Monitoring Releases

You can monitor the release process in the [Actions tab](../../actions) of the GitHub repository. If the workflow fails, check the logs to see what went wrong.

## Troubleshooting

### Common Issues

1. **packwiz export fails**: Make sure all mods in the pack are still available and the index is up to date
2. **Version already exists**: Check if the tag already exists with `git tag -l`
3. **Permission errors**: Ensure the repository has the correct permissions for creating releases

### Manual Export Testing

To test exports locally before creating a release:

```bash
cd pack
packwiz curseforge export
packwiz modrinth export
```

This will create the export files in the `pack` directory so you can verify they work correctly.
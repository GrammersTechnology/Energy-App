# Byge design system :art:
This is the design system for **byge.**

## Why?🧐
Byge is developed in two versions and this repository contains the shared components based on the **byge** design.

## Intended use and setup :mag:
### Git setup
This design system is meant to be used as a submodule and can be added to your current project by using the following command: <br>
:warning: This repository should be cloned inside the `lib` directory, remember to do `cd lib` if your in the root folder :warning:
``` 
git submodule add git@github.com:jvhenriksen/byge-design-system.git
``` 

When the submodule is added the new changes can be retrieved by the following command inside this directory
```
git pull
```
### SVG
The design system uses svg to display some icons, to install this package use the following command
```
flutter pub add flutter_svg
```
### Fonts
Since the design system contains the `Inter` font, these fonts has to be added to the `pubspec.yaml` like so:
```yml
  fonts:
    - family: Inter
      fonts:
      - asset: lib/byge-design-system/fonts/inter/Inter-Black.ttf
        weight: 900
      - asset: lib/byge-design-system/fonts/inter/Inter-ExtraBold.ttf
        weight: 800
      - asset: lib/byge-design-system/fonts/inter/Inter-Bold.ttf
        weight: 700
      - asset: lib/byge-design-system/fonts/inter/Inter-SemiBold.ttf
        weight: 600
      - asset: lib/byge-design-system/fonts/inter/Inter-Medium.ttf
        weight: 500
      - asset: lib/byge-design-system/fonts/inter/Inter-Regular.ttf
        weight: 400
      - asset: lib/byge-design-system/fonts/inter/Inter-Light.ttf
        weight: 300
      - asset: lib/byge-design-system/fonts/inter/Inter-ExtraLight.ttf
        weight: 200
      - asset: lib/byge-design-system/fonts/inter/Inter-Thin.ttf
        weight: 100

```
### Themes
The themes used by the design system needs to be added into MaterialApp :

```dart
import 'package:{your_app}/byge-design-system/theme/themes.dart'; //⚠️ Fill in your_app

MaterialApp(
  title: 'Flutter Demo',
  theme: theme,
  darkTheme: theme,
  home: Scaffold(
    appBar: AppBar(
      title: const Text('byge'),
    ),
    body: const Center(
      child: const Text("Design system example"),
    ),
  ),
);

```

## Developer Guidelines🧑 💻
Below are some guidelines for developers on the project.

### Language🗣️

This lists which language should be used in different contexts:

- **Code**: English (with some exceptions for uniquely Norwegian terms, e.g. "nettleie")
- **Commit messages**: English
- **Pull requests**: English
- **Discussions**: English/Norwegian

### Commit Conventions + Gitmojis✨🐛

Commits should be defined based on the sentence form: **this commit will** `<commit_message>`.

We use [gitmojis](https://gitmoji.dev) to structure commit messages so that each
commit has an associated emoji describing the commit's purpose.<br>
E.g. `:sparkles:` ✨ is used when we want to introduce a new feature, while `:bug:` 🐛 is used when we want to fix a bug. For a list of all gitmojis please see [this table](https://gitmoji.dev/).

Why do we use this? Because it makes it alot easier to overview and read through commit messages at a later stage.

#### Examples

- **Example 1:** I'm updating the app themes and write my commit message as:<br>
  `git commit -m ":art: update all themes"` this results in the commit message `🎨 update all themes`.

- **Example 2:** I'm adding a new table to display the current electricity price.<br>
  `git commit -m ":sparkles: add current price table"` this results in the commit message `✨ add current price table`.

### Branch Conventions🌳

We operate with 4 different branch categories:

- **feature** - When you're adding something new to the application.
- **fix** - When you're fixing a bug or making a change.
- **doc** - When documenting something, e.g. README or docstrings in code.
- **ci-cd** - DevOps tasks like configuring workflows in GitHub actions.

The practice for creating a branch is as follows:
`<category>/<task-name>` <- We use a hyphen "-" between words.

#### Branch examples

- **Example:** You're creating a branch to implement Google login:<br>
  ```
  git checkout -b feature/implement-google-login
  ```
- **Example:** You're creating a branch to implement a CI-CD action for building the app:<br>
  ```
  git checkout -b ci-cd/action-for-building-app
  ```

### Rebase

When developing on a branch and you should always use rebase. Merge commit are generally not approved.
All Pull Requests (PR) are rebased into main and all merging are disabled in GitHub.

#### Example rebase

I'm on a local branch and want to get the current state of `main` in my branch:<br>

```git
git pull --rebase origin main
```

Here your local branch is rebased ontop of `main`, which means your commit history will stack on top.

### Pull Requests (PR)

Pull request should follow the automatically generated template provided.<br>
All PR's are automatically checked for the correct formating.

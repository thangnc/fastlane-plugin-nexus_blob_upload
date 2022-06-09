# nexus_raw_upload plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-nexus_raw_upload) ![Gem Version](https://badge.fury.io/rb/fastlane-plugin-nexus_raw_upload.svg) ![](https://ruby-gem-downloads-badge.herokuapp.com/fastlane-plugin-nexus_raw_upload) [![CircleCI](https://circleci.com/gh/thangnc/fastlane-plugin-nexus_raw_upload.svg?style=shield)](https://circleci.com/gh/thangnc/fastlane-plugin-nexus_raw_upload)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started
with `fastlane-plugin-nexus_raw_upload`, add it to your project by running:

```bash
fastlane add_plugin nexus_raw_upload
```

## About nexus_raw_upload

Actions related to Nexus raw upload

### raw_upload

| Key           | Description                                                                                                                      | Env Var | Default |
|---------------|----------------------------------------------------------------------------------------------------------------------------------|---------|---------|
| file          | File to be uploaded to Nexus                                                                                                     |         |         |
| repository    | Nexus repository id e.g. artifacts                                                                                               |         |         |
| raw_directory | Nexus raw directory name e.g. 'com/fastlane'. Only letters, digits, underscores(_), hyphens(-), and forward slash(/) are allowed |         |         |
| file_name     | Nexus asset file name                                                                                                            |         |         |
| endpoint      | Nexus endpoint e.g. http://nexus:8081                                                                                            |         |         |
| username      | Nexus username                                                                                                                   |         |         |
| password      | Nexus password                                                                                                                   |         |         |
| ssl_verify    | Verify SSL                                                                                                                       |         | true    |
| verbose       | Make detailed output                                                                                                             |         | false   |

```ruby
raw_upload(
  file: "/path/to/file.ipa",
  repository: "artifacts",
  raw_directory: "com/fastlane",
  file_name: "myproject",
  endpoint: "http://localhost:8081",
  username: "admin",
  password: "admin123"
)
```

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo,
running `fastlane install_plugins` and `bundle exec fastlane test`.

**Note to author:** Please set up a sample project to make it easy for users to explore what your plugin does. Provide
everything that is necessary to try out the plugin in this project (including a sample Xcode/Android project if
necessary)

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use

```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out
the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out
the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more,
check out [fastlane.tools](https://fastlane.tools).

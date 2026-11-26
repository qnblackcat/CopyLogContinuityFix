# CopyLogContinuityFix

Stops `pasted` from crashing when CopyLog handles a paste copied from another device (Universal Clipboard), which freezes pasting for a moment. If you don't encounter this issue, just ignore this tweak.

**Symptom:** pasting occasionally hangs when an app reads the clipboard by itself while its content came from another device (e.g. copied on a Mac, then opening Sileo). Settings → Privacy & Security → Analytics & Improvements → Analytics Data shows repeated `pasted-*.ips` crash logs (`EXC_CRASH`/`SIGABRT`, crashed in `CopyLogPasteD.dylib`).

CopyLog calls `-persistentIdentifier` on the paste source, but a source from another device (`DRPasteAnnouncementContinuityEndpoint`) doesn't have it. This tweak adds that method, returning `nil`.

No options to configre.

## Build

<details>
<summary>Build instructions</summary>

Build the package with roothide's fork of Theos. 

```sh
make clean package FINALPACKAGE=1 THEOS_PACKAGE_SCHEME=rootless
make clean package FINALPACKAGE=1 THEOS_PACKAGE_SCHEME=roothide

```

</details>

## License

The source code is under the [MIT License](LICENSE).
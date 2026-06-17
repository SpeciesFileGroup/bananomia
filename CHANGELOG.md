## [Unreleased]
 - Fixed copy-paste residue from the upstream serrano/colrapi template:
    - Renamed `Faraday::ColrapiErrors` middleware module to `Faraday::BananomiaErrors`
    - Changed the 503 error message from "Crossref is rate limiting your requests." to "Bionomia is rate limiting your requests."
    - Fixed a comment in `Bananomia::Request#perform` that referred to ChecklistBank instead of Bionomia

## [0.1.2] - 2026-06-17
 - Allow Ruby 4.0.0:
    - Relaxed `required_ruby_version` to `>= 2.5.0, < 5.0`
    - Added Ruby 4.0.0 to the CI matrix
    - Bumped `faraday-follow_redirects` upper bound to allow 0.5+ (which lifts the Ruby < 4 cap)
    - Dropped the `bundler` development dependency
    - Added `irb` development dependency (no longer in stdlib)
 - Fixed `Bananomia.search_occurrences` (and other endpoints) being blocked by Bionomia's Cloudflare bot mitigation by requesting strictly `Accept: application/ld+json` instead of `application/ld+json,*/*`
 - Updated license from NCSA to MIT

## [0.1.1] - 2024-09-11
 - Updated documentation
 - Removed Gemfile.lock
 - Bumped development depency versions to avoid CVE-2024-43398

## [0.1.0] - 2022-01-20

- Initial release

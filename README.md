Microserver
===========

### Overview

Microserver is a docker configuration for running certain web services. This server runs in conjunction with [Orchestrate](https://github.com/ryan-mahoney/orchestrate) and [Universal React PHP App](https://github.com/ryan-mahoney/universal-react-php-app).

### Detail

Supervisor is configured to run:
- Nginx (with Lua extension)
- PHP-FPM
- NodeJS for React serverside rendering
- PostgreSQL

[The Twelve-Factors App](https://12factor.net/)

1. Codebase
    - app is always tracked in a version control system. A deploy is a running instance of the app.
    - There is only one codebase per app, but there will be many deploys of the app;
    - The codebase is the same across all deploys, although different versions may be active in each deploy

2. Dependencies
    - app never relies on implicit existence of system-wide packages
    - It declares all dependencies, completely and exactly, via a dependency declaration manifest
    - It uses a dependency isolation tool during execution to ensure that no implicit dependencies “leak in” from the surrounding system
3. Config
    - app stores config in environment variables (often shortened to env vars or env).
4. Backing services
    - Each distinct backing service is a resource
    - To the app, both are attached resources, accessed via a URL or other locator/credentials stored in the config  
    - app treats these backing services as attached resources, which indicates their loose coupling to the deploy they are attached to.
    
5. Build, release, run

    - The build stage is a transform which converts a code repo into an executable bundle known as a build. Using a version of the code at a commit specified by the deployment process, the build stage fetches vendors dependencies and compiles binaries and assets.
    - The release stage takes the build produced by the build stage and combines it with the deploy’s current config. The resulting release contains both the build and the config and is ready for immediate execution in the execution environment.
    - The run stage (also known as “runtime”) runs the app in the execution environment, by launching some set of the app’s processes against a selected release.
    - app uses strict separation between the build, release, and run stages

6. Processes
    - processes are stateless and share-nothing, any data that needs to persist must be stored in a stateful backing service, typically a database
    - app never assumes that anything cached in memory or on disk will be available on a future request or job – with many processes of each type running, chances are high that a future request will be served by a different process
    - Even when running only one process, a restart  will usually wipe out all local (e.g., memory and filesystem) state.

7. Port binding
    - app is completely self-contained and does not rely on runtime injection of a webserver into the execution environment to create a web-facing service.
    - This is typically implemented by using dependency declaration to add a webserver library to the app
8. Concurrency:
    - processes are a first class citizen, we use process for concurrency instead of threads
9. Disposability:
    - app’s processes are disposable, meaning they can be started or stopped at a moment’s notice,This facilitates fast elastic scaling, rapid deployment of code or config changes, and robustness of production deploys.
    - Processes should strive to minimize startup time
    - Processes shut down gracefully when they receive a SIGTERM signal from the process manager
    - Processes should also be robust against sudden death, in the case of a failure in the underlying hardware
10. Dev/prod parity
    - Keep development, staging, and production as similar as possible
    - app is designed for continuous deployment by keeping the gap between development and production small
    - developer resists the urge to use different backing services between development and production, even when adapters theoretically abstract away any differences in backing services

11. Logs
    - Treat logs as event streams
    - app never concerns itself with routing or storage of its output stream
    - each running process writes its event stream, unbuffered, to stdout
12. Admin processes
    - Run admin/management tasks as one-off processes
    - One-off admin processes should be run in an identical environment as the regular long-running processes of the app
# Repro for 'Process.Start() loses identity when started from a Scheduled Task on Windows Server 2019'
If `process-starter` was started using impersonation (a scheduled task in this example), `secure-operation` will fail with `Exception calling ".ctor" with "2" argument(s): "The specified network password is not correct."`. This is strange, because if I start `secure-operation` directly in the scheduled task, it will execute it successfully.
## Reproduction

### Requirements
* OS: Windows Server 2019
* Powershell or Powershell Core

### Steps

* Run:
```
git clone https://github.com/fhammerl/ps-task-repro.git
```
* Copy all `ps1` files and `key.pfx` to `C:\pstests` - this folder is hardcoded in the scripts

* Run `task-start-secureop-directly.ps1` and see it succeed. It will echo 'true' to success.txt. This proves that directly running the secure script from the task works.
* Run `process-starter.ps1` and see it succeed. It will echo 'true' to success.txt. This proves that starting a new process without impersonation works.
* Run `task-process-start-powershell` and see it fail. It will echo `Exception calling ".ctor" with "2" argument(s): "The specified network password is not correct."`.' to errors.txt. This proves that executing a secure operation in a new process with impersonation fails.

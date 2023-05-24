# Systemd

[Blog For Systemd](https://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html)

## Uint and Unit Contrl
System call system resources as Unit, and divide them into 12 classes.

- `systemctl status NAME_OF_UNIT`check the status of the specific unit.
- `systemctl start NAME_OF_UNIT` start the specific unit
- `systemctl stop NAME_OF_UNIT` stop the specific uint
- `systemctl kill NAME_OF_UNIT` kill the proc of the specific uint, including the subproc
- `systemctl list-dependencies NAME_OF_UINT` list the dependence of the specific unit( A depends on B means that when Systemd start A unit, it will start B **before** A)

## Unit Configuration
Systemd read config file from `/etc/systemd/system`(most of these are symbol link), while the real config file in  `/usr/lilb/systemd/system`.

`systemctl list-unit-files --type=service` can list all config files with the type of service. STATE of the Uint are one of these:
- **enable** Already Set Up Link 
- **disable** Not Set Up Link
- **static** No [Install] part in config file, can only be treated as dependency by other
- **masked** Forbidded to set up Link

Once modify config file, following commands are need to source the new config
```
systemctl daemon-reload
systemctl restart SERIVENAME.service
```

## Uint Configuration Blocks
1. [Unit]
    Use to define metadata of Unit.

    Fields of [Unit]:
    - Description
    - Documentation
    - Requires: if units in Requires isn't running, the current unit will fail to start
    - Wants: if units in Wants isn't running, the current unit    will fail to start
    - BindsTo: if units in BindsTo quit, the current unit will stop running
    - Before: units in Before must start before current uint if needed
    - After: units in After must start after current uint if needed
    - Conflicts: units in Conflicts cannot run at the same time with the current unit
    - Condition: the condition must satisfy when current unit running,otherwise not running
    - Assert: the condition must satisfy when current unit running,otherwise give error info

2. [Service]
    Set config of service

    Field of [Service]
    - Type 
        - =simple: Default Value, execute command in ExecStart
        - =forking: fork and execute command in ExecStart
    - ExecStart: set up execute command
    - EnvironmentFile: specify the env parameter of current unit 

3. [Install]
    define how to start the unit

    Fields of [Install]
    - WantBy: Use Target type as value. When current unit enables, its symbol link will be add to `/etc/systemd/system/Target_name.wants`
    - RequiredBy: Use Target type as value. When current unit enables,its symbol link will be add to `/etc/systemd/system/Target_name.required`
    - Alias: Alias name for current unit 
    - Also: enable the unit in Also when current unit enable

## Exmaple

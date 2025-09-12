# Running Meeting Playbooks Across Environments

This demo shows how to switch inventories between environments (`dev/`, `staging/`, `prod/`) and run a simple playbook that prints a meeting message.

## Inventories
- `dev/inventory.ini`
- `staging/inventory.ini`
- `prod/inventory.ini`

Each inventory defines a `meetings` group with `localhost` for simplicity.

## Playbooks
- `dev/meeting.yaml` — Daily Standup (Dev)
- `staging/meeting.yaml` — Sprint Review (Staging)
- `prod/meeting.yaml` — Executive Sync (Prod)

## Commands
Run the meeting playbook for each environment like this:

```bash
ansible-playbook -i dev/inventory.ini dev/meeting.yaml
ansible-playbook -i staging/inventory.ini staging/meeting.yaml
ansible-playbook -i prod/inventory.ini prod/meeting.yaml
```

You should see an output message similar to:

```text
TASK [Print meeting info] ********************************************************
ok: [localhost] => {
    "msg": "DEV: Daily Standup at 09:00 AM"
}
```

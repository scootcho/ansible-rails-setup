# A small Rails server playbook for Ansible

**based off of https://github.com/radar/ansible-rails-app**

---

## Creates and launches EC2 instance on AWS

1. Install boto from source:

```
$ git clone git://github.com/boto/boto.git
$ cd boto
$ python setup.py install
```
2. Set the AWS_ACCESS_KEY_ID & AWS_SECRET_ACCESS_KEY in the boto Env

3. Fill in required variables in `ec2_launch.yml`, such as instance_type, security_group, etc.

4. Make sure `hosts` file exists.

4. Run `ansible-playbook -i hosts ec2_launch.yml -vvv`

---

## Provisioning Server

1. Ensure the server is listed under [webserver] in the `hosts` file once created.

2. Change the application information in `vars/defaults.yml`.

3. run `ansible-playbook -i hosts server_env.yml`

This will install:

- Ruby (Chruy)
- PostgreSQL
- nginx
- Puma (jungle)

Deployment Flow:
```
ansible-playbook -i hosts server_env.yml --skip-tags "puma"
<deploy your app>
ansible-playbook -i hosts server_env.yml --tags "puma"
```


---

## Deploying with Capistrano

There is an example Capistrano `deploy.rb` in this repository that you can use too.

Make sure your ssh key is avaiable

```
ssh-add -l

ssh-add ~/.ssh/id_rsa
```


If you're deploying with Capistrano to EC2 using the `key.pem` file. Remember to enable `:pty` option and enable `forward_agent`.

```
set :pty, true

set :ssh_options, {
  forward_agent: true,
  auth_methods: ["publickey"],
  keys: ["/path/to/key.pem"]
}
```


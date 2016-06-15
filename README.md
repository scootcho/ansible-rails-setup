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

It installs:

- Ruby 2.3
- PostgreSQL
- nginx
- Puma (jungle)

1. Change the app name and deploy directory in `vars/defaults.yml`.

To run:

    $ ansible-playbook -i hosts ruby-webapp.yml -t ruby,deploy,postgresql,nginx
    $ <deploy your app>
    $ ansible-playbook -i hosts ruby-webapp.yml -t puma

There is an example Capistrano `deploy.rb` in this repository that you can use too.

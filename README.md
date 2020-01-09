# Introduction
This repository contains a simple implemented read-only backend API.

# Objective
The purpose of this workshop is to learn to dockerize and deploy your application.
By the end of this tutorial, you should be able to:
- Read and write Dockerfiles
- Build docker images
- Run docker containers from a given image
- Deploy

# What is Docker?
The purpose of docker is to build a small isolated image that has all the essential infrastructure to run our application and can be deployed to any cloud provider. In a way, Docker can be treated as a very lightweight virtual machine that's meant to run a specific command (such as our rails server). 
Installing docker varies by operating system (you can google 'Install docker on <OS>'), but be sure that whichever way you choose - that you install the CLI tools.
  
A small note on terminology: `image` refers to the 'blueprint' of an environment. `container` refers to an instance of that image. For example, you can create an image for running your rails server then deploy many containers of that image.

# Dockerfile
In order to build a docker image, we have to specify a file with step-by-step instructions on how to build that image. That file is usually called `Dockerfile` (a basic version is provided in this repo)

Think of every step as a separate 'commit' in a version control system. For example, you can start with an empty linux container, add your code to the image, install additional libraries and software, run some preparation commands (for example, `bundle install`). Finally, you will specify an entry point: the command to run when your container is actually ran (for example, `rails s`).

# Building The Image
Every docker image starts with a parent image. The parent image could be a basic linux installation or it could be an image that has some software pre-installed.

In our case, we will use a ruby 2.6.5 image. That's the current ruby version for API and it's already included in the starter Dockerfile.

The rest of the setup is for you to implement!
Please refer to the following document: https://docs.docker.com/engine/reference/builder/
There you will find what commands the Dockerfile accepts

When building an image, think to yourself the following:
What do you need to add to your image in order to run your server?
You probably need to copy the code over.
You should probably install all of the ruby dependencies.
Finally, you need to specify the entrypoint command. I have prepared a `start.sh` script that contains the `rails s` as well as some supplementary release commands
_Note:_ In a real world scenario, deploy operations would be executed elsewhere and the container would only be responsible for running the server.

When you think you're ready, run `docker build . -t server`.
There's a good chance you will run into errors as you go, but that is expected. See what the error says an correct it accordingly or ask any of the organizers a question.

Note, `-t server` sets the name of your image to `server` instead of a random UUID

# Running The Container

Once you have your image built, you will be able to create an instance and run your container.
You can use `docker run -p 80:80 server` to run your container.
Note: we use `-p PORT:PORT` to make the container listen on the specified port. Use a different port if you application does not run on port 80. The syntax of the command allows mapping external port to a different internal port, but we don't really need that feature here)

Please note that once you run your container in a terminal window, you may not be able to terminate it with `Ctrl+C`.
You can use the following instead (replace `server` if you used a different name): `docker container kill $(docker ps | grep server | awk '{print $1}')`

# Deploying (Beta)

_Note: This setup is a bit more complex than last section, so if you hit roadblocks - don't hesitate to reach out for help!_

First, we need to install several dependencies:
```
brew install kubectl

brew install aws-iam-authenticator

brew install awscli
```


Next, since we are using a private repository for deploys, you must login:
docker login docker.ci.platterz.co -u localIt will ask for a password, the password is found in the shared-devs folder in LastPass, under secure notes
You should see
> Login Succeeded


In order to configure aws\kubernetes, run the following:
```
cd dockerize
./setup.sh
```
Feel free to view the file contents for details.


Next, we need to push our docker image to the private repository from which we will deploy.
```
# Tag our local image with repository:tag (we all push to the same repository, 
# but each one of us has our own version of the image specified with the tag)
docker tag server:latest docker.ci.platterz.co/repository/docker/workshop:$(whoami)
docker push docker.ci.platterz.co/repository/docker/workshop:$(whoami)
```

Now we can actually run our container in kubernetes (run while in `dockerize` folder):
```
cat pod-setup.yaml | sed "s/{{MY_APP}}/$(whoami)/g" | kubectl apply -f -
```
You can examine the contents of `pod-setup.yaml` but the idea is to create two containers in a single pod: one with the database and one with our app, conntected together so that the application can access the database as if it was local
The command simply replaces 
In order to access the container, you can forward a local port to the cluster:
`kubectl port-forward pod/$(whoami)-app 80:80` (you may have to use sudo)

At this point, you can use graphql playground for debugging on `http://localhost:80/graphql`


For debug purposes, in order to see the logs use the following command:

kubectl logs -f pods/$(whoami) -c app-$(whoami) for application logs

kubectl logs -f pods/$(whoami) -c db-$(whoami) for db logs

You can also run shell in the context of your container using the following command:
`kubectl exec pods/ytaben -c app-ytaben /bin/sh -it`
Once inside, you can run `bundle exec rails c` as usual.

If you want to make changes to your app and\or config and restart, you must first delete the existing pods:
`kubectl delete pods $(whoami)`

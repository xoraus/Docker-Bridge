# Step 1 - 
# - build the custom image - btree/node -from the docker file - node.dockefile -
#command:     
    # docker build -f node.dockerfile -t btree/node .

# Step 2 - 
# - build a mongo container with a custom name
#command: 
    # docker run -d --name my-mongodb mongo

#step 3 -
    #Option 1 - Legacy Linking - 
        # - build a container - btree/node - from our custom custom image 
        # - link the mongo container - mymongdb as mongodb - to the node container using the --link command
        # - remember there is no data in the database till step 4. 
        #command: 
            # docker run -d -p 3000:3000 --link my-mongodb:mongodb --name nodeapp btree/node

    #Option 2 - Custom Bridge Network -
        # a) Create a network name isolated_network
            #Command:  
                # docker network create --driver bridge isolated_network
        # b) Add mongodb to the network
            #Command:
                # docker run -d --net=isolated_network --name mongodb mongo
        #Add node express site to the network
            #Command: 
                # docker run -d --net=isolated_network --name nodeapp -p 3000:3000 btree/node
        #Bonus Commands
            #View Networks
                #view all networks currently running 
                #command:
                    # docker network ls  
            #Inspect 
                #view the detials of a network
                #command: 
                    # docker network inspect <NETWORKID> 
            #Remove Network 
                #removes a network 
                # all nodes or containers in the network must be removed in order to work 
                #command 
                    # docker network rm <NETWORKID>
            

#step 4  
# Seed or add pets the petDB the database in mongo
# - here we are demoing the using the *exec* command to show how to execute a command in a running container.
# - alternatively you can ssh in the container and do the same thing but this ay is much simpler.  
#command: 
    # docker exec nodeapp node dbSeeder.js




FROM node:latest

MAINTAINER BTree Press

ENV NODE_ENV=development 
ENV PORT=3000

COPY      . /var/www
WORKDIR   /var/www

RUN       npm install

EXPOSE $PORT

ENTRYPOINT ["npm", "start"]
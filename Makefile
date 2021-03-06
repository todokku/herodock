export VCS_REF=$$(git rev-parse --short HEAD)

build:		
		docker build --build-arg VCS_REF="${VCS_REF}" \
									--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
									--tag herodock --file ./.deploy/app/Dockerfile .

run:
		docker run -d --name herodock -e "PORT=9876" -p 9876:9876 herodock

stop:
		docker container stop herodock
		docker container rm herodock

test:
		@docker run -it --rm herodock php -i | grep "PHP Version => 7.4.5"
		@docker inspect -f {{.Config.Labels}} herodock:latest
		@docker inspect -f {{.Config.Labels}} herodock:latest | grep ${VCS_REF}

destroy:
		#docker container stop herodock
		#docker container rm herodock
		docker image rm herodock
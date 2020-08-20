SHELL = /bin/bash


# ## api-preview ##

# - https://blog.pchudzik.com/202004/open-api-and-external-ref/
build-api-preview-image:
	docker build api-preview -t api-preview:latest

preview-api:
	docker run --rm -it                                  \
        -p 8000:8000                                   \
        -v ${PWD}:/api                                 \
        api-preview:latest /watch.sh /api/openapi.yaml \
  # END


# ## openapi generator ##

# - https://github.com/OpenAPITools/openapi-generator#16---docker
generate-client:
	docker run                                       \
			 --rm                                        \
			 -v ${PWD}:/spec                             \
			 openapitools/openapi-generator-cli          \
							 generate                            \
									 --input-spec /spec/openapi.yaml \
									 --config /spec/config.yaml      \
									 --generator-name java           \
									 --output /spec/client           \
									 | tee gen.log                   \
  # END

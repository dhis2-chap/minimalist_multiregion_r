DOCKER_IMAGE := ghcr.io/mortenoh/r-docker-images/my-r-base:latest
PWD := $(shell pwd)

.PHONY: all run train predict clean pull help

all: help

run: pull train predict

train:
	docker run --rm -v $(PWD):/app -w /app $(DOCKER_IMAGE) Rscript train.R input/trainData.csv output/model.bin

predict:
	docker run --rm -v $(PWD):/app -w /app $(DOCKER_IMAGE) Rscript predict.R output/model.bin input/trainData.csv input/futureClimateData.csv output/predictions.csv

clean:
	rm -f output/model.bin output/predictions.csv

pull:
	docker pull $(DOCKER_IMAGE)

help:
	@echo "Available targets:"
	@echo "  make run      - Run complete pipeline (train + predict)"
	@echo "  make train    - Train model only"
	@echo "  make predict  - Run predictions only"
	@echo "  make clean    - Remove generated files"
	@echo "  make pull     - Pull Docker image"
	@echo "  make help     - Show this help message"

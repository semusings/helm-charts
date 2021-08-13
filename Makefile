push:
	docker-compose build && docker-compose push
lint:
	docker run -it --rm --name ct --volume $$(pwd):/data quay.io/helmpack/chart-testing sh -c "cd /data; ct lint --config .github/ct-lint.yaml"

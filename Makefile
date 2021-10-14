# This `Makefile` is intended for Cowrie developers.

# Dummy target `all`
.PHONY: all
all: lint

.PHONY: lint
lint:
	yamllint .
	kube-manifest-lint cowrie-service.yaml cowrie-pod.yaml
	kube-linter lint cowrie-service.yaml cowrie-pod.yaml

.PHONY: pre-commit
pre-commit:
	pre-commit run --all-files

.PHONY: pip-upgrade
pip-upgrade:
	pip install --upgrade -r requirements.txt

.PHONY: pip-check
pip-check:
	pip check

.PHONY: dependency-upgrade
dependency-upgrade:
	git checkout master
	-git branch -D "dependency-upgrade-`date -u +%Y-%m-%d`"
	git checkout -b "dependency-upgrade-`date -u +%Y-%m-%d`"
	pur -r requirements.txt
	git commit -m "dependency upgrade `date -u`" requirements*.txt

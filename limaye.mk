.PHONY: limenv check-black check-flake lint format 
#tests check-black check-flake lint format examples examples
PYTHON := limenv/bin/python
PIP = pip3

limenv:
	python3 -m venv limenv
	${PIP} install --upgrade pip
	${PIP} install -r limrequirements.txt
	${PIP} install -r limrequirements-dev.txt
	${PIP} install -e .

tests:
	${PYTHON} -m pytest
	${PYTHON} -m coverage html

check-black:
	${PYTHON} -m black --check limaye tests

check-isort:
	${PYTHON} -m isort --profile black --check-only limaye 

check-flake:
	${PYTHON} -m flake8 limaye

check-mypy:
	${PYTHON} -m mypy --strict --implicit-reexport limaye

lint: check-flake check-mypy check-black check-isort

format:
	${PYTHON} -m black limaye
	${PYTHON} -m isort --profile black limaye

examples:
	${PYTHON} -m nbexec.cli examples/notebooks

build:
	${PYTHON} -m build

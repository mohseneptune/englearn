virtualenv = .venv
source_dir = src

run:
	@echo "Running FastAPI app..."
	@cd ${source_dir} && uvicorn main:app --reload

pre-commit:
	@echo "Running pre-commit..."
	@git add .
	@pre-commit run -a

test:
	@echo "Running tests..."
	@pytest tests/

clean:
	@echo "Cleaning up..."
	@find . -type d -name '*cache*' | grep -v "${virtualenv}" | xargs rm -rf
	@find . -name "*.pyc" -not -delete

compose-up:
	@echo "Running docker-compose up..."
	@docker compose up -d

tree:
	@make clean
	@echo "Generating project tree..."
	@tree -L 4 -a -I "${virtualenv}|.git|tests"


help:
	@echo "Available commands:"
	@echo "  run: Run FastAPI app"
	@echo "  pre-commit: Run pre-commit"
	@echo "  test: Run tests"
	@echo "  clean: Clean up"
	@echo "  compose-up: Run docker-compose up"
	@echo "  tree: Generate project tree"
	@echo "  help: Show this help message"

.DEFAULT_GOAL := help
.PHONY: run pre-commit test clean compose-up tree help

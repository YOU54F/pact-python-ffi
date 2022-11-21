setup:
	python setup.py develop

install:
	pip install -r pact.egg-info/requires.txt

run_hello_ffi:
	python hello_ffi.py

run_pact_http:
	python pact_http_create_mock_server.py

run_pact_http_create_mock_server_for_pact:
	python pact_http_create_mock_server_for_pact.py

run_pact_message_v3:
	python pact_message_v3.py

run_pact_plugin_grpc_v4:
	python pact_plugin_grpc_v4.py

grpc_install: install_cli_tools install_protobuf_plugin 
	pip install -r examples/area_calculator/requirements.txt

test: run_pact_http run_pact_http_create_mock_server_for_pact run_pact_message_v3 run_pact_plugin_grpc_v4

pacts_show:
	cat "pacts/Consumer-Alice Service.json" | jq .
	cat "pacts/http-consumer-1-http-provider.json" | jq .
	cat "pacts/http-consumer-http-provider.json" | jq .
	cat "pacts/message-consumer-2-message-provider.json" | jq .
	cat "pacts/grpc-consumer-python-area-calculator-provider.json" | jq .

test_ci:
	act --container-architecture linux/amd64 --job act

proto_regen:
	python -m grpc_tools.protoc -Iexamples/proto --python_out=./examples/area_calculator --pyi_out=./examples/area_calculator --grpc_python_out=./examples/area_calculator examples/proto/area_calculator.proto

grpc_run_consumer:
	python examples/area_calculator/area_calculator_client.py

grpc_run_provider:
	python examples/area_calculator/area_calculator_server.py

install_cli_tools:
	./script/download-libs.sh

install_protobuf_plugin:
	pact/plugin/pact-plugin-cli -y install https://github.com/pactflow/pact-protobuf-plugin/releases/latest
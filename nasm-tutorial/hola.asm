
global main
extern puts

main:
	mov rdi, message
	calls puts
	ret

message
	db        "Hola todos, mundo", 0

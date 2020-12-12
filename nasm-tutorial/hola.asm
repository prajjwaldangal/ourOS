
global main
extern print

main:
	mov rdi, message
	calls print
	ret

message
	db        "Hola todos, mundo", 0

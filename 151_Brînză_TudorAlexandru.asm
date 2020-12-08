.data
	matrix: .space 1600
	roles: .space 80
	queue: .space 80
	visited: .space 80
	task: .space 4
	node_left: .space 4
	node_right: .space 4
	nodes: .space 4
	edges: .space 4
	index: .space 4
	role: .space 4
	host1: .space 4
	host2: .space 4
	lineIndex: .space 4
	columnIndex: .space 4
	counter: .space 4
	queueIndex: .space 4
	queueSize: .space 4
	node: .space 4
	len: .space 4
	letter: .space 8
	formatRead1: .asciz "%d"
	formatRead2: .asciz "%s"
	formatPrint: .asciz "%d"
	string_malitios: .asciz "switch malitios index "
	string_host: .asciz "host index "
	string_switch: .asciz "switch index "
	string_controller: .asciz "controller index "
	string1: .asciz ": "
	string2: .asciz "\n"
	string3: .asciz "; "
	string_yes: .asciz "Yes"
	string_no: .asciz "No"
	word: .space 30

.text

.global main

main:
	pushl $nodes
	pushl $formatRead1
	call scanf
	popl %ebx
	popl %ebx

	pushl $edges
	pushl $formatRead1
	call scanf
	popl %ebx
	popl %ebx

	movl $0, index

for1:
	movl index, %ecx
	cmp %ecx, edges
	je read_roles

	pushl $node_left
	pushl $formatRead1
	call scanf
	popl %ebx
	popl %ebx

	pushl $node_right
	pushl $formatRead1
	call scanf
	popl %ebx
	popl %ebx

	movl node_left, %eax
	movl $0, %edx
	mull nodes
	addl node_right, %eax
	lea matrix, %edi
	movl $1, (%edi, %eax, 4)
	
	movl node_right, %eax
	movl $0, %edx
	mull nodes
	addl node_left, %eax
	lea matrix, %edi
	movl $1, (%edi, %eax, 4)

	incl index
	jmp for1

read_roles:
	movl $0, index
	
for2:
	movl index, %ecx
	cmp %ecx, nodes
	je task_read

	pushl $role
	pushl $formatRead1
	call scanf
	popl %ebx
	popl %ebx

	lea roles, %edi
	movl index, %eax
	movl role, %ecx
	movl %ecx, (%edi, %eax, 4)

	incl index
	jmp for2

task_read:
	pushl $task
	pushl $formatRead1
	call scanf
	popl %ebx
	popl %ebx

	movl task, %ecx

	movl $1, %eax
	cmp %ecx, %eax
	je task1
	
	movl $2, %eax
	cmp %ecx, %eax
	je task2

	movl $3, %eax
	cmp %ecx, %eax
	je task3

task1:
	movl $0, lineIndex
	
for3:
	movl lineIndex, %ecx
	cmp %ecx, nodes
	je exit
	
	lea roles, %edi
	movl lineIndex, %eax
	movl (%edi, %eax, 4) , %ecx
	movl $3, %ebx
	
	cmp %ecx, %ebx
	jne increment_for3
	
	movl $4, %eax
	movl $1, %ebx
	mov $string_malitios, %ecx
	movl $23, %edx
	int $0x80
	
	pushl lineIndex
	pushl $formatPrint
	call printf
	popl %ebx
	popl %ebx
	
	pushl $0
	call fflush
	popl %ebx
	
	movl $4, %eax
	movl $1, %ebx
	mov $string1, %ecx
	movl $3, %edx
	int $0x80
	
	movl $0, columnIndex

for4:
	movl columnIndex, %ecx
	cmp %ecx, nodes
	je print_new_line
	
	movl lineIndex, %eax
	movl $0, %edx
	mull nodes
	addl columnIndex, %eax
	lea matrix, %edi
	
	movl (%edi, %eax,4) , %ecx
	movl $1, %ebx
	
	cmp %ecx, %ebx
	jne increment_for4
	
	movl columnIndex, %eax
	lea roles, %edi
	movl (%edi, %eax,4), %ecx
	
	movl $1, %ebx
	cmp %ecx, %ebx
	je afisare1
	
	movl $2, %ebx
	cmp %ecx, %ebx
	je afisare2
	
	movl $3, %ebx
	cmp %ecx, %ebx
	je afisare3
	
	movl $4, %ebx
	cmp %ecx, %ebx
	je afisare4
	
afisare1:
	movl $4, %eax
	movl $1, %ebx
	mov $string_host, %ecx
	movl $12, %edx
	int $0x80
	
	pushl columnIndex
	pushl $formatPrint
	call printf
	popl %ebx
	popl %ebx
	
	pushl $0
	call fflush
	popl %ebx
	
	movl $4, %eax
	movl $1, %ebx
	mov $string3, %ecx
	movl $3, %edx
	int $0x80
	
	jmp increment_for4
	
afisare2:
	movl $4, %eax
	movl $1, %ebx
	mov $string_switch, %ecx
	movl $14, %edx
	int $0x80
	
	pushl columnIndex
	pushl $formatPrint
	call printf
	popl %ebx
	popl %ebx
	
	pushl $0
	call fflush
	popl %ebx
	
	movl $4, %eax
	movl $1, %ebx
	mov $string3, %ecx
	movl $3, %edx
	int $0x80
	
	jmp increment_for4
	
afisare3:
	movl $4, %eax
	movl $1, %ebx
	mov $string_malitios, %ecx
	movl $23, %edx
	int $0x80
	
	pushl columnIndex
	pushl $formatPrint
	call printf
	popl %ebx
	popl %ebx
	
	pushl $0
	call fflush
	popl %ebx
	
	movl $4, %eax
	movl $1, %ebx
	mov $string3, %ecx
	movl $3, %edx
	int $0x80
	
	jmp increment_for4
	
afisare4:
	movl $4, %eax
	movl $1, %ebx
	mov $string_controller, %ecx
	movl $18, %edx
	int $0x80
	
	pushl columnIndex
	pushl $formatPrint
	call printf
	popl %ebx
	popl %ebx
	
	pushl $0
	call fflush
	popl %ebx
	
	movl $4, %eax
	movl $1, %ebx
	mov $string3, %ecx
	movl $3, %edx
	int $0x80
	
	jmp increment_for4
	
print_new_line:
	movl $4, %eax
	movl $1, %ebx
	mov $string2, %ecx
	movl $2, %edx
	int $0x80
	
	jmp increment_for3
	
increment_for4:
	incl columnIndex
	jmp for4
	
increment_for3:
	incl lineIndex
	jmp for3

task2:
	movl $0, %eax
	lea queue, %edi
	movl $0, (%edi, %eax, 4)
	movl $1, queueSize
	lea visited, %edi
	movl $0, %eax
	movl $1, (%edi, %eax, 4)
	movl $1, counter
	movl $0, queueIndex
while1:
	movl $0, columnIndex
	movl queueIndex, %ecx
	movl queueSize, %ebx
	cmp %ecx, %ebx
	je print1
	
	lea queue, %edi
	movl queueIndex, %eax
	movl (%edi, %eax, 4), %ecx
	movl %ecx, node
	incl queueIndex
	
	lea roles, %edi
	movl node, %eax
	movl (%edi, %eax, 4), %ecx
	movl $1, %ebx
	cmp %ecx, %ebx
	jne for5
	
	movl $4, %eax
	movl $1, %ebx
	mov $string_host, %ecx
	movl $12, %edx
	int $0x80
	
	pushl node
	pushl $formatPrint
	call printf
	popl %ebx
	popl %ebx
	
	pushl $0
	call fflush
	popl %ebx
	
	movl $4, %eax
	movl $1, %ebx
	mov $string3, %ecx
	movl $3, %edx
	int $0x80
for5: 
	movl columnIndex, %ecx
	cmp %ecx, nodes
	je while1
	
	movl node, %eax
	movl $0, %edx
	mull nodes
	addl columnIndex, %eax
	lea matrix, %edi
	movl (%edi, %eax, 4), %ecx
	movl $1, %ebx
	cmp %ecx, %ebx
	jne increment_for5
	
	movl columnIndex, %eax
	lea visited, %edi
	movl (%edi, %eax, 4), %ecx
	movl $0, %ebx
	cmp %ecx, %ebx
	jne increment_for5
	
	movl queueSize, %eax
	lea queue, %edi
	movl columnIndex, %ecx
	movl %ecx, (%edi, %eax, 4)
	incl queueSize
	movl columnIndex, %eax
	lea visited, %edi
	movl $1, (%edi, %eax, 4)
	incl counter
	jmp for5
	
increment_for5:
	incl columnIndex
	jmp for5
	
print1:
	movl $4, %eax
	movl $1, %ebx
	mov $string2, %ecx
	movl $2, %edx
	int $0x80
	
	movl counter, %ecx
	cmp %ecx, nodes
	je print_yes
	
print_no:
	movl $4, %eax
	movl $1, %ebx
	mov $string_no, %ecx
	movl $3, %edx
	int $0x80
	jmp exit
	
print_yes:
	movl $4, %eax
	movl $1, %ebx
	mov $string_yes, %ecx
	movl $4, %edx
	int $0x80
	jmp exit
	
task3:
	pushl $host1
	pushl $formatRead1
	call scanf
	popl %ebx
	popl %ebx

	pushl $host2
	pushl $formatRead1
	call scanf
	popl %ebx
	popl %ebx
	
	push $word
	push $formatRead2
	call scanf
	pop %ebx
	pop %ebx
	
	movl $0, %eax
	lea queue, %edi
	movl host1, %ebx
	movl %ebx, (%edi, %eax, 4)
	movl $1, queueSize
	lea visited, %edi
	movl host1, %eax
	movl $1, (%edi, %eax, 4)
	movl $1, counter
	movl $0, queueIndex
while2:
	movl $0, columnIndex
	movl queueIndex, %ecx
	movl queueSize, %ebx
	cmp %ecx, %ebx
	je print2
	
	lea queue, %edi
	movl queueIndex, %eax
	movl (%edi, %eax, 4), %ecx
	movl %ecx, node
	incl queueIndex
	
for6: 
	movl columnIndex, %ecx
	cmp %ecx, nodes
	je while2
	
	movl node, %eax
	movl $0, %edx
	mull nodes
	addl columnIndex, %eax
	lea matrix, %edi
	movl (%edi, %eax, 4), %ecx
	movl $1, %ebx
	cmp %ecx, %ebx
	jne increment_for6
	
	lea roles, %edi
	movl columnIndex, %eax
	movl (%edi, %eax, 4), %ecx
	movl $3, %ebx
	cmp %ecx, %ebx
	je increment_for6
	
	movl columnIndex, %eax
	lea visited, %edi
	movl (%edi, %eax, 4), %ecx
	movl $0, %ebx
	cmp %ecx, %ebx
	jne increment_for6
	
	movl queueSize, %eax
	lea queue, %edi
	movl columnIndex, %ecx
	movl %ecx, (%edi, %eax, 4)
	
	incl queueSize
	movl columnIndex, %eax
	lea visited, %edi
	movl $1, (%edi, %eax, 4)
	incl counter
	jmp for6
	
increment_for6:
	incl columnIndex
	jmp for6
	
print2:
	lea visited, %edi
	movl host2, %eax
	movl (%edi, %eax, 4), %ecx
	movl $1, %ebx
	cmp %ecx, %ebx
	je print_word
	
print_new_word:
	movl $0, index
	
for7:
	movl $0, %eax
	lea word, %edi
	movl index, %ecx
	movb (%edi, %ecx, 1), %al
	cmp $0, %al
	je print_wordd
	
	subb $10, %al
	cmp $97, %al
	jg increment_for7
	
	movb %al, letter
	
	push letter
	push $formatPrint
	call printf
	pop %ebx
	pop %ebx
	
	movb letter, %al
	addb $26, %al
	
increment_for7:
	lea word, %edi
	movl index, %ecx
	movb %al, (%edi, %ecx, 1)
	incl index
	jmp for7
	
print_word:
	lea word, %edi
	movl $0, index
	
for8:
	movl index, %ecx
	movb (%edi, %ecx, 1), %al
	cmp $0, %al
	je print_wordd
	
	incl index
	jmp for8
	
print_wordd:
	movl index, %ecx
	movl %ecx, len
	
	movl $4, %eax
	movl $1, %ebx
	mov $word, %ecx
	movl len, %edx
	int $0x80

exit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80

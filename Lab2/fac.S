.text
	.global	zero		@ 声明全局常量变量 zero
	.section .rodata
	.align	2
	.type	zero, %object	
	.size	zero, 4
	.text
	.align	2
zero:
	.space	4				@ 分配4字节的空间给 zero
	.align	2
_str0:
	.ascii	"%d"			@ 字符串常量 "%d"
	.align	2
_str1:
	.ascii	"%d\n"			@ 字符串常量 "%d\n"
	.align	2

factorial:				@ 定义函数 int factorial(int n)
	str lr, [sp,#-4]! 		@ 保存当前函数的返回地址
        str r0, [sp,#-4]!  	@ 保存 n
	mov	r1, #1		    @ 初始化 sum=1
	b	loop				@ 跳转到循环开始处
loop:		                @ 循环开始
	cmp r0,	#0	        @ 比较 n 和 0
	ble	end		        @ 如果 n <= 0，则跳转到结束处
	mul	r1,	r0	        @ sum = sum * n
	sub	r0,	r0,	#1	    @ n = n - 1
	b	loop		        @ 继续循环
end:
	add	sp,	sp, #4		@ 释放 n 的空间
	ldr	lr,	[sp], #4	@ 恢复返回地址
	bx	lr				    @ 返回

	.global main
main:
    str lr, [sp,#-4]!   	@ 保存当前函数的返回地址
    sub sp, sp, #4    	@ 开辟空间给 n
	mov r1, sp			@ r1 = &n
	ldr	r0,	_bridge+4	@ 加载字符串常量 "%d" 到 r0
	bl	__isoc99_scanf	@ 调用 scanf 函数读取输入到 n

	ldr	r0, [sp]		@ 加载 n
	bl	factorial		@ 调用 factorial 函数

	mov r2, r1			@ r2 = r1 = factorial(n)
	ldr r0, _bridge+8	@ 加载字符串常量 "%d\n" 到 r0
	bl	printf			@ 调用 printf 函数打印结果

	add	sp,	sp,	#4		@ 释放 n 的空间
	ldr	lr,	[sp], #4	@ 恢复返回地址
	bx	lr				    @ 退出

_bridge:
	.word	zero			@ zero 的地址
	.word	_str0			@ _str0 的地址
	.word	_str1			@ _str1 的地址


	
.PHONY:test,clean
2 test:
3 arm-linux-gnueabihf-gcc example.S -o example.out
4 qemu-arm -L /usr/arm-linux-gnueabihf ./example.out
5 clean:
6 rm -fr example.out

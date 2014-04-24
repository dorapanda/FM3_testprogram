#
# なんとなく作ってみた
#

# CPUアーキテクチャ
ARCH = arm-elf-eabi

CFLAGS = -Wall -mlittle-endian -march=armv7-m -mcpu=cortex-m3 -mthumb
CFLAGS += -I.
CFLAGS += -g

# リンカ設定/共有ライブラリリンク/リンカスクリプト link/ライブラリパス ./
LFLAGS = -static -T linker -L.


# 各ツール名定義
AR		= $(ARCH)-ar
AS		= $(ARCH)-as
CC		= $(ARCH)-gcc
LD		= $(ARCH)-ld
NM		= $(ARCH)-nm
OBJCOPY	= $(ARCH)-objcopy
OBJDUMP	= $(ARCH)-objdump
RAMLIB	= $(ARCH)-ranlib
STRIP	= $(ARCH)-strip

# コンパイル対象
OBJS	= startup.o
OBJS	+= main.o

# 生成バイナリ名
TARGET	= testprog

all:	$(TARGET)
$(TARGET) :	$(OBJS)
	$(CC) -o $@ $(OBJS) $(CFLAGS) $(LFLAGS)

.c.o :		$<
	$(CC) -c $(CFLAGS) $<
	
.s.o :		$<
	$(CC) -c $(CFLAGS) $<
	

clean:
	rm -f *.o
	rm $(TARGET)

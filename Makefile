#
# �Ȃ�ƂȂ�����Ă݂�
#

# CPU�A�[�L�e�N�`��
ARCH = arm-elf-eabi

CFLAGS = -Wall -mlittle-endian -march=armv7-m -mcpu=cortex-m3 -mthumb
CFLAGS += -I.
CFLAGS += -g

# �����J�ݒ�/���L���C�u���������N/�����J�X�N���v�g link/���C�u�����p�X ./
LFLAGS = -static -T linker -L.


# �e�c�[������`
AR		= $(ARCH)-ar
AS		= $(ARCH)-as
CC		= $(ARCH)-gcc
LD		= $(ARCH)-ld
NM		= $(ARCH)-nm
OBJCOPY	= $(ARCH)-objcopy
OBJDUMP	= $(ARCH)-objdump
RAMLIB	= $(ARCH)-ranlib
STRIP	= $(ARCH)-strip

# �R���p�C���Ώ�
OBJS	= startup.o
OBJS	+= main.o

# �����o�C�i����
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

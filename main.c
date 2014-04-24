#include <string.h>


int main(void)
{
	int a = 0;
	// ÇŸÇ∞Å[
	while (1) {
		a++;
		memset(&a, 0, 1);
	}
	return a;
}



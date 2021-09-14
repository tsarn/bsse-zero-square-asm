#include <stdio.h>
#include <stdlib.h>

unsigned char *array;
size_t nelem;
int *psumx;
int *psumy;
int *dp;
size_t i;
size_t j;
size_t k;
int width;
int height;
int H;
int tmp;

int main() {
    scanf("%d%d", &width, &height);
    H = height + 1;
    nelem = (width + 1) * H;

    array = calloc(nelem, 1);
    psumx = calloc(nelem, 4);
    psumy = calloc(nelem, 4);
    dp = calloc(nelem, 4);

    k = 0;
    for (i = 0; i < width; ++i) {
        for (j = 0; j < height; ++j, ++k) {
            scanf("%d", &tmp);
            array[k] = tmp;
            psumx[k+H] = psumx[k] + array[k];
            psumy[k+1] = psumy[k] + array[k];

            if (tmp == 0) {
                for (tmp = 0; tmp <= dp[k]; ++tmp) {
                    if (psumx[k] == psumx[k-tmp*H] &&
                        psumy[k] == psumy[k-tmp]) {
                        dp[k+H+1] = tmp + 1;
                    } else {
                        break;
                    }
                }
            }
        }
        ++k;
    }

    k = H+1;
    for (i = 0; i < width; ++i) {
        for (j = 0; j < height; ++j, ++k) {
            printf("%d ", dp[k]);
        }
        puts("");
        ++k;
    }

    return 0;
}

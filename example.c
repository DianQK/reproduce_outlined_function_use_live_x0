typedef struct {
    double v1;
    double v2;
} D16;

typedef struct {
    D16 v1;
    D16 v2;
} D32;

typedef long long LL8;
typedef struct {
    long long v1;
    long long v2;
} LL16;
typedef struct {
    LL16 v1;
    LL16 v2;
} LL32;

typedef struct {
    LL32 v1;
    LL32 v2;
} LL64;

LL8 needx0(LL8 v0, LL8 v1);

void bar(LL64 v1, LL32 v2, LL16 v3, LL32 v4, LL8 v5, D16 v6, D16 v7, D16 v8);

LL8 foo(LL8 v0, LL64 v1, LL32 v2, LL16 v3, LL32 v4, LL8 v5, D16 v6, D16 v7, D16 v8)
{
  LL8 result = needx0(v0, 0);
  bar(v1, v2, v3, v4, v5, v6, v7, v8);
  return result + 1;
}

LL8 foo1(LL8 v0)
{
  LL8 result = needx0(v0, 0);
  return result + 1;
}

int foo2(LL8 v0)
{
  int result = needx0(v0, 0);
  return result + 2;
}

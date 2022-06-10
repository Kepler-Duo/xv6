
_init：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	53                   	push   %ebx
  12:	51                   	push   %ecx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
  13:	83 ec 08             	sub    $0x8,%esp
  16:	6a 02                	push   $0x2
  18:	68 28 08 00 00       	push   $0x828
  1d:	e8 71 03 00 00       	call   393 <open>
  22:	83 c4 10             	add    $0x10,%esp
  25:	85 c0                	test   %eax,%eax
  27:	0f 88 9b 00 00 00    	js     c8 <main+0xc8>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  2d:	83 ec 0c             	sub    $0xc,%esp
  30:	6a 00                	push   $0x0
  32:	e8 94 03 00 00       	call   3cb <dup>
  dup(0);  // stderr
  37:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3e:	e8 88 03 00 00       	call   3cb <dup>
  43:	83 c4 10             	add    $0x10,%esp
  46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  4d:	8d 76 00             	lea    0x0(%esi),%esi

  for(;;){
    printf(1, "init: starting sh\n");
  50:	83 ec 08             	sub    $0x8,%esp
  53:	68 30 08 00 00       	push   $0x830
  58:	6a 01                	push   $0x1
  5a:	e8 61 04 00 00       	call   4c0 <printf>
    pid = fork();
  5f:	e8 e7 02 00 00       	call   34b <fork>
    if(pid < 0){
  64:	83 c4 10             	add    $0x10,%esp
    pid = fork();
  67:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  69:	85 c0                	test   %eax,%eax
  6b:	78 24                	js     91 <main+0x91>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  6d:	74 35                	je     a4 <main+0xa4>
  6f:	90                   	nop
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  70:	e8 e6 02 00 00       	call   35b <wait>
  75:	85 c0                	test   %eax,%eax
  77:	78 d7                	js     50 <main+0x50>
  79:	39 c3                	cmp    %eax,%ebx
  7b:	74 d3                	je     50 <main+0x50>
      printf(1, "zombie!\n");
  7d:	83 ec 08             	sub    $0x8,%esp
  80:	68 6f 08 00 00       	push   $0x86f
  85:	6a 01                	push   $0x1
  87:	e8 34 04 00 00       	call   4c0 <printf>
  8c:	83 c4 10             	add    $0x10,%esp
  8f:	eb df                	jmp    70 <main+0x70>
      printf(1, "init: fork failed\n");
  91:	53                   	push   %ebx
  92:	53                   	push   %ebx
  93:	68 43 08 00 00       	push   $0x843
  98:	6a 01                	push   $0x1
  9a:	e8 21 04 00 00       	call   4c0 <printf>
      exit();
  9f:	e8 af 02 00 00       	call   353 <exit>
      exec("sh", argv);
  a4:	50                   	push   %eax
  a5:	50                   	push   %eax
  a6:	68 2c 0b 00 00       	push   $0xb2c
  ab:	68 56 08 00 00       	push   $0x856
  b0:	e8 d6 02 00 00       	call   38b <exec>
      printf(1, "init: exec sh failed\n");
  b5:	5a                   	pop    %edx
  b6:	59                   	pop    %ecx
  b7:	68 59 08 00 00       	push   $0x859
  bc:	6a 01                	push   $0x1
  be:	e8 fd 03 00 00       	call   4c0 <printf>
      exit();
  c3:	e8 8b 02 00 00       	call   353 <exit>
    mknod("console", 1, 1);
  c8:	50                   	push   %eax
  c9:	6a 01                	push   $0x1
  cb:	6a 01                	push   $0x1
  cd:	68 28 08 00 00       	push   $0x828
  d2:	e8 c4 02 00 00       	call   39b <mknod>
    open("console", O_RDWR);
  d7:	58                   	pop    %eax
  d8:	5a                   	pop    %edx
  d9:	6a 02                	push   $0x2
  db:	68 28 08 00 00       	push   $0x828
  e0:	e8 ae 02 00 00       	call   393 <open>
  e5:	83 c4 10             	add    $0x10,%esp
  e8:	e9 40 ff ff ff       	jmp    2d <main+0x2d>
  ed:	66 90                	xchg   %ax,%ax
  ef:	90                   	nop

000000f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  f0:	f3 0f 1e fb          	endbr32 
  f4:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  f5:	31 c0                	xor    %eax,%eax
{
  f7:	89 e5                	mov    %esp,%ebp
  f9:	53                   	push   %ebx
  fa:	8b 4d 08             	mov    0x8(%ebp),%ecx
  fd:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
 100:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 104:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 107:	83 c0 01             	add    $0x1,%eax
 10a:	84 d2                	test   %dl,%dl
 10c:	75 f2                	jne    100 <strcpy+0x10>
    ;
  return os;
}
 10e:	89 c8                	mov    %ecx,%eax
 110:	5b                   	pop    %ebx
 111:	5d                   	pop    %ebp
 112:	c3                   	ret    
 113:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 11a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000120 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 120:	f3 0f 1e fb          	endbr32 
 124:	55                   	push   %ebp
 125:	89 e5                	mov    %esp,%ebp
 127:	53                   	push   %ebx
 128:	8b 4d 08             	mov    0x8(%ebp),%ecx
 12b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 12e:	0f b6 01             	movzbl (%ecx),%eax
 131:	0f b6 1a             	movzbl (%edx),%ebx
 134:	84 c0                	test   %al,%al
 136:	75 19                	jne    151 <strcmp+0x31>
 138:	eb 26                	jmp    160 <strcmp+0x40>
 13a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 140:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 144:	83 c1 01             	add    $0x1,%ecx
 147:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 14a:	0f b6 1a             	movzbl (%edx),%ebx
 14d:	84 c0                	test   %al,%al
 14f:	74 0f                	je     160 <strcmp+0x40>
 151:	38 d8                	cmp    %bl,%al
 153:	74 eb                	je     140 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 155:	29 d8                	sub    %ebx,%eax
}
 157:	5b                   	pop    %ebx
 158:	5d                   	pop    %ebp
 159:	c3                   	ret    
 15a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 160:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 162:	29 d8                	sub    %ebx,%eax
}
 164:	5b                   	pop    %ebx
 165:	5d                   	pop    %ebp
 166:	c3                   	ret    
 167:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 16e:	66 90                	xchg   %ax,%ax

00000170 <strlen>:

uint
strlen(char *s)
{
 170:	f3 0f 1e fb          	endbr32 
 174:	55                   	push   %ebp
 175:	89 e5                	mov    %esp,%ebp
 177:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 17a:	80 3a 00             	cmpb   $0x0,(%edx)
 17d:	74 21                	je     1a0 <strlen+0x30>
 17f:	31 c0                	xor    %eax,%eax
 181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 188:	83 c0 01             	add    $0x1,%eax
 18b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 18f:	89 c1                	mov    %eax,%ecx
 191:	75 f5                	jne    188 <strlen+0x18>
    ;
  return n;
}
 193:	89 c8                	mov    %ecx,%eax
 195:	5d                   	pop    %ebp
 196:	c3                   	ret    
 197:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 19e:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 1a0:	31 c9                	xor    %ecx,%ecx
}
 1a2:	5d                   	pop    %ebp
 1a3:	89 c8                	mov    %ecx,%eax
 1a5:	c3                   	ret    
 1a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ad:	8d 76 00             	lea    0x0(%esi),%esi

000001b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1b0:	f3 0f 1e fb          	endbr32 
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	57                   	push   %edi
 1b8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1bb:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1be:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c1:	89 d7                	mov    %edx,%edi
 1c3:	fc                   	cld    
 1c4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1c6:	89 d0                	mov    %edx,%eax
 1c8:	5f                   	pop    %edi
 1c9:	5d                   	pop    %ebp
 1ca:	c3                   	ret    
 1cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1cf:	90                   	nop

000001d0 <strchr>:

char*
strchr(const char *s, char c)
{
 1d0:	f3 0f 1e fb          	endbr32 
 1d4:	55                   	push   %ebp
 1d5:	89 e5                	mov    %esp,%ebp
 1d7:	8b 45 08             	mov    0x8(%ebp),%eax
 1da:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1de:	0f b6 10             	movzbl (%eax),%edx
 1e1:	84 d2                	test   %dl,%dl
 1e3:	75 16                	jne    1fb <strchr+0x2b>
 1e5:	eb 21                	jmp    208 <strchr+0x38>
 1e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ee:	66 90                	xchg   %ax,%ax
 1f0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 1f4:	83 c0 01             	add    $0x1,%eax
 1f7:	84 d2                	test   %dl,%dl
 1f9:	74 0d                	je     208 <strchr+0x38>
    if(*s == c)
 1fb:	38 d1                	cmp    %dl,%cl
 1fd:	75 f1                	jne    1f0 <strchr+0x20>
      return (char*)s;
  return 0;
}
 1ff:	5d                   	pop    %ebp
 200:	c3                   	ret    
 201:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 208:	31 c0                	xor    %eax,%eax
}
 20a:	5d                   	pop    %ebp
 20b:	c3                   	ret    
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000210 <gets>:

char*
gets(char *buf, int max)
{
 210:	f3 0f 1e fb          	endbr32 
 214:	55                   	push   %ebp
 215:	89 e5                	mov    %esp,%ebp
 217:	57                   	push   %edi
 218:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 219:	31 f6                	xor    %esi,%esi
{
 21b:	53                   	push   %ebx
 21c:	89 f3                	mov    %esi,%ebx
 21e:	83 ec 1c             	sub    $0x1c,%esp
 221:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 224:	eb 33                	jmp    259 <gets+0x49>
 226:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 22d:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 230:	83 ec 04             	sub    $0x4,%esp
 233:	8d 45 e7             	lea    -0x19(%ebp),%eax
 236:	6a 01                	push   $0x1
 238:	50                   	push   %eax
 239:	6a 00                	push   $0x0
 23b:	e8 2b 01 00 00       	call   36b <read>
    if(cc < 1)
 240:	83 c4 10             	add    $0x10,%esp
 243:	85 c0                	test   %eax,%eax
 245:	7e 1c                	jle    263 <gets+0x53>
      break;
    buf[i++] = c;
 247:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 24b:	83 c7 01             	add    $0x1,%edi
 24e:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 251:	3c 0a                	cmp    $0xa,%al
 253:	74 23                	je     278 <gets+0x68>
 255:	3c 0d                	cmp    $0xd,%al
 257:	74 1f                	je     278 <gets+0x68>
  for(i=0; i+1 < max; ){
 259:	83 c3 01             	add    $0x1,%ebx
 25c:	89 fe                	mov    %edi,%esi
 25e:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 261:	7c cd                	jl     230 <gets+0x20>
 263:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 265:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 268:	c6 03 00             	movb   $0x0,(%ebx)
}
 26b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 26e:	5b                   	pop    %ebx
 26f:	5e                   	pop    %esi
 270:	5f                   	pop    %edi
 271:	5d                   	pop    %ebp
 272:	c3                   	ret    
 273:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 277:	90                   	nop
 278:	8b 75 08             	mov    0x8(%ebp),%esi
 27b:	8b 45 08             	mov    0x8(%ebp),%eax
 27e:	01 de                	add    %ebx,%esi
 280:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 282:	c6 03 00             	movb   $0x0,(%ebx)
}
 285:	8d 65 f4             	lea    -0xc(%ebp),%esp
 288:	5b                   	pop    %ebx
 289:	5e                   	pop    %esi
 28a:	5f                   	pop    %edi
 28b:	5d                   	pop    %ebp
 28c:	c3                   	ret    
 28d:	8d 76 00             	lea    0x0(%esi),%esi

00000290 <stat>:

int
stat(char *n, struct stat *st)
{
 290:	f3 0f 1e fb          	endbr32 
 294:	55                   	push   %ebp
 295:	89 e5                	mov    %esp,%ebp
 297:	56                   	push   %esi
 298:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 299:	83 ec 08             	sub    $0x8,%esp
 29c:	6a 00                	push   $0x0
 29e:	ff 75 08             	pushl  0x8(%ebp)
 2a1:	e8 ed 00 00 00       	call   393 <open>
  if(fd < 0)
 2a6:	83 c4 10             	add    $0x10,%esp
 2a9:	85 c0                	test   %eax,%eax
 2ab:	78 2b                	js     2d8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 2ad:	83 ec 08             	sub    $0x8,%esp
 2b0:	ff 75 0c             	pushl  0xc(%ebp)
 2b3:	89 c3                	mov    %eax,%ebx
 2b5:	50                   	push   %eax
 2b6:	e8 f0 00 00 00       	call   3ab <fstat>
  close(fd);
 2bb:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2be:	89 c6                	mov    %eax,%esi
  close(fd);
 2c0:	e8 b6 00 00 00       	call   37b <close>
  return r;
 2c5:	83 c4 10             	add    $0x10,%esp
}
 2c8:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2cb:	89 f0                	mov    %esi,%eax
 2cd:	5b                   	pop    %ebx
 2ce:	5e                   	pop    %esi
 2cf:	5d                   	pop    %ebp
 2d0:	c3                   	ret    
 2d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 2d8:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2dd:	eb e9                	jmp    2c8 <stat+0x38>
 2df:	90                   	nop

000002e0 <atoi>:

int
atoi(const char *s)
{
 2e0:	f3 0f 1e fb          	endbr32 
 2e4:	55                   	push   %ebp
 2e5:	89 e5                	mov    %esp,%ebp
 2e7:	53                   	push   %ebx
 2e8:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2eb:	0f be 02             	movsbl (%edx),%eax
 2ee:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2f1:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2f4:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2f9:	77 1a                	ja     315 <atoi+0x35>
 2fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2ff:	90                   	nop
    n = n*10 + *s++ - '0';
 300:	83 c2 01             	add    $0x1,%edx
 303:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 306:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 30a:	0f be 02             	movsbl (%edx),%eax
 30d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 310:	80 fb 09             	cmp    $0x9,%bl
 313:	76 eb                	jbe    300 <atoi+0x20>
  return n;
}
 315:	89 c8                	mov    %ecx,%eax
 317:	5b                   	pop    %ebx
 318:	5d                   	pop    %ebp
 319:	c3                   	ret    
 31a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000320 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 320:	f3 0f 1e fb          	endbr32 
 324:	55                   	push   %ebp
 325:	89 e5                	mov    %esp,%ebp
 327:	57                   	push   %edi
 328:	8b 45 10             	mov    0x10(%ebp),%eax
 32b:	8b 55 08             	mov    0x8(%ebp),%edx
 32e:	56                   	push   %esi
 32f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 332:	85 c0                	test   %eax,%eax
 334:	7e 0f                	jle    345 <memmove+0x25>
 336:	01 d0                	add    %edx,%eax
  dst = vdst;
 338:	89 d7                	mov    %edx,%edi
 33a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 340:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 341:	39 f8                	cmp    %edi,%eax
 343:	75 fb                	jne    340 <memmove+0x20>
  return vdst;
}
 345:	5e                   	pop    %esi
 346:	89 d0                	mov    %edx,%eax
 348:	5f                   	pop    %edi
 349:	5d                   	pop    %ebp
 34a:	c3                   	ret    

0000034b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 34b:	b8 01 00 00 00       	mov    $0x1,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <exit>:
SYSCALL(exit)
 353:	b8 02 00 00 00       	mov    $0x2,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <wait>:
SYSCALL(wait)
 35b:	b8 03 00 00 00       	mov    $0x3,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <pipe>:
SYSCALL(pipe)
 363:	b8 04 00 00 00       	mov    $0x4,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <read>:
SYSCALL(read)
 36b:	b8 05 00 00 00       	mov    $0x5,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <write>:
SYSCALL(write)
 373:	b8 10 00 00 00       	mov    $0x10,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <close>:
SYSCALL(close)
 37b:	b8 15 00 00 00       	mov    $0x15,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <kill>:
SYSCALL(kill)
 383:	b8 06 00 00 00       	mov    $0x6,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <exec>:
SYSCALL(exec)
 38b:	b8 07 00 00 00       	mov    $0x7,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <open>:
SYSCALL(open)
 393:	b8 0f 00 00 00       	mov    $0xf,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <mknod>:
SYSCALL(mknod)
 39b:	b8 11 00 00 00       	mov    $0x11,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <unlink>:
SYSCALL(unlink)
 3a3:	b8 12 00 00 00       	mov    $0x12,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <fstat>:
SYSCALL(fstat)
 3ab:	b8 08 00 00 00       	mov    $0x8,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <link>:
SYSCALL(link)
 3b3:	b8 13 00 00 00       	mov    $0x13,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <mkdir>:
SYSCALL(mkdir)
 3bb:	b8 14 00 00 00       	mov    $0x14,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <chdir>:
SYSCALL(chdir)
 3c3:	b8 09 00 00 00       	mov    $0x9,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <dup>:
SYSCALL(dup)
 3cb:	b8 0a 00 00 00       	mov    $0xa,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <getpid>:
SYSCALL(getpid)
 3d3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <sbrk>:
SYSCALL(sbrk)
 3db:	b8 0c 00 00 00       	mov    $0xc,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <sleep>:
SYSCALL(sleep)
 3e3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <uptime>:
SYSCALL(uptime)
 3eb:	b8 0e 00 00 00       	mov    $0xe,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <clone>:

SYSCALL(clone)
 3f3:	b8 16 00 00 00       	mov    $0x16,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <join>:
 3fb:	b8 17 00 00 00       	mov    $0x17,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    
 403:	66 90                	xchg   %ax,%ax
 405:	66 90                	xchg   %ax,%ax
 407:	66 90                	xchg   %ax,%ax
 409:	66 90                	xchg   %ax,%ax
 40b:	66 90                	xchg   %ax,%ax
 40d:	66 90                	xchg   %ax,%ax
 40f:	90                   	nop

00000410 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	83 ec 3c             	sub    $0x3c,%esp
 419:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 41c:	89 d1                	mov    %edx,%ecx
{
 41e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 421:	85 d2                	test   %edx,%edx
 423:	0f 89 7f 00 00 00    	jns    4a8 <printint+0x98>
 429:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 42d:	74 79                	je     4a8 <printint+0x98>
    neg = 1;
 42f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 436:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 438:	31 db                	xor    %ebx,%ebx
 43a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 43d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 440:	89 c8                	mov    %ecx,%eax
 442:	31 d2                	xor    %edx,%edx
 444:	89 cf                	mov    %ecx,%edi
 446:	f7 75 c4             	divl   -0x3c(%ebp)
 449:	0f b6 92 80 08 00 00 	movzbl 0x880(%edx),%edx
 450:	89 45 c0             	mov    %eax,-0x40(%ebp)
 453:	89 d8                	mov    %ebx,%eax
 455:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 458:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 45b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 45e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 461:	76 dd                	jbe    440 <printint+0x30>
  if(neg)
 463:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 466:	85 c9                	test   %ecx,%ecx
 468:	74 0c                	je     476 <printint+0x66>
    buf[i++] = '-';
 46a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 46f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 471:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 476:	8b 7d b8             	mov    -0x48(%ebp),%edi
 479:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 47d:	eb 07                	jmp    486 <printint+0x76>
 47f:	90                   	nop
 480:	0f b6 13             	movzbl (%ebx),%edx
 483:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 486:	83 ec 04             	sub    $0x4,%esp
 489:	88 55 d7             	mov    %dl,-0x29(%ebp)
 48c:	6a 01                	push   $0x1
 48e:	56                   	push   %esi
 48f:	57                   	push   %edi
 490:	e8 de fe ff ff       	call   373 <write>
  while(--i >= 0)
 495:	83 c4 10             	add    $0x10,%esp
 498:	39 de                	cmp    %ebx,%esi
 49a:	75 e4                	jne    480 <printint+0x70>
    putc(fd, buf[i]);
}
 49c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 49f:	5b                   	pop    %ebx
 4a0:	5e                   	pop    %esi
 4a1:	5f                   	pop    %edi
 4a2:	5d                   	pop    %ebp
 4a3:	c3                   	ret    
 4a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4a8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 4af:	eb 87                	jmp    438 <printint+0x28>
 4b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4bf:	90                   	nop

000004c0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4c0:	f3 0f 1e fb          	endbr32 
 4c4:	55                   	push   %ebp
 4c5:	89 e5                	mov    %esp,%ebp
 4c7:	57                   	push   %edi
 4c8:	56                   	push   %esi
 4c9:	53                   	push   %ebx
 4ca:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4cd:	8b 75 0c             	mov    0xc(%ebp),%esi
 4d0:	0f b6 1e             	movzbl (%esi),%ebx
 4d3:	84 db                	test   %bl,%bl
 4d5:	0f 84 b4 00 00 00    	je     58f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 4db:	8d 45 10             	lea    0x10(%ebp),%eax
 4de:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 4e1:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 4e4:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 4e6:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4e9:	eb 33                	jmp    51e <printf+0x5e>
 4eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4ef:	90                   	nop
 4f0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4f3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 4f8:	83 f8 25             	cmp    $0x25,%eax
 4fb:	74 17                	je     514 <printf+0x54>
  write(fd, &c, 1);
 4fd:	83 ec 04             	sub    $0x4,%esp
 500:	88 5d e7             	mov    %bl,-0x19(%ebp)
 503:	6a 01                	push   $0x1
 505:	57                   	push   %edi
 506:	ff 75 08             	pushl  0x8(%ebp)
 509:	e8 65 fe ff ff       	call   373 <write>
 50e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 511:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 514:	0f b6 1e             	movzbl (%esi),%ebx
 517:	83 c6 01             	add    $0x1,%esi
 51a:	84 db                	test   %bl,%bl
 51c:	74 71                	je     58f <printf+0xcf>
    c = fmt[i] & 0xff;
 51e:	0f be cb             	movsbl %bl,%ecx
 521:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 524:	85 d2                	test   %edx,%edx
 526:	74 c8                	je     4f0 <printf+0x30>
      }
    } else if(state == '%'){
 528:	83 fa 25             	cmp    $0x25,%edx
 52b:	75 e7                	jne    514 <printf+0x54>
      if(c == 'd'){
 52d:	83 f8 64             	cmp    $0x64,%eax
 530:	0f 84 9a 00 00 00    	je     5d0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 536:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 53c:	83 f9 70             	cmp    $0x70,%ecx
 53f:	74 5f                	je     5a0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 541:	83 f8 73             	cmp    $0x73,%eax
 544:	0f 84 d6 00 00 00    	je     620 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 54a:	83 f8 63             	cmp    $0x63,%eax
 54d:	0f 84 8d 00 00 00    	je     5e0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 553:	83 f8 25             	cmp    $0x25,%eax
 556:	0f 84 b4 00 00 00    	je     610 <printf+0x150>
  write(fd, &c, 1);
 55c:	83 ec 04             	sub    $0x4,%esp
 55f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 563:	6a 01                	push   $0x1
 565:	57                   	push   %edi
 566:	ff 75 08             	pushl  0x8(%ebp)
 569:	e8 05 fe ff ff       	call   373 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 56e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 571:	83 c4 0c             	add    $0xc,%esp
 574:	6a 01                	push   $0x1
 576:	83 c6 01             	add    $0x1,%esi
 579:	57                   	push   %edi
 57a:	ff 75 08             	pushl  0x8(%ebp)
 57d:	e8 f1 fd ff ff       	call   373 <write>
  for(i = 0; fmt[i]; i++){
 582:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 586:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 589:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 58b:	84 db                	test   %bl,%bl
 58d:	75 8f                	jne    51e <printf+0x5e>
    }
  }
}
 58f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 592:	5b                   	pop    %ebx
 593:	5e                   	pop    %esi
 594:	5f                   	pop    %edi
 595:	5d                   	pop    %ebp
 596:	c3                   	ret    
 597:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 59e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 5a0:	83 ec 0c             	sub    $0xc,%esp
 5a3:	b9 10 00 00 00       	mov    $0x10,%ecx
 5a8:	6a 00                	push   $0x0
 5aa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5ad:	8b 45 08             	mov    0x8(%ebp),%eax
 5b0:	8b 13                	mov    (%ebx),%edx
 5b2:	e8 59 fe ff ff       	call   410 <printint>
        ap++;
 5b7:	89 d8                	mov    %ebx,%eax
 5b9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5bc:	31 d2                	xor    %edx,%edx
        ap++;
 5be:	83 c0 04             	add    $0x4,%eax
 5c1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5c4:	e9 4b ff ff ff       	jmp    514 <printf+0x54>
 5c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 5d0:	83 ec 0c             	sub    $0xc,%esp
 5d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5d8:	6a 01                	push   $0x1
 5da:	eb ce                	jmp    5aa <printf+0xea>
 5dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 5e0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 5e3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 5e6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 5e8:	6a 01                	push   $0x1
        ap++;
 5ea:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 5ed:	57                   	push   %edi
 5ee:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 5f1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5f4:	e8 7a fd ff ff       	call   373 <write>
        ap++;
 5f9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5fc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5ff:	31 d2                	xor    %edx,%edx
 601:	e9 0e ff ff ff       	jmp    514 <printf+0x54>
 606:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 60d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 610:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 613:	83 ec 04             	sub    $0x4,%esp
 616:	e9 59 ff ff ff       	jmp    574 <printf+0xb4>
 61b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 61f:	90                   	nop
        s = (char*)*ap;
 620:	8b 45 d0             	mov    -0x30(%ebp),%eax
 623:	8b 18                	mov    (%eax),%ebx
        ap++;
 625:	83 c0 04             	add    $0x4,%eax
 628:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 62b:	85 db                	test   %ebx,%ebx
 62d:	74 17                	je     646 <printf+0x186>
        while(*s != 0){
 62f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 632:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 634:	84 c0                	test   %al,%al
 636:	0f 84 d8 fe ff ff    	je     514 <printf+0x54>
 63c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 63f:	89 de                	mov    %ebx,%esi
 641:	8b 5d 08             	mov    0x8(%ebp),%ebx
 644:	eb 1a                	jmp    660 <printf+0x1a0>
          s = "(null)";
 646:	bb 78 08 00 00       	mov    $0x878,%ebx
        while(*s != 0){
 64b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 64e:	b8 28 00 00 00       	mov    $0x28,%eax
 653:	89 de                	mov    %ebx,%esi
 655:	8b 5d 08             	mov    0x8(%ebp),%ebx
 658:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 65f:	90                   	nop
  write(fd, &c, 1);
 660:	83 ec 04             	sub    $0x4,%esp
          s++;
 663:	83 c6 01             	add    $0x1,%esi
 666:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 669:	6a 01                	push   $0x1
 66b:	57                   	push   %edi
 66c:	53                   	push   %ebx
 66d:	e8 01 fd ff ff       	call   373 <write>
        while(*s != 0){
 672:	0f b6 06             	movzbl (%esi),%eax
 675:	83 c4 10             	add    $0x10,%esp
 678:	84 c0                	test   %al,%al
 67a:	75 e4                	jne    660 <printf+0x1a0>
 67c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 67f:	31 d2                	xor    %edx,%edx
 681:	e9 8e fe ff ff       	jmp    514 <printf+0x54>
 686:	66 90                	xchg   %ax,%ax
 688:	66 90                	xchg   %ax,%ax
 68a:	66 90                	xchg   %ax,%ax
 68c:	66 90                	xchg   %ax,%ax
 68e:	66 90                	xchg   %ax,%ax

00000690 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 690:	f3 0f 1e fb          	endbr32 
 694:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 695:	a1 34 0b 00 00       	mov    0xb34,%eax
{
 69a:	89 e5                	mov    %esp,%ebp
 69c:	57                   	push   %edi
 69d:	56                   	push   %esi
 69e:	53                   	push   %ebx
 69f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6a2:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 6a4:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a7:	39 c8                	cmp    %ecx,%eax
 6a9:	73 15                	jae    6c0 <free+0x30>
 6ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6af:	90                   	nop
 6b0:	39 d1                	cmp    %edx,%ecx
 6b2:	72 14                	jb     6c8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b4:	39 d0                	cmp    %edx,%eax
 6b6:	73 10                	jae    6c8 <free+0x38>
{
 6b8:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ba:	8b 10                	mov    (%eax),%edx
 6bc:	39 c8                	cmp    %ecx,%eax
 6be:	72 f0                	jb     6b0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c0:	39 d0                	cmp    %edx,%eax
 6c2:	72 f4                	jb     6b8 <free+0x28>
 6c4:	39 d1                	cmp    %edx,%ecx
 6c6:	73 f0                	jae    6b8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6c8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6cb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6ce:	39 fa                	cmp    %edi,%edx
 6d0:	74 1e                	je     6f0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6d2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6d5:	8b 50 04             	mov    0x4(%eax),%edx
 6d8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6db:	39 f1                	cmp    %esi,%ecx
 6dd:	74 28                	je     707 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6df:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 6e1:	5b                   	pop    %ebx
  freep = p;
 6e2:	a3 34 0b 00 00       	mov    %eax,0xb34
}
 6e7:	5e                   	pop    %esi
 6e8:	5f                   	pop    %edi
 6e9:	5d                   	pop    %ebp
 6ea:	c3                   	ret    
 6eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6ef:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 6f0:	03 72 04             	add    0x4(%edx),%esi
 6f3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6f6:	8b 10                	mov    (%eax),%edx
 6f8:	8b 12                	mov    (%edx),%edx
 6fa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6fd:	8b 50 04             	mov    0x4(%eax),%edx
 700:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 703:	39 f1                	cmp    %esi,%ecx
 705:	75 d8                	jne    6df <free+0x4f>
    p->s.size += bp->s.size;
 707:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 70a:	a3 34 0b 00 00       	mov    %eax,0xb34
    p->s.size += bp->s.size;
 70f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 712:	8b 53 f8             	mov    -0x8(%ebx),%edx
 715:	89 10                	mov    %edx,(%eax)
}
 717:	5b                   	pop    %ebx
 718:	5e                   	pop    %esi
 719:	5f                   	pop    %edi
 71a:	5d                   	pop    %ebp
 71b:	c3                   	ret    
 71c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000720 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 720:	f3 0f 1e fb          	endbr32 
 724:	55                   	push   %ebp
 725:	89 e5                	mov    %esp,%ebp
 727:	57                   	push   %edi
 728:	56                   	push   %esi
 729:	53                   	push   %ebx
 72a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 72d:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 730:	8b 3d 34 0b 00 00    	mov    0xb34,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 736:	8d 70 07             	lea    0x7(%eax),%esi
 739:	c1 ee 03             	shr    $0x3,%esi
 73c:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 73f:	85 ff                	test   %edi,%edi
 741:	0f 84 a9 00 00 00    	je     7f0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 747:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 749:	8b 48 04             	mov    0x4(%eax),%ecx
 74c:	39 f1                	cmp    %esi,%ecx
 74e:	73 6d                	jae    7bd <malloc+0x9d>
 750:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 756:	bb 00 10 00 00       	mov    $0x1000,%ebx
 75b:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 75e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 765:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 768:	eb 17                	jmp    781 <malloc+0x61>
 76a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 770:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 772:	8b 4a 04             	mov    0x4(%edx),%ecx
 775:	39 f1                	cmp    %esi,%ecx
 777:	73 4f                	jae    7c8 <malloc+0xa8>
 779:	8b 3d 34 0b 00 00    	mov    0xb34,%edi
 77f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 781:	39 c7                	cmp    %eax,%edi
 783:	75 eb                	jne    770 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 785:	83 ec 0c             	sub    $0xc,%esp
 788:	ff 75 e4             	pushl  -0x1c(%ebp)
 78b:	e8 4b fc ff ff       	call   3db <sbrk>
  if(p == (char*)-1)
 790:	83 c4 10             	add    $0x10,%esp
 793:	83 f8 ff             	cmp    $0xffffffff,%eax
 796:	74 1b                	je     7b3 <malloc+0x93>
  hp->s.size = nu;
 798:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 79b:	83 ec 0c             	sub    $0xc,%esp
 79e:	83 c0 08             	add    $0x8,%eax
 7a1:	50                   	push   %eax
 7a2:	e8 e9 fe ff ff       	call   690 <free>
  return freep;
 7a7:	a1 34 0b 00 00       	mov    0xb34,%eax
      if((p = morecore(nunits)) == 0)
 7ac:	83 c4 10             	add    $0x10,%esp
 7af:	85 c0                	test   %eax,%eax
 7b1:	75 bd                	jne    770 <malloc+0x50>
        return 0;
  }
}
 7b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7b6:	31 c0                	xor    %eax,%eax
}
 7b8:	5b                   	pop    %ebx
 7b9:	5e                   	pop    %esi
 7ba:	5f                   	pop    %edi
 7bb:	5d                   	pop    %ebp
 7bc:	c3                   	ret    
    if(p->s.size >= nunits){
 7bd:	89 c2                	mov    %eax,%edx
 7bf:	89 f8                	mov    %edi,%eax
 7c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 7c8:	39 ce                	cmp    %ecx,%esi
 7ca:	74 54                	je     820 <malloc+0x100>
        p->s.size -= nunits;
 7cc:	29 f1                	sub    %esi,%ecx
 7ce:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 7d1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 7d4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 7d7:	a3 34 0b 00 00       	mov    %eax,0xb34
}
 7dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7df:	8d 42 08             	lea    0x8(%edx),%eax
}
 7e2:	5b                   	pop    %ebx
 7e3:	5e                   	pop    %esi
 7e4:	5f                   	pop    %edi
 7e5:	5d                   	pop    %ebp
 7e6:	c3                   	ret    
 7e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7ee:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 7f0:	c7 05 34 0b 00 00 38 	movl   $0xb38,0xb34
 7f7:	0b 00 00 
    base.s.size = 0;
 7fa:	bf 38 0b 00 00       	mov    $0xb38,%edi
    base.s.ptr = freep = prevp = &base;
 7ff:	c7 05 38 0b 00 00 38 	movl   $0xb38,0xb38
 806:	0b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 809:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 80b:	c7 05 3c 0b 00 00 00 	movl   $0x0,0xb3c
 812:	00 00 00 
    if(p->s.size >= nunits){
 815:	e9 36 ff ff ff       	jmp    750 <malloc+0x30>
 81a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 820:	8b 0a                	mov    (%edx),%ecx
 822:	89 08                	mov    %ecx,(%eax)
 824:	eb b1                	jmp    7d7 <malloc+0xb7>

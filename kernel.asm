
kernel：     文件格式 elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc d0 b5 10 80       	mov    $0x8010b5d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 d0 30 10 80       	mov    $0x801030d0,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	f3 0f 1e fb          	endbr32 
80100044:	55                   	push   %ebp
80100045:	89 e5                	mov    %esp,%ebp
80100047:	83 ec 10             	sub    $0x10,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010004a:	68 a0 72 10 80       	push   $0x801072a0
8010004f:	68 e0 b5 10 80       	push   $0x8010b5e0
80100054:	e8 d7 44 00 00       	call   80104530 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
80100059:	83 c4 10             	add    $0x10,%esp
8010005c:	ba e4 f4 10 80       	mov    $0x8010f4e4,%edx
  bcache.head.prev = &bcache.head;
80100061:	c7 05 f0 f4 10 80 e4 	movl   $0x8010f4e4,0x8010f4f0
80100068:	f4 10 80 
  bcache.head.next = &bcache.head;
8010006b:	c7 05 f4 f4 10 80 e4 	movl   $0x8010f4e4,0x8010f4f4
80100072:	f4 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100075:	b8 14 b6 10 80       	mov    $0x8010b614,%eax
8010007a:	eb 06                	jmp    80100082 <binit+0x42>
8010007c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c8                	mov    %ecx,%eax
    b->next = bcache.head.next;
80100082:	89 50 10             	mov    %edx,0x10(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100085:	8d 88 18 02 00 00    	lea    0x218(%eax),%ecx
    b->prev = &bcache.head;
8010008b:	c7 40 0c e4 f4 10 80 	movl   $0x8010f4e4,0xc(%eax)
    b->dev = -1;
80100092:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
80100099:	8b 15 f4 f4 10 80    	mov    0x8010f4f4,%edx
8010009f:	89 42 0c             	mov    %eax,0xc(%edx)
    bcache.head.next = b;
801000a2:	89 c2                	mov    %eax,%edx
801000a4:	a3 f4 f4 10 80       	mov    %eax,0x8010f4f4
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a9:	3d cc f2 10 80       	cmp    $0x8010f2cc,%eax
801000ae:	75 d0                	jne    80100080 <binit+0x40>
  }
}
801000b0:	c9                   	leave  
801000b1:	c3                   	ret    
801000b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801000c0 <bread>:
}

// Return a B_BUSY buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000c0:	f3 0f 1e fb          	endbr32 
801000c4:	55                   	push   %ebp
801000c5:	89 e5                	mov    %esp,%ebp
801000c7:	57                   	push   %edi
801000c8:	56                   	push   %esi
801000c9:	53                   	push   %ebx
801000ca:	83 ec 18             	sub    $0x18,%esp
801000cd:	8b 7d 08             	mov    0x8(%ebp),%edi
801000d0:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&bcache.lock);
801000d3:	68 e0 b5 10 80       	push   $0x8010b5e0
801000d8:	e8 73 44 00 00       	call   80104550 <acquire>
801000dd:	83 c4 10             	add    $0x10,%esp
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e0:	8b 1d f4 f4 10 80    	mov    0x8010f4f4,%ebx
801000e6:	81 fb e4 f4 10 80    	cmp    $0x8010f4e4,%ebx
801000ec:	75 0d                	jne    801000fb <bread+0x3b>
801000ee:	eb 38                	jmp    80100128 <bread+0x68>
801000f0:	8b 5b 10             	mov    0x10(%ebx),%ebx
801000f3:	81 fb e4 f4 10 80    	cmp    $0x8010f4e4,%ebx
801000f9:	74 2d                	je     80100128 <bread+0x68>
    if(b->dev == dev && b->blockno == blockno){
801000fb:	3b 7b 04             	cmp    0x4(%ebx),%edi
801000fe:	75 f0                	jne    801000f0 <bread+0x30>
80100100:	3b 73 08             	cmp    0x8(%ebx),%esi
80100103:	75 eb                	jne    801000f0 <bread+0x30>
      if(!(b->flags & B_BUSY)){
80100105:	8b 03                	mov    (%ebx),%eax
80100107:	a8 01                	test   $0x1,%al
80100109:	0f 84 91 00 00 00    	je     801001a0 <bread+0xe0>
      sleep(b, &bcache.lock);
8010010f:	83 ec 08             	sub    $0x8,%esp
80100112:	68 e0 b5 10 80       	push   $0x8010b5e0
80100117:	53                   	push   %ebx
80100118:	e8 93 3e 00 00       	call   80103fb0 <sleep>
      goto loop;
8010011d:	83 c4 10             	add    $0x10,%esp
80100120:	eb be                	jmp    801000e0 <bread+0x20>
80100122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100128:	8b 1d f0 f4 10 80    	mov    0x8010f4f0,%ebx
8010012e:	81 fb e4 f4 10 80    	cmp    $0x8010f4e4,%ebx
80100134:	75 15                	jne    8010014b <bread+0x8b>
80100136:	eb 7f                	jmp    801001b7 <bread+0xf7>
80100138:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010013f:	90                   	nop
80100140:	8b 5b 0c             	mov    0xc(%ebx),%ebx
80100143:	81 fb e4 f4 10 80    	cmp    $0x8010f4e4,%ebx
80100149:	74 6c                	je     801001b7 <bread+0xf7>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
8010014b:	f6 03 05             	testb  $0x5,(%ebx)
8010014e:	75 f0                	jne    80100140 <bread+0x80>
      release(&bcache.lock);
80100150:	83 ec 0c             	sub    $0xc,%esp
      b->dev = dev;
80100153:	89 7b 04             	mov    %edi,0x4(%ebx)
      b->blockno = blockno;
80100156:	89 73 08             	mov    %esi,0x8(%ebx)
      b->flags = B_BUSY;
80100159:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
      release(&bcache.lock);
8010015f:	68 e0 b5 10 80       	push   $0x8010b5e0
80100164:	e8 c7 45 00 00       	call   80104730 <release>
      return b;
80100169:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if(!(b->flags & B_VALID)) {
8010016c:	f6 03 02             	testb  $0x2,(%ebx)
8010016f:	74 0f                	je     80100180 <bread+0xc0>
    iderw(b);
  }
  return b;
}
80100171:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100174:	89 d8                	mov    %ebx,%eax
80100176:	5b                   	pop    %ebx
80100177:	5e                   	pop    %esi
80100178:	5f                   	pop    %edi
80100179:	5d                   	pop    %ebp
8010017a:	c3                   	ret    
8010017b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010017f:	90                   	nop
    iderw(b);
80100180:	83 ec 0c             	sub    $0xc,%esp
80100183:	53                   	push   %ebx
80100184:	e8 e7 20 00 00       	call   80102270 <iderw>
80100189:	83 c4 10             	add    $0x10,%esp
}
8010018c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010018f:	89 d8                	mov    %ebx,%eax
80100191:	5b                   	pop    %ebx
80100192:	5e                   	pop    %esi
80100193:	5f                   	pop    %edi
80100194:	5d                   	pop    %ebp
80100195:	c3                   	ret    
80100196:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010019d:	8d 76 00             	lea    0x0(%esi),%esi
        release(&bcache.lock);
801001a0:	83 ec 0c             	sub    $0xc,%esp
        b->flags |= B_BUSY;
801001a3:	83 c8 01             	or     $0x1,%eax
801001a6:	89 03                	mov    %eax,(%ebx)
        release(&bcache.lock);
801001a8:	68 e0 b5 10 80       	push   $0x8010b5e0
801001ad:	e8 7e 45 00 00       	call   80104730 <release>
        return b;
801001b2:	83 c4 10             	add    $0x10,%esp
801001b5:	eb b5                	jmp    8010016c <bread+0xac>
  panic("bget: no buffers");
801001b7:	83 ec 0c             	sub    $0xc,%esp
801001ba:	68 a7 72 10 80       	push   $0x801072a7
801001bf:	e8 bc 01 00 00       	call   80100380 <panic>
801001c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001cf:	90                   	nop

801001d0 <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
801001d0:	f3 0f 1e fb          	endbr32 
801001d4:	55                   	push   %ebp
801001d5:	89 e5                	mov    %esp,%ebp
801001d7:	83 ec 08             	sub    $0x8,%esp
801001da:	8b 55 08             	mov    0x8(%ebp),%edx
  if((b->flags & B_BUSY) == 0)
801001dd:	8b 02                	mov    (%edx),%eax
801001df:	a8 01                	test   $0x1,%al
801001e1:	74 0b                	je     801001ee <bwrite+0x1e>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001e3:	83 c8 04             	or     $0x4,%eax
801001e6:	89 02                	mov    %eax,(%edx)
  iderw(b);
}
801001e8:	c9                   	leave  
  iderw(b);
801001e9:	e9 82 20 00 00       	jmp    80102270 <iderw>
    panic("bwrite");
801001ee:	83 ec 0c             	sub    $0xc,%esp
801001f1:	68 b8 72 10 80       	push   $0x801072b8
801001f6:	e8 85 01 00 00       	call   80100380 <panic>
801001fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001ff:	90                   	nop

80100200 <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
80100200:	f3 0f 1e fb          	endbr32 
80100204:	55                   	push   %ebp
80100205:	89 e5                	mov    %esp,%ebp
80100207:	53                   	push   %ebx
80100208:	83 ec 04             	sub    $0x4,%esp
8010020b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((b->flags & B_BUSY) == 0)
8010020e:	f6 03 01             	testb  $0x1,(%ebx)
80100211:	74 57                	je     8010026a <brelse+0x6a>
    panic("brelse");

  acquire(&bcache.lock);
80100213:	83 ec 0c             	sub    $0xc,%esp
80100216:	68 e0 b5 10 80       	push   $0x8010b5e0
8010021b:	e8 30 43 00 00       	call   80104550 <acquire>

  b->next->prev = b->prev;
80100220:	8b 53 10             	mov    0x10(%ebx),%edx
80100223:	8b 43 0c             	mov    0xc(%ebx),%eax
80100226:	89 42 0c             	mov    %eax,0xc(%edx)
  b->prev->next = b->next;
80100229:	8b 53 10             	mov    0x10(%ebx),%edx
8010022c:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
8010022f:	a1 f4 f4 10 80       	mov    0x8010f4f4,%eax
  b->prev = &bcache.head;
80100234:	c7 43 0c e4 f4 10 80 	movl   $0x8010f4e4,0xc(%ebx)
  b->next = bcache.head.next;
8010023b:	89 43 10             	mov    %eax,0x10(%ebx)
  bcache.head.next->prev = b;
8010023e:	a1 f4 f4 10 80       	mov    0x8010f4f4,%eax
80100243:	89 58 0c             	mov    %ebx,0xc(%eax)
  bcache.head.next = b;
80100246:	89 1d f4 f4 10 80    	mov    %ebx,0x8010f4f4

  b->flags &= ~B_BUSY;
8010024c:	83 23 fe             	andl   $0xfffffffe,(%ebx)
  wakeup(b);
8010024f:	89 1c 24             	mov    %ebx,(%esp)
80100252:	e8 19 3f 00 00       	call   80104170 <wakeup>

  release(&bcache.lock);
80100257:	c7 45 08 e0 b5 10 80 	movl   $0x8010b5e0,0x8(%ebp)
}
8010025e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&bcache.lock);
80100261:	83 c4 10             	add    $0x10,%esp
}
80100264:	c9                   	leave  
  release(&bcache.lock);
80100265:	e9 c6 44 00 00       	jmp    80104730 <release>
    panic("brelse");
8010026a:	83 ec 0c             	sub    $0xc,%esp
8010026d:	68 bf 72 10 80       	push   $0x801072bf
80100272:	e8 09 01 00 00       	call   80100380 <panic>
80100277:	66 90                	xchg   %ax,%ax
80100279:	66 90                	xchg   %ax,%ax
8010027b:	66 90                	xchg   %ax,%ax
8010027d:	66 90                	xchg   %ax,%ax
8010027f:	90                   	nop

80100280 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	f3 0f 1e fb          	endbr32 
80100284:	55                   	push   %ebp
80100285:	89 e5                	mov    %esp,%ebp
80100287:	57                   	push   %edi
80100288:	56                   	push   %esi
80100289:	53                   	push   %ebx
8010028a:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
8010028d:	ff 75 08             	pushl  0x8(%ebp)
{
80100290:	8b 5d 10             	mov    0x10(%ebp),%ebx
  target = n;
80100293:	89 de                	mov    %ebx,%esi
  iunlock(ip);
80100295:	e8 86 15 00 00       	call   80101820 <iunlock>
  acquire(&cons.lock);
8010029a:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801002a1:	e8 aa 42 00 00       	call   80104550 <acquire>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002a6:	8b 7d 0c             	mov    0xc(%ebp),%edi
  while(n > 0){
801002a9:	83 c4 10             	add    $0x10,%esp
    *dst++ = c;
801002ac:	01 df                	add    %ebx,%edi
  while(n > 0){
801002ae:	85 db                	test   %ebx,%ebx
801002b0:	0f 8e 97 00 00 00    	jle    8010034d <consoleread+0xcd>
    while(input.r == input.w){
801002b6:	a1 80 f7 10 80       	mov    0x8010f780,%eax
801002bb:	3b 05 84 f7 10 80    	cmp    0x8010f784,%eax
801002c1:	74 27                	je     801002ea <consoleread+0x6a>
801002c3:	eb 5b                	jmp    80100320 <consoleread+0xa0>
801002c5:	8d 76 00             	lea    0x0(%esi),%esi
      sleep(&input.r, &cons.lock);
801002c8:	83 ec 08             	sub    $0x8,%esp
801002cb:	68 20 a5 10 80       	push   $0x8010a520
801002d0:	68 80 f7 10 80       	push   $0x8010f780
801002d5:	e8 d6 3c 00 00       	call   80103fb0 <sleep>
    while(input.r == input.w){
801002da:	a1 80 f7 10 80       	mov    0x8010f780,%eax
801002df:	83 c4 10             	add    $0x10,%esp
801002e2:	3b 05 84 f7 10 80    	cmp    0x8010f784,%eax
801002e8:	75 36                	jne    80100320 <consoleread+0xa0>
      if(proc->killed){
801002ea:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801002f0:	8b 48 24             	mov    0x24(%eax),%ecx
801002f3:	85 c9                	test   %ecx,%ecx
801002f5:	74 d1                	je     801002c8 <consoleread+0x48>
        release(&cons.lock);
801002f7:	83 ec 0c             	sub    $0xc,%esp
801002fa:	68 20 a5 10 80       	push   $0x8010a520
801002ff:	e8 2c 44 00 00       	call   80104730 <release>
        ilock(ip);
80100304:	5a                   	pop    %edx
80100305:	ff 75 08             	pushl  0x8(%ebp)
80100308:	e8 03 14 00 00       	call   80101710 <ilock>
        return -1;
8010030d:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100310:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100313:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100318:	5b                   	pop    %ebx
80100319:	5e                   	pop    %esi
8010031a:	5f                   	pop    %edi
8010031b:	5d                   	pop    %ebp
8010031c:	c3                   	ret    
8010031d:	8d 76 00             	lea    0x0(%esi),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100320:	8d 50 01             	lea    0x1(%eax),%edx
80100323:	89 15 80 f7 10 80    	mov    %edx,0x8010f780
80100329:	89 c2                	mov    %eax,%edx
8010032b:	83 e2 7f             	and    $0x7f,%edx
8010032e:	0f be 8a 00 f7 10 80 	movsbl -0x7fef0900(%edx),%ecx
    if(c == C('D')){  // EOF
80100335:	80 f9 04             	cmp    $0x4,%cl
80100338:	74 38                	je     80100372 <consoleread+0xf2>
    *dst++ = c;
8010033a:	89 d8                	mov    %ebx,%eax
    --n;
8010033c:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
8010033f:	f7 d8                	neg    %eax
80100341:	88 0c 07             	mov    %cl,(%edi,%eax,1)
    if(c == '\n')
80100344:	83 f9 0a             	cmp    $0xa,%ecx
80100347:	0f 85 61 ff ff ff    	jne    801002ae <consoleread+0x2e>
  release(&cons.lock);
8010034d:	83 ec 0c             	sub    $0xc,%esp
80100350:	68 20 a5 10 80       	push   $0x8010a520
80100355:	e8 d6 43 00 00       	call   80104730 <release>
  ilock(ip);
8010035a:	58                   	pop    %eax
8010035b:	ff 75 08             	pushl  0x8(%ebp)
8010035e:	e8 ad 13 00 00       	call   80101710 <ilock>
  return target - n;
80100363:	89 f0                	mov    %esi,%eax
80100365:	83 c4 10             	add    $0x10,%esp
}
80100368:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
8010036b:	29 d8                	sub    %ebx,%eax
}
8010036d:	5b                   	pop    %ebx
8010036e:	5e                   	pop    %esi
8010036f:	5f                   	pop    %edi
80100370:	5d                   	pop    %ebp
80100371:	c3                   	ret    
      if(n < target){
80100372:	39 f3                	cmp    %esi,%ebx
80100374:	73 d7                	jae    8010034d <consoleread+0xcd>
        input.r--;
80100376:	a3 80 f7 10 80       	mov    %eax,0x8010f780
8010037b:	eb d0                	jmp    8010034d <consoleread+0xcd>
8010037d:	8d 76 00             	lea    0x0(%esi),%esi

80100380 <panic>:
{
80100380:	f3 0f 1e fb          	endbr32 
80100384:	55                   	push   %ebp
80100385:	89 e5                	mov    %esp,%ebp
80100387:	56                   	push   %esi
80100388:	53                   	push   %ebx
80100389:	83 ec 38             	sub    $0x38,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
8010038c:	fa                   	cli    
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
8010038d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cons.locking = 0;
80100399:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
801003a0:	00 00 00 
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
801003a3:	0f b6 00             	movzbl (%eax),%eax
801003a6:	50                   	push   %eax
801003a7:	68 c6 72 10 80       	push   $0x801072c6
801003ac:	e8 ef 02 00 00       	call   801006a0 <cprintf>
  cprintf(s);
801003b1:	58                   	pop    %eax
801003b2:	ff 75 08             	pushl  0x8(%ebp)
801003b5:	e8 e6 02 00 00       	call   801006a0 <cprintf>
  cprintf("\n");
801003ba:	c7 04 24 e6 77 10 80 	movl   $0x801077e6,(%esp)
801003c1:	e8 da 02 00 00       	call   801006a0 <cprintf>
  getcallerpcs(&s, pcs);
801003c6:	8d 45 08             	lea    0x8(%ebp),%eax
801003c9:	5a                   	pop    %edx
801003ca:	59                   	pop    %ecx
801003cb:	53                   	push   %ebx
801003cc:	50                   	push   %eax
801003cd:	e8 4e 42 00 00       	call   80104620 <getcallerpcs>
  for(i=0; i<10; i++)
801003d2:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d5:	83 ec 08             	sub    $0x8,%esp
801003d8:	ff 33                	pushl  (%ebx)
801003da:	83 c3 04             	add    $0x4,%ebx
801003dd:	68 e2 72 10 80       	push   $0x801072e2
801003e2:	e8 b9 02 00 00       	call   801006a0 <cprintf>
  for(i=0; i<10; i++)
801003e7:	83 c4 10             	add    $0x10,%esp
801003ea:	39 f3                	cmp    %esi,%ebx
801003ec:	75 e7                	jne    801003d5 <panic+0x55>
  panicked = 1; // freeze other CPU
801003ee:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003f5:	00 00 00 
  for(;;)
801003f8:	eb fe                	jmp    801003f8 <panic+0x78>
801003fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100400 <consputc.part.0>:
consputc(int c)
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 ea 00 00 00    	je     80100500 <consputc.part.0+0x100>
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 b1 5a 00 00       	call   80105ed0 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100434:	89 ca                	mov    %ecx,%edx
80100436:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	c1 e0 08             	shl    $0x8,%eax
8010043f:	89 c6                	mov    %eax,%esi
80100441:	b8 0f 00 00 00       	mov    $0xf,%eax
80100446:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100447:	89 ca                	mov    %ecx,%edx
80100449:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
8010044a:	0f b6 c0             	movzbl %al,%eax
8010044d:	09 f0                	or     %esi,%eax
  if(c == '\n')
8010044f:	83 fb 0a             	cmp    $0xa,%ebx
80100452:	0f 84 90 00 00 00    	je     801004e8 <consputc.part.0+0xe8>
  else if(c == BACKSPACE){
80100458:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045e:	74 70                	je     801004d0 <consputc.part.0+0xd0>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100460:	0f b6 db             	movzbl %bl,%ebx
80100463:	8d 70 01             	lea    0x1(%eax),%esi
80100466:	80 cf 07             	or     $0x7,%bh
80100469:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
80100470:	80 
  if(pos < 0 || pos > 25*80)
80100471:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
80100477:	0f 8f f9 00 00 00    	jg     80100576 <consputc.part.0+0x176>
  if((pos/80) >= 24){  // Scroll up.
8010047d:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100483:	0f 8f a7 00 00 00    	jg     80100530 <consputc.part.0+0x130>
80100489:	89 f0                	mov    %esi,%eax
8010048b:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
80100492:	88 45 e7             	mov    %al,-0x19(%ebp)
80100495:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100498:	bb d4 03 00 00       	mov    $0x3d4,%ebx
8010049d:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a2:	89 da                	mov    %ebx,%edx
801004a4:	ee                   	out    %al,(%dx)
801004a5:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801004aa:	89 f8                	mov    %edi,%eax
801004ac:	89 ca                	mov    %ecx,%edx
801004ae:	ee                   	out    %al,(%dx)
801004af:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b4:	89 da                	mov    %ebx,%edx
801004b6:	ee                   	out    %al,(%dx)
801004b7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004bb:	89 ca                	mov    %ecx,%edx
801004bd:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004be:	b8 20 07 00 00       	mov    $0x720,%eax
801004c3:	66 89 06             	mov    %ax,(%esi)
}
801004c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c9:	5b                   	pop    %ebx
801004ca:	5e                   	pop    %esi
801004cb:	5f                   	pop    %edi
801004cc:	5d                   	pop    %ebp
801004cd:	c3                   	ret    
801004ce:	66 90                	xchg   %ax,%ax
    if(pos > 0) --pos;
801004d0:	8d 70 ff             	lea    -0x1(%eax),%esi
801004d3:	85 c0                	test   %eax,%eax
801004d5:	75 9a                	jne    80100471 <consputc.part.0+0x71>
801004d7:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
801004db:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004e0:	31 ff                	xor    %edi,%edi
801004e2:	eb b4                	jmp    80100498 <consputc.part.0+0x98>
801004e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pos += 80 - pos%80;
801004e8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004ed:	f7 e2                	mul    %edx
801004ef:	c1 ea 06             	shr    $0x6,%edx
801004f2:	8d 04 92             	lea    (%edx,%edx,4),%eax
801004f5:	c1 e0 04             	shl    $0x4,%eax
801004f8:	8d 70 50             	lea    0x50(%eax),%esi
801004fb:	e9 71 ff ff ff       	jmp    80100471 <consputc.part.0+0x71>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100500:	83 ec 0c             	sub    $0xc,%esp
80100503:	6a 08                	push   $0x8
80100505:	e8 c6 59 00 00       	call   80105ed0 <uartputc>
8010050a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100511:	e8 ba 59 00 00       	call   80105ed0 <uartputc>
80100516:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010051d:	e8 ae 59 00 00       	call   80105ed0 <uartputc>
80100522:	83 c4 10             	add    $0x10,%esp
80100525:	e9 f8 fe ff ff       	jmp    80100422 <consputc.part.0+0x22>
8010052a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100530:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100533:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100536:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
8010053d:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100542:	68 60 0e 00 00       	push   $0xe60
80100547:	68 a0 80 0b 80       	push   $0x800b80a0
8010054c:	68 00 80 0b 80       	push   $0x800b8000
80100551:	e8 ca 42 00 00       	call   80104820 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100556:	b8 80 07 00 00       	mov    $0x780,%eax
8010055b:	83 c4 0c             	add    $0xc,%esp
8010055e:	29 d8                	sub    %ebx,%eax
80100560:	01 c0                	add    %eax,%eax
80100562:	50                   	push   %eax
80100563:	6a 00                	push   $0x0
80100565:	56                   	push   %esi
80100566:	e8 15 42 00 00       	call   80104780 <memset>
8010056b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010056e:	83 c4 10             	add    $0x10,%esp
80100571:	e9 22 ff ff ff       	jmp    80100498 <consputc.part.0+0x98>
    panic("pos under/overflow");
80100576:	83 ec 0c             	sub    $0xc,%esp
80100579:	68 e6 72 10 80       	push   $0x801072e6
8010057e:	e8 fd fd ff ff       	call   80100380 <panic>
80100583:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010058a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100590 <printint>:
{
80100590:	55                   	push   %ebp
80100591:	89 e5                	mov    %esp,%ebp
80100593:	57                   	push   %edi
80100594:	56                   	push   %esi
80100595:	53                   	push   %ebx
80100596:	83 ec 2c             	sub    $0x2c,%esp
80100599:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
8010059c:	85 c9                	test   %ecx,%ecx
8010059e:	74 04                	je     801005a4 <printint+0x14>
801005a0:	85 c0                	test   %eax,%eax
801005a2:	78 6d                	js     80100611 <printint+0x81>
    x = xx;
801005a4:	89 c1                	mov    %eax,%ecx
801005a6:	31 f6                	xor    %esi,%esi
  i = 0;
801005a8:	89 75 cc             	mov    %esi,-0x34(%ebp)
801005ab:	31 db                	xor    %ebx,%ebx
801005ad:	8d 7d d7             	lea    -0x29(%ebp),%edi
    buf[i++] = digits[x % base];
801005b0:	89 c8                	mov    %ecx,%eax
801005b2:	31 d2                	xor    %edx,%edx
801005b4:	89 ce                	mov    %ecx,%esi
801005b6:	f7 75 d4             	divl   -0x2c(%ebp)
801005b9:	0f b6 92 14 73 10 80 	movzbl -0x7fef8cec(%edx),%edx
801005c0:	89 45 d0             	mov    %eax,-0x30(%ebp)
801005c3:	89 d8                	mov    %ebx,%eax
801005c5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
801005c8:	8b 4d d0             	mov    -0x30(%ebp),%ecx
801005cb:	89 75 d0             	mov    %esi,-0x30(%ebp)
    buf[i++] = digits[x % base];
801005ce:	88 14 1f             	mov    %dl,(%edi,%ebx,1)
  }while((x /= base) != 0);
801005d1:	8b 75 d4             	mov    -0x2c(%ebp),%esi
801005d4:	39 75 d0             	cmp    %esi,-0x30(%ebp)
801005d7:	73 d7                	jae    801005b0 <printint+0x20>
801005d9:	8b 75 cc             	mov    -0x34(%ebp),%esi
  if(sign)
801005dc:	85 f6                	test   %esi,%esi
801005de:	74 0c                	je     801005ec <printint+0x5c>
    buf[i++] = '-';
801005e0:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
801005e5:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
801005e7:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while(--i >= 0)
801005ec:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
801005f0:	0f be c2             	movsbl %dl,%eax
  if(panicked){
801005f3:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801005f9:	85 d2                	test   %edx,%edx
801005fb:	74 03                	je     80100600 <printint+0x70>
  asm volatile("cli");
801005fd:	fa                   	cli    
    for(;;)
801005fe:	eb fe                	jmp    801005fe <printint+0x6e>
80100600:	e8 fb fd ff ff       	call   80100400 <consputc.part.0>
  while(--i >= 0)
80100605:	39 fb                	cmp    %edi,%ebx
80100607:	74 10                	je     80100619 <printint+0x89>
80100609:	0f be 03             	movsbl (%ebx),%eax
8010060c:	83 eb 01             	sub    $0x1,%ebx
8010060f:	eb e2                	jmp    801005f3 <printint+0x63>
    x = -xx;
80100611:	f7 d8                	neg    %eax
80100613:	89 ce                	mov    %ecx,%esi
80100615:	89 c1                	mov    %eax,%ecx
80100617:	eb 8f                	jmp    801005a8 <printint+0x18>
}
80100619:	83 c4 2c             	add    $0x2c,%esp
8010061c:	5b                   	pop    %ebx
8010061d:	5e                   	pop    %esi
8010061e:	5f                   	pop    %edi
8010061f:	5d                   	pop    %ebp
80100620:	c3                   	ret    
80100621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100628:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010062f:	90                   	nop

80100630 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100630:	f3 0f 1e fb          	endbr32 
80100634:	55                   	push   %ebp
80100635:	89 e5                	mov    %esp,%ebp
80100637:	57                   	push   %edi
80100638:	56                   	push   %esi
80100639:	53                   	push   %ebx
8010063a:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
8010063d:	ff 75 08             	pushl  0x8(%ebp)
{
80100640:	8b 5d 10             	mov    0x10(%ebp),%ebx
  iunlock(ip);
80100643:	e8 d8 11 00 00       	call   80101820 <iunlock>
  acquire(&cons.lock);
80100648:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010064f:	e8 fc 3e 00 00       	call   80104550 <acquire>
  for(i = 0; i < n; i++)
80100654:	83 c4 10             	add    $0x10,%esp
80100657:	85 db                	test   %ebx,%ebx
80100659:	7e 24                	jle    8010067f <consolewrite+0x4f>
8010065b:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010065e:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
  if(panicked){
80100661:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
80100667:	85 d2                	test   %edx,%edx
80100669:	74 05                	je     80100670 <consolewrite+0x40>
8010066b:	fa                   	cli    
    for(;;)
8010066c:	eb fe                	jmp    8010066c <consolewrite+0x3c>
8010066e:	66 90                	xchg   %ax,%ax
    consputc(buf[i] & 0xff);
80100670:	0f b6 07             	movzbl (%edi),%eax
80100673:	83 c7 01             	add    $0x1,%edi
80100676:	e8 85 fd ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; i < n; i++)
8010067b:	39 fe                	cmp    %edi,%esi
8010067d:	75 e2                	jne    80100661 <consolewrite+0x31>
  release(&cons.lock);
8010067f:	83 ec 0c             	sub    $0xc,%esp
80100682:	68 20 a5 10 80       	push   $0x8010a520
80100687:	e8 a4 40 00 00       	call   80104730 <release>
  ilock(ip);
8010068c:	58                   	pop    %eax
8010068d:	ff 75 08             	pushl  0x8(%ebp)
80100690:	e8 7b 10 00 00       	call   80101710 <ilock>

  return n;
}
80100695:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100698:	89 d8                	mov    %ebx,%eax
8010069a:	5b                   	pop    %ebx
8010069b:	5e                   	pop    %esi
8010069c:	5f                   	pop    %edi
8010069d:	5d                   	pop    %ebp
8010069e:	c3                   	ret    
8010069f:	90                   	nop

801006a0 <cprintf>:
{
801006a0:	f3 0f 1e fb          	endbr32 
801006a4:	55                   	push   %ebp
801006a5:	89 e5                	mov    %esp,%ebp
801006a7:	57                   	push   %edi
801006a8:	56                   	push   %esi
801006a9:	53                   	push   %ebx
801006aa:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006ad:	a1 54 a5 10 80       	mov    0x8010a554,%eax
801006b2:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
801006b5:	85 c0                	test   %eax,%eax
801006b7:	0f 85 e8 00 00 00    	jne    801007a5 <cprintf+0x105>
  if (fmt == 0)
801006bd:	8b 45 08             	mov    0x8(%ebp),%eax
801006c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006c3:	85 c0                	test   %eax,%eax
801006c5:	0f 84 5a 01 00 00    	je     80100825 <cprintf+0x185>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006cb:	0f b6 00             	movzbl (%eax),%eax
801006ce:	85 c0                	test   %eax,%eax
801006d0:	74 36                	je     80100708 <cprintf+0x68>
  argp = (uint*)(void*)(&fmt + 1);
801006d2:	8d 5d 0c             	lea    0xc(%ebp),%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006d5:	31 f6                	xor    %esi,%esi
    if(c != '%'){
801006d7:	83 f8 25             	cmp    $0x25,%eax
801006da:	74 44                	je     80100720 <cprintf+0x80>
  if(panicked){
801006dc:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
801006e2:	85 c9                	test   %ecx,%ecx
801006e4:	74 0f                	je     801006f5 <cprintf+0x55>
801006e6:	fa                   	cli    
    for(;;)
801006e7:	eb fe                	jmp    801006e7 <cprintf+0x47>
801006e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801006f0:	b8 25 00 00 00       	mov    $0x25,%eax
801006f5:	e8 06 fd ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006fd:	83 c6 01             	add    $0x1,%esi
80100700:	0f b6 04 30          	movzbl (%eax,%esi,1),%eax
80100704:	85 c0                	test   %eax,%eax
80100706:	75 cf                	jne    801006d7 <cprintf+0x37>
  if(locking)
80100708:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010070b:	85 c0                	test   %eax,%eax
8010070d:	0f 85 fd 00 00 00    	jne    80100810 <cprintf+0x170>
}
80100713:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100716:	5b                   	pop    %ebx
80100717:	5e                   	pop    %esi
80100718:	5f                   	pop    %edi
80100719:	5d                   	pop    %ebp
8010071a:	c3                   	ret    
8010071b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010071f:	90                   	nop
    c = fmt[++i] & 0xff;
80100720:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100723:	83 c6 01             	add    $0x1,%esi
80100726:	0f b6 3c 30          	movzbl (%eax,%esi,1),%edi
    if(c == 0)
8010072a:	85 ff                	test   %edi,%edi
8010072c:	74 da                	je     80100708 <cprintf+0x68>
    switch(c){
8010072e:	83 ff 70             	cmp    $0x70,%edi
80100731:	74 5a                	je     8010078d <cprintf+0xed>
80100733:	7f 2a                	jg     8010075f <cprintf+0xbf>
80100735:	83 ff 25             	cmp    $0x25,%edi
80100738:	0f 84 92 00 00 00    	je     801007d0 <cprintf+0x130>
8010073e:	83 ff 64             	cmp    $0x64,%edi
80100741:	0f 85 a1 00 00 00    	jne    801007e8 <cprintf+0x148>
      printint(*argp++, 10, 1);
80100747:	8b 03                	mov    (%ebx),%eax
80100749:	8d 7b 04             	lea    0x4(%ebx),%edi
8010074c:	b9 01 00 00 00       	mov    $0x1,%ecx
80100751:	ba 0a 00 00 00       	mov    $0xa,%edx
80100756:	89 fb                	mov    %edi,%ebx
80100758:	e8 33 fe ff ff       	call   80100590 <printint>
      break;
8010075d:	eb 9b                	jmp    801006fa <cprintf+0x5a>
    switch(c){
8010075f:	83 ff 73             	cmp    $0x73,%edi
80100762:	75 24                	jne    80100788 <cprintf+0xe8>
      if((s = (char*)*argp++) == 0)
80100764:	8d 7b 04             	lea    0x4(%ebx),%edi
80100767:	8b 1b                	mov    (%ebx),%ebx
80100769:	85 db                	test   %ebx,%ebx
8010076b:	75 55                	jne    801007c2 <cprintf+0x122>
        s = "(null)";
8010076d:	bb f9 72 10 80       	mov    $0x801072f9,%ebx
      for(; *s; s++)
80100772:	b8 28 00 00 00       	mov    $0x28,%eax
  if(panicked){
80100777:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
8010077d:	85 d2                	test   %edx,%edx
8010077f:	74 39                	je     801007ba <cprintf+0x11a>
80100781:	fa                   	cli    
    for(;;)
80100782:	eb fe                	jmp    80100782 <cprintf+0xe2>
80100784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100788:	83 ff 78             	cmp    $0x78,%edi
8010078b:	75 5b                	jne    801007e8 <cprintf+0x148>
      printint(*argp++, 16, 0);
8010078d:	8b 03                	mov    (%ebx),%eax
8010078f:	8d 7b 04             	lea    0x4(%ebx),%edi
80100792:	31 c9                	xor    %ecx,%ecx
80100794:	ba 10 00 00 00       	mov    $0x10,%edx
80100799:	89 fb                	mov    %edi,%ebx
8010079b:	e8 f0 fd ff ff       	call   80100590 <printint>
      break;
801007a0:	e9 55 ff ff ff       	jmp    801006fa <cprintf+0x5a>
    acquire(&cons.lock);
801007a5:	83 ec 0c             	sub    $0xc,%esp
801007a8:	68 20 a5 10 80       	push   $0x8010a520
801007ad:	e8 9e 3d 00 00       	call   80104550 <acquire>
801007b2:	83 c4 10             	add    $0x10,%esp
801007b5:	e9 03 ff ff ff       	jmp    801006bd <cprintf+0x1d>
801007ba:	e8 41 fc ff ff       	call   80100400 <consputc.part.0>
      for(; *s; s++)
801007bf:	83 c3 01             	add    $0x1,%ebx
801007c2:	0f be 03             	movsbl (%ebx),%eax
801007c5:	84 c0                	test   %al,%al
801007c7:	75 ae                	jne    80100777 <cprintf+0xd7>
      if((s = (char*)*argp++) == 0)
801007c9:	89 fb                	mov    %edi,%ebx
801007cb:	e9 2a ff ff ff       	jmp    801006fa <cprintf+0x5a>
  if(panicked){
801007d0:	8b 3d 58 a5 10 80    	mov    0x8010a558,%edi
801007d6:	85 ff                	test   %edi,%edi
801007d8:	0f 84 12 ff ff ff    	je     801006f0 <cprintf+0x50>
801007de:	fa                   	cli    
    for(;;)
801007df:	eb fe                	jmp    801007df <cprintf+0x13f>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(panicked){
801007e8:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
801007ee:	85 c9                	test   %ecx,%ecx
801007f0:	74 06                	je     801007f8 <cprintf+0x158>
801007f2:	fa                   	cli    
    for(;;)
801007f3:	eb fe                	jmp    801007f3 <cprintf+0x153>
801007f5:	8d 76 00             	lea    0x0(%esi),%esi
801007f8:	b8 25 00 00 00       	mov    $0x25,%eax
801007fd:	e8 fe fb ff ff       	call   80100400 <consputc.part.0>
  if(panicked){
80100802:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
80100808:	85 d2                	test   %edx,%edx
8010080a:	74 2c                	je     80100838 <cprintf+0x198>
8010080c:	fa                   	cli    
    for(;;)
8010080d:	eb fe                	jmp    8010080d <cprintf+0x16d>
8010080f:	90                   	nop
    release(&cons.lock);
80100810:	83 ec 0c             	sub    $0xc,%esp
80100813:	68 20 a5 10 80       	push   $0x8010a520
80100818:	e8 13 3f 00 00       	call   80104730 <release>
8010081d:	83 c4 10             	add    $0x10,%esp
}
80100820:	e9 ee fe ff ff       	jmp    80100713 <cprintf+0x73>
    panic("null fmt");
80100825:	83 ec 0c             	sub    $0xc,%esp
80100828:	68 00 73 10 80       	push   $0x80107300
8010082d:	e8 4e fb ff ff       	call   80100380 <panic>
80100832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100838:	89 f8                	mov    %edi,%eax
8010083a:	e8 c1 fb ff ff       	call   80100400 <consputc.part.0>
8010083f:	e9 b6 fe ff ff       	jmp    801006fa <cprintf+0x5a>
80100844:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010084b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010084f:	90                   	nop

80100850 <consoleintr>:
{
80100850:	f3 0f 1e fb          	endbr32 
80100854:	55                   	push   %ebp
80100855:	89 e5                	mov    %esp,%ebp
80100857:	57                   	push   %edi
80100858:	56                   	push   %esi
  int c, doprocdump = 0;
80100859:	31 f6                	xor    %esi,%esi
{
8010085b:	53                   	push   %ebx
8010085c:	83 ec 18             	sub    $0x18,%esp
8010085f:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquire(&cons.lock);
80100862:	68 20 a5 10 80       	push   $0x8010a520
80100867:	e8 e4 3c 00 00       	call   80104550 <acquire>
  while((c = getc()) >= 0){
8010086c:	83 c4 10             	add    $0x10,%esp
8010086f:	eb 17                	jmp    80100888 <consoleintr+0x38>
    switch(c){
80100871:	83 fb 08             	cmp    $0x8,%ebx
80100874:	0f 84 f6 00 00 00    	je     80100970 <consoleintr+0x120>
8010087a:	83 fb 10             	cmp    $0x10,%ebx
8010087d:	0f 85 15 01 00 00    	jne    80100998 <consoleintr+0x148>
80100883:	be 01 00 00 00       	mov    $0x1,%esi
  while((c = getc()) >= 0){
80100888:	ff d7                	call   *%edi
8010088a:	89 c3                	mov    %eax,%ebx
8010088c:	85 c0                	test   %eax,%eax
8010088e:	0f 88 23 01 00 00    	js     801009b7 <consoleintr+0x167>
    switch(c){
80100894:	83 fb 15             	cmp    $0x15,%ebx
80100897:	74 77                	je     80100910 <consoleintr+0xc0>
80100899:	7e d6                	jle    80100871 <consoleintr+0x21>
8010089b:	83 fb 7f             	cmp    $0x7f,%ebx
8010089e:	0f 84 cc 00 00 00    	je     80100970 <consoleintr+0x120>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a4:	a1 88 f7 10 80       	mov    0x8010f788,%eax
801008a9:	89 c2                	mov    %eax,%edx
801008ab:	2b 15 80 f7 10 80    	sub    0x8010f780,%edx
801008b1:	83 fa 7f             	cmp    $0x7f,%edx
801008b4:	77 d2                	ja     80100888 <consoleintr+0x38>
        c = (c == '\r') ? '\n' : c;
801008b6:	8d 48 01             	lea    0x1(%eax),%ecx
801008b9:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801008bf:	83 e0 7f             	and    $0x7f,%eax
        input.buf[input.e++ % INPUT_BUF] = c;
801008c2:	89 0d 88 f7 10 80    	mov    %ecx,0x8010f788
        c = (c == '\r') ? '\n' : c;
801008c8:	83 fb 0d             	cmp    $0xd,%ebx
801008cb:	0f 84 02 01 00 00    	je     801009d3 <consoleintr+0x183>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d1:	88 98 00 f7 10 80    	mov    %bl,-0x7fef0900(%eax)
  if(panicked){
801008d7:	85 d2                	test   %edx,%edx
801008d9:	0f 85 ff 00 00 00    	jne    801009de <consoleintr+0x18e>
801008df:	89 d8                	mov    %ebx,%eax
801008e1:	e8 1a fb ff ff       	call   80100400 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e6:	83 fb 0a             	cmp    $0xa,%ebx
801008e9:	0f 84 0f 01 00 00    	je     801009fe <consoleintr+0x1ae>
801008ef:	83 fb 04             	cmp    $0x4,%ebx
801008f2:	0f 84 06 01 00 00    	je     801009fe <consoleintr+0x1ae>
801008f8:	a1 80 f7 10 80       	mov    0x8010f780,%eax
801008fd:	83 e8 80             	sub    $0xffffff80,%eax
80100900:	39 05 88 f7 10 80    	cmp    %eax,0x8010f788
80100906:	75 80                	jne    80100888 <consoleintr+0x38>
80100908:	e9 f6 00 00 00       	jmp    80100a03 <consoleintr+0x1b3>
8010090d:	8d 76 00             	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100910:	a1 88 f7 10 80       	mov    0x8010f788,%eax
80100915:	39 05 84 f7 10 80    	cmp    %eax,0x8010f784
8010091b:	0f 84 67 ff ff ff    	je     80100888 <consoleintr+0x38>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100921:	83 e8 01             	sub    $0x1,%eax
80100924:	89 c2                	mov    %eax,%edx
80100926:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100929:	80 ba 00 f7 10 80 0a 	cmpb   $0xa,-0x7fef0900(%edx)
80100930:	0f 84 52 ff ff ff    	je     80100888 <consoleintr+0x38>
  if(panicked){
80100936:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
        input.e--;
8010093c:	a3 88 f7 10 80       	mov    %eax,0x8010f788
  if(panicked){
80100941:	85 d2                	test   %edx,%edx
80100943:	74 0b                	je     80100950 <consoleintr+0x100>
80100945:	fa                   	cli    
    for(;;)
80100946:	eb fe                	jmp    80100946 <consoleintr+0xf6>
80100948:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010094f:	90                   	nop
80100950:	b8 00 01 00 00       	mov    $0x100,%eax
80100955:	e8 a6 fa ff ff       	call   80100400 <consputc.part.0>
      while(input.e != input.w &&
8010095a:	a1 88 f7 10 80       	mov    0x8010f788,%eax
8010095f:	3b 05 84 f7 10 80    	cmp    0x8010f784,%eax
80100965:	75 ba                	jne    80100921 <consoleintr+0xd1>
80100967:	e9 1c ff ff ff       	jmp    80100888 <consoleintr+0x38>
8010096c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(input.e != input.w){
80100970:	a1 88 f7 10 80       	mov    0x8010f788,%eax
80100975:	3b 05 84 f7 10 80    	cmp    0x8010f784,%eax
8010097b:	0f 84 07 ff ff ff    	je     80100888 <consoleintr+0x38>
        input.e--;
80100981:	83 e8 01             	sub    $0x1,%eax
80100984:	a3 88 f7 10 80       	mov    %eax,0x8010f788
  if(panicked){
80100989:	a1 58 a5 10 80       	mov    0x8010a558,%eax
8010098e:	85 c0                	test   %eax,%eax
80100990:	74 16                	je     801009a8 <consoleintr+0x158>
80100992:	fa                   	cli    
    for(;;)
80100993:	eb fe                	jmp    80100993 <consoleintr+0x143>
80100995:	8d 76 00             	lea    0x0(%esi),%esi
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100998:	85 db                	test   %ebx,%ebx
8010099a:	0f 84 e8 fe ff ff    	je     80100888 <consoleintr+0x38>
801009a0:	e9 ff fe ff ff       	jmp    801008a4 <consoleintr+0x54>
801009a5:	8d 76 00             	lea    0x0(%esi),%esi
801009a8:	b8 00 01 00 00       	mov    $0x100,%eax
801009ad:	e8 4e fa ff ff       	call   80100400 <consputc.part.0>
801009b2:	e9 d1 fe ff ff       	jmp    80100888 <consoleintr+0x38>
  release(&cons.lock);
801009b7:	83 ec 0c             	sub    $0xc,%esp
801009ba:	68 20 a5 10 80       	push   $0x8010a520
801009bf:	e8 6c 3d 00 00       	call   80104730 <release>
  if(doprocdump) {
801009c4:	83 c4 10             	add    $0x10,%esp
801009c7:	85 f6                	test   %esi,%esi
801009c9:	75 1d                	jne    801009e8 <consoleintr+0x198>
}
801009cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009ce:	5b                   	pop    %ebx
801009cf:	5e                   	pop    %esi
801009d0:	5f                   	pop    %edi
801009d1:	5d                   	pop    %ebp
801009d2:	c3                   	ret    
        input.buf[input.e++ % INPUT_BUF] = c;
801009d3:	c6 80 00 f7 10 80 0a 	movb   $0xa,-0x7fef0900(%eax)
  if(panicked){
801009da:	85 d2                	test   %edx,%edx
801009dc:	74 16                	je     801009f4 <consoleintr+0x1a4>
801009de:	fa                   	cli    
    for(;;)
801009df:	eb fe                	jmp    801009df <consoleintr+0x18f>
801009e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
801009e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009eb:	5b                   	pop    %ebx
801009ec:	5e                   	pop    %esi
801009ed:	5f                   	pop    %edi
801009ee:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
801009ef:	e9 7c 38 00 00       	jmp    80104270 <procdump>
801009f4:	b8 0a 00 00 00       	mov    $0xa,%eax
801009f9:	e8 02 fa ff ff       	call   80100400 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009fe:	a1 88 f7 10 80       	mov    0x8010f788,%eax
          wakeup(&input.r);
80100a03:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a06:	a3 84 f7 10 80       	mov    %eax,0x8010f784
          wakeup(&input.r);
80100a0b:	68 80 f7 10 80       	push   $0x8010f780
80100a10:	e8 5b 37 00 00       	call   80104170 <wakeup>
80100a15:	83 c4 10             	add    $0x10,%esp
80100a18:	e9 6b fe ff ff       	jmp    80100888 <consoleintr+0x38>
80100a1d:	8d 76 00             	lea    0x0(%esi),%esi

80100a20 <consoleinit>:

void
consoleinit(void)
{
80100a20:	f3 0f 1e fb          	endbr32 
80100a24:	55                   	push   %ebp
80100a25:	89 e5                	mov    %esp,%ebp
80100a27:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100a2a:	68 09 73 10 80       	push   $0x80107309
80100a2f:	68 20 a5 10 80       	push   $0x8010a520
80100a34:	e8 f7 3a 00 00       	call   80104530 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  picenable(IRQ_KBD);
80100a39:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  devsw[CONSOLE].write = consolewrite;
80100a40:	c7 05 4c 01 11 80 30 	movl   $0x80100630,0x8011014c
80100a47:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100a4a:	c7 05 48 01 11 80 80 	movl   $0x80100280,0x80110148
80100a51:	02 10 80 
  cons.locking = 1;
80100a54:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
80100a5b:	00 00 00 
  picenable(IRQ_KBD);
80100a5e:	e8 2d 2a 00 00       	call   80103490 <picenable>
  ioapicenable(IRQ_KBD, 0);
80100a63:	58                   	pop    %eax
80100a64:	5a                   	pop    %edx
80100a65:	6a 00                	push   $0x0
80100a67:	6a 01                	push   $0x1
80100a69:	e8 c2 19 00 00       	call   80102430 <ioapicenable>
}
80100a6e:	83 c4 10             	add    $0x10,%esp
80100a71:	c9                   	leave  
80100a72:	c3                   	ret    
80100a73:	66 90                	xchg   %ax,%ax
80100a75:	66 90                	xchg   %ax,%ax
80100a77:	66 90                	xchg   %ax,%ax
80100a79:	66 90                	xchg   %ax,%ax
80100a7b:	66 90                	xchg   %ax,%ax
80100a7d:	66 90                	xchg   %ax,%ax
80100a7f:	90                   	nop

80100a80 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a80:	f3 0f 1e fb          	endbr32 
80100a84:	55                   	push   %ebp
80100a85:	89 e5                	mov    %esp,%ebp
80100a87:	57                   	push   %edi
80100a88:	56                   	push   %esi
80100a89:	53                   	push   %ebx
80100a8a:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
80100a90:	e8 2b 23 00 00       	call   80102dc0 <begin_op>
  if((ip = namei(path)) == 0){
80100a95:	83 ec 0c             	sub    $0xc,%esp
80100a98:	ff 75 08             	pushl  0x8(%ebp)
80100a9b:	e8 80 15 00 00       	call   80102020 <namei>
80100aa0:	83 c4 10             	add    $0x10,%esp
80100aa3:	85 c0                	test   %eax,%eax
80100aa5:	0f 84 ff 02 00 00    	je     80100daa <exec+0x32a>
    end_op();
    return -1;
  }
  ilock(ip);
80100aab:	83 ec 0c             	sub    $0xc,%esp
80100aae:	89 c3                	mov    %eax,%ebx
80100ab0:	50                   	push   %eax
80100ab1:	e8 5a 0c 00 00       	call   80101710 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100ab6:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100abc:	6a 34                	push   $0x34
80100abe:	6a 00                	push   $0x0
80100ac0:	50                   	push   %eax
80100ac1:	53                   	push   %ebx
80100ac2:	e8 89 0f 00 00       	call   80101a50 <readi>
80100ac7:	83 c4 20             	add    $0x20,%esp
80100aca:	83 f8 33             	cmp    $0x33,%eax
80100acd:	76 0c                	jbe    80100adb <exec+0x5b>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100acf:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100ad6:	45 4c 46 
80100ad9:	74 25                	je     80100b00 <exec+0x80>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100adb:	83 ec 0c             	sub    $0xc,%esp
80100ade:	53                   	push   %ebx
80100adf:	e8 0c 0f 00 00       	call   801019f0 <iunlockput>
    end_op();
80100ae4:	e8 47 23 00 00       	call   80102e30 <end_op>
80100ae9:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100aec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100af1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100af4:	5b                   	pop    %ebx
80100af5:	5e                   	pop    %esi
80100af6:	5f                   	pop    %edi
80100af7:	5d                   	pop    %ebp
80100af8:	c3                   	ret    
80100af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((pgdir = setupkvm()) == 0)
80100b00:	e8 1b 61 00 00       	call   80106c20 <setupkvm>
80100b05:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b0b:	85 c0                	test   %eax,%eax
80100b0d:	74 cc                	je     80100adb <exec+0x5b>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b0f:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b16:	00 
80100b17:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100b1d:	0f 84 96 02 00 00    	je     80100db9 <exec+0x339>
  sz = 0;
80100b23:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100b2a:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b2d:	31 ff                	xor    %edi,%edi
80100b2f:	e9 8a 00 00 00       	jmp    80100bbe <exec+0x13e>
80100b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100b38:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b3f:	75 6c                	jne    80100bad <exec+0x12d>
    if(ph.memsz < ph.filesz)
80100b41:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b47:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b4d:	0f 82 87 00 00 00    	jb     80100bda <exec+0x15a>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100b53:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b59:	72 7f                	jb     80100bda <exec+0x15a>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b5b:	83 ec 04             	sub    $0x4,%esp
80100b5e:	50                   	push   %eax
80100b5f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b65:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b6b:	e8 60 63 00 00       	call   80106ed0 <allocuvm>
80100b70:	83 c4 10             	add    $0x10,%esp
80100b73:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b79:	85 c0                	test   %eax,%eax
80100b7b:	74 5d                	je     80100bda <exec+0x15a>
    if(ph.vaddr % PGSIZE != 0)
80100b7d:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b83:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b88:	75 50                	jne    80100bda <exec+0x15a>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b8a:	83 ec 0c             	sub    $0xc,%esp
80100b8d:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b93:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b99:	53                   	push   %ebx
80100b9a:	50                   	push   %eax
80100b9b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100ba1:	e8 5a 62 00 00       	call   80106e00 <loaduvm>
80100ba6:	83 c4 20             	add    $0x20,%esp
80100ba9:	85 c0                	test   %eax,%eax
80100bab:	78 2d                	js     80100bda <exec+0x15a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bad:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100bb4:	83 c7 01             	add    $0x1,%edi
80100bb7:	83 c6 20             	add    $0x20,%esi
80100bba:	39 f8                	cmp    %edi,%eax
80100bbc:	7e 32                	jle    80100bf0 <exec+0x170>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bbe:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100bc4:	6a 20                	push   $0x20
80100bc6:	56                   	push   %esi
80100bc7:	50                   	push   %eax
80100bc8:	53                   	push   %ebx
80100bc9:	e8 82 0e 00 00       	call   80101a50 <readi>
80100bce:	83 c4 10             	add    $0x10,%esp
80100bd1:	83 f8 20             	cmp    $0x20,%eax
80100bd4:	0f 84 5e ff ff ff    	je     80100b38 <exec+0xb8>
    freevm(pgdir);
80100bda:	83 ec 0c             	sub    $0xc,%esp
80100bdd:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100be3:	e8 48 64 00 00       	call   80107030 <freevm>
  if(ip){
80100be8:	83 c4 10             	add    $0x10,%esp
80100beb:	e9 eb fe ff ff       	jmp    80100adb <exec+0x5b>
80100bf0:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100bf6:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100bfc:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100c02:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100c08:	83 ec 0c             	sub    $0xc,%esp
80100c0b:	53                   	push   %ebx
80100c0c:	e8 df 0d 00 00       	call   801019f0 <iunlockput>
  end_op();
80100c11:	e8 1a 22 00 00       	call   80102e30 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c16:	83 c4 0c             	add    $0xc,%esp
80100c19:	56                   	push   %esi
80100c1a:	57                   	push   %edi
80100c1b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100c21:	57                   	push   %edi
80100c22:	e8 a9 62 00 00       	call   80106ed0 <allocuvm>
80100c27:	83 c4 10             	add    $0x10,%esp
80100c2a:	89 c6                	mov    %eax,%esi
80100c2c:	85 c0                	test   %eax,%eax
80100c2e:	0f 84 94 00 00 00    	je     80100cc8 <exec+0x248>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c34:	83 ec 08             	sub    $0x8,%esp
80100c37:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100c3d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c3f:	50                   	push   %eax
80100c40:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80100c41:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c43:	e8 68 64 00 00       	call   801070b0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c48:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c4b:	83 c4 10             	add    $0x10,%esp
80100c4e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c54:	8b 00                	mov    (%eax),%eax
80100c56:	85 c0                	test   %eax,%eax
80100c58:	0f 84 8b 00 00 00    	je     80100ce9 <exec+0x269>
80100c5e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100c64:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100c6a:	eb 23                	jmp    80100c8f <exec+0x20f>
80100c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100c70:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c73:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c7a:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c7d:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c83:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c86:	85 c0                	test   %eax,%eax
80100c88:	74 59                	je     80100ce3 <exec+0x263>
    if(argc >= MAXARG)
80100c8a:	83 ff 20             	cmp    $0x20,%edi
80100c8d:	74 39                	je     80100cc8 <exec+0x248>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c8f:	83 ec 0c             	sub    $0xc,%esp
80100c92:	50                   	push   %eax
80100c93:	e8 e8 3c 00 00       	call   80104980 <strlen>
80100c98:	f7 d0                	not    %eax
80100c9a:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c9c:	58                   	pop    %eax
80100c9d:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ca0:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ca3:	ff 34 b8             	pushl  (%eax,%edi,4)
80100ca6:	e8 d5 3c 00 00       	call   80104980 <strlen>
80100cab:	83 c0 01             	add    $0x1,%eax
80100cae:	50                   	push   %eax
80100caf:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cb2:	ff 34 b8             	pushl  (%eax,%edi,4)
80100cb5:	53                   	push   %ebx
80100cb6:	56                   	push   %esi
80100cb7:	e8 44 65 00 00       	call   80107200 <copyout>
80100cbc:	83 c4 20             	add    $0x20,%esp
80100cbf:	85 c0                	test   %eax,%eax
80100cc1:	79 ad                	jns    80100c70 <exec+0x1f0>
80100cc3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100cc7:	90                   	nop
    freevm(pgdir);
80100cc8:	83 ec 0c             	sub    $0xc,%esp
80100ccb:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100cd1:	e8 5a 63 00 00       	call   80107030 <freevm>
80100cd6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100cd9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100cde:	e9 0e fe ff ff       	jmp    80100af1 <exec+0x71>
80100ce3:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100ce9:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100cf0:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100cf2:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100cf9:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cfd:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100cff:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80100d02:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80100d08:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d0a:	50                   	push   %eax
80100d0b:	52                   	push   %edx
80100d0c:	53                   	push   %ebx
80100d0d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80100d13:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d1a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d1d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d23:	e8 d8 64 00 00       	call   80107200 <copyout>
80100d28:	83 c4 10             	add    $0x10,%esp
80100d2b:	85 c0                	test   %eax,%eax
80100d2d:	78 99                	js     80100cc8 <exec+0x248>
  for(last=s=path; *s; s++)
80100d2f:	8b 45 08             	mov    0x8(%ebp),%eax
80100d32:	8b 55 08             	mov    0x8(%ebp),%edx
80100d35:	0f b6 00             	movzbl (%eax),%eax
80100d38:	84 c0                	test   %al,%al
80100d3a:	74 13                	je     80100d4f <exec+0x2cf>
80100d3c:	89 d1                	mov    %edx,%ecx
80100d3e:	66 90                	xchg   %ax,%ax
    if(*s == '/')
80100d40:	83 c1 01             	add    $0x1,%ecx
80100d43:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100d45:	0f b6 01             	movzbl (%ecx),%eax
    if(*s == '/')
80100d48:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100d4b:	84 c0                	test   %al,%al
80100d4d:	75 f1                	jne    80100d40 <exec+0x2c0>
  safestrcpy(proc->name, last, sizeof(proc->name));
80100d4f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100d55:	83 ec 04             	sub    $0x4,%esp
80100d58:	6a 10                	push   $0x10
80100d5a:	83 c0 6c             	add    $0x6c,%eax
80100d5d:	52                   	push   %edx
80100d5e:	50                   	push   %eax
80100d5f:	e8 dc 3b 00 00       	call   80104940 <safestrcpy>
  oldpgdir = proc->pgdir;
80100d64:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  proc->pgdir = pgdir;
80100d6a:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = proc->pgdir;
80100d70:	8b 78 04             	mov    0x4(%eax),%edi
  proc->sz = sz;
80100d73:	89 30                	mov    %esi,(%eax)
  proc->pgdir = pgdir;
80100d75:	89 48 04             	mov    %ecx,0x4(%eax)
  proc->tf->eip = elf.entry;  // main
80100d78:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100d7e:	8b 8d 3c ff ff ff    	mov    -0xc4(%ebp),%ecx
80100d84:	8b 50 18             	mov    0x18(%eax),%edx
80100d87:	89 4a 38             	mov    %ecx,0x38(%edx)
  proc->tf->esp = sp;
80100d8a:	8b 50 18             	mov    0x18(%eax),%edx
80100d8d:	89 5a 44             	mov    %ebx,0x44(%edx)
  switchuvm(proc);
80100d90:	89 04 24             	mov    %eax,(%esp)
80100d93:	e8 38 5f 00 00       	call   80106cd0 <switchuvm>
  freevm(oldpgdir);
80100d98:	89 3c 24             	mov    %edi,(%esp)
80100d9b:	e8 90 62 00 00       	call   80107030 <freevm>
  return 0;
80100da0:	83 c4 10             	add    $0x10,%esp
80100da3:	31 c0                	xor    %eax,%eax
80100da5:	e9 47 fd ff ff       	jmp    80100af1 <exec+0x71>
    end_op();
80100daa:	e8 81 20 00 00       	call   80102e30 <end_op>
    return -1;
80100daf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100db4:	e9 38 fd ff ff       	jmp    80100af1 <exec+0x71>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100db9:	31 ff                	xor    %edi,%edi
80100dbb:	be 00 20 00 00       	mov    $0x2000,%esi
80100dc0:	e9 43 fe ff ff       	jmp    80100c08 <exec+0x188>
80100dc5:	66 90                	xchg   %ax,%ax
80100dc7:	66 90                	xchg   %ax,%ax
80100dc9:	66 90                	xchg   %ax,%ax
80100dcb:	66 90                	xchg   %ax,%ax
80100dcd:	66 90                	xchg   %ax,%ax
80100dcf:	90                   	nop

80100dd0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100dd0:	f3 0f 1e fb          	endbr32 
80100dd4:	55                   	push   %ebp
80100dd5:	89 e5                	mov    %esp,%ebp
80100dd7:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100dda:	68 25 73 10 80       	push   $0x80107325
80100ddf:	68 a0 f7 10 80       	push   $0x8010f7a0
80100de4:	e8 47 37 00 00       	call   80104530 <initlock>
}
80100de9:	83 c4 10             	add    $0x10,%esp
80100dec:	c9                   	leave  
80100ded:	c3                   	ret    
80100dee:	66 90                	xchg   %ax,%ax

80100df0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100df0:	f3 0f 1e fb          	endbr32 
80100df4:	55                   	push   %ebp
80100df5:	89 e5                	mov    %esp,%ebp
80100df7:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100df8:	bb d4 f7 10 80       	mov    $0x8010f7d4,%ebx
{
80100dfd:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e00:	68 a0 f7 10 80       	push   $0x8010f7a0
80100e05:	e8 46 37 00 00       	call   80104550 <acquire>
80100e0a:	83 c4 10             	add    $0x10,%esp
80100e0d:	eb 0c                	jmp    80100e1b <filealloc+0x2b>
80100e0f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e10:	83 c3 18             	add    $0x18,%ebx
80100e13:	81 fb 34 01 11 80    	cmp    $0x80110134,%ebx
80100e19:	74 25                	je     80100e40 <filealloc+0x50>
    if(f->ref == 0){
80100e1b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e1e:	85 c0                	test   %eax,%eax
80100e20:	75 ee                	jne    80100e10 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e22:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100e25:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e2c:	68 a0 f7 10 80       	push   $0x8010f7a0
80100e31:	e8 fa 38 00 00       	call   80104730 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e36:	89 d8                	mov    %ebx,%eax
      return f;
80100e38:	83 c4 10             	add    $0x10,%esp
}
80100e3b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e3e:	c9                   	leave  
80100e3f:	c3                   	ret    
  release(&ftable.lock);
80100e40:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100e43:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100e45:	68 a0 f7 10 80       	push   $0x8010f7a0
80100e4a:	e8 e1 38 00 00       	call   80104730 <release>
}
80100e4f:	89 d8                	mov    %ebx,%eax
  return 0;
80100e51:	83 c4 10             	add    $0x10,%esp
}
80100e54:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e57:	c9                   	leave  
80100e58:	c3                   	ret    
80100e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100e60 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100e60:	f3 0f 1e fb          	endbr32 
80100e64:	55                   	push   %ebp
80100e65:	89 e5                	mov    %esp,%ebp
80100e67:	53                   	push   %ebx
80100e68:	83 ec 10             	sub    $0x10,%esp
80100e6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100e6e:	68 a0 f7 10 80       	push   $0x8010f7a0
80100e73:	e8 d8 36 00 00       	call   80104550 <acquire>
  if(f->ref < 1)
80100e78:	8b 43 04             	mov    0x4(%ebx),%eax
80100e7b:	83 c4 10             	add    $0x10,%esp
80100e7e:	85 c0                	test   %eax,%eax
80100e80:	7e 1a                	jle    80100e9c <filedup+0x3c>
    panic("filedup");
  f->ref++;
80100e82:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e85:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e88:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e8b:	68 a0 f7 10 80       	push   $0x8010f7a0
80100e90:	e8 9b 38 00 00       	call   80104730 <release>
  return f;
}
80100e95:	89 d8                	mov    %ebx,%eax
80100e97:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e9a:	c9                   	leave  
80100e9b:	c3                   	ret    
    panic("filedup");
80100e9c:	83 ec 0c             	sub    $0xc,%esp
80100e9f:	68 2c 73 10 80       	push   $0x8010732c
80100ea4:	e8 d7 f4 ff ff       	call   80100380 <panic>
80100ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100eb0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100eb0:	f3 0f 1e fb          	endbr32 
80100eb4:	55                   	push   %ebp
80100eb5:	89 e5                	mov    %esp,%ebp
80100eb7:	57                   	push   %edi
80100eb8:	56                   	push   %esi
80100eb9:	53                   	push   %ebx
80100eba:	83 ec 28             	sub    $0x28,%esp
80100ebd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100ec0:	68 a0 f7 10 80       	push   $0x8010f7a0
80100ec5:	e8 86 36 00 00       	call   80104550 <acquire>
  if(f->ref < 1)
80100eca:	8b 53 04             	mov    0x4(%ebx),%edx
80100ecd:	83 c4 10             	add    $0x10,%esp
80100ed0:	85 d2                	test   %edx,%edx
80100ed2:	0f 8e a1 00 00 00    	jle    80100f79 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80100ed8:	83 ea 01             	sub    $0x1,%edx
80100edb:	89 53 04             	mov    %edx,0x4(%ebx)
80100ede:	75 40                	jne    80100f20 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100ee0:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100ee4:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100ee7:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80100ee9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100eef:	8b 73 0c             	mov    0xc(%ebx),%esi
80100ef2:	88 45 e7             	mov    %al,-0x19(%ebp)
80100ef5:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100ef8:	68 a0 f7 10 80       	push   $0x8010f7a0
  ff = *f;
80100efd:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f00:	e8 2b 38 00 00       	call   80104730 <release>

  if(ff.type == FD_PIPE)
80100f05:	83 c4 10             	add    $0x10,%esp
80100f08:	83 ff 01             	cmp    $0x1,%edi
80100f0b:	74 53                	je     80100f60 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100f0d:	83 ff 02             	cmp    $0x2,%edi
80100f10:	74 26                	je     80100f38 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f12:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f15:	5b                   	pop    %ebx
80100f16:	5e                   	pop    %esi
80100f17:	5f                   	pop    %edi
80100f18:	5d                   	pop    %ebp
80100f19:	c3                   	ret    
80100f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&ftable.lock);
80100f20:	c7 45 08 a0 f7 10 80 	movl   $0x8010f7a0,0x8(%ebp)
}
80100f27:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f2a:	5b                   	pop    %ebx
80100f2b:	5e                   	pop    %esi
80100f2c:	5f                   	pop    %edi
80100f2d:	5d                   	pop    %ebp
    release(&ftable.lock);
80100f2e:	e9 fd 37 00 00       	jmp    80104730 <release>
80100f33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f37:	90                   	nop
    begin_op();
80100f38:	e8 83 1e 00 00       	call   80102dc0 <begin_op>
    iput(ff.ip);
80100f3d:	83 ec 0c             	sub    $0xc,%esp
80100f40:	ff 75 e0             	pushl  -0x20(%ebp)
80100f43:	e8 38 09 00 00       	call   80101880 <iput>
    end_op();
80100f48:	83 c4 10             	add    $0x10,%esp
}
80100f4b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f4e:	5b                   	pop    %ebx
80100f4f:	5e                   	pop    %esi
80100f50:	5f                   	pop    %edi
80100f51:	5d                   	pop    %ebp
    end_op();
80100f52:	e9 d9 1e 00 00       	jmp    80102e30 <end_op>
80100f57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f5e:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80100f60:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100f64:	83 ec 08             	sub    $0x8,%esp
80100f67:	53                   	push   %ebx
80100f68:	56                   	push   %esi
80100f69:	e8 02 27 00 00       	call   80103670 <pipeclose>
80100f6e:	83 c4 10             	add    $0x10,%esp
}
80100f71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f74:	5b                   	pop    %ebx
80100f75:	5e                   	pop    %esi
80100f76:	5f                   	pop    %edi
80100f77:	5d                   	pop    %ebp
80100f78:	c3                   	ret    
    panic("fileclose");
80100f79:	83 ec 0c             	sub    $0xc,%esp
80100f7c:	68 34 73 10 80       	push   $0x80107334
80100f81:	e8 fa f3 ff ff       	call   80100380 <panic>
80100f86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f8d:	8d 76 00             	lea    0x0(%esi),%esi

80100f90 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f90:	f3 0f 1e fb          	endbr32 
80100f94:	55                   	push   %ebp
80100f95:	89 e5                	mov    %esp,%ebp
80100f97:	53                   	push   %ebx
80100f98:	83 ec 04             	sub    $0x4,%esp
80100f9b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f9e:	83 3b 02             	cmpl   $0x2,(%ebx)
80100fa1:	75 2d                	jne    80100fd0 <filestat+0x40>
    ilock(f->ip);
80100fa3:	83 ec 0c             	sub    $0xc,%esp
80100fa6:	ff 73 10             	pushl  0x10(%ebx)
80100fa9:	e8 62 07 00 00       	call   80101710 <ilock>
    stati(f->ip, st);
80100fae:	58                   	pop    %eax
80100faf:	5a                   	pop    %edx
80100fb0:	ff 75 0c             	pushl  0xc(%ebp)
80100fb3:	ff 73 10             	pushl  0x10(%ebx)
80100fb6:	e8 65 0a 00 00       	call   80101a20 <stati>
    iunlock(f->ip);
80100fbb:	59                   	pop    %ecx
80100fbc:	ff 73 10             	pushl  0x10(%ebx)
80100fbf:	e8 5c 08 00 00       	call   80101820 <iunlock>
    return 0;
  }
  return -1;
}
80100fc4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80100fc7:	83 c4 10             	add    $0x10,%esp
80100fca:	31 c0                	xor    %eax,%eax
}
80100fcc:	c9                   	leave  
80100fcd:	c3                   	ret    
80100fce:	66 90                	xchg   %ax,%ax
80100fd0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80100fd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100fd8:	c9                   	leave  
80100fd9:	c3                   	ret    
80100fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100fe0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100fe0:	f3 0f 1e fb          	endbr32 
80100fe4:	55                   	push   %ebp
80100fe5:	89 e5                	mov    %esp,%ebp
80100fe7:	57                   	push   %edi
80100fe8:	56                   	push   %esi
80100fe9:	53                   	push   %ebx
80100fea:	83 ec 0c             	sub    $0xc,%esp
80100fed:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100ff0:	8b 75 0c             	mov    0xc(%ebp),%esi
80100ff3:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100ff6:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100ffa:	74 64                	je     80101060 <fileread+0x80>
    return -1;
  if(f->type == FD_PIPE)
80100ffc:	8b 03                	mov    (%ebx),%eax
80100ffe:	83 f8 01             	cmp    $0x1,%eax
80101001:	74 45                	je     80101048 <fileread+0x68>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101003:	83 f8 02             	cmp    $0x2,%eax
80101006:	75 5f                	jne    80101067 <fileread+0x87>
    ilock(f->ip);
80101008:	83 ec 0c             	sub    $0xc,%esp
8010100b:	ff 73 10             	pushl  0x10(%ebx)
8010100e:	e8 fd 06 00 00       	call   80101710 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101013:	57                   	push   %edi
80101014:	ff 73 14             	pushl  0x14(%ebx)
80101017:	56                   	push   %esi
80101018:	ff 73 10             	pushl  0x10(%ebx)
8010101b:	e8 30 0a 00 00       	call   80101a50 <readi>
80101020:	83 c4 20             	add    $0x20,%esp
80101023:	89 c6                	mov    %eax,%esi
80101025:	85 c0                	test   %eax,%eax
80101027:	7e 03                	jle    8010102c <fileread+0x4c>
      f->off += r;
80101029:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
8010102c:	83 ec 0c             	sub    $0xc,%esp
8010102f:	ff 73 10             	pushl  0x10(%ebx)
80101032:	e8 e9 07 00 00       	call   80101820 <iunlock>
    return r;
80101037:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
8010103a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010103d:	89 f0                	mov    %esi,%eax
8010103f:	5b                   	pop    %ebx
80101040:	5e                   	pop    %esi
80101041:	5f                   	pop    %edi
80101042:	5d                   	pop    %ebp
80101043:	c3                   	ret    
80101044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return piperead(f->pipe, addr, n);
80101048:	8b 43 0c             	mov    0xc(%ebx),%eax
8010104b:	89 45 08             	mov    %eax,0x8(%ebp)
}
8010104e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101051:	5b                   	pop    %ebx
80101052:	5e                   	pop    %esi
80101053:	5f                   	pop    %edi
80101054:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80101055:	e9 b6 27 00 00       	jmp    80103810 <piperead>
8010105a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101060:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101065:	eb d3                	jmp    8010103a <fileread+0x5a>
  panic("fileread");
80101067:	83 ec 0c             	sub    $0xc,%esp
8010106a:	68 3e 73 10 80       	push   $0x8010733e
8010106f:	e8 0c f3 ff ff       	call   80100380 <panic>
80101074:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010107b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010107f:	90                   	nop

80101080 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101080:	f3 0f 1e fb          	endbr32 
80101084:	55                   	push   %ebp
80101085:	89 e5                	mov    %esp,%ebp
80101087:	57                   	push   %edi
80101088:	56                   	push   %esi
80101089:	53                   	push   %ebx
8010108a:	83 ec 1c             	sub    $0x1c,%esp
8010108d:	8b 45 0c             	mov    0xc(%ebp),%eax
80101090:	8b 75 08             	mov    0x8(%ebp),%esi
80101093:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101096:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101099:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
8010109d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801010a0:	0f 84 c1 00 00 00    	je     80101167 <filewrite+0xe7>
    return -1;
  if(f->type == FD_PIPE)
801010a6:	8b 06                	mov    (%esi),%eax
801010a8:	83 f8 01             	cmp    $0x1,%eax
801010ab:	0f 84 c3 00 00 00    	je     80101174 <filewrite+0xf4>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010b1:	83 f8 02             	cmp    $0x2,%eax
801010b4:	0f 85 cc 00 00 00    	jne    80101186 <filewrite+0x106>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801010ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801010bd:	31 ff                	xor    %edi,%edi
    while(i < n){
801010bf:	85 c0                	test   %eax,%eax
801010c1:	7f 34                	jg     801010f7 <filewrite+0x77>
801010c3:	e9 98 00 00 00       	jmp    80101160 <filewrite+0xe0>
801010c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801010cf:	90                   	nop
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801010d0:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
801010d3:	83 ec 0c             	sub    $0xc,%esp
801010d6:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
801010d9:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801010dc:	e8 3f 07 00 00       	call   80101820 <iunlock>
      end_op();
801010e1:	e8 4a 1d 00 00       	call   80102e30 <end_op>

      if(r < 0)
        break;
      if(r != n1)
801010e6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010e9:	83 c4 10             	add    $0x10,%esp
801010ec:	39 c3                	cmp    %eax,%ebx
801010ee:	75 60                	jne    80101150 <filewrite+0xd0>
        panic("short filewrite");
      i += r;
801010f0:	01 df                	add    %ebx,%edi
    while(i < n){
801010f2:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010f5:	7e 69                	jle    80101160 <filewrite+0xe0>
      int n1 = n - i;
801010f7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801010fa:	b8 00 1a 00 00       	mov    $0x1a00,%eax
801010ff:	29 fb                	sub    %edi,%ebx
      if(n1 > max)
80101101:	81 fb 00 1a 00 00    	cmp    $0x1a00,%ebx
80101107:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
8010110a:	e8 b1 1c 00 00       	call   80102dc0 <begin_op>
      ilock(f->ip);
8010110f:	83 ec 0c             	sub    $0xc,%esp
80101112:	ff 76 10             	pushl  0x10(%esi)
80101115:	e8 f6 05 00 00       	call   80101710 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010111a:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010111d:	53                   	push   %ebx
8010111e:	ff 76 14             	pushl  0x14(%esi)
80101121:	01 f8                	add    %edi,%eax
80101123:	50                   	push   %eax
80101124:	ff 76 10             	pushl  0x10(%esi)
80101127:	e8 24 0a 00 00       	call   80101b50 <writei>
8010112c:	83 c4 20             	add    $0x20,%esp
8010112f:	85 c0                	test   %eax,%eax
80101131:	7f 9d                	jg     801010d0 <filewrite+0x50>
      iunlock(f->ip);
80101133:	83 ec 0c             	sub    $0xc,%esp
80101136:	ff 76 10             	pushl  0x10(%esi)
80101139:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010113c:	e8 df 06 00 00       	call   80101820 <iunlock>
      end_op();
80101141:	e8 ea 1c 00 00       	call   80102e30 <end_op>
      if(r < 0)
80101146:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101149:	83 c4 10             	add    $0x10,%esp
8010114c:	85 c0                	test   %eax,%eax
8010114e:	75 17                	jne    80101167 <filewrite+0xe7>
        panic("short filewrite");
80101150:	83 ec 0c             	sub    $0xc,%esp
80101153:	68 47 73 10 80       	push   $0x80107347
80101158:	e8 23 f2 ff ff       	call   80100380 <panic>
8010115d:	8d 76 00             	lea    0x0(%esi),%esi
    }
    return i == n ? n : -1;
80101160:	89 f8                	mov    %edi,%eax
80101162:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80101165:	74 05                	je     8010116c <filewrite+0xec>
80101167:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
8010116c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010116f:	5b                   	pop    %ebx
80101170:	5e                   	pop    %esi
80101171:	5f                   	pop    %edi
80101172:	5d                   	pop    %ebp
80101173:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
80101174:	8b 46 0c             	mov    0xc(%esi),%eax
80101177:	89 45 08             	mov    %eax,0x8(%ebp)
}
8010117a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010117d:	5b                   	pop    %ebx
8010117e:	5e                   	pop    %esi
8010117f:	5f                   	pop    %edi
80101180:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101181:	e9 8a 25 00 00       	jmp    80103710 <pipewrite>
  panic("filewrite");
80101186:	83 ec 0c             	sub    $0xc,%esp
80101189:	68 4d 73 10 80       	push   $0x8010734d
8010118e:	e8 ed f1 ff ff       	call   80100380 <panic>
80101193:	66 90                	xchg   %ax,%ax
80101195:	66 90                	xchg   %ax,%ax
80101197:	66 90                	xchg   %ax,%ax
80101199:	66 90                	xchg   %ax,%ax
8010119b:	66 90                	xchg   %ax,%ax
8010119d:	66 90                	xchg   %ax,%ax
8010119f:	90                   	nop

801011a0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801011a0:	55                   	push   %ebp
801011a1:	89 e5                	mov    %esp,%ebp
801011a3:	57                   	push   %edi
801011a4:	56                   	push   %esi
801011a5:	53                   	push   %ebx
801011a6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801011a9:	8b 0d a0 01 11 80    	mov    0x801101a0,%ecx
{
801011af:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801011b2:	85 c9                	test   %ecx,%ecx
801011b4:	0f 84 87 00 00 00    	je     80101241 <balloc+0xa1>
801011ba:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801011c1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801011c4:	83 ec 08             	sub    $0x8,%esp
801011c7:	89 f0                	mov    %esi,%eax
801011c9:	c1 f8 0c             	sar    $0xc,%eax
801011cc:	03 05 b8 01 11 80    	add    0x801101b8,%eax
801011d2:	50                   	push   %eax
801011d3:	ff 75 d8             	pushl  -0x28(%ebp)
801011d6:	e8 e5 ee ff ff       	call   801000c0 <bread>
801011db:	83 c4 10             	add    $0x10,%esp
801011de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011e1:	a1 a0 01 11 80       	mov    0x801101a0,%eax
801011e6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801011e9:	31 c0                	xor    %eax,%eax
801011eb:	eb 2f                	jmp    8010121c <balloc+0x7c>
801011ed:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801011f0:	89 c1                	mov    %eax,%ecx
801011f2:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011f7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801011fa:	83 e1 07             	and    $0x7,%ecx
801011fd:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011ff:	89 c1                	mov    %eax,%ecx
80101201:	c1 f9 03             	sar    $0x3,%ecx
80101204:	0f b6 7c 0a 18       	movzbl 0x18(%edx,%ecx,1),%edi
80101209:	89 fa                	mov    %edi,%edx
8010120b:	85 df                	test   %ebx,%edi
8010120d:	74 41                	je     80101250 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010120f:	83 c0 01             	add    $0x1,%eax
80101212:	83 c6 01             	add    $0x1,%esi
80101215:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010121a:	74 05                	je     80101221 <balloc+0x81>
8010121c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010121f:	77 cf                	ja     801011f0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101221:	83 ec 0c             	sub    $0xc,%esp
80101224:	ff 75 e4             	pushl  -0x1c(%ebp)
80101227:	e8 d4 ef ff ff       	call   80100200 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010122c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101233:	83 c4 10             	add    $0x10,%esp
80101236:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101239:	39 05 a0 01 11 80    	cmp    %eax,0x801101a0
8010123f:	77 80                	ja     801011c1 <balloc+0x21>
  }
  panic("balloc: out of blocks");
80101241:	83 ec 0c             	sub    $0xc,%esp
80101244:	68 57 73 10 80       	push   $0x80107357
80101249:	e8 32 f1 ff ff       	call   80100380 <panic>
8010124e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101250:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101253:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101256:	09 da                	or     %ebx,%edx
80101258:	88 54 0f 18          	mov    %dl,0x18(%edi,%ecx,1)
        log_write(bp);
8010125c:	57                   	push   %edi
8010125d:	e8 3e 1d 00 00       	call   80102fa0 <log_write>
        brelse(bp);
80101262:	89 3c 24             	mov    %edi,(%esp)
80101265:	e8 96 ef ff ff       	call   80100200 <brelse>
  bp = bread(dev, bno);
8010126a:	58                   	pop    %eax
8010126b:	5a                   	pop    %edx
8010126c:	56                   	push   %esi
8010126d:	ff 75 d8             	pushl  -0x28(%ebp)
80101270:	e8 4b ee ff ff       	call   801000c0 <bread>
  memset(bp->data, 0, BSIZE);
80101275:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101278:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
8010127a:	8d 40 18             	lea    0x18(%eax),%eax
8010127d:	68 00 02 00 00       	push   $0x200
80101282:	6a 00                	push   $0x0
80101284:	50                   	push   %eax
80101285:	e8 f6 34 00 00       	call   80104780 <memset>
  log_write(bp);
8010128a:	89 1c 24             	mov    %ebx,(%esp)
8010128d:	e8 0e 1d 00 00       	call   80102fa0 <log_write>
  brelse(bp);
80101292:	89 1c 24             	mov    %ebx,(%esp)
80101295:	e8 66 ef ff ff       	call   80100200 <brelse>
}
8010129a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010129d:	89 f0                	mov    %esi,%eax
8010129f:	5b                   	pop    %ebx
801012a0:	5e                   	pop    %esi
801012a1:	5f                   	pop    %edi
801012a2:	5d                   	pop    %ebp
801012a3:	c3                   	ret    
801012a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801012ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801012af:	90                   	nop

801012b0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801012b0:	55                   	push   %ebp
801012b1:	89 e5                	mov    %esp,%ebp
801012b3:	57                   	push   %edi
801012b4:	89 c7                	mov    %eax,%edi
801012b6:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801012b7:	31 f6                	xor    %esi,%esi
{
801012b9:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012ba:	bb f4 01 11 80       	mov    $0x801101f4,%ebx
{
801012bf:	83 ec 28             	sub    $0x28,%esp
801012c2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801012c5:	68 c0 01 11 80       	push   $0x801101c0
801012ca:	e8 81 32 00 00       	call   80104550 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012cf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
801012d2:	83 c4 10             	add    $0x10,%esp
801012d5:	eb 18                	jmp    801012ef <iget+0x3f>
801012d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801012de:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012e0:	39 3b                	cmp    %edi,(%ebx)
801012e2:	74 64                	je     80101348 <iget+0x98>
801012e4:	83 c3 50             	add    $0x50,%ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012e7:	81 fb 94 11 11 80    	cmp    $0x80111194,%ebx
801012ed:	73 21                	jae    80101310 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012ef:	8b 4b 08             	mov    0x8(%ebx),%ecx
801012f2:	85 c9                	test   %ecx,%ecx
801012f4:	7f ea                	jg     801012e0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012f6:	85 f6                	test   %esi,%esi
801012f8:	75 ea                	jne    801012e4 <iget+0x34>
801012fa:	89 d8                	mov    %ebx,%eax
801012fc:	83 c3 50             	add    $0x50,%ebx
801012ff:	85 c9                	test   %ecx,%ecx
80101301:	75 6c                	jne    8010136f <iget+0xbf>
80101303:	89 c6                	mov    %eax,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101305:	81 fb 94 11 11 80    	cmp    $0x80111194,%ebx
8010130b:	72 e2                	jb     801012ef <iget+0x3f>
8010130d:	8d 76 00             	lea    0x0(%esi),%esi
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101310:	85 f6                	test   %esi,%esi
80101312:	74 73                	je     80101387 <iget+0xd7>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);
80101314:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101317:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101319:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010131c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
80101323:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
  release(&icache.lock);
8010132a:	68 c0 01 11 80       	push   $0x801101c0
8010132f:	e8 fc 33 00 00       	call   80104730 <release>

  return ip;
80101334:	83 c4 10             	add    $0x10,%esp
}
80101337:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010133a:	89 f0                	mov    %esi,%eax
8010133c:	5b                   	pop    %ebx
8010133d:	5e                   	pop    %esi
8010133e:	5f                   	pop    %edi
8010133f:	5d                   	pop    %ebp
80101340:	c3                   	ret    
80101341:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101348:	39 53 04             	cmp    %edx,0x4(%ebx)
8010134b:	75 97                	jne    801012e4 <iget+0x34>
      release(&icache.lock);
8010134d:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101350:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101353:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101355:	68 c0 01 11 80       	push   $0x801101c0
      ip->ref++;
8010135a:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010135d:	e8 ce 33 00 00       	call   80104730 <release>
      return ip;
80101362:	83 c4 10             	add    $0x10,%esp
}
80101365:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101368:	89 f0                	mov    %esi,%eax
8010136a:	5b                   	pop    %ebx
8010136b:	5e                   	pop    %esi
8010136c:	5f                   	pop    %edi
8010136d:	5d                   	pop    %ebp
8010136e:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010136f:	81 fb 94 11 11 80    	cmp    $0x80111194,%ebx
80101375:	73 10                	jae    80101387 <iget+0xd7>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101377:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010137a:	85 c9                	test   %ecx,%ecx
8010137c:	0f 8f 5e ff ff ff    	jg     801012e0 <iget+0x30>
80101382:	e9 73 ff ff ff       	jmp    801012fa <iget+0x4a>
    panic("iget: no inodes");
80101387:	83 ec 0c             	sub    $0xc,%esp
8010138a:	68 6d 73 10 80       	push   $0x8010736d
8010138f:	e8 ec ef ff ff       	call   80100380 <panic>
80101394:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010139b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010139f:	90                   	nop

801013a0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801013a0:	55                   	push   %ebp
801013a1:	89 e5                	mov    %esp,%ebp
801013a3:	57                   	push   %edi
801013a4:	56                   	push   %esi
801013a5:	89 c6                	mov    %eax,%esi
801013a7:	53                   	push   %ebx
801013a8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801013ab:	83 fa 0b             	cmp    $0xb,%edx
801013ae:	0f 86 7c 00 00 00    	jbe    80101430 <bmap+0x90>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801013b4:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801013b7:	83 fb 7f             	cmp    $0x7f,%ebx
801013ba:	0f 87 90 00 00 00    	ja     80101450 <bmap+0xb0>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801013c0:	8b 40 4c             	mov    0x4c(%eax),%eax
801013c3:	8b 16                	mov    (%esi),%edx
801013c5:	85 c0                	test   %eax,%eax
801013c7:	74 57                	je     80101420 <bmap+0x80>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801013c9:	83 ec 08             	sub    $0x8,%esp
801013cc:	50                   	push   %eax
801013cd:	52                   	push   %edx
801013ce:	e8 ed ec ff ff       	call   801000c0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801013d3:	83 c4 10             	add    $0x10,%esp
801013d6:	8d 54 98 18          	lea    0x18(%eax,%ebx,4),%edx
    bp = bread(ip->dev, addr);
801013da:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801013dc:	8b 1a                	mov    (%edx),%ebx
801013de:	85 db                	test   %ebx,%ebx
801013e0:	74 1e                	je     80101400 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801013e2:	83 ec 0c             	sub    $0xc,%esp
801013e5:	57                   	push   %edi
801013e6:	e8 15 ee ff ff       	call   80100200 <brelse>
    return addr;
801013eb:	83 c4 10             	add    $0x10,%esp
  }

  panic("bmap: out of range");
}
801013ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013f1:	89 d8                	mov    %ebx,%eax
801013f3:	5b                   	pop    %ebx
801013f4:	5e                   	pop    %esi
801013f5:	5f                   	pop    %edi
801013f6:	5d                   	pop    %ebp
801013f7:	c3                   	ret    
801013f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801013ff:	90                   	nop
      a[bn] = addr = balloc(ip->dev);
80101400:	8b 06                	mov    (%esi),%eax
80101402:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101405:	e8 96 fd ff ff       	call   801011a0 <balloc>
8010140a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
8010140d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101410:	89 c3                	mov    %eax,%ebx
80101412:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101414:	57                   	push   %edi
80101415:	e8 86 1b 00 00       	call   80102fa0 <log_write>
8010141a:	83 c4 10             	add    $0x10,%esp
8010141d:	eb c3                	jmp    801013e2 <bmap+0x42>
8010141f:	90                   	nop
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101420:	89 d0                	mov    %edx,%eax
80101422:	e8 79 fd ff ff       	call   801011a0 <balloc>
80101427:	8b 16                	mov    (%esi),%edx
80101429:	89 46 4c             	mov    %eax,0x4c(%esi)
8010142c:	eb 9b                	jmp    801013c9 <bmap+0x29>
8010142e:	66 90                	xchg   %ax,%ax
    if((addr = ip->addrs[bn]) == 0)
80101430:	8d 3c 90             	lea    (%eax,%edx,4),%edi
80101433:	8b 5f 1c             	mov    0x1c(%edi),%ebx
80101436:	85 db                	test   %ebx,%ebx
80101438:	75 b4                	jne    801013ee <bmap+0x4e>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010143a:	8b 00                	mov    (%eax),%eax
8010143c:	e8 5f fd ff ff       	call   801011a0 <balloc>
80101441:	89 47 1c             	mov    %eax,0x1c(%edi)
80101444:	89 c3                	mov    %eax,%ebx
}
80101446:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101449:	89 d8                	mov    %ebx,%eax
8010144b:	5b                   	pop    %ebx
8010144c:	5e                   	pop    %esi
8010144d:	5f                   	pop    %edi
8010144e:	5d                   	pop    %ebp
8010144f:	c3                   	ret    
  panic("bmap: out of range");
80101450:	83 ec 0c             	sub    $0xc,%esp
80101453:	68 7d 73 10 80       	push   $0x8010737d
80101458:	e8 23 ef ff ff       	call   80100380 <panic>
8010145d:	8d 76 00             	lea    0x0(%esi),%esi

80101460 <readsb>:
{
80101460:	f3 0f 1e fb          	endbr32 
80101464:	55                   	push   %ebp
80101465:	89 e5                	mov    %esp,%ebp
80101467:	56                   	push   %esi
80101468:	53                   	push   %ebx
80101469:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
8010146c:	83 ec 08             	sub    $0x8,%esp
8010146f:	6a 01                	push   $0x1
80101471:	ff 75 08             	pushl  0x8(%ebp)
80101474:	e8 47 ec ff ff       	call   801000c0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101479:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
8010147c:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010147e:	8d 40 18             	lea    0x18(%eax),%eax
80101481:	6a 1c                	push   $0x1c
80101483:	50                   	push   %eax
80101484:	56                   	push   %esi
80101485:	e8 96 33 00 00       	call   80104820 <memmove>
  brelse(bp);
8010148a:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010148d:	83 c4 10             	add    $0x10,%esp
}
80101490:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101493:	5b                   	pop    %ebx
80101494:	5e                   	pop    %esi
80101495:	5d                   	pop    %ebp
  brelse(bp);
80101496:	e9 65 ed ff ff       	jmp    80100200 <brelse>
8010149b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010149f:	90                   	nop

801014a0 <bfree>:
{
801014a0:	55                   	push   %ebp
801014a1:	89 e5                	mov    %esp,%ebp
801014a3:	56                   	push   %esi
801014a4:	89 c6                	mov    %eax,%esi
801014a6:	53                   	push   %ebx
801014a7:	89 d3                	mov    %edx,%ebx
  readsb(dev, &sb);
801014a9:	83 ec 08             	sub    $0x8,%esp
801014ac:	68 a0 01 11 80       	push   $0x801101a0
801014b1:	50                   	push   %eax
801014b2:	e8 a9 ff ff ff       	call   80101460 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801014b7:	58                   	pop    %eax
801014b8:	89 d8                	mov    %ebx,%eax
801014ba:	5a                   	pop    %edx
801014bb:	c1 e8 0c             	shr    $0xc,%eax
801014be:	03 05 b8 01 11 80    	add    0x801101b8,%eax
801014c4:	50                   	push   %eax
801014c5:	56                   	push   %esi
801014c6:	e8 f5 eb ff ff       	call   801000c0 <bread>
  m = 1 << (bi % 8);
801014cb:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801014cd:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
801014d0:	ba 01 00 00 00       	mov    $0x1,%edx
801014d5:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
801014d8:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801014de:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
801014e1:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
801014e3:	0f b6 4c 18 18       	movzbl 0x18(%eax,%ebx,1),%ecx
801014e8:	85 d1                	test   %edx,%ecx
801014ea:	74 25                	je     80101511 <bfree+0x71>
  bp->data[bi/8] &= ~m;
801014ec:	f7 d2                	not    %edx
  log_write(bp);
801014ee:	83 ec 0c             	sub    $0xc,%esp
801014f1:	89 c6                	mov    %eax,%esi
  bp->data[bi/8] &= ~m;
801014f3:	21 ca                	and    %ecx,%edx
801014f5:	88 54 18 18          	mov    %dl,0x18(%eax,%ebx,1)
  log_write(bp);
801014f9:	50                   	push   %eax
801014fa:	e8 a1 1a 00 00       	call   80102fa0 <log_write>
  brelse(bp);
801014ff:	89 34 24             	mov    %esi,(%esp)
80101502:	e8 f9 ec ff ff       	call   80100200 <brelse>
}
80101507:	83 c4 10             	add    $0x10,%esp
8010150a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010150d:	5b                   	pop    %ebx
8010150e:	5e                   	pop    %esi
8010150f:	5d                   	pop    %ebp
80101510:	c3                   	ret    
    panic("freeing free block");
80101511:	83 ec 0c             	sub    $0xc,%esp
80101514:	68 90 73 10 80       	push   $0x80107390
80101519:	e8 62 ee ff ff       	call   80100380 <panic>
8010151e:	66 90                	xchg   %ax,%ax

80101520 <iinit>:
{
80101520:	f3 0f 1e fb          	endbr32 
80101524:	55                   	push   %ebp
80101525:	89 e5                	mov    %esp,%ebp
80101527:	83 ec 10             	sub    $0x10,%esp
  initlock(&icache.lock, "icache");
8010152a:	68 a3 73 10 80       	push   $0x801073a3
8010152f:	68 c0 01 11 80       	push   $0x801101c0
80101534:	e8 f7 2f 00 00       	call   80104530 <initlock>
  readsb(dev, &sb);
80101539:	58                   	pop    %eax
8010153a:	5a                   	pop    %edx
8010153b:	68 a0 01 11 80       	push   $0x801101a0
80101540:	ff 75 08             	pushl  0x8(%ebp)
80101543:	e8 18 ff ff ff       	call   80101460 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101548:	ff 35 b8 01 11 80    	pushl  0x801101b8
8010154e:	ff 35 b4 01 11 80    	pushl  0x801101b4
80101554:	ff 35 b0 01 11 80    	pushl  0x801101b0
8010155a:	ff 35 ac 01 11 80    	pushl  0x801101ac
80101560:	ff 35 a8 01 11 80    	pushl  0x801101a8
80101566:	ff 35 a4 01 11 80    	pushl  0x801101a4
8010156c:	ff 35 a0 01 11 80    	pushl  0x801101a0
80101572:	68 04 74 10 80       	push   $0x80107404
80101577:	e8 24 f1 ff ff       	call   801006a0 <cprintf>
}
8010157c:	83 c4 30             	add    $0x30,%esp
8010157f:	c9                   	leave  
80101580:	c3                   	ret    
80101581:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101588:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010158f:	90                   	nop

80101590 <ialloc>:
{
80101590:	f3 0f 1e fb          	endbr32 
80101594:	55                   	push   %ebp
80101595:	89 e5                	mov    %esp,%ebp
80101597:	57                   	push   %edi
80101598:	56                   	push   %esi
80101599:	53                   	push   %ebx
8010159a:	83 ec 1c             	sub    $0x1c,%esp
8010159d:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
801015a0:	83 3d a8 01 11 80 01 	cmpl   $0x1,0x801101a8
{
801015a7:	8b 75 08             	mov    0x8(%ebp),%esi
801015aa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
801015ad:	0f 86 8d 00 00 00    	jbe    80101640 <ialloc+0xb0>
801015b3:	bf 01 00 00 00       	mov    $0x1,%edi
801015b8:	eb 1d                	jmp    801015d7 <ialloc+0x47>
801015ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    brelse(bp);
801015c0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801015c3:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
801015c6:	53                   	push   %ebx
801015c7:	e8 34 ec ff ff       	call   80100200 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801015cc:	83 c4 10             	add    $0x10,%esp
801015cf:	3b 3d a8 01 11 80    	cmp    0x801101a8,%edi
801015d5:	73 69                	jae    80101640 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801015d7:	89 f8                	mov    %edi,%eax
801015d9:	83 ec 08             	sub    $0x8,%esp
801015dc:	c1 e8 03             	shr    $0x3,%eax
801015df:	03 05 b4 01 11 80    	add    0x801101b4,%eax
801015e5:	50                   	push   %eax
801015e6:	56                   	push   %esi
801015e7:	e8 d4 ea ff ff       	call   801000c0 <bread>
    if(dip->type == 0){  // a free inode
801015ec:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
801015ef:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
801015f1:	89 f8                	mov    %edi,%eax
801015f3:	83 e0 07             	and    $0x7,%eax
801015f6:	c1 e0 06             	shl    $0x6,%eax
801015f9:	8d 4c 03 18          	lea    0x18(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801015fd:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101601:	75 bd                	jne    801015c0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101603:	83 ec 04             	sub    $0x4,%esp
80101606:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101609:	6a 40                	push   $0x40
8010160b:	6a 00                	push   $0x0
8010160d:	51                   	push   %ecx
8010160e:	e8 6d 31 00 00       	call   80104780 <memset>
      dip->type = type;
80101613:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101617:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010161a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010161d:	89 1c 24             	mov    %ebx,(%esp)
80101620:	e8 7b 19 00 00       	call   80102fa0 <log_write>
      brelse(bp);
80101625:	89 1c 24             	mov    %ebx,(%esp)
80101628:	e8 d3 eb ff ff       	call   80100200 <brelse>
      return iget(dev, inum);
8010162d:	83 c4 10             	add    $0x10,%esp
}
80101630:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101633:	89 fa                	mov    %edi,%edx
}
80101635:	5b                   	pop    %ebx
      return iget(dev, inum);
80101636:	89 f0                	mov    %esi,%eax
}
80101638:	5e                   	pop    %esi
80101639:	5f                   	pop    %edi
8010163a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010163b:	e9 70 fc ff ff       	jmp    801012b0 <iget>
  panic("ialloc: no inodes");
80101640:	83 ec 0c             	sub    $0xc,%esp
80101643:	68 aa 73 10 80       	push   $0x801073aa
80101648:	e8 33 ed ff ff       	call   80100380 <panic>
8010164d:	8d 76 00             	lea    0x0(%esi),%esi

80101650 <iupdate>:
{
80101650:	f3 0f 1e fb          	endbr32 
80101654:	55                   	push   %ebp
80101655:	89 e5                	mov    %esp,%ebp
80101657:	56                   	push   %esi
80101658:	53                   	push   %ebx
80101659:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010165c:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010165f:	83 c3 1c             	add    $0x1c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101662:	83 ec 08             	sub    $0x8,%esp
80101665:	c1 e8 03             	shr    $0x3,%eax
80101668:	03 05 b4 01 11 80    	add    0x801101b4,%eax
8010166e:	50                   	push   %eax
8010166f:	ff 73 e4             	pushl  -0x1c(%ebx)
80101672:	e8 49 ea ff ff       	call   801000c0 <bread>
  dip->type = ip->type;
80101677:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010167b:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010167e:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101680:	8b 43 e8             	mov    -0x18(%ebx),%eax
80101683:	83 e0 07             	and    $0x7,%eax
80101686:	c1 e0 06             	shl    $0x6,%eax
80101689:	8d 44 06 18          	lea    0x18(%esi,%eax,1),%eax
  dip->type = ip->type;
8010168d:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101690:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101694:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101697:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
8010169b:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010169f:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801016a3:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
801016a7:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
801016ab:	8b 53 fc             	mov    -0x4(%ebx),%edx
801016ae:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016b1:	6a 34                	push   $0x34
801016b3:	53                   	push   %ebx
801016b4:	50                   	push   %eax
801016b5:	e8 66 31 00 00       	call   80104820 <memmove>
  log_write(bp);
801016ba:	89 34 24             	mov    %esi,(%esp)
801016bd:	e8 de 18 00 00       	call   80102fa0 <log_write>
  brelse(bp);
801016c2:	89 75 08             	mov    %esi,0x8(%ebp)
801016c5:	83 c4 10             	add    $0x10,%esp
}
801016c8:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016cb:	5b                   	pop    %ebx
801016cc:	5e                   	pop    %esi
801016cd:	5d                   	pop    %ebp
  brelse(bp);
801016ce:	e9 2d eb ff ff       	jmp    80100200 <brelse>
801016d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801016da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801016e0 <idup>:
{
801016e0:	f3 0f 1e fb          	endbr32 
801016e4:	55                   	push   %ebp
801016e5:	89 e5                	mov    %esp,%ebp
801016e7:	53                   	push   %ebx
801016e8:	83 ec 10             	sub    $0x10,%esp
801016eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801016ee:	68 c0 01 11 80       	push   $0x801101c0
801016f3:	e8 58 2e 00 00       	call   80104550 <acquire>
  ip->ref++;
801016f8:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801016fc:	c7 04 24 c0 01 11 80 	movl   $0x801101c0,(%esp)
80101703:	e8 28 30 00 00       	call   80104730 <release>
}
80101708:	89 d8                	mov    %ebx,%eax
8010170a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010170d:	c9                   	leave  
8010170e:	c3                   	ret    
8010170f:	90                   	nop

80101710 <ilock>:
{
80101710:	f3 0f 1e fb          	endbr32 
80101714:	55                   	push   %ebp
80101715:	89 e5                	mov    %esp,%ebp
80101717:	56                   	push   %esi
80101718:	53                   	push   %ebx
80101719:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
8010171c:	85 db                	test   %ebx,%ebx
8010171e:	0f 84 ec 00 00 00    	je     80101810 <ilock+0x100>
80101724:	8b 43 08             	mov    0x8(%ebx),%eax
80101727:	85 c0                	test   %eax,%eax
80101729:	0f 8e e1 00 00 00    	jle    80101810 <ilock+0x100>
  acquire(&icache.lock);
8010172f:	83 ec 0c             	sub    $0xc,%esp
80101732:	68 c0 01 11 80       	push   $0x801101c0
80101737:	e8 14 2e 00 00       	call   80104550 <acquire>
  while(ip->flags & I_BUSY)
8010173c:	8b 43 0c             	mov    0xc(%ebx),%eax
8010173f:	83 c4 10             	add    $0x10,%esp
80101742:	a8 01                	test   $0x1,%al
80101744:	74 22                	je     80101768 <ilock+0x58>
80101746:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010174d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(ip, &icache.lock);
80101750:	83 ec 08             	sub    $0x8,%esp
80101753:	68 c0 01 11 80       	push   $0x801101c0
80101758:	53                   	push   %ebx
80101759:	e8 52 28 00 00       	call   80103fb0 <sleep>
  while(ip->flags & I_BUSY)
8010175e:	8b 43 0c             	mov    0xc(%ebx),%eax
80101761:	83 c4 10             	add    $0x10,%esp
80101764:	a8 01                	test   $0x1,%al
80101766:	75 e8                	jne    80101750 <ilock+0x40>
  release(&icache.lock);
80101768:	83 ec 0c             	sub    $0xc,%esp
  ip->flags |= I_BUSY;
8010176b:	83 c8 01             	or     $0x1,%eax
8010176e:	89 43 0c             	mov    %eax,0xc(%ebx)
  release(&icache.lock);
80101771:	68 c0 01 11 80       	push   $0x801101c0
80101776:	e8 b5 2f 00 00       	call   80104730 <release>
  if(!(ip->flags & I_VALID)){
8010177b:	83 c4 10             	add    $0x10,%esp
8010177e:	f6 43 0c 02          	testb  $0x2,0xc(%ebx)
80101782:	74 0c                	je     80101790 <ilock+0x80>
}
80101784:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101787:	5b                   	pop    %ebx
80101788:	5e                   	pop    %esi
80101789:	5d                   	pop    %ebp
8010178a:	c3                   	ret    
8010178b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010178f:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101790:	8b 43 04             	mov    0x4(%ebx),%eax
80101793:	83 ec 08             	sub    $0x8,%esp
80101796:	c1 e8 03             	shr    $0x3,%eax
80101799:	03 05 b4 01 11 80    	add    0x801101b4,%eax
8010179f:	50                   	push   %eax
801017a0:	ff 33                	pushl  (%ebx)
801017a2:	e8 19 e9 ff ff       	call   801000c0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017a7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017aa:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801017ac:	8b 43 04             	mov    0x4(%ebx),%eax
801017af:	83 e0 07             	and    $0x7,%eax
801017b2:	c1 e0 06             	shl    $0x6,%eax
801017b5:	8d 44 06 18          	lea    0x18(%esi,%eax,1),%eax
    ip->type = dip->type;
801017b9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017bc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801017bf:	66 89 53 10          	mov    %dx,0x10(%ebx)
    ip->major = dip->major;
801017c3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801017c7:	66 89 53 12          	mov    %dx,0x12(%ebx)
    ip->minor = dip->minor;
801017cb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801017cf:	66 89 53 14          	mov    %dx,0x14(%ebx)
    ip->nlink = dip->nlink;
801017d3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801017d7:	66 89 53 16          	mov    %dx,0x16(%ebx)
    ip->size = dip->size;
801017db:	8b 50 fc             	mov    -0x4(%eax),%edx
801017de:	89 53 18             	mov    %edx,0x18(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017e1:	6a 34                	push   $0x34
801017e3:	50                   	push   %eax
801017e4:	8d 43 1c             	lea    0x1c(%ebx),%eax
801017e7:	50                   	push   %eax
801017e8:	e8 33 30 00 00       	call   80104820 <memmove>
    brelse(bp);
801017ed:	89 34 24             	mov    %esi,(%esp)
801017f0:	e8 0b ea ff ff       	call   80100200 <brelse>
    ip->flags |= I_VALID;
801017f5:	83 4b 0c 02          	orl    $0x2,0xc(%ebx)
    if(ip->type == 0)
801017f9:	83 c4 10             	add    $0x10,%esp
801017fc:	66 83 7b 10 00       	cmpw   $0x0,0x10(%ebx)
80101801:	75 81                	jne    80101784 <ilock+0x74>
      panic("ilock: no type");
80101803:	83 ec 0c             	sub    $0xc,%esp
80101806:	68 c2 73 10 80       	push   $0x801073c2
8010180b:	e8 70 eb ff ff       	call   80100380 <panic>
    panic("ilock");
80101810:	83 ec 0c             	sub    $0xc,%esp
80101813:	68 bc 73 10 80       	push   $0x801073bc
80101818:	e8 63 eb ff ff       	call   80100380 <panic>
8010181d:	8d 76 00             	lea    0x0(%esi),%esi

80101820 <iunlock>:
{
80101820:	f3 0f 1e fb          	endbr32 
80101824:	55                   	push   %ebp
80101825:	89 e5                	mov    %esp,%ebp
80101827:	53                   	push   %ebx
80101828:	83 ec 04             	sub    $0x4,%esp
8010182b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
8010182e:	85 db                	test   %ebx,%ebx
80101830:	74 39                	je     8010186b <iunlock+0x4b>
80101832:	f6 43 0c 01          	testb  $0x1,0xc(%ebx)
80101836:	74 33                	je     8010186b <iunlock+0x4b>
80101838:	8b 43 08             	mov    0x8(%ebx),%eax
8010183b:	85 c0                	test   %eax,%eax
8010183d:	7e 2c                	jle    8010186b <iunlock+0x4b>
  acquire(&icache.lock);
8010183f:	83 ec 0c             	sub    $0xc,%esp
80101842:	68 c0 01 11 80       	push   $0x801101c0
80101847:	e8 04 2d 00 00       	call   80104550 <acquire>
  ip->flags &= ~I_BUSY;
8010184c:	83 63 0c fe          	andl   $0xfffffffe,0xc(%ebx)
  wakeup(ip);
80101850:	89 1c 24             	mov    %ebx,(%esp)
80101853:	e8 18 29 00 00       	call   80104170 <wakeup>
  release(&icache.lock);
80101858:	c7 45 08 c0 01 11 80 	movl   $0x801101c0,0x8(%ebp)
}
8010185f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&icache.lock);
80101862:	83 c4 10             	add    $0x10,%esp
}
80101865:	c9                   	leave  
  release(&icache.lock);
80101866:	e9 c5 2e 00 00       	jmp    80104730 <release>
    panic("iunlock");
8010186b:	83 ec 0c             	sub    $0xc,%esp
8010186e:	68 d1 73 10 80       	push   $0x801073d1
80101873:	e8 08 eb ff ff       	call   80100380 <panic>
80101878:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010187f:	90                   	nop

80101880 <iput>:
{
80101880:	f3 0f 1e fb          	endbr32 
80101884:	55                   	push   %ebp
80101885:	89 e5                	mov    %esp,%ebp
80101887:	57                   	push   %edi
80101888:	56                   	push   %esi
80101889:	53                   	push   %ebx
8010188a:	83 ec 28             	sub    $0x28,%esp
8010188d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
80101890:	68 c0 01 11 80       	push   $0x801101c0
80101895:	e8 b6 2c 00 00       	call   80104550 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
8010189a:	8b 43 08             	mov    0x8(%ebx),%eax
8010189d:	83 c4 10             	add    $0x10,%esp
801018a0:	83 f8 01             	cmp    $0x1,%eax
801018a3:	0f 85 af 00 00 00    	jne    80101958 <iput+0xd8>
801018a9:	8b 53 0c             	mov    0xc(%ebx),%edx
801018ac:	f6 c2 02             	test   $0x2,%dl
801018af:	0f 84 a3 00 00 00    	je     80101958 <iput+0xd8>
801018b5:	66 83 7b 16 00       	cmpw   $0x0,0x16(%ebx)
801018ba:	0f 85 98 00 00 00    	jne    80101958 <iput+0xd8>
    if(ip->flags & I_BUSY)
801018c0:	f6 c2 01             	test   $0x1,%dl
801018c3:	0f 85 0b 01 00 00    	jne    801019d4 <iput+0x154>
    release(&icache.lock);
801018c9:	83 ec 0c             	sub    $0xc,%esp
801018cc:	8d 73 1c             	lea    0x1c(%ebx),%esi
801018cf:	8d 7b 4c             	lea    0x4c(%ebx),%edi
    ip->flags |= I_BUSY;
801018d2:	83 ca 01             	or     $0x1,%edx
801018d5:	89 53 0c             	mov    %edx,0xc(%ebx)
    release(&icache.lock);
801018d8:	68 c0 01 11 80       	push   $0x801101c0
801018dd:	e8 4e 2e 00 00       	call   80104730 <release>
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801018e2:	83 c4 10             	add    $0x10,%esp
801018e5:	eb 10                	jmp    801018f7 <iput+0x77>
801018e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018ee:	66 90                	xchg   %ax,%ax
801018f0:	83 c6 04             	add    $0x4,%esi
801018f3:	39 fe                	cmp    %edi,%esi
801018f5:	74 1b                	je     80101912 <iput+0x92>
    if(ip->addrs[i]){
801018f7:	8b 16                	mov    (%esi),%edx
801018f9:	85 d2                	test   %edx,%edx
801018fb:	74 f3                	je     801018f0 <iput+0x70>
      bfree(ip->dev, ip->addrs[i]);
801018fd:	8b 03                	mov    (%ebx),%eax
801018ff:	83 c6 04             	add    $0x4,%esi
80101902:	e8 99 fb ff ff       	call   801014a0 <bfree>
      ip->addrs[i] = 0;
80101907:	c7 46 fc 00 00 00 00 	movl   $0x0,-0x4(%esi)
  for(i = 0; i < NDIRECT; i++){
8010190e:	39 fe                	cmp    %edi,%esi
80101910:	75 e5                	jne    801018f7 <iput+0x77>
    }
  }

  if(ip->addrs[NDIRECT]){
80101912:	8b 43 4c             	mov    0x4c(%ebx),%eax
80101915:	85 c0                	test   %eax,%eax
80101917:	75 5f                	jne    80101978 <iput+0xf8>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101919:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
8010191c:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
  iupdate(ip);
80101923:	53                   	push   %ebx
80101924:	e8 27 fd ff ff       	call   80101650 <iupdate>
    ip->type = 0;
80101929:	31 c0                	xor    %eax,%eax
8010192b:	66 89 43 10          	mov    %ax,0x10(%ebx)
    iupdate(ip);
8010192f:	89 1c 24             	mov    %ebx,(%esp)
80101932:	e8 19 fd ff ff       	call   80101650 <iupdate>
    acquire(&icache.lock);
80101937:	c7 04 24 c0 01 11 80 	movl   $0x801101c0,(%esp)
8010193e:	e8 0d 2c 00 00       	call   80104550 <acquire>
    ip->flags = 0;
80101943:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    wakeup(ip);
8010194a:	89 1c 24             	mov    %ebx,(%esp)
8010194d:	e8 1e 28 00 00       	call   80104170 <wakeup>
80101952:	8b 43 08             	mov    0x8(%ebx),%eax
80101955:	83 c4 10             	add    $0x10,%esp
  ip->ref--;
80101958:	83 e8 01             	sub    $0x1,%eax
8010195b:	89 43 08             	mov    %eax,0x8(%ebx)
  release(&icache.lock);
8010195e:	c7 45 08 c0 01 11 80 	movl   $0x801101c0,0x8(%ebp)
}
80101965:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101968:	5b                   	pop    %ebx
80101969:	5e                   	pop    %esi
8010196a:	5f                   	pop    %edi
8010196b:	5d                   	pop    %ebp
  release(&icache.lock);
8010196c:	e9 bf 2d 00 00       	jmp    80104730 <release>
80101971:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101978:	83 ec 08             	sub    $0x8,%esp
8010197b:	50                   	push   %eax
8010197c:	ff 33                	pushl  (%ebx)
8010197e:	e8 3d e7 ff ff       	call   801000c0 <bread>
80101983:	83 c4 10             	add    $0x10,%esp
80101986:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101989:	8d 78 18             	lea    0x18(%eax),%edi
8010198c:	8d b0 18 02 00 00    	lea    0x218(%eax),%esi
80101992:	eb 0b                	jmp    8010199f <iput+0x11f>
80101994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101998:	83 c7 04             	add    $0x4,%edi
8010199b:	39 f7                	cmp    %esi,%edi
8010199d:	74 11                	je     801019b0 <iput+0x130>
      if(a[j])
8010199f:	8b 17                	mov    (%edi),%edx
801019a1:	85 d2                	test   %edx,%edx
801019a3:	74 f3                	je     80101998 <iput+0x118>
        bfree(ip->dev, a[j]);
801019a5:	8b 03                	mov    (%ebx),%eax
801019a7:	e8 f4 fa ff ff       	call   801014a0 <bfree>
801019ac:	eb ea                	jmp    80101998 <iput+0x118>
801019ae:	66 90                	xchg   %ax,%ax
    brelse(bp);
801019b0:	83 ec 0c             	sub    $0xc,%esp
801019b3:	ff 75 e4             	pushl  -0x1c(%ebp)
801019b6:	e8 45 e8 ff ff       	call   80100200 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801019bb:	8b 53 4c             	mov    0x4c(%ebx),%edx
801019be:	8b 03                	mov    (%ebx),%eax
801019c0:	e8 db fa ff ff       	call   801014a0 <bfree>
    ip->addrs[NDIRECT] = 0;
801019c5:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801019cc:	83 c4 10             	add    $0x10,%esp
801019cf:	e9 45 ff ff ff       	jmp    80101919 <iput+0x99>
      panic("iput busy");
801019d4:	83 ec 0c             	sub    $0xc,%esp
801019d7:	68 d9 73 10 80       	push   $0x801073d9
801019dc:	e8 9f e9 ff ff       	call   80100380 <panic>
801019e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019ef:	90                   	nop

801019f0 <iunlockput>:
{
801019f0:	f3 0f 1e fb          	endbr32 
801019f4:	55                   	push   %ebp
801019f5:	89 e5                	mov    %esp,%ebp
801019f7:	53                   	push   %ebx
801019f8:	83 ec 10             	sub    $0x10,%esp
801019fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801019fe:	53                   	push   %ebx
801019ff:	e8 1c fe ff ff       	call   80101820 <iunlock>
  iput(ip);
80101a04:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101a07:	83 c4 10             	add    $0x10,%esp
}
80101a0a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101a0d:	c9                   	leave  
  iput(ip);
80101a0e:	e9 6d fe ff ff       	jmp    80101880 <iput>
80101a13:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101a20 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101a20:	f3 0f 1e fb          	endbr32 
80101a24:	55                   	push   %ebp
80101a25:	89 e5                	mov    %esp,%ebp
80101a27:	8b 55 08             	mov    0x8(%ebp),%edx
80101a2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101a2d:	8b 0a                	mov    (%edx),%ecx
80101a2f:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101a32:	8b 4a 04             	mov    0x4(%edx),%ecx
80101a35:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101a38:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
80101a3c:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101a3f:	0f b7 4a 16          	movzwl 0x16(%edx),%ecx
80101a43:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101a47:	8b 52 18             	mov    0x18(%edx),%edx
80101a4a:	89 50 10             	mov    %edx,0x10(%eax)
}
80101a4d:	5d                   	pop    %ebp
80101a4e:	c3                   	ret    
80101a4f:	90                   	nop

80101a50 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101a50:	f3 0f 1e fb          	endbr32 
80101a54:	55                   	push   %ebp
80101a55:	89 e5                	mov    %esp,%ebp
80101a57:	57                   	push   %edi
80101a58:	56                   	push   %esi
80101a59:	53                   	push   %ebx
80101a5a:	83 ec 1c             	sub    $0x1c,%esp
80101a5d:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101a60:	8b 45 08             	mov    0x8(%ebp),%eax
80101a63:	8b 75 10             	mov    0x10(%ebp),%esi
80101a66:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101a69:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a6c:	66 83 78 10 03       	cmpw   $0x3,0x10(%eax)
{
80101a71:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a74:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101a77:	0f 84 a3 00 00 00    	je     80101b20 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101a7d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a80:	8b 40 18             	mov    0x18(%eax),%eax
80101a83:	39 c6                	cmp    %eax,%esi
80101a85:	0f 87 b6 00 00 00    	ja     80101b41 <readi+0xf1>
80101a8b:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101a8e:	31 c9                	xor    %ecx,%ecx
80101a90:	89 da                	mov    %ebx,%edx
80101a92:	01 f2                	add    %esi,%edx
80101a94:	0f 92 c1             	setb   %cl
80101a97:	89 cf                	mov    %ecx,%edi
80101a99:	0f 82 a2 00 00 00    	jb     80101b41 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101a9f:	89 c1                	mov    %eax,%ecx
80101aa1:	29 f1                	sub    %esi,%ecx
80101aa3:	39 d0                	cmp    %edx,%eax
80101aa5:	0f 43 cb             	cmovae %ebx,%ecx
80101aa8:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101aab:	85 c9                	test   %ecx,%ecx
80101aad:	74 63                	je     80101b12 <readi+0xc2>
80101aaf:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ab0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101ab3:	89 f2                	mov    %esi,%edx
80101ab5:	c1 ea 09             	shr    $0x9,%edx
80101ab8:	89 d8                	mov    %ebx,%eax
80101aba:	e8 e1 f8 ff ff       	call   801013a0 <bmap>
80101abf:	83 ec 08             	sub    $0x8,%esp
80101ac2:	50                   	push   %eax
80101ac3:	ff 33                	pushl  (%ebx)
80101ac5:	e8 f6 e5 ff ff       	call   801000c0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101aca:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101acd:	b9 00 02 00 00       	mov    $0x200,%ecx
80101ad2:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ad5:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101ad7:	89 f0                	mov    %esi,%eax
80101ad9:	25 ff 01 00 00       	and    $0x1ff,%eax
80101ade:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101ae0:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101ae3:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101ae5:	8d 44 02 18          	lea    0x18(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101ae9:	39 d9                	cmp    %ebx,%ecx
80101aeb:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101aee:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101aef:	01 df                	add    %ebx,%edi
80101af1:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101af3:	50                   	push   %eax
80101af4:	ff 75 e0             	pushl  -0x20(%ebp)
80101af7:	e8 24 2d 00 00       	call   80104820 <memmove>
    brelse(bp);
80101afc:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101aff:	89 14 24             	mov    %edx,(%esp)
80101b02:	e8 f9 e6 ff ff       	call   80100200 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b07:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101b0a:	83 c4 10             	add    $0x10,%esp
80101b0d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101b10:	77 9e                	ja     80101ab0 <readi+0x60>
  }
  return n;
80101b12:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101b15:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b18:	5b                   	pop    %ebx
80101b19:	5e                   	pop    %esi
80101b1a:	5f                   	pop    %edi
80101b1b:	5d                   	pop    %ebp
80101b1c:	c3                   	ret    
80101b1d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101b20:	0f bf 40 12          	movswl 0x12(%eax),%eax
80101b24:	66 83 f8 09          	cmp    $0x9,%ax
80101b28:	77 17                	ja     80101b41 <readi+0xf1>
80101b2a:	8b 04 c5 40 01 11 80 	mov    -0x7feefec0(,%eax,8),%eax
80101b31:	85 c0                	test   %eax,%eax
80101b33:	74 0c                	je     80101b41 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101b35:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b38:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b3b:	5b                   	pop    %ebx
80101b3c:	5e                   	pop    %esi
80101b3d:	5f                   	pop    %edi
80101b3e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101b3f:	ff e0                	jmp    *%eax
      return -1;
80101b41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b46:	eb cd                	jmp    80101b15 <readi+0xc5>
80101b48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b4f:	90                   	nop

80101b50 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b50:	f3 0f 1e fb          	endbr32 
80101b54:	55                   	push   %ebp
80101b55:	89 e5                	mov    %esp,%ebp
80101b57:	57                   	push   %edi
80101b58:	56                   	push   %esi
80101b59:	53                   	push   %ebx
80101b5a:	83 ec 1c             	sub    $0x1c,%esp
80101b5d:	8b 45 08             	mov    0x8(%ebp),%eax
80101b60:	8b 75 0c             	mov    0xc(%ebp),%esi
80101b63:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b66:	66 83 78 10 03       	cmpw   $0x3,0x10(%eax)
{
80101b6b:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101b6e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101b71:	8b 75 10             	mov    0x10(%ebp),%esi
80101b74:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101b77:	0f 84 b3 00 00 00    	je     80101c30 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101b7d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b80:	39 70 18             	cmp    %esi,0x18(%eax)
80101b83:	0f 82 e3 00 00 00    	jb     80101c6c <writei+0x11c>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101b89:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101b8c:	89 f8                	mov    %edi,%eax
80101b8e:	01 f0                	add    %esi,%eax
80101b90:	0f 82 d6 00 00 00    	jb     80101c6c <writei+0x11c>
80101b96:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101b9b:	0f 87 cb 00 00 00    	ja     80101c6c <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ba1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101ba8:	85 ff                	test   %edi,%edi
80101baa:	74 75                	je     80101c21 <writei+0xd1>
80101bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bb0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101bb3:	89 f2                	mov    %esi,%edx
80101bb5:	c1 ea 09             	shr    $0x9,%edx
80101bb8:	89 f8                	mov    %edi,%eax
80101bba:	e8 e1 f7 ff ff       	call   801013a0 <bmap>
80101bbf:	83 ec 08             	sub    $0x8,%esp
80101bc2:	50                   	push   %eax
80101bc3:	ff 37                	pushl  (%edi)
80101bc5:	e8 f6 e4 ff ff       	call   801000c0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101bca:	b9 00 02 00 00       	mov    $0x200,%ecx
80101bcf:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101bd2:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bd5:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101bd7:	89 f0                	mov    %esi,%eax
80101bd9:	83 c4 0c             	add    $0xc,%esp
80101bdc:	25 ff 01 00 00       	and    $0x1ff,%eax
80101be1:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101be3:	8d 44 07 18          	lea    0x18(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101be7:	39 d9                	cmp    %ebx,%ecx
80101be9:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101bec:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101bed:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101bef:	ff 75 dc             	pushl  -0x24(%ebp)
80101bf2:	50                   	push   %eax
80101bf3:	e8 28 2c 00 00       	call   80104820 <memmove>
    log_write(bp);
80101bf8:	89 3c 24             	mov    %edi,(%esp)
80101bfb:	e8 a0 13 00 00       	call   80102fa0 <log_write>
    brelse(bp);
80101c00:	89 3c 24             	mov    %edi,(%esp)
80101c03:	e8 f8 e5 ff ff       	call   80100200 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c08:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101c0b:	83 c4 10             	add    $0x10,%esp
80101c0e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c11:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101c14:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101c17:	77 97                	ja     80101bb0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101c19:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c1c:	3b 70 18             	cmp    0x18(%eax),%esi
80101c1f:	77 37                	ja     80101c58 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101c21:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101c24:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c27:	5b                   	pop    %ebx
80101c28:	5e                   	pop    %esi
80101c29:	5f                   	pop    %edi
80101c2a:	5d                   	pop    %ebp
80101c2b:	c3                   	ret    
80101c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101c30:	0f bf 40 12          	movswl 0x12(%eax),%eax
80101c34:	66 83 f8 09          	cmp    $0x9,%ax
80101c38:	77 32                	ja     80101c6c <writei+0x11c>
80101c3a:	8b 04 c5 44 01 11 80 	mov    -0x7feefebc(,%eax,8),%eax
80101c41:	85 c0                	test   %eax,%eax
80101c43:	74 27                	je     80101c6c <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80101c45:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101c48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c4b:	5b                   	pop    %ebx
80101c4c:	5e                   	pop    %esi
80101c4d:	5f                   	pop    %edi
80101c4e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101c4f:	ff e0                	jmp    *%eax
80101c51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101c58:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101c5b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101c5e:	89 70 18             	mov    %esi,0x18(%eax)
    iupdate(ip);
80101c61:	50                   	push   %eax
80101c62:	e8 e9 f9 ff ff       	call   80101650 <iupdate>
80101c67:	83 c4 10             	add    $0x10,%esp
80101c6a:	eb b5                	jmp    80101c21 <writei+0xd1>
      return -1;
80101c6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c71:	eb b1                	jmp    80101c24 <writei+0xd4>
80101c73:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101c80 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101c80:	f3 0f 1e fb          	endbr32 
80101c84:	55                   	push   %ebp
80101c85:	89 e5                	mov    %esp,%ebp
80101c87:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101c8a:	6a 0e                	push   $0xe
80101c8c:	ff 75 0c             	pushl  0xc(%ebp)
80101c8f:	ff 75 08             	pushl  0x8(%ebp)
80101c92:	e8 f9 2b 00 00       	call   80104890 <strncmp>
}
80101c97:	c9                   	leave  
80101c98:	c3                   	ret    
80101c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101ca0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101ca0:	f3 0f 1e fb          	endbr32 
80101ca4:	55                   	push   %ebp
80101ca5:	89 e5                	mov    %esp,%ebp
80101ca7:	57                   	push   %edi
80101ca8:	56                   	push   %esi
80101ca9:	53                   	push   %ebx
80101caa:	83 ec 1c             	sub    $0x1c,%esp
80101cad:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101cb0:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
80101cb5:	0f 85 89 00 00 00    	jne    80101d44 <dirlookup+0xa4>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101cbb:	8b 53 18             	mov    0x18(%ebx),%edx
80101cbe:	31 ff                	xor    %edi,%edi
80101cc0:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101cc3:	85 d2                	test   %edx,%edx
80101cc5:	74 42                	je     80101d09 <dirlookup+0x69>
80101cc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cce:	66 90                	xchg   %ax,%ax
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101cd0:	6a 10                	push   $0x10
80101cd2:	57                   	push   %edi
80101cd3:	56                   	push   %esi
80101cd4:	53                   	push   %ebx
80101cd5:	e8 76 fd ff ff       	call   80101a50 <readi>
80101cda:	83 c4 10             	add    $0x10,%esp
80101cdd:	83 f8 10             	cmp    $0x10,%eax
80101ce0:	75 55                	jne    80101d37 <dirlookup+0x97>
      panic("dirlink read");
    if(de.inum == 0)
80101ce2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101ce7:	74 18                	je     80101d01 <dirlookup+0x61>
  return strncmp(s, t, DIRSIZ);
80101ce9:	83 ec 04             	sub    $0x4,%esp
80101cec:	8d 45 da             	lea    -0x26(%ebp),%eax
80101cef:	6a 0e                	push   $0xe
80101cf1:	50                   	push   %eax
80101cf2:	ff 75 0c             	pushl  0xc(%ebp)
80101cf5:	e8 96 2b 00 00       	call   80104890 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101cfa:	83 c4 10             	add    $0x10,%esp
80101cfd:	85 c0                	test   %eax,%eax
80101cff:	74 17                	je     80101d18 <dirlookup+0x78>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101d01:	83 c7 10             	add    $0x10,%edi
80101d04:	3b 7b 18             	cmp    0x18(%ebx),%edi
80101d07:	72 c7                	jb     80101cd0 <dirlookup+0x30>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101d09:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101d0c:	31 c0                	xor    %eax,%eax
}
80101d0e:	5b                   	pop    %ebx
80101d0f:	5e                   	pop    %esi
80101d10:	5f                   	pop    %edi
80101d11:	5d                   	pop    %ebp
80101d12:	c3                   	ret    
80101d13:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d17:	90                   	nop
      if(poff)
80101d18:	8b 45 10             	mov    0x10(%ebp),%eax
80101d1b:	85 c0                	test   %eax,%eax
80101d1d:	74 05                	je     80101d24 <dirlookup+0x84>
        *poff = off;
80101d1f:	8b 45 10             	mov    0x10(%ebp),%eax
80101d22:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101d24:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101d28:	8b 03                	mov    (%ebx),%eax
80101d2a:	e8 81 f5 ff ff       	call   801012b0 <iget>
}
80101d2f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d32:	5b                   	pop    %ebx
80101d33:	5e                   	pop    %esi
80101d34:	5f                   	pop    %edi
80101d35:	5d                   	pop    %ebp
80101d36:	c3                   	ret    
      panic("dirlink read");
80101d37:	83 ec 0c             	sub    $0xc,%esp
80101d3a:	68 f5 73 10 80       	push   $0x801073f5
80101d3f:	e8 3c e6 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
80101d44:	83 ec 0c             	sub    $0xc,%esp
80101d47:	68 e3 73 10 80       	push   $0x801073e3
80101d4c:	e8 2f e6 ff ff       	call   80100380 <panic>
80101d51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d5f:	90                   	nop

80101d60 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d60:	55                   	push   %ebp
80101d61:	89 e5                	mov    %esp,%ebp
80101d63:	57                   	push   %edi
80101d64:	56                   	push   %esi
80101d65:	53                   	push   %ebx
80101d66:	89 c3                	mov    %eax,%ebx
80101d68:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101d6b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101d6e:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101d71:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101d74:	0f 84 86 01 00 00    	je     80101f00 <namex+0x1a0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80101d7a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  acquire(&icache.lock);
80101d80:	83 ec 0c             	sub    $0xc,%esp
80101d83:	89 df                	mov    %ebx,%edi
    ip = idup(proc->cwd);
80101d85:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101d88:	68 c0 01 11 80       	push   $0x801101c0
80101d8d:	e8 be 27 00 00       	call   80104550 <acquire>
  ip->ref++;
80101d92:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101d96:	c7 04 24 c0 01 11 80 	movl   $0x801101c0,(%esp)
80101d9d:	e8 8e 29 00 00       	call   80104730 <release>
80101da2:	83 c4 10             	add    $0x10,%esp
80101da5:	eb 0c                	jmp    80101db3 <namex+0x53>
80101da7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101dae:	66 90                	xchg   %ax,%ax
    path++;
80101db0:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
80101db3:	0f b6 07             	movzbl (%edi),%eax
80101db6:	3c 2f                	cmp    $0x2f,%al
80101db8:	74 f6                	je     80101db0 <namex+0x50>
  if(*path == 0)
80101dba:	84 c0                	test   %al,%al
80101dbc:	0f 84 ee 00 00 00    	je     80101eb0 <namex+0x150>
  while(*path != '/' && *path != 0)
80101dc2:	0f b6 07             	movzbl (%edi),%eax
80101dc5:	84 c0                	test   %al,%al
80101dc7:	0f 84 fb 00 00 00    	je     80101ec8 <namex+0x168>
80101dcd:	89 fb                	mov    %edi,%ebx
80101dcf:	3c 2f                	cmp    $0x2f,%al
80101dd1:	0f 84 f1 00 00 00    	je     80101ec8 <namex+0x168>
80101dd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101dde:	66 90                	xchg   %ax,%ax
80101de0:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
    path++;
80101de4:	83 c3 01             	add    $0x1,%ebx
  while(*path != '/' && *path != 0)
80101de7:	3c 2f                	cmp    $0x2f,%al
80101de9:	74 04                	je     80101def <namex+0x8f>
80101deb:	84 c0                	test   %al,%al
80101ded:	75 f1                	jne    80101de0 <namex+0x80>
  len = path - s;
80101def:	89 d8                	mov    %ebx,%eax
80101df1:	29 f8                	sub    %edi,%eax
  if(len >= DIRSIZ)
80101df3:	83 f8 0d             	cmp    $0xd,%eax
80101df6:	0f 8e 84 00 00 00    	jle    80101e80 <namex+0x120>
    memmove(name, s, DIRSIZ);
80101dfc:	83 ec 04             	sub    $0x4,%esp
80101dff:	6a 0e                	push   $0xe
80101e01:	57                   	push   %edi
    path++;
80101e02:	89 df                	mov    %ebx,%edi
    memmove(name, s, DIRSIZ);
80101e04:	ff 75 e4             	pushl  -0x1c(%ebp)
80101e07:	e8 14 2a 00 00       	call   80104820 <memmove>
80101e0c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101e0f:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101e12:	75 0c                	jne    80101e20 <namex+0xc0>
80101e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101e18:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
80101e1b:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101e1e:	74 f8                	je     80101e18 <namex+0xb8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101e20:	83 ec 0c             	sub    $0xc,%esp
80101e23:	56                   	push   %esi
80101e24:	e8 e7 f8 ff ff       	call   80101710 <ilock>
    if(ip->type != T_DIR){
80101e29:	83 c4 10             	add    $0x10,%esp
80101e2c:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
80101e31:	0f 85 a1 00 00 00    	jne    80101ed8 <namex+0x178>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101e37:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101e3a:	85 d2                	test   %edx,%edx
80101e3c:	74 09                	je     80101e47 <namex+0xe7>
80101e3e:	80 3f 00             	cmpb   $0x0,(%edi)
80101e41:	0f 84 d9 00 00 00    	je     80101f20 <namex+0x1c0>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101e47:	83 ec 04             	sub    $0x4,%esp
80101e4a:	6a 00                	push   $0x0
80101e4c:	ff 75 e4             	pushl  -0x1c(%ebp)
80101e4f:	56                   	push   %esi
80101e50:	e8 4b fe ff ff       	call   80101ca0 <dirlookup>
80101e55:	83 c4 10             	add    $0x10,%esp
80101e58:	89 c3                	mov    %eax,%ebx
80101e5a:	85 c0                	test   %eax,%eax
80101e5c:	74 7a                	je     80101ed8 <namex+0x178>
  iunlock(ip);
80101e5e:	83 ec 0c             	sub    $0xc,%esp
80101e61:	56                   	push   %esi
80101e62:	e8 b9 f9 ff ff       	call   80101820 <iunlock>
  iput(ip);
80101e67:	89 34 24             	mov    %esi,(%esp)
80101e6a:	89 de                	mov    %ebx,%esi
80101e6c:	e8 0f fa ff ff       	call   80101880 <iput>
80101e71:	83 c4 10             	add    $0x10,%esp
80101e74:	e9 3a ff ff ff       	jmp    80101db3 <namex+0x53>
80101e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e80:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101e83:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
80101e86:	89 4d dc             	mov    %ecx,-0x24(%ebp)
    memmove(name, s, len);
80101e89:	83 ec 04             	sub    $0x4,%esp
80101e8c:	50                   	push   %eax
80101e8d:	57                   	push   %edi
    name[len] = 0;
80101e8e:	89 df                	mov    %ebx,%edi
    memmove(name, s, len);
80101e90:	ff 75 e4             	pushl  -0x1c(%ebp)
80101e93:	e8 88 29 00 00       	call   80104820 <memmove>
    name[len] = 0;
80101e98:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101e9b:	83 c4 10             	add    $0x10,%esp
80101e9e:	c6 00 00             	movb   $0x0,(%eax)
80101ea1:	e9 69 ff ff ff       	jmp    80101e0f <namex+0xaf>
80101ea6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ead:	8d 76 00             	lea    0x0(%esi),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101eb0:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101eb3:	85 c0                	test   %eax,%eax
80101eb5:	0f 85 85 00 00 00    	jne    80101f40 <namex+0x1e0>
    iput(ip);
    return 0;
  }
  return ip;
}
80101ebb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ebe:	89 f0                	mov    %esi,%eax
80101ec0:	5b                   	pop    %ebx
80101ec1:	5e                   	pop    %esi
80101ec2:	5f                   	pop    %edi
80101ec3:	5d                   	pop    %ebp
80101ec4:	c3                   	ret    
80101ec5:	8d 76 00             	lea    0x0(%esi),%esi
  while(*path != '/' && *path != 0)
80101ec8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101ecb:	89 fb                	mov    %edi,%ebx
80101ecd:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101ed0:	31 c0                	xor    %eax,%eax
80101ed2:	eb b5                	jmp    80101e89 <namex+0x129>
80101ed4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101ed8:	83 ec 0c             	sub    $0xc,%esp
80101edb:	56                   	push   %esi
80101edc:	e8 3f f9 ff ff       	call   80101820 <iunlock>
  iput(ip);
80101ee1:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101ee4:	31 f6                	xor    %esi,%esi
  iput(ip);
80101ee6:	e8 95 f9 ff ff       	call   80101880 <iput>
      return 0;
80101eeb:	83 c4 10             	add    $0x10,%esp
}
80101eee:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ef1:	89 f0                	mov    %esi,%eax
80101ef3:	5b                   	pop    %ebx
80101ef4:	5e                   	pop    %esi
80101ef5:	5f                   	pop    %edi
80101ef6:	5d                   	pop    %ebp
80101ef7:	c3                   	ret    
80101ef8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101eff:	90                   	nop
    ip = iget(ROOTDEV, ROOTINO);
80101f00:	ba 01 00 00 00       	mov    $0x1,%edx
80101f05:	b8 01 00 00 00       	mov    $0x1,%eax
80101f0a:	89 df                	mov    %ebx,%edi
80101f0c:	e8 9f f3 ff ff       	call   801012b0 <iget>
80101f11:	89 c6                	mov    %eax,%esi
80101f13:	e9 9b fe ff ff       	jmp    80101db3 <namex+0x53>
80101f18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f1f:	90                   	nop
      iunlock(ip);
80101f20:	83 ec 0c             	sub    $0xc,%esp
80101f23:	56                   	push   %esi
80101f24:	e8 f7 f8 ff ff       	call   80101820 <iunlock>
      return ip;
80101f29:	83 c4 10             	add    $0x10,%esp
}
80101f2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f2f:	89 f0                	mov    %esi,%eax
80101f31:	5b                   	pop    %ebx
80101f32:	5e                   	pop    %esi
80101f33:	5f                   	pop    %edi
80101f34:	5d                   	pop    %ebp
80101f35:	c3                   	ret    
80101f36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f3d:	8d 76 00             	lea    0x0(%esi),%esi
    iput(ip);
80101f40:	83 ec 0c             	sub    $0xc,%esp
80101f43:	56                   	push   %esi
    return 0;
80101f44:	31 f6                	xor    %esi,%esi
    iput(ip);
80101f46:	e8 35 f9 ff ff       	call   80101880 <iput>
    return 0;
80101f4b:	83 c4 10             	add    $0x10,%esp
80101f4e:	e9 68 ff ff ff       	jmp    80101ebb <namex+0x15b>
80101f53:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101f60 <dirlink>:
{
80101f60:	f3 0f 1e fb          	endbr32 
80101f64:	55                   	push   %ebp
80101f65:	89 e5                	mov    %esp,%ebp
80101f67:	57                   	push   %edi
80101f68:	56                   	push   %esi
80101f69:	53                   	push   %ebx
80101f6a:	83 ec 20             	sub    $0x20,%esp
80101f6d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101f70:	6a 00                	push   $0x0
80101f72:	ff 75 0c             	pushl  0xc(%ebp)
80101f75:	53                   	push   %ebx
80101f76:	e8 25 fd ff ff       	call   80101ca0 <dirlookup>
80101f7b:	83 c4 10             	add    $0x10,%esp
80101f7e:	85 c0                	test   %eax,%eax
80101f80:	75 6b                	jne    80101fed <dirlink+0x8d>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f82:	8b 7b 18             	mov    0x18(%ebx),%edi
80101f85:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f88:	85 ff                	test   %edi,%edi
80101f8a:	74 2d                	je     80101fb9 <dirlink+0x59>
80101f8c:	31 ff                	xor    %edi,%edi
80101f8e:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f91:	eb 0d                	jmp    80101fa0 <dirlink+0x40>
80101f93:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f97:	90                   	nop
80101f98:	83 c7 10             	add    $0x10,%edi
80101f9b:	3b 7b 18             	cmp    0x18(%ebx),%edi
80101f9e:	73 19                	jae    80101fb9 <dirlink+0x59>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fa0:	6a 10                	push   $0x10
80101fa2:	57                   	push   %edi
80101fa3:	56                   	push   %esi
80101fa4:	53                   	push   %ebx
80101fa5:	e8 a6 fa ff ff       	call   80101a50 <readi>
80101faa:	83 c4 10             	add    $0x10,%esp
80101fad:	83 f8 10             	cmp    $0x10,%eax
80101fb0:	75 4e                	jne    80102000 <dirlink+0xa0>
    if(de.inum == 0)
80101fb2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101fb7:	75 df                	jne    80101f98 <dirlink+0x38>
  strncpy(de.name, name, DIRSIZ);
80101fb9:	83 ec 04             	sub    $0x4,%esp
80101fbc:	8d 45 da             	lea    -0x26(%ebp),%eax
80101fbf:	6a 0e                	push   $0xe
80101fc1:	ff 75 0c             	pushl  0xc(%ebp)
80101fc4:	50                   	push   %eax
80101fc5:	e8 16 29 00 00       	call   801048e0 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fca:	6a 10                	push   $0x10
  de.inum = inum;
80101fcc:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fcf:	57                   	push   %edi
80101fd0:	56                   	push   %esi
80101fd1:	53                   	push   %ebx
  de.inum = inum;
80101fd2:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fd6:	e8 75 fb ff ff       	call   80101b50 <writei>
80101fdb:	83 c4 20             	add    $0x20,%esp
80101fde:	83 f8 10             	cmp    $0x10,%eax
80101fe1:	75 2a                	jne    8010200d <dirlink+0xad>
  return 0;
80101fe3:	31 c0                	xor    %eax,%eax
}
80101fe5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fe8:	5b                   	pop    %ebx
80101fe9:	5e                   	pop    %esi
80101fea:	5f                   	pop    %edi
80101feb:	5d                   	pop    %ebp
80101fec:	c3                   	ret    
    iput(ip);
80101fed:	83 ec 0c             	sub    $0xc,%esp
80101ff0:	50                   	push   %eax
80101ff1:	e8 8a f8 ff ff       	call   80101880 <iput>
    return -1;
80101ff6:	83 c4 10             	add    $0x10,%esp
80101ff9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ffe:	eb e5                	jmp    80101fe5 <dirlink+0x85>
      panic("dirlink read");
80102000:	83 ec 0c             	sub    $0xc,%esp
80102003:	68 f5 73 10 80       	push   $0x801073f5
80102008:	e8 73 e3 ff ff       	call   80100380 <panic>
    panic("dirlink");
8010200d:	83 ec 0c             	sub    $0xc,%esp
80102010:	68 c6 79 10 80       	push   $0x801079c6
80102015:	e8 66 e3 ff ff       	call   80100380 <panic>
8010201a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102020 <namei>:

struct inode*
namei(char *path)
{
80102020:	f3 0f 1e fb          	endbr32 
80102024:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102025:	31 d2                	xor    %edx,%edx
{
80102027:	89 e5                	mov    %esp,%ebp
80102029:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
8010202c:	8b 45 08             	mov    0x8(%ebp),%eax
8010202f:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102032:	e8 29 fd ff ff       	call   80101d60 <namex>
}
80102037:	c9                   	leave  
80102038:	c3                   	ret    
80102039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102040 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102040:	f3 0f 1e fb          	endbr32 
80102044:	55                   	push   %ebp
  return namex(path, 1, name);
80102045:	ba 01 00 00 00       	mov    $0x1,%edx
{
8010204a:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
8010204c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010204f:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102052:	5d                   	pop    %ebp
  return namex(path, 1, name);
80102053:	e9 08 fd ff ff       	jmp    80101d60 <namex>
80102058:	66 90                	xchg   %ax,%ax
8010205a:	66 90                	xchg   %ax,%ax
8010205c:	66 90                	xchg   %ax,%ax
8010205e:	66 90                	xchg   %ax,%ax

80102060 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102060:	55                   	push   %ebp
80102061:	89 e5                	mov    %esp,%ebp
80102063:	57                   	push   %edi
80102064:	56                   	push   %esi
80102065:	53                   	push   %ebx
80102066:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102069:	85 c0                	test   %eax,%eax
8010206b:	0f 84 b4 00 00 00    	je     80102125 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102071:	8b 70 08             	mov    0x8(%eax),%esi
80102074:	89 c3                	mov    %eax,%ebx
80102076:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010207c:	0f 87 96 00 00 00    	ja     80102118 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102082:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102087:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010208e:	66 90                	xchg   %ax,%ax
80102090:	89 ca                	mov    %ecx,%edx
80102092:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102093:	83 e0 c0             	and    $0xffffffc0,%eax
80102096:	3c 40                	cmp    $0x40,%al
80102098:	75 f6                	jne    80102090 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010209a:	31 ff                	xor    %edi,%edi
8010209c:	ba f6 03 00 00       	mov    $0x3f6,%edx
801020a1:	89 f8                	mov    %edi,%eax
801020a3:	ee                   	out    %al,(%dx)
801020a4:	b8 01 00 00 00       	mov    $0x1,%eax
801020a9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801020ae:	ee                   	out    %al,(%dx)
801020af:	ba f3 01 00 00       	mov    $0x1f3,%edx
801020b4:	89 f0                	mov    %esi,%eax
801020b6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801020b7:	89 f0                	mov    %esi,%eax
801020b9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801020be:	c1 f8 08             	sar    $0x8,%eax
801020c1:	ee                   	out    %al,(%dx)
801020c2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801020c7:	89 f8                	mov    %edi,%eax
801020c9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801020ca:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
801020ce:	ba f6 01 00 00       	mov    $0x1f6,%edx
801020d3:	c1 e0 04             	shl    $0x4,%eax
801020d6:	83 e0 10             	and    $0x10,%eax
801020d9:	83 c8 e0             	or     $0xffffffe0,%eax
801020dc:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
801020dd:	f6 03 04             	testb  $0x4,(%ebx)
801020e0:	75 16                	jne    801020f8 <idestart+0x98>
801020e2:	b8 20 00 00 00       	mov    $0x20,%eax
801020e7:	89 ca                	mov    %ecx,%edx
801020e9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801020ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020ed:	5b                   	pop    %ebx
801020ee:	5e                   	pop    %esi
801020ef:	5f                   	pop    %edi
801020f0:	5d                   	pop    %ebp
801020f1:	c3                   	ret    
801020f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801020f8:	b8 30 00 00 00       	mov    $0x30,%eax
801020fd:	89 ca                	mov    %ecx,%edx
801020ff:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102100:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102105:	8d 73 18             	lea    0x18(%ebx),%esi
80102108:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010210d:	fc                   	cld    
8010210e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102110:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102113:	5b                   	pop    %ebx
80102114:	5e                   	pop    %esi
80102115:	5f                   	pop    %edi
80102116:	5d                   	pop    %ebp
80102117:	c3                   	ret    
    panic("incorrect blockno");
80102118:	83 ec 0c             	sub    $0xc,%esp
8010211b:	68 69 74 10 80       	push   $0x80107469
80102120:	e8 5b e2 ff ff       	call   80100380 <panic>
    panic("idestart");
80102125:	83 ec 0c             	sub    $0xc,%esp
80102128:	68 60 74 10 80       	push   $0x80107460
8010212d:	e8 4e e2 ff ff       	call   80100380 <panic>
80102132:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102140 <ideinit>:
{
80102140:	f3 0f 1e fb          	endbr32 
80102144:	55                   	push   %ebp
80102145:	89 e5                	mov    %esp,%ebp
80102147:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
8010214a:	68 7b 74 10 80       	push   $0x8010747b
8010214f:	68 80 a5 10 80       	push   $0x8010a580
80102154:	e8 d7 23 00 00       	call   80104530 <initlock>
  picenable(IRQ_IDE);
80102159:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102160:	e8 2b 13 00 00       	call   80103490 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102165:	58                   	pop    %eax
80102166:	a1 c0 18 11 80       	mov    0x801118c0,%eax
8010216b:	5a                   	pop    %edx
8010216c:	83 e8 01             	sub    $0x1,%eax
8010216f:	50                   	push   %eax
80102170:	6a 0e                	push   $0xe
80102172:	e8 b9 02 00 00       	call   80102430 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102177:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010217a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010217f:	90                   	nop
80102180:	ec                   	in     (%dx),%al
80102181:	83 e0 c0             	and    $0xffffffc0,%eax
80102184:	3c 40                	cmp    $0x40,%al
80102186:	75 f8                	jne    80102180 <ideinit+0x40>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102188:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010218d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102192:	ee                   	out    %al,(%dx)
80102193:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102198:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010219d:	eb 06                	jmp    801021a5 <ideinit+0x65>
8010219f:	90                   	nop
  for(i=0; i<1000; i++){
801021a0:	83 e9 01             	sub    $0x1,%ecx
801021a3:	74 0f                	je     801021b4 <ideinit+0x74>
801021a5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801021a6:	84 c0                	test   %al,%al
801021a8:	74 f6                	je     801021a0 <ideinit+0x60>
      havedisk1 = 1;
801021aa:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
801021b1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021b4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801021b9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021be:	ee                   	out    %al,(%dx)
}
801021bf:	c9                   	leave  
801021c0:	c3                   	ret    
801021c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021cf:	90                   	nop

801021d0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801021d0:	f3 0f 1e fb          	endbr32 
801021d4:	55                   	push   %ebp
801021d5:	89 e5                	mov    %esp,%ebp
801021d7:	57                   	push   %edi
801021d8:	56                   	push   %esi
801021d9:	53                   	push   %ebx
801021da:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801021dd:	68 80 a5 10 80       	push   $0x8010a580
801021e2:	e8 69 23 00 00       	call   80104550 <acquire>
  if((b = idequeue) == 0){
801021e7:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
801021ed:	83 c4 10             	add    $0x10,%esp
801021f0:	85 db                	test   %ebx,%ebx
801021f2:	74 5f                	je     80102253 <ideintr+0x83>
    release(&idelock);
    // cprintf("spurious IDE interrupt\n");
    return;
  }
  idequeue = b->qnext;
801021f4:	8b 43 14             	mov    0x14(%ebx),%eax
801021f7:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801021fc:	8b 33                	mov    (%ebx),%esi
801021fe:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102204:	75 2b                	jne    80102231 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102206:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010220b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010220f:	90                   	nop
80102210:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102211:	89 c1                	mov    %eax,%ecx
80102213:	83 e1 c0             	and    $0xffffffc0,%ecx
80102216:	80 f9 40             	cmp    $0x40,%cl
80102219:	75 f5                	jne    80102210 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010221b:	a8 21                	test   $0x21,%al
8010221d:	75 12                	jne    80102231 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010221f:	8d 7b 18             	lea    0x18(%ebx),%edi
  asm volatile("cld; rep insl" :
80102222:	b9 80 00 00 00       	mov    $0x80,%ecx
80102227:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010222c:	fc                   	cld    
8010222d:	f3 6d                	rep insl (%dx),%es:(%edi)
8010222f:	8b 33                	mov    (%ebx),%esi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102231:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102234:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102237:	83 ce 02             	or     $0x2,%esi
8010223a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010223c:	53                   	push   %ebx
8010223d:	e8 2e 1f 00 00       	call   80104170 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102242:	a1 64 a5 10 80       	mov    0x8010a564,%eax
80102247:	83 c4 10             	add    $0x10,%esp
8010224a:	85 c0                	test   %eax,%eax
8010224c:	74 05                	je     80102253 <ideintr+0x83>
    idestart(idequeue);
8010224e:	e8 0d fe ff ff       	call   80102060 <idestart>
    release(&idelock);
80102253:	83 ec 0c             	sub    $0xc,%esp
80102256:	68 80 a5 10 80       	push   $0x8010a580
8010225b:	e8 d0 24 00 00       	call   80104730 <release>

  release(&idelock);
}
80102260:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102263:	5b                   	pop    %ebx
80102264:	5e                   	pop    %esi
80102265:	5f                   	pop    %edi
80102266:	5d                   	pop    %ebp
80102267:	c3                   	ret    
80102268:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010226f:	90                   	nop

80102270 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102270:	f3 0f 1e fb          	endbr32 
80102274:	55                   	push   %ebp
80102275:	89 e5                	mov    %esp,%ebp
80102277:	53                   	push   %ebx
80102278:	83 ec 04             	sub    $0x4,%esp
8010227b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!(b->flags & B_BUSY))
8010227e:	8b 03                	mov    (%ebx),%eax
80102280:	a8 01                	test   $0x1,%al
80102282:	0f 84 c9 00 00 00    	je     80102351 <iderw+0xe1>
    panic("iderw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102288:	83 e0 06             	and    $0x6,%eax
8010228b:	83 f8 02             	cmp    $0x2,%eax
8010228e:	0f 84 b0 00 00 00    	je     80102344 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
80102294:	8b 53 04             	mov    0x4(%ebx),%edx
80102297:	85 d2                	test   %edx,%edx
80102299:	74 0d                	je     801022a8 <iderw+0x38>
8010229b:	a1 60 a5 10 80       	mov    0x8010a560,%eax
801022a0:	85 c0                	test   %eax,%eax
801022a2:	0f 84 8f 00 00 00    	je     80102337 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801022a8:	83 ec 0c             	sub    $0xc,%esp
801022ab:	68 80 a5 10 80       	push   $0x8010a580
801022b0:	e8 9b 22 00 00       	call   80104550 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022b5:	a1 64 a5 10 80       	mov    0x8010a564,%eax
  b->qnext = 0;
801022ba:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022c1:	83 c4 10             	add    $0x10,%esp
801022c4:	85 c0                	test   %eax,%eax
801022c6:	74 68                	je     80102330 <iderw+0xc0>
801022c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022cf:	90                   	nop
801022d0:	89 c2                	mov    %eax,%edx
801022d2:	8b 40 14             	mov    0x14(%eax),%eax
801022d5:	85 c0                	test   %eax,%eax
801022d7:	75 f7                	jne    801022d0 <iderw+0x60>
801022d9:	83 c2 14             	add    $0x14,%edx
    ;
  *pp = b;
801022dc:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801022de:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
801022e4:	74 3a                	je     80102320 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801022e6:	8b 03                	mov    (%ebx),%eax
801022e8:	83 e0 06             	and    $0x6,%eax
801022eb:	83 f8 02             	cmp    $0x2,%eax
801022ee:	74 1b                	je     8010230b <iderw+0x9b>
    sleep(b, &idelock);
801022f0:	83 ec 08             	sub    $0x8,%esp
801022f3:	68 80 a5 10 80       	push   $0x8010a580
801022f8:	53                   	push   %ebx
801022f9:	e8 b2 1c 00 00       	call   80103fb0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801022fe:	8b 03                	mov    (%ebx),%eax
80102300:	83 c4 10             	add    $0x10,%esp
80102303:	83 e0 06             	and    $0x6,%eax
80102306:	83 f8 02             	cmp    $0x2,%eax
80102309:	75 e5                	jne    801022f0 <iderw+0x80>
  }

  release(&idelock);
8010230b:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
80102312:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102315:	c9                   	leave  
  release(&idelock);
80102316:	e9 15 24 00 00       	jmp    80104730 <release>
8010231b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010231f:	90                   	nop
    idestart(b);
80102320:	89 d8                	mov    %ebx,%eax
80102322:	e8 39 fd ff ff       	call   80102060 <idestart>
80102327:	eb bd                	jmp    801022e6 <iderw+0x76>
80102329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102330:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
80102335:	eb a5                	jmp    801022dc <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102337:	83 ec 0c             	sub    $0xc,%esp
8010233a:	68 a8 74 10 80       	push   $0x801074a8
8010233f:	e8 3c e0 ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
80102344:	83 ec 0c             	sub    $0xc,%esp
80102347:	68 93 74 10 80       	push   $0x80107493
8010234c:	e8 2f e0 ff ff       	call   80100380 <panic>
    panic("iderw: buf not busy");
80102351:	83 ec 0c             	sub    $0xc,%esp
80102354:	68 7f 74 10 80       	push   $0x8010747f
80102359:	e8 22 e0 ff ff       	call   80100380 <panic>
8010235e:	66 90                	xchg   %ax,%ax

80102360 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102360:	f3 0f 1e fb          	endbr32 
  int i, id, maxintr;

  if(!ismp)
80102364:	a1 c4 12 11 80       	mov    0x801112c4,%eax
80102369:	85 c0                	test   %eax,%eax
8010236b:	0f 84 af 00 00 00    	je     80102420 <ioapicinit+0xc0>
{
80102371:	55                   	push   %ebp
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102372:	c7 05 94 11 11 80 00 	movl   $0xfec00000,0x80111194
80102379:	00 c0 fe 
{
8010237c:	89 e5                	mov    %esp,%ebp
8010237e:	56                   	push   %esi
8010237f:	53                   	push   %ebx
  ioapic->reg = reg;
80102380:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102387:	00 00 00 
  return ioapic->data;
8010238a:	8b 15 94 11 11 80    	mov    0x80111194,%edx
80102390:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102393:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102399:	8b 0d 94 11 11 80    	mov    0x80111194,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010239f:	0f b6 15 c0 12 11 80 	movzbl 0x801112c0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801023a6:	c1 ee 10             	shr    $0x10,%esi
801023a9:	89 f0                	mov    %esi,%eax
801023ab:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
801023ae:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
801023b1:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801023b4:	39 c2                	cmp    %eax,%edx
801023b6:	75 48                	jne    80102400 <ioapicinit+0xa0>
801023b8:	83 c6 21             	add    $0x21,%esi
{
801023bb:	ba 10 00 00 00       	mov    $0x10,%edx
801023c0:	b8 20 00 00 00       	mov    $0x20,%eax
801023c5:	8d 76 00             	lea    0x0(%esi),%esi
  ioapic->reg = reg;
801023c8:	89 11                	mov    %edx,(%ecx)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801023ca:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
801023cc:	8b 0d 94 11 11 80    	mov    0x80111194,%ecx
801023d2:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801023d5:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
801023db:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
801023de:	8d 5a 01             	lea    0x1(%edx),%ebx
801023e1:	83 c2 02             	add    $0x2,%edx
801023e4:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
801023e6:	8b 0d 94 11 11 80    	mov    0x80111194,%ecx
801023ec:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801023f3:	39 f0                	cmp    %esi,%eax
801023f5:	75 d1                	jne    801023c8 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801023f7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023fa:	5b                   	pop    %ebx
801023fb:	5e                   	pop    %esi
801023fc:	5d                   	pop    %ebp
801023fd:	c3                   	ret    
801023fe:	66 90                	xchg   %ax,%ax
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102400:	83 ec 0c             	sub    $0xc,%esp
80102403:	68 c8 74 10 80       	push   $0x801074c8
80102408:	e8 93 e2 ff ff       	call   801006a0 <cprintf>
8010240d:	8b 0d 94 11 11 80    	mov    0x80111194,%ecx
80102413:	83 c4 10             	add    $0x10,%esp
80102416:	eb a0                	jmp    801023b8 <ioapicinit+0x58>
80102418:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010241f:	90                   	nop
80102420:	c3                   	ret    
80102421:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102428:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010242f:	90                   	nop

80102430 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102430:	f3 0f 1e fb          	endbr32 
80102434:	55                   	push   %ebp
  if(!ismp)
80102435:	8b 15 c4 12 11 80    	mov    0x801112c4,%edx
{
8010243b:	89 e5                	mov    %esp,%ebp
8010243d:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!ismp)
80102440:	85 d2                	test   %edx,%edx
80102442:	74 2b                	je     8010246f <ioapicenable+0x3f>
  ioapic->reg = reg;
80102444:	8b 0d 94 11 11 80    	mov    0x80111194,%ecx
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010244a:	8d 50 20             	lea    0x20(%eax),%edx
8010244d:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102451:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102453:	8b 0d 94 11 11 80    	mov    0x80111194,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102459:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010245c:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010245f:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102462:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102464:	a1 94 11 11 80       	mov    0x80111194,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102469:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010246c:	89 50 10             	mov    %edx,0x10(%eax)
}
8010246f:	5d                   	pop    %ebp
80102470:	c3                   	ret    
80102471:	66 90                	xchg   %ax,%ax
80102473:	66 90                	xchg   %ax,%ax
80102475:	66 90                	xchg   %ax,%ax
80102477:	66 90                	xchg   %ax,%ax
80102479:	66 90                	xchg   %ax,%ax
8010247b:	66 90                	xchg   %ax,%ax
8010247d:	66 90                	xchg   %ax,%ax
8010247f:	90                   	nop

80102480 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102480:	f3 0f 1e fb          	endbr32 
80102484:	55                   	push   %ebp
80102485:	89 e5                	mov    %esp,%ebp
80102487:	53                   	push   %ebx
80102488:	83 ec 04             	sub    $0x4,%esp
8010248b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010248e:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102494:	75 7a                	jne    80102510 <kfree+0x90>
80102496:	81 fb 68 42 11 80    	cmp    $0x80114268,%ebx
8010249c:	72 72                	jb     80102510 <kfree+0x90>
8010249e:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801024a4:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801024a9:	77 65                	ja     80102510 <kfree+0x90>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801024ab:	83 ec 04             	sub    $0x4,%esp
801024ae:	68 00 10 00 00       	push   $0x1000
801024b3:	6a 01                	push   $0x1
801024b5:	53                   	push   %ebx
801024b6:	e8 c5 22 00 00       	call   80104780 <memset>

  if(kmem.use_lock)
801024bb:	8b 15 d4 11 11 80    	mov    0x801111d4,%edx
801024c1:	83 c4 10             	add    $0x10,%esp
801024c4:	85 d2                	test   %edx,%edx
801024c6:	75 20                	jne    801024e8 <kfree+0x68>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801024c8:	a1 d8 11 11 80       	mov    0x801111d8,%eax
801024cd:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801024cf:	a1 d4 11 11 80       	mov    0x801111d4,%eax
  kmem.freelist = r;
801024d4:	89 1d d8 11 11 80    	mov    %ebx,0x801111d8
  if(kmem.use_lock)
801024da:	85 c0                	test   %eax,%eax
801024dc:	75 22                	jne    80102500 <kfree+0x80>
    release(&kmem.lock);
}
801024de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024e1:	c9                   	leave  
801024e2:	c3                   	ret    
801024e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024e7:	90                   	nop
    acquire(&kmem.lock);
801024e8:	83 ec 0c             	sub    $0xc,%esp
801024eb:	68 a0 11 11 80       	push   $0x801111a0
801024f0:	e8 5b 20 00 00       	call   80104550 <acquire>
801024f5:	83 c4 10             	add    $0x10,%esp
801024f8:	eb ce                	jmp    801024c8 <kfree+0x48>
801024fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102500:	c7 45 08 a0 11 11 80 	movl   $0x801111a0,0x8(%ebp)
}
80102507:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010250a:	c9                   	leave  
    release(&kmem.lock);
8010250b:	e9 20 22 00 00       	jmp    80104730 <release>
    panic("kfree");
80102510:	83 ec 0c             	sub    $0xc,%esp
80102513:	68 fa 74 10 80       	push   $0x801074fa
80102518:	e8 63 de ff ff       	call   80100380 <panic>
8010251d:	8d 76 00             	lea    0x0(%esi),%esi

80102520 <freerange>:
{
80102520:	f3 0f 1e fb          	endbr32 
80102524:	55                   	push   %ebp
80102525:	89 e5                	mov    %esp,%ebp
80102527:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102528:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010252b:	8b 75 0c             	mov    0xc(%ebp),%esi
8010252e:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010252f:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102535:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010253b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102541:	39 de                	cmp    %ebx,%esi
80102543:	72 1f                	jb     80102564 <freerange+0x44>
80102545:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
80102548:	83 ec 0c             	sub    $0xc,%esp
8010254b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102551:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102557:	50                   	push   %eax
80102558:	e8 23 ff ff ff       	call   80102480 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010255d:	83 c4 10             	add    $0x10,%esp
80102560:	39 f3                	cmp    %esi,%ebx
80102562:	76 e4                	jbe    80102548 <freerange+0x28>
}
80102564:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102567:	5b                   	pop    %ebx
80102568:	5e                   	pop    %esi
80102569:	5d                   	pop    %ebp
8010256a:	c3                   	ret    
8010256b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010256f:	90                   	nop

80102570 <kinit1>:
{
80102570:	f3 0f 1e fb          	endbr32 
80102574:	55                   	push   %ebp
80102575:	89 e5                	mov    %esp,%ebp
80102577:	56                   	push   %esi
80102578:	53                   	push   %ebx
80102579:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
8010257c:	83 ec 08             	sub    $0x8,%esp
8010257f:	68 00 75 10 80       	push   $0x80107500
80102584:	68 a0 11 11 80       	push   $0x801111a0
80102589:	e8 a2 1f 00 00       	call   80104530 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010258e:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102591:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102594:	c7 05 d4 11 11 80 00 	movl   $0x0,0x801111d4
8010259b:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010259e:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025a4:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025aa:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025b0:	39 de                	cmp    %ebx,%esi
801025b2:	72 20                	jb     801025d4 <kinit1+0x64>
801025b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801025b8:	83 ec 0c             	sub    $0xc,%esp
801025bb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025c1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801025c7:	50                   	push   %eax
801025c8:	e8 b3 fe ff ff       	call   80102480 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025cd:	83 c4 10             	add    $0x10,%esp
801025d0:	39 de                	cmp    %ebx,%esi
801025d2:	73 e4                	jae    801025b8 <kinit1+0x48>
}
801025d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025d7:	5b                   	pop    %ebx
801025d8:	5e                   	pop    %esi
801025d9:	5d                   	pop    %ebp
801025da:	c3                   	ret    
801025db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801025df:	90                   	nop

801025e0 <kinit2>:
{
801025e0:	f3 0f 1e fb          	endbr32 
801025e4:	55                   	push   %ebp
801025e5:	89 e5                	mov    %esp,%ebp
801025e7:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801025e8:	8b 45 08             	mov    0x8(%ebp),%eax
{
801025eb:	8b 75 0c             	mov    0xc(%ebp),%esi
801025ee:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801025ef:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025f5:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025fb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102601:	39 de                	cmp    %ebx,%esi
80102603:	72 1f                	jb     80102624 <kinit2+0x44>
80102605:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
80102608:	83 ec 0c             	sub    $0xc,%esp
8010260b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102611:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102617:	50                   	push   %eax
80102618:	e8 63 fe ff ff       	call   80102480 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010261d:	83 c4 10             	add    $0x10,%esp
80102620:	39 de                	cmp    %ebx,%esi
80102622:	73 e4                	jae    80102608 <kinit2+0x28>
  kmem.use_lock = 1;
80102624:	c7 05 d4 11 11 80 01 	movl   $0x1,0x801111d4
8010262b:	00 00 00 
}
8010262e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102631:	5b                   	pop    %ebx
80102632:	5e                   	pop    %esi
80102633:	5d                   	pop    %ebp
80102634:	c3                   	ret    
80102635:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010263c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102640 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102640:	f3 0f 1e fb          	endbr32 
  struct run *r;

  if(kmem.use_lock)
80102644:	a1 d4 11 11 80       	mov    0x801111d4,%eax
80102649:	85 c0                	test   %eax,%eax
8010264b:	75 1b                	jne    80102668 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
8010264d:	a1 d8 11 11 80       	mov    0x801111d8,%eax
  if(r)
80102652:	85 c0                	test   %eax,%eax
80102654:	74 0a                	je     80102660 <kalloc+0x20>
    kmem.freelist = r->next;
80102656:	8b 10                	mov    (%eax),%edx
80102658:	89 15 d8 11 11 80    	mov    %edx,0x801111d8
  if(kmem.use_lock)
8010265e:	c3                   	ret    
8010265f:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
80102660:	c3                   	ret    
80102661:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
80102668:	55                   	push   %ebp
80102669:	89 e5                	mov    %esp,%ebp
8010266b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010266e:	68 a0 11 11 80       	push   $0x801111a0
80102673:	e8 d8 1e 00 00       	call   80104550 <acquire>
  r = kmem.freelist;
80102678:	a1 d8 11 11 80       	mov    0x801111d8,%eax
  if(r)
8010267d:	8b 15 d4 11 11 80    	mov    0x801111d4,%edx
80102683:	83 c4 10             	add    $0x10,%esp
80102686:	85 c0                	test   %eax,%eax
80102688:	74 08                	je     80102692 <kalloc+0x52>
    kmem.freelist = r->next;
8010268a:	8b 08                	mov    (%eax),%ecx
8010268c:	89 0d d8 11 11 80    	mov    %ecx,0x801111d8
  if(kmem.use_lock)
80102692:	85 d2                	test   %edx,%edx
80102694:	74 16                	je     801026ac <kalloc+0x6c>
    release(&kmem.lock);
80102696:	83 ec 0c             	sub    $0xc,%esp
80102699:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010269c:	68 a0 11 11 80       	push   $0x801111a0
801026a1:	e8 8a 20 00 00       	call   80104730 <release>
  return (char*)r;
801026a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
801026a9:	83 c4 10             	add    $0x10,%esp
}
801026ac:	c9                   	leave  
801026ad:	c3                   	ret    
801026ae:	66 90                	xchg   %ax,%ax

801026b0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
801026b0:	f3 0f 1e fb          	endbr32 
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026b4:	ba 64 00 00 00       	mov    $0x64,%edx
801026b9:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801026ba:	a8 01                	test   $0x1,%al
801026bc:	0f 84 be 00 00 00    	je     80102780 <kbdgetc+0xd0>
{
801026c2:	55                   	push   %ebp
801026c3:	ba 60 00 00 00       	mov    $0x60,%edx
801026c8:	89 e5                	mov    %esp,%ebp
801026ca:	53                   	push   %ebx
801026cb:	ec                   	in     (%dx),%al
  return data;
801026cc:	8b 1d b4 a5 10 80    	mov    0x8010a5b4,%ebx
    return -1;
  data = inb(KBDATAP);
801026d2:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
801026d5:	3c e0                	cmp    $0xe0,%al
801026d7:	74 57                	je     80102730 <kbdgetc+0x80>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801026d9:	89 d9                	mov    %ebx,%ecx
801026db:	83 e1 40             	and    $0x40,%ecx
801026de:	84 c0                	test   %al,%al
801026e0:	78 5e                	js     80102740 <kbdgetc+0x90>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801026e2:	85 c9                	test   %ecx,%ecx
801026e4:	74 09                	je     801026ef <kbdgetc+0x3f>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801026e6:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801026e9:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
801026ec:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
801026ef:	0f b6 8a 40 76 10 80 	movzbl -0x7fef89c0(%edx),%ecx
  shift ^= togglecode[data];
801026f6:	0f b6 82 40 75 10 80 	movzbl -0x7fef8ac0(%edx),%eax
  shift |= shiftcode[data];
801026fd:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
801026ff:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102701:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102703:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102709:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010270c:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
8010270f:	8b 04 85 20 75 10 80 	mov    -0x7fef8ae0(,%eax,4),%eax
80102716:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010271a:	74 0b                	je     80102727 <kbdgetc+0x77>
    if('a' <= c && c <= 'z')
8010271c:	8d 50 9f             	lea    -0x61(%eax),%edx
8010271f:	83 fa 19             	cmp    $0x19,%edx
80102722:	77 44                	ja     80102768 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102724:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102727:	5b                   	pop    %ebx
80102728:	5d                   	pop    %ebp
80102729:	c3                   	ret    
8010272a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    shift |= E0ESC;
80102730:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102733:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102735:	89 1d b4 a5 10 80    	mov    %ebx,0x8010a5b4
}
8010273b:	5b                   	pop    %ebx
8010273c:	5d                   	pop    %ebp
8010273d:	c3                   	ret    
8010273e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102740:	83 e0 7f             	and    $0x7f,%eax
80102743:	85 c9                	test   %ecx,%ecx
80102745:	0f 44 d0             	cmove  %eax,%edx
    return 0;
80102748:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
8010274a:	0f b6 8a 40 76 10 80 	movzbl -0x7fef89c0(%edx),%ecx
80102751:	83 c9 40             	or     $0x40,%ecx
80102754:	0f b6 c9             	movzbl %cl,%ecx
80102757:	f7 d1                	not    %ecx
80102759:	21 d9                	and    %ebx,%ecx
}
8010275b:	5b                   	pop    %ebx
8010275c:	5d                   	pop    %ebp
    shift &= ~(shiftcode[data] | E0ESC);
8010275d:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
}
80102763:	c3                   	ret    
80102764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102768:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010276b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010276e:	5b                   	pop    %ebx
8010276f:	5d                   	pop    %ebp
      c += 'a' - 'A';
80102770:	83 f9 1a             	cmp    $0x1a,%ecx
80102773:	0f 42 c2             	cmovb  %edx,%eax
}
80102776:	c3                   	ret    
80102777:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010277e:	66 90                	xchg   %ax,%ax
    return -1;
80102780:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102785:	c3                   	ret    
80102786:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010278d:	8d 76 00             	lea    0x0(%esi),%esi

80102790 <kbdintr>:

void
kbdintr(void)
{
80102790:	f3 0f 1e fb          	endbr32 
80102794:	55                   	push   %ebp
80102795:	89 e5                	mov    %esp,%ebp
80102797:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
8010279a:	68 b0 26 10 80       	push   $0x801026b0
8010279f:	e8 ac e0 ff ff       	call   80100850 <consoleintr>
}
801027a4:	83 c4 10             	add    $0x10,%esp
801027a7:	c9                   	leave  
801027a8:	c3                   	ret    
801027a9:	66 90                	xchg   %ax,%ax
801027ab:	66 90                	xchg   %ax,%ax
801027ad:	66 90                	xchg   %ax,%ax
801027af:	90                   	nop

801027b0 <lapicinit>:
}
//PAGEBREAK!

void
lapicinit(void)
{
801027b0:	f3 0f 1e fb          	endbr32 
  if(!lapic)
801027b4:	a1 dc 11 11 80       	mov    0x801111dc,%eax
801027b9:	85 c0                	test   %eax,%eax
801027bb:	0f 84 c7 00 00 00    	je     80102888 <lapicinit+0xd8>
  lapic[index] = value;
801027c1:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801027c8:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027cb:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027ce:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801027d5:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027d8:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027db:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801027e2:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801027e5:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027e8:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801027ef:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801027f2:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027f5:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801027fc:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801027ff:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102802:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102809:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010280c:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010280f:	8b 50 30             	mov    0x30(%eax),%edx
80102812:	c1 ea 10             	shr    $0x10,%edx
80102815:	81 e2 fc 00 00 00    	and    $0xfc,%edx
8010281b:	75 73                	jne    80102890 <lapicinit+0xe0>
  lapic[index] = value;
8010281d:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102824:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102827:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010282a:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102831:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102834:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102837:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010283e:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102841:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102844:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
8010284b:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010284e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102851:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102858:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010285b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010285e:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102865:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102868:	8b 50 20             	mov    0x20(%eax),%edx
8010286b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010286f:	90                   	nop
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102870:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102876:	80 e6 10             	and    $0x10,%dh
80102879:	75 f5                	jne    80102870 <lapicinit+0xc0>
  lapic[index] = value;
8010287b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102882:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102885:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102888:	c3                   	ret    
80102889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102890:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102897:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010289a:	8b 50 20             	mov    0x20(%eax),%edx
}
8010289d:	e9 7b ff ff ff       	jmp    8010281d <lapicinit+0x6d>
801028a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801028b0 <cpunum>:

int
cpunum(void)
{
801028b0:	f3 0f 1e fb          	endbr32 
801028b4:	55                   	push   %ebp
801028b5:	89 e5                	mov    %esp,%ebp
801028b7:	53                   	push   %ebx
801028b8:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801028bb:	9c                   	pushf  
801028bc:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
801028bd:	f6 c4 02             	test   $0x2,%ah
801028c0:	74 12                	je     801028d4 <cpunum+0x24>
    static int n;
    if(n++ == 0)
801028c2:	a1 b8 a5 10 80       	mov    0x8010a5b8,%eax
801028c7:	8d 50 01             	lea    0x1(%eax),%edx
801028ca:	89 15 b8 a5 10 80    	mov    %edx,0x8010a5b8
801028d0:	85 c0                	test   %eax,%eax
801028d2:	74 44                	je     80102918 <cpunum+0x68>
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if (!lapic)
801028d4:	a1 dc 11 11 80       	mov    0x801111dc,%eax
801028d9:	85 c0                	test   %eax,%eax
801028db:	74 57                	je     80102934 <cpunum+0x84>
    return 0;

  apicid = lapic[ID] >> 24;
801028dd:	8b 48 20             	mov    0x20(%eax),%ecx
  for (i = 0; i < ncpu; ++i) {
801028e0:	8b 1d c0 18 11 80    	mov    0x801118c0,%ebx
  apicid = lapic[ID] >> 24;
801028e6:	c1 e9 18             	shr    $0x18,%ecx
  for (i = 0; i < ncpu; ++i) {
801028e9:	85 db                	test   %ebx,%ebx
801028eb:	7e 4e                	jle    8010293b <cpunum+0x8b>
801028ed:	31 c0                	xor    %eax,%eax
801028ef:	eb 0e                	jmp    801028ff <cpunum+0x4f>
801028f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028f8:	83 c0 01             	add    $0x1,%eax
801028fb:	39 c3                	cmp    %eax,%ebx
801028fd:	74 3c                	je     8010293b <cpunum+0x8b>
    if (cpus[i].apicid == apicid)
801028ff:	69 d0 bc 00 00 00    	imul   $0xbc,%eax,%edx
80102905:	0f b6 92 e0 12 11 80 	movzbl -0x7feeed20(%edx),%edx
8010290c:	39 ca                	cmp    %ecx,%edx
8010290e:	75 e8                	jne    801028f8 <cpunum+0x48>
      return i;
  }
  panic("unknown apicid\n");
}
80102910:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102913:	c9                   	leave  
80102914:	c3                   	ret    
80102915:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("cpu called from %x with interrupts enabled\n",
80102918:	83 ec 08             	sub    $0x8,%esp
8010291b:	ff 75 04             	pushl  0x4(%ebp)
8010291e:	68 40 77 10 80       	push   $0x80107740
80102923:	e8 78 dd ff ff       	call   801006a0 <cprintf>
  if (!lapic)
80102928:	a1 dc 11 11 80       	mov    0x801111dc,%eax
      cprintf("cpu called from %x with interrupts enabled\n",
8010292d:	83 c4 10             	add    $0x10,%esp
  if (!lapic)
80102930:	85 c0                	test   %eax,%eax
80102932:	75 a9                	jne    801028dd <cpunum+0x2d>
}
80102934:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80102937:	31 c0                	xor    %eax,%eax
}
80102939:	c9                   	leave  
8010293a:	c3                   	ret    
  panic("unknown apicid\n");
8010293b:	83 ec 0c             	sub    $0xc,%esp
8010293e:	68 6c 77 10 80       	push   $0x8010776c
80102943:	e8 38 da ff ff       	call   80100380 <panic>
80102948:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010294f:	90                   	nop

80102950 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102950:	f3 0f 1e fb          	endbr32 
  if(lapic)
80102954:	a1 dc 11 11 80       	mov    0x801111dc,%eax
80102959:	85 c0                	test   %eax,%eax
8010295b:	74 0d                	je     8010296a <lapiceoi+0x1a>
  lapic[index] = value;
8010295d:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102964:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102967:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
8010296a:	c3                   	ret    
8010296b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010296f:	90                   	nop

80102970 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102970:	f3 0f 1e fb          	endbr32 
}
80102974:	c3                   	ret    
80102975:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010297c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102980 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102980:	f3 0f 1e fb          	endbr32 
80102984:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102985:	b8 0f 00 00 00       	mov    $0xf,%eax
8010298a:	ba 70 00 00 00       	mov    $0x70,%edx
8010298f:	89 e5                	mov    %esp,%ebp
80102991:	53                   	push   %ebx
80102992:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102995:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102998:	ee                   	out    %al,(%dx)
80102999:	b8 0a 00 00 00       	mov    $0xa,%eax
8010299e:	ba 71 00 00 00       	mov    $0x71,%edx
801029a3:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801029a4:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801029a6:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
801029a9:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801029af:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801029b1:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
801029b4:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
801029b6:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
801029b9:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
801029bc:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801029c2:	a1 dc 11 11 80       	mov    0x801111dc,%eax
801029c7:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029cd:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029d0:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801029d7:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029da:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029dd:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801029e4:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029e7:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029ea:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029f0:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029f3:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029f9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029fc:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a02:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a05:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
    microdelay(200);
  }
}
80102a0b:	5b                   	pop    %ebx
  lapic[ID];  // wait for write to finish, by reading
80102a0c:	8b 40 20             	mov    0x20(%eax),%eax
}
80102a0f:	5d                   	pop    %ebp
80102a10:	c3                   	ret    
80102a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a1f:	90                   	nop

80102a20 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80102a20:	f3 0f 1e fb          	endbr32 
80102a24:	55                   	push   %ebp
80102a25:	b8 0b 00 00 00       	mov    $0xb,%eax
80102a2a:	ba 70 00 00 00       	mov    $0x70,%edx
80102a2f:	89 e5                	mov    %esp,%ebp
80102a31:	57                   	push   %edi
80102a32:	56                   	push   %esi
80102a33:	53                   	push   %ebx
80102a34:	83 ec 4c             	sub    $0x4c,%esp
80102a37:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a38:	ba 71 00 00 00       	mov    $0x71,%edx
80102a3d:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102a3e:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a41:	bb 70 00 00 00       	mov    $0x70,%ebx
80102a46:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a50:	31 c0                	xor    %eax,%eax
80102a52:	89 da                	mov    %ebx,%edx
80102a54:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a55:	b9 71 00 00 00       	mov    $0x71,%ecx
80102a5a:	89 ca                	mov    %ecx,%edx
80102a5c:	ec                   	in     (%dx),%al
80102a5d:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a60:	89 da                	mov    %ebx,%edx
80102a62:	b8 02 00 00 00       	mov    $0x2,%eax
80102a67:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a68:	89 ca                	mov    %ecx,%edx
80102a6a:	ec                   	in     (%dx),%al
80102a6b:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a6e:	89 da                	mov    %ebx,%edx
80102a70:	b8 04 00 00 00       	mov    $0x4,%eax
80102a75:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a76:	89 ca                	mov    %ecx,%edx
80102a78:	ec                   	in     (%dx),%al
80102a79:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a7c:	89 da                	mov    %ebx,%edx
80102a7e:	b8 07 00 00 00       	mov    $0x7,%eax
80102a83:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a84:	89 ca                	mov    %ecx,%edx
80102a86:	ec                   	in     (%dx),%al
80102a87:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a8a:	89 da                	mov    %ebx,%edx
80102a8c:	b8 08 00 00 00       	mov    $0x8,%eax
80102a91:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a92:	89 ca                	mov    %ecx,%edx
80102a94:	ec                   	in     (%dx),%al
80102a95:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a97:	89 da                	mov    %ebx,%edx
80102a99:	b8 09 00 00 00       	mov    $0x9,%eax
80102a9e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a9f:	89 ca                	mov    %ecx,%edx
80102aa1:	ec                   	in     (%dx),%al
80102aa2:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aa4:	89 da                	mov    %ebx,%edx
80102aa6:	b8 0a 00 00 00       	mov    $0xa,%eax
80102aab:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102aac:	89 ca                	mov    %ecx,%edx
80102aae:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102aaf:	84 c0                	test   %al,%al
80102ab1:	78 9d                	js     80102a50 <cmostime+0x30>
  return inb(CMOS_RETURN);
80102ab3:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102ab7:	89 fa                	mov    %edi,%edx
80102ab9:	0f b6 fa             	movzbl %dl,%edi
80102abc:	89 f2                	mov    %esi,%edx
80102abe:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102ac1:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102ac5:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ac8:	89 da                	mov    %ebx,%edx
80102aca:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102acd:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102ad0:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102ad4:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102ad7:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102ada:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102ade:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102ae1:	31 c0                	xor    %eax,%eax
80102ae3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ae4:	89 ca                	mov    %ecx,%edx
80102ae6:	ec                   	in     (%dx),%al
80102ae7:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aea:	89 da                	mov    %ebx,%edx
80102aec:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102aef:	b8 02 00 00 00       	mov    $0x2,%eax
80102af4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102af5:	89 ca                	mov    %ecx,%edx
80102af7:	ec                   	in     (%dx),%al
80102af8:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102afb:	89 da                	mov    %ebx,%edx
80102afd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102b00:	b8 04 00 00 00       	mov    $0x4,%eax
80102b05:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b06:	89 ca                	mov    %ecx,%edx
80102b08:	ec                   	in     (%dx),%al
80102b09:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b0c:	89 da                	mov    %ebx,%edx
80102b0e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102b11:	b8 07 00 00 00       	mov    $0x7,%eax
80102b16:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b17:	89 ca                	mov    %ecx,%edx
80102b19:	ec                   	in     (%dx),%al
80102b1a:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b1d:	89 da                	mov    %ebx,%edx
80102b1f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102b22:	b8 08 00 00 00       	mov    $0x8,%eax
80102b27:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b28:	89 ca                	mov    %ecx,%edx
80102b2a:	ec                   	in     (%dx),%al
80102b2b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b2e:	89 da                	mov    %ebx,%edx
80102b30:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102b33:	b8 09 00 00 00       	mov    $0x9,%eax
80102b38:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b39:	89 ca                	mov    %ecx,%edx
80102b3b:	ec                   	in     (%dx),%al
80102b3c:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102b3f:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102b42:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102b45:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102b48:	6a 18                	push   $0x18
80102b4a:	50                   	push   %eax
80102b4b:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102b4e:	50                   	push   %eax
80102b4f:	e8 7c 1c 00 00       	call   801047d0 <memcmp>
80102b54:	83 c4 10             	add    $0x10,%esp
80102b57:	85 c0                	test   %eax,%eax
80102b59:	0f 85 f1 fe ff ff    	jne    80102a50 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102b5f:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102b63:	75 78                	jne    80102bdd <cmostime+0x1bd>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102b65:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b68:	89 c2                	mov    %eax,%edx
80102b6a:	83 e0 0f             	and    $0xf,%eax
80102b6d:	c1 ea 04             	shr    $0x4,%edx
80102b70:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b73:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b76:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102b79:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b7c:	89 c2                	mov    %eax,%edx
80102b7e:	83 e0 0f             	and    $0xf,%eax
80102b81:	c1 ea 04             	shr    $0x4,%edx
80102b84:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b87:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b8a:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102b8d:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b90:	89 c2                	mov    %eax,%edx
80102b92:	83 e0 0f             	and    $0xf,%eax
80102b95:	c1 ea 04             	shr    $0x4,%edx
80102b98:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b9b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b9e:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102ba1:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102ba4:	89 c2                	mov    %eax,%edx
80102ba6:	83 e0 0f             	and    $0xf,%eax
80102ba9:	c1 ea 04             	shr    $0x4,%edx
80102bac:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102baf:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102bb2:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102bb5:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102bb8:	89 c2                	mov    %eax,%edx
80102bba:	83 e0 0f             	and    $0xf,%eax
80102bbd:	c1 ea 04             	shr    $0x4,%edx
80102bc0:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102bc3:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102bc6:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102bc9:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102bcc:	89 c2                	mov    %eax,%edx
80102bce:	83 e0 0f             	and    $0xf,%eax
80102bd1:	c1 ea 04             	shr    $0x4,%edx
80102bd4:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102bd7:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102bda:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102bdd:	8b 75 08             	mov    0x8(%ebp),%esi
80102be0:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102be3:	89 06                	mov    %eax,(%esi)
80102be5:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102be8:	89 46 04             	mov    %eax,0x4(%esi)
80102beb:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102bee:	89 46 08             	mov    %eax,0x8(%esi)
80102bf1:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102bf4:	89 46 0c             	mov    %eax,0xc(%esi)
80102bf7:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102bfa:	89 46 10             	mov    %eax,0x10(%esi)
80102bfd:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102c00:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102c03:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102c0a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c0d:	5b                   	pop    %ebx
80102c0e:	5e                   	pop    %esi
80102c0f:	5f                   	pop    %edi
80102c10:	5d                   	pop    %ebp
80102c11:	c3                   	ret    
80102c12:	66 90                	xchg   %ax,%ax
80102c14:	66 90                	xchg   %ax,%ax
80102c16:	66 90                	xchg   %ax,%ax
80102c18:	66 90                	xchg   %ax,%ax
80102c1a:	66 90                	xchg   %ax,%ax
80102c1c:	66 90                	xchg   %ax,%ax
80102c1e:	66 90                	xchg   %ax,%ax

80102c20 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c20:	8b 0d 28 12 11 80    	mov    0x80111228,%ecx
80102c26:	85 c9                	test   %ecx,%ecx
80102c28:	0f 8e 8a 00 00 00    	jle    80102cb8 <install_trans+0x98>
{
80102c2e:	55                   	push   %ebp
80102c2f:	89 e5                	mov    %esp,%ebp
80102c31:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102c32:	31 ff                	xor    %edi,%edi
{
80102c34:	56                   	push   %esi
80102c35:	53                   	push   %ebx
80102c36:	83 ec 0c             	sub    $0xc,%esp
80102c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102c40:	a1 14 12 11 80       	mov    0x80111214,%eax
80102c45:	83 ec 08             	sub    $0x8,%esp
80102c48:	01 f8                	add    %edi,%eax
80102c4a:	83 c0 01             	add    $0x1,%eax
80102c4d:	50                   	push   %eax
80102c4e:	ff 35 24 12 11 80    	pushl  0x80111224
80102c54:	e8 67 d4 ff ff       	call   801000c0 <bread>
80102c59:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102c5b:	58                   	pop    %eax
80102c5c:	5a                   	pop    %edx
80102c5d:	ff 34 bd 2c 12 11 80 	pushl  -0x7feeedd4(,%edi,4)
80102c64:	ff 35 24 12 11 80    	pushl  0x80111224
  for (tail = 0; tail < log.lh.n; tail++) {
80102c6a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102c6d:	e8 4e d4 ff ff       	call   801000c0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102c72:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102c75:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102c77:	8d 46 18             	lea    0x18(%esi),%eax
80102c7a:	68 00 02 00 00       	push   $0x200
80102c7f:	50                   	push   %eax
80102c80:	8d 43 18             	lea    0x18(%ebx),%eax
80102c83:	50                   	push   %eax
80102c84:	e8 97 1b 00 00       	call   80104820 <memmove>
    bwrite(dbuf);  // write dst to disk
80102c89:	89 1c 24             	mov    %ebx,(%esp)
80102c8c:	e8 3f d5 ff ff       	call   801001d0 <bwrite>
    brelse(lbuf);
80102c91:	89 34 24             	mov    %esi,(%esp)
80102c94:	e8 67 d5 ff ff       	call   80100200 <brelse>
    brelse(dbuf);
80102c99:	89 1c 24             	mov    %ebx,(%esp)
80102c9c:	e8 5f d5 ff ff       	call   80100200 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102ca1:	83 c4 10             	add    $0x10,%esp
80102ca4:	39 3d 28 12 11 80    	cmp    %edi,0x80111228
80102caa:	7f 94                	jg     80102c40 <install_trans+0x20>
  }
}
80102cac:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102caf:	5b                   	pop    %ebx
80102cb0:	5e                   	pop    %esi
80102cb1:	5f                   	pop    %edi
80102cb2:	5d                   	pop    %ebp
80102cb3:	c3                   	ret    
80102cb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102cb8:	c3                   	ret    
80102cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102cc0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102cc0:	55                   	push   %ebp
80102cc1:	89 e5                	mov    %esp,%ebp
80102cc3:	53                   	push   %ebx
80102cc4:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102cc7:	ff 35 14 12 11 80    	pushl  0x80111214
80102ccd:	ff 35 24 12 11 80    	pushl  0x80111224
80102cd3:	e8 e8 d3 ff ff       	call   801000c0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102cd8:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102cdb:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102cdd:	a1 28 12 11 80       	mov    0x80111228,%eax
80102ce2:	89 43 18             	mov    %eax,0x18(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102ce5:	a1 28 12 11 80       	mov    0x80111228,%eax
80102cea:	85 c0                	test   %eax,%eax
80102cec:	7e 18                	jle    80102d06 <write_head+0x46>
80102cee:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102cf0:	8b 0c 95 2c 12 11 80 	mov    -0x7feeedd4(,%edx,4),%ecx
80102cf7:	89 4c 93 1c          	mov    %ecx,0x1c(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102cfb:	83 c2 01             	add    $0x1,%edx
80102cfe:	39 15 28 12 11 80    	cmp    %edx,0x80111228
80102d04:	7f ea                	jg     80102cf0 <write_head+0x30>
  }
  bwrite(buf);
80102d06:	83 ec 0c             	sub    $0xc,%esp
80102d09:	53                   	push   %ebx
80102d0a:	e8 c1 d4 ff ff       	call   801001d0 <bwrite>
  brelse(buf);
80102d0f:	89 1c 24             	mov    %ebx,(%esp)
80102d12:	e8 e9 d4 ff ff       	call   80100200 <brelse>
}
80102d17:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d1a:	83 c4 10             	add    $0x10,%esp
80102d1d:	c9                   	leave  
80102d1e:	c3                   	ret    
80102d1f:	90                   	nop

80102d20 <initlog>:
{
80102d20:	f3 0f 1e fb          	endbr32 
80102d24:	55                   	push   %ebp
80102d25:	89 e5                	mov    %esp,%ebp
80102d27:	53                   	push   %ebx
80102d28:	83 ec 2c             	sub    $0x2c,%esp
80102d2b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102d2e:	68 7c 77 10 80       	push   $0x8010777c
80102d33:	68 e0 11 11 80       	push   $0x801111e0
80102d38:	e8 f3 17 00 00       	call   80104530 <initlock>
  readsb(dev, &sb);
80102d3d:	58                   	pop    %eax
80102d3e:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102d41:	5a                   	pop    %edx
80102d42:	50                   	push   %eax
80102d43:	53                   	push   %ebx
80102d44:	e8 17 e7 ff ff       	call   80101460 <readsb>
  log.start = sb.logstart;
80102d49:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102d4c:	59                   	pop    %ecx
  log.dev = dev;
80102d4d:	89 1d 24 12 11 80    	mov    %ebx,0x80111224
  log.size = sb.nlog;
80102d53:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102d56:	a3 14 12 11 80       	mov    %eax,0x80111214
  log.size = sb.nlog;
80102d5b:	89 15 18 12 11 80    	mov    %edx,0x80111218
  struct buf *buf = bread(log.dev, log.start);
80102d61:	5a                   	pop    %edx
80102d62:	50                   	push   %eax
80102d63:	53                   	push   %ebx
80102d64:	e8 57 d3 ff ff       	call   801000c0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102d69:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102d6c:	8b 48 18             	mov    0x18(%eax),%ecx
80102d6f:	89 0d 28 12 11 80    	mov    %ecx,0x80111228
  for (i = 0; i < log.lh.n; i++) {
80102d75:	85 c9                	test   %ecx,%ecx
80102d77:	7e 19                	jle    80102d92 <initlog+0x72>
80102d79:	31 d2                	xor    %edx,%edx
80102d7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d7f:	90                   	nop
    log.lh.block[i] = lh->block[i];
80102d80:	8b 5c 90 1c          	mov    0x1c(%eax,%edx,4),%ebx
80102d84:	89 1c 95 2c 12 11 80 	mov    %ebx,-0x7feeedd4(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102d8b:	83 c2 01             	add    $0x1,%edx
80102d8e:	39 d1                	cmp    %edx,%ecx
80102d90:	75 ee                	jne    80102d80 <initlog+0x60>
  brelse(buf);
80102d92:	83 ec 0c             	sub    $0xc,%esp
80102d95:	50                   	push   %eax
80102d96:	e8 65 d4 ff ff       	call   80100200 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102d9b:	e8 80 fe ff ff       	call   80102c20 <install_trans>
  log.lh.n = 0;
80102da0:	c7 05 28 12 11 80 00 	movl   $0x0,0x80111228
80102da7:	00 00 00 
  write_head(); // clear the log
80102daa:	e8 11 ff ff ff       	call   80102cc0 <write_head>
}
80102daf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102db2:	83 c4 10             	add    $0x10,%esp
80102db5:	c9                   	leave  
80102db6:	c3                   	ret    
80102db7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102dbe:	66 90                	xchg   %ax,%ax

80102dc0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102dc0:	f3 0f 1e fb          	endbr32 
80102dc4:	55                   	push   %ebp
80102dc5:	89 e5                	mov    %esp,%ebp
80102dc7:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102dca:	68 e0 11 11 80       	push   $0x801111e0
80102dcf:	e8 7c 17 00 00       	call   80104550 <acquire>
80102dd4:	83 c4 10             	add    $0x10,%esp
80102dd7:	eb 1c                	jmp    80102df5 <begin_op+0x35>
80102dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102de0:	83 ec 08             	sub    $0x8,%esp
80102de3:	68 e0 11 11 80       	push   $0x801111e0
80102de8:	68 e0 11 11 80       	push   $0x801111e0
80102ded:	e8 be 11 00 00       	call   80103fb0 <sleep>
80102df2:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102df5:	a1 20 12 11 80       	mov    0x80111220,%eax
80102dfa:	85 c0                	test   %eax,%eax
80102dfc:	75 e2                	jne    80102de0 <begin_op+0x20>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102dfe:	a1 1c 12 11 80       	mov    0x8011121c,%eax
80102e03:	8b 15 28 12 11 80    	mov    0x80111228,%edx
80102e09:	83 c0 01             	add    $0x1,%eax
80102e0c:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102e0f:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102e12:	83 fa 1e             	cmp    $0x1e,%edx
80102e15:	7f c9                	jg     80102de0 <begin_op+0x20>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102e17:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102e1a:	a3 1c 12 11 80       	mov    %eax,0x8011121c
      release(&log.lock);
80102e1f:	68 e0 11 11 80       	push   $0x801111e0
80102e24:	e8 07 19 00 00       	call   80104730 <release>
      break;
    }
  }
}
80102e29:	83 c4 10             	add    $0x10,%esp
80102e2c:	c9                   	leave  
80102e2d:	c3                   	ret    
80102e2e:	66 90                	xchg   %ax,%ax

80102e30 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102e30:	f3 0f 1e fb          	endbr32 
80102e34:	55                   	push   %ebp
80102e35:	89 e5                	mov    %esp,%ebp
80102e37:	57                   	push   %edi
80102e38:	56                   	push   %esi
80102e39:	53                   	push   %ebx
80102e3a:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102e3d:	68 e0 11 11 80       	push   $0x801111e0
80102e42:	e8 09 17 00 00       	call   80104550 <acquire>
  log.outstanding -= 1;
80102e47:	a1 1c 12 11 80       	mov    0x8011121c,%eax
  if(log.committing)
80102e4c:	8b 35 20 12 11 80    	mov    0x80111220,%esi
80102e52:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102e55:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102e58:	89 1d 1c 12 11 80    	mov    %ebx,0x8011121c
  if(log.committing)
80102e5e:	85 f6                	test   %esi,%esi
80102e60:	0f 85 1e 01 00 00    	jne    80102f84 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102e66:	85 db                	test   %ebx,%ebx
80102e68:	0f 85 f2 00 00 00    	jne    80102f60 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102e6e:	c7 05 20 12 11 80 01 	movl   $0x1,0x80111220
80102e75:	00 00 00 
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102e78:	83 ec 0c             	sub    $0xc,%esp
80102e7b:	68 e0 11 11 80       	push   $0x801111e0
80102e80:	e8 ab 18 00 00       	call   80104730 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102e85:	8b 0d 28 12 11 80    	mov    0x80111228,%ecx
80102e8b:	83 c4 10             	add    $0x10,%esp
80102e8e:	85 c9                	test   %ecx,%ecx
80102e90:	7f 3e                	jg     80102ed0 <end_op+0xa0>
    acquire(&log.lock);
80102e92:	83 ec 0c             	sub    $0xc,%esp
80102e95:	68 e0 11 11 80       	push   $0x801111e0
80102e9a:	e8 b1 16 00 00       	call   80104550 <acquire>
    wakeup(&log);
80102e9f:	c7 04 24 e0 11 11 80 	movl   $0x801111e0,(%esp)
    log.committing = 0;
80102ea6:	c7 05 20 12 11 80 00 	movl   $0x0,0x80111220
80102ead:	00 00 00 
    wakeup(&log);
80102eb0:	e8 bb 12 00 00       	call   80104170 <wakeup>
    release(&log.lock);
80102eb5:	c7 04 24 e0 11 11 80 	movl   $0x801111e0,(%esp)
80102ebc:	e8 6f 18 00 00       	call   80104730 <release>
80102ec1:	83 c4 10             	add    $0x10,%esp
}
80102ec4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ec7:	5b                   	pop    %ebx
80102ec8:	5e                   	pop    %esi
80102ec9:	5f                   	pop    %edi
80102eca:	5d                   	pop    %ebp
80102ecb:	c3                   	ret    
80102ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102ed0:	a1 14 12 11 80       	mov    0x80111214,%eax
80102ed5:	83 ec 08             	sub    $0x8,%esp
80102ed8:	01 d8                	add    %ebx,%eax
80102eda:	83 c0 01             	add    $0x1,%eax
80102edd:	50                   	push   %eax
80102ede:	ff 35 24 12 11 80    	pushl  0x80111224
80102ee4:	e8 d7 d1 ff ff       	call   801000c0 <bread>
80102ee9:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102eeb:	58                   	pop    %eax
80102eec:	5a                   	pop    %edx
80102eed:	ff 34 9d 2c 12 11 80 	pushl  -0x7feeedd4(,%ebx,4)
80102ef4:	ff 35 24 12 11 80    	pushl  0x80111224
  for (tail = 0; tail < log.lh.n; tail++) {
80102efa:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102efd:	e8 be d1 ff ff       	call   801000c0 <bread>
    memmove(to->data, from->data, BSIZE);
80102f02:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102f05:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102f07:	8d 40 18             	lea    0x18(%eax),%eax
80102f0a:	68 00 02 00 00       	push   $0x200
80102f0f:	50                   	push   %eax
80102f10:	8d 46 18             	lea    0x18(%esi),%eax
80102f13:	50                   	push   %eax
80102f14:	e8 07 19 00 00       	call   80104820 <memmove>
    bwrite(to);  // write the log
80102f19:	89 34 24             	mov    %esi,(%esp)
80102f1c:	e8 af d2 ff ff       	call   801001d0 <bwrite>
    brelse(from);
80102f21:	89 3c 24             	mov    %edi,(%esp)
80102f24:	e8 d7 d2 ff ff       	call   80100200 <brelse>
    brelse(to);
80102f29:	89 34 24             	mov    %esi,(%esp)
80102f2c:	e8 cf d2 ff ff       	call   80100200 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102f31:	83 c4 10             	add    $0x10,%esp
80102f34:	3b 1d 28 12 11 80    	cmp    0x80111228,%ebx
80102f3a:	7c 94                	jl     80102ed0 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102f3c:	e8 7f fd ff ff       	call   80102cc0 <write_head>
    install_trans(); // Now install writes to home locations
80102f41:	e8 da fc ff ff       	call   80102c20 <install_trans>
    log.lh.n = 0;
80102f46:	c7 05 28 12 11 80 00 	movl   $0x0,0x80111228
80102f4d:	00 00 00 
    write_head();    // Erase the transaction from the log
80102f50:	e8 6b fd ff ff       	call   80102cc0 <write_head>
80102f55:	e9 38 ff ff ff       	jmp    80102e92 <end_op+0x62>
80102f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80102f60:	83 ec 0c             	sub    $0xc,%esp
80102f63:	68 e0 11 11 80       	push   $0x801111e0
80102f68:	e8 03 12 00 00       	call   80104170 <wakeup>
  release(&log.lock);
80102f6d:	c7 04 24 e0 11 11 80 	movl   $0x801111e0,(%esp)
80102f74:	e8 b7 17 00 00       	call   80104730 <release>
80102f79:	83 c4 10             	add    $0x10,%esp
}
80102f7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f7f:	5b                   	pop    %ebx
80102f80:	5e                   	pop    %esi
80102f81:	5f                   	pop    %edi
80102f82:	5d                   	pop    %ebp
80102f83:	c3                   	ret    
    panic("log.committing");
80102f84:	83 ec 0c             	sub    $0xc,%esp
80102f87:	68 80 77 10 80       	push   $0x80107780
80102f8c:	e8 ef d3 ff ff       	call   80100380 <panic>
80102f91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f9f:	90                   	nop

80102fa0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102fa0:	f3 0f 1e fb          	endbr32 
80102fa4:	55                   	push   %ebp
80102fa5:	89 e5                	mov    %esp,%ebp
80102fa7:	53                   	push   %ebx
80102fa8:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102fab:	8b 15 28 12 11 80    	mov    0x80111228,%edx
{
80102fb1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102fb4:	83 fa 1d             	cmp    $0x1d,%edx
80102fb7:	0f 8f 91 00 00 00    	jg     8010304e <log_write+0xae>
80102fbd:	a1 18 12 11 80       	mov    0x80111218,%eax
80102fc2:	83 e8 01             	sub    $0x1,%eax
80102fc5:	39 c2                	cmp    %eax,%edx
80102fc7:	0f 8d 81 00 00 00    	jge    8010304e <log_write+0xae>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102fcd:	a1 1c 12 11 80       	mov    0x8011121c,%eax
80102fd2:	85 c0                	test   %eax,%eax
80102fd4:	0f 8e 81 00 00 00    	jle    8010305b <log_write+0xbb>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102fda:	83 ec 0c             	sub    $0xc,%esp
80102fdd:	68 e0 11 11 80       	push   $0x801111e0
80102fe2:	e8 69 15 00 00       	call   80104550 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102fe7:	8b 15 28 12 11 80    	mov    0x80111228,%edx
80102fed:	83 c4 10             	add    $0x10,%esp
80102ff0:	85 d2                	test   %edx,%edx
80102ff2:	7e 4e                	jle    80103042 <log_write+0xa2>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102ff4:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102ff7:	31 c0                	xor    %eax,%eax
80102ff9:	eb 0c                	jmp    80103007 <log_write+0x67>
80102ffb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102fff:	90                   	nop
80103000:	83 c0 01             	add    $0x1,%eax
80103003:	39 c2                	cmp    %eax,%edx
80103005:	74 29                	je     80103030 <log_write+0x90>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103007:	39 0c 85 2c 12 11 80 	cmp    %ecx,-0x7feeedd4(,%eax,4)
8010300e:	75 f0                	jne    80103000 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80103010:	89 0c 85 2c 12 11 80 	mov    %ecx,-0x7feeedd4(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103017:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
8010301a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
8010301d:	c7 45 08 e0 11 11 80 	movl   $0x801111e0,0x8(%ebp)
}
80103024:	c9                   	leave  
  release(&log.lock);
80103025:	e9 06 17 00 00       	jmp    80104730 <release>
8010302a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103030:	89 0c 95 2c 12 11 80 	mov    %ecx,-0x7feeedd4(,%edx,4)
    log.lh.n++;
80103037:	83 c2 01             	add    $0x1,%edx
8010303a:	89 15 28 12 11 80    	mov    %edx,0x80111228
80103040:	eb d5                	jmp    80103017 <log_write+0x77>
  log.lh.block[i] = b->blockno;
80103042:	8b 43 08             	mov    0x8(%ebx),%eax
80103045:	a3 2c 12 11 80       	mov    %eax,0x8011122c
  if (i == log.lh.n)
8010304a:	75 cb                	jne    80103017 <log_write+0x77>
8010304c:	eb e9                	jmp    80103037 <log_write+0x97>
    panic("too big a transaction");
8010304e:	83 ec 0c             	sub    $0xc,%esp
80103051:	68 8f 77 10 80       	push   $0x8010778f
80103056:	e8 25 d3 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
8010305b:	83 ec 0c             	sub    $0xc,%esp
8010305e:	68 a5 77 10 80       	push   $0x801077a5
80103063:	e8 18 d3 ff ff       	call   80100380 <panic>
80103068:	66 90                	xchg   %ax,%ax
8010306a:	66 90                	xchg   %ax,%ax
8010306c:	66 90                	xchg   %ax,%ax
8010306e:	66 90                	xchg   %ax,%ax

80103070 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103070:	55                   	push   %ebp
80103071:	89 e5                	mov    %esp,%ebp
80103073:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpunum());
80103076:	e8 35 f8 ff ff       	call   801028b0 <cpunum>
8010307b:	83 ec 08             	sub    $0x8,%esp
8010307e:	50                   	push   %eax
8010307f:	68 c0 77 10 80       	push   $0x801077c0
80103084:	e8 17 d6 ff ff       	call   801006a0 <cprintf>
  idtinit();       // load idt register
80103089:	e8 72 2a 00 00       	call   80105b00 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
8010308e:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103095:	b8 01 00 00 00       	mov    $0x1,%eax
8010309a:	f0 87 82 a8 00 00 00 	lock xchg %eax,0xa8(%edx)
  scheduler();     // start running processes
801030a1:	e8 3a 0c 00 00       	call   80103ce0 <scheduler>
801030a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030ad:	8d 76 00             	lea    0x0(%esi),%esi

801030b0 <mpenter>:
{
801030b0:	f3 0f 1e fb          	endbr32 
801030b4:	55                   	push   %ebp
801030b5:	89 e5                	mov    %esp,%ebp
801030b7:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
801030ba:	e8 f1 3b 00 00       	call   80106cb0 <switchkvm>
  seginit();
801030bf:	e8 7c 3a 00 00       	call   80106b40 <seginit>
  lapicinit();
801030c4:	e8 e7 f6 ff ff       	call   801027b0 <lapicinit>
  mpmain();
801030c9:	e8 a2 ff ff ff       	call   80103070 <mpmain>
801030ce:	66 90                	xchg   %ax,%ax

801030d0 <main>:
{
801030d0:	f3 0f 1e fb          	endbr32 
801030d4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801030d8:	83 e4 f0             	and    $0xfffffff0,%esp
801030db:	ff 71 fc             	pushl  -0x4(%ecx)
801030de:	55                   	push   %ebp
801030df:	89 e5                	mov    %esp,%ebp
801030e1:	53                   	push   %ebx
801030e2:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801030e3:	83 ec 08             	sub    $0x8,%esp
801030e6:	68 00 00 40 80       	push   $0x80400000
801030eb:	68 68 42 11 80       	push   $0x80114268
801030f0:	e8 7b f4 ff ff       	call   80102570 <kinit1>
  kvmalloc();      // kernel page table
801030f5:	e8 96 3b 00 00       	call   80106c90 <kvmalloc>
  mpinit();        // detect other processors
801030fa:	e8 b1 01 00 00       	call   801032b0 <mpinit>
  lapicinit();     // interrupt controller
801030ff:	e8 ac f6 ff ff       	call   801027b0 <lapicinit>
  seginit();       // segment descriptors
80103104:	e8 37 3a 00 00       	call   80106b40 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpunum());
80103109:	e8 a2 f7 ff ff       	call   801028b0 <cpunum>
8010310e:	5a                   	pop    %edx
8010310f:	59                   	pop    %ecx
80103110:	50                   	push   %eax
80103111:	68 d1 77 10 80       	push   $0x801077d1
80103116:	e8 85 d5 ff ff       	call   801006a0 <cprintf>
  picinit();       // another interrupt controller
8010311b:	e8 a0 03 00 00       	call   801034c0 <picinit>
  ioapicinit();    // another interrupt controller
80103120:	e8 3b f2 ff ff       	call   80102360 <ioapicinit>
  consoleinit();   // console hardware
80103125:	e8 f6 d8 ff ff       	call   80100a20 <consoleinit>
  uartinit();      // serial port
8010312a:	e8 d1 2c 00 00       	call   80105e00 <uartinit>
  pinit();         // process table
8010312f:	e8 cc 08 00 00       	call   80103a00 <pinit>
  tvinit();        // trap vectors
80103134:	e8 47 29 00 00       	call   80105a80 <tvinit>
  binit();         // buffer cache
80103139:	e8 02 cf ff ff       	call   80100040 <binit>
  fileinit();      // file table
8010313e:	e8 8d dc ff ff       	call   80100dd0 <fileinit>
  ideinit();       // disk
80103143:	e8 f8 ef ff ff       	call   80102140 <ideinit>
  if(!ismp)
80103148:	8b 1d c4 12 11 80    	mov    0x801112c4,%ebx
8010314e:	83 c4 10             	add    $0x10,%esp
80103151:	85 db                	test   %ebx,%ebx
80103153:	0f 84 cb 00 00 00    	je     80103224 <main+0x154>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103159:	83 ec 04             	sub    $0x4,%esp
8010315c:	68 8a 00 00 00       	push   $0x8a
80103161:	68 8c a4 10 80       	push   $0x8010a48c
80103166:	68 00 70 00 80       	push   $0x80007000
8010316b:	e8 b0 16 00 00       	call   80104820 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103170:	83 c4 10             	add    $0x10,%esp
80103173:	69 05 c0 18 11 80 bc 	imul   $0xbc,0x801118c0,%eax
8010317a:	00 00 00 
8010317d:	05 e0 12 11 80       	add    $0x801112e0,%eax
80103182:	3d e0 12 11 80       	cmp    $0x801112e0,%eax
80103187:	76 7f                	jbe    80103208 <main+0x138>
80103189:	bb e0 12 11 80       	mov    $0x801112e0,%ebx
8010318e:	eb 19                	jmp    801031a9 <main+0xd9>
80103190:	69 05 c0 18 11 80 bc 	imul   $0xbc,0x801118c0,%eax
80103197:	00 00 00 
8010319a:	81 c3 bc 00 00 00    	add    $0xbc,%ebx
801031a0:	05 e0 12 11 80       	add    $0x801112e0,%eax
801031a5:	39 c3                	cmp    %eax,%ebx
801031a7:	73 5f                	jae    80103208 <main+0x138>
    if(c == cpus+cpunum())  // We've started already.
801031a9:	e8 02 f7 ff ff       	call   801028b0 <cpunum>
801031ae:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801031b4:	05 e0 12 11 80       	add    $0x801112e0,%eax
801031b9:	39 c3                	cmp    %eax,%ebx
801031bb:	74 d3                	je     80103190 <main+0xc0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801031bd:	e8 7e f4 ff ff       	call   80102640 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
801031c2:	83 ec 08             	sub    $0x8,%esp
    *(void**)(code-8) = mpenter;
801031c5:	c7 05 f8 6f 00 80 b0 	movl   $0x801030b0,0x80006ff8
801031cc:	30 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801031cf:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
801031d6:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
801031d9:	05 00 10 00 00       	add    $0x1000,%eax
801031de:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
801031e3:	68 00 70 00 00       	push   $0x7000
801031e8:	0f b6 03             	movzbl (%ebx),%eax
801031eb:	50                   	push   %eax
801031ec:	e8 8f f7 ff ff       	call   80102980 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801031f1:	83 c4 10             	add    $0x10,%esp
801031f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801031f8:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
801031fe:	85 c0                	test   %eax,%eax
80103200:	74 f6                	je     801031f8 <main+0x128>
80103202:	eb 8c                	jmp    80103190 <main+0xc0>
80103204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103208:	83 ec 08             	sub    $0x8,%esp
8010320b:	68 00 00 00 8e       	push   $0x8e000000
80103210:	68 00 00 40 80       	push   $0x80400000
80103215:	e8 c6 f3 ff ff       	call   801025e0 <kinit2>
  userinit();      // first user process
8010321a:	e8 01 08 00 00       	call   80103a20 <userinit>
  mpmain();        // finish this processor's setup
8010321f:	e8 4c fe ff ff       	call   80103070 <mpmain>
    timerinit();   // uniprocessor timer
80103224:	e8 f7 27 00 00       	call   80105a20 <timerinit>
80103229:	e9 2b ff ff ff       	jmp    80103159 <main+0x89>
8010322e:	66 90                	xchg   %ax,%ax

80103230 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103230:	55                   	push   %ebp
80103231:	89 e5                	mov    %esp,%ebp
80103233:	57                   	push   %edi
80103234:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103235:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010323b:	53                   	push   %ebx
  e = addr+len;
8010323c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010323f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103242:	39 de                	cmp    %ebx,%esi
80103244:	72 10                	jb     80103256 <mpsearch1+0x26>
80103246:	eb 50                	jmp    80103298 <mpsearch1+0x68>
80103248:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010324f:	90                   	nop
80103250:	89 fe                	mov    %edi,%esi
80103252:	39 fb                	cmp    %edi,%ebx
80103254:	76 42                	jbe    80103298 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103256:	83 ec 04             	sub    $0x4,%esp
80103259:	8d 7e 10             	lea    0x10(%esi),%edi
8010325c:	6a 04                	push   $0x4
8010325e:	68 e8 77 10 80       	push   $0x801077e8
80103263:	56                   	push   %esi
80103264:	e8 67 15 00 00       	call   801047d0 <memcmp>
80103269:	83 c4 10             	add    $0x10,%esp
8010326c:	85 c0                	test   %eax,%eax
8010326e:	75 e0                	jne    80103250 <mpsearch1+0x20>
80103270:	89 f2                	mov    %esi,%edx
80103272:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103278:	0f b6 0a             	movzbl (%edx),%ecx
8010327b:	83 c2 01             	add    $0x1,%edx
8010327e:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103280:	39 fa                	cmp    %edi,%edx
80103282:	75 f4                	jne    80103278 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103284:	84 c0                	test   %al,%al
80103286:	75 c8                	jne    80103250 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103288:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010328b:	89 f0                	mov    %esi,%eax
8010328d:	5b                   	pop    %ebx
8010328e:	5e                   	pop    %esi
8010328f:	5f                   	pop    %edi
80103290:	5d                   	pop    %ebp
80103291:	c3                   	ret    
80103292:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103298:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010329b:	31 f6                	xor    %esi,%esi
}
8010329d:	5b                   	pop    %ebx
8010329e:	89 f0                	mov    %esi,%eax
801032a0:	5e                   	pop    %esi
801032a1:	5f                   	pop    %edi
801032a2:	5d                   	pop    %ebp
801032a3:	c3                   	ret    
801032a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801032af:	90                   	nop

801032b0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801032b0:	f3 0f 1e fb          	endbr32 
801032b4:	55                   	push   %ebp
801032b5:	89 e5                	mov    %esp,%ebp
801032b7:	57                   	push   %edi
801032b8:	56                   	push   %esi
801032b9:	53                   	push   %ebx
801032ba:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801032bd:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801032c4:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801032cb:	c1 e0 08             	shl    $0x8,%eax
801032ce:	09 d0                	or     %edx,%eax
801032d0:	c1 e0 04             	shl    $0x4,%eax
801032d3:	75 1b                	jne    801032f0 <mpinit+0x40>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801032d5:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801032dc:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801032e3:	c1 e0 08             	shl    $0x8,%eax
801032e6:	09 d0                	or     %edx,%eax
801032e8:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801032eb:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801032f0:	ba 00 04 00 00       	mov    $0x400,%edx
801032f5:	e8 36 ff ff ff       	call   80103230 <mpsearch1>
801032fa:	89 c3                	mov    %eax,%ebx
801032fc:	85 c0                	test   %eax,%eax
801032fe:	0f 84 6c 01 00 00    	je     80103470 <mpinit+0x1c0>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103304:	8b 73 04             	mov    0x4(%ebx),%esi
80103307:	85 f6                	test   %esi,%esi
80103309:	0f 84 fc 00 00 00    	je     8010340b <mpinit+0x15b>
  if(memcmp(conf, "PCMP", 4) != 0)
8010330f:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103312:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103318:	6a 04                	push   $0x4
8010331a:	68 ed 77 10 80       	push   $0x801077ed
8010331f:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103320:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103323:	e8 a8 14 00 00       	call   801047d0 <memcmp>
80103328:	83 c4 10             	add    $0x10,%esp
8010332b:	85 c0                	test   %eax,%eax
8010332d:	0f 85 d8 00 00 00    	jne    8010340b <mpinit+0x15b>
  if(conf->version != 1 && conf->version != 4)
80103333:	0f b6 96 06 00 00 80 	movzbl -0x7ffffffa(%esi),%edx
8010333a:	80 fa 01             	cmp    $0x1,%dl
8010333d:	74 09                	je     80103348 <mpinit+0x98>
8010333f:	80 fa 04             	cmp    $0x4,%dl
80103342:	0f 85 c3 00 00 00    	jne    8010340b <mpinit+0x15b>
  if(sum((uchar*)conf, conf->length) != 0)
80103348:	0f b7 be 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edi
  for(i=0; i<len; i++)
8010334f:	66 85 ff             	test   %di,%di
80103352:	74 24                	je     80103378 <mpinit+0xc8>
80103354:	89 f2                	mov    %esi,%edx
80103356:	01 f7                	add    %esi,%edi
80103358:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010335f:	90                   	nop
    sum += addr[i];
80103360:	0f b6 8a 00 00 00 80 	movzbl -0x80000000(%edx),%ecx
80103367:	83 c2 01             	add    $0x1,%edx
8010336a:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
8010336c:	39 d7                	cmp    %edx,%edi
8010336e:	75 f0                	jne    80103360 <mpinit+0xb0>
  if(sum((uchar*)conf, conf->length) != 0)
80103370:	84 c0                	test   %al,%al
80103372:	0f 85 93 00 00 00    	jne    8010340b <mpinit+0x15b>
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
80103378:	c7 05 c4 12 11 80 01 	movl   $0x1,0x801112c4
8010337f:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80103382:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103388:	8d 96 2c 00 00 80    	lea    -0x7fffffd4(%esi),%edx
  lapic = (uint*)conf->lapicaddr;
8010338e:	a3 dc 11 11 80       	mov    %eax,0x801111dc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103393:	0f b7 8e 04 00 00 80 	movzwl -0x7ffffffc(%esi),%ecx
8010339a:	03 4d e4             	add    -0x1c(%ebp),%ecx
8010339d:	39 ca                	cmp    %ecx,%edx
8010339f:	72 0e                	jb     801033af <mpinit+0xff>
801033a1:	eb 4d                	jmp    801033f0 <mpinit+0x140>
801033a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801033a7:	90                   	nop
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801033a8:	83 c2 08             	add    $0x8,%edx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801033ab:	39 d1                	cmp    %edx,%ecx
801033ad:	76 38                	jbe    801033e7 <mpinit+0x137>
    switch(*p){
801033af:	0f b6 02             	movzbl (%edx),%eax
801033b2:	3c 02                	cmp    $0x2,%al
801033b4:	74 7a                	je     80103430 <mpinit+0x180>
801033b6:	77 60                	ja     80103418 <mpinit+0x168>
801033b8:	84 c0                	test   %al,%al
801033ba:	75 ec                	jne    801033a8 <mpinit+0xf8>
      if(ncpu < NCPU) {
801033bc:	8b 35 c0 18 11 80    	mov    0x801118c0,%esi
801033c2:	83 fe 07             	cmp    $0x7,%esi
801033c5:	7f 19                	jg     801033e0 <mpinit+0x130>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801033c7:	69 fe bc 00 00 00    	imul   $0xbc,%esi,%edi
801033cd:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        ncpu++;
801033d1:	83 c6 01             	add    $0x1,%esi
801033d4:	89 35 c0 18 11 80    	mov    %esi,0x801118c0
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801033da:	88 87 e0 12 11 80    	mov    %al,-0x7feeed20(%edi)
      p += sizeof(struct mpproc);
801033e0:	83 c2 14             	add    $0x14,%edx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801033e3:	39 d1                	cmp    %edx,%ecx
801033e5:	77 c8                	ja     801033af <mpinit+0xff>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp){
801033e7:	a1 c4 12 11 80       	mov    0x801112c4,%eax
801033ec:	85 c0                	test   %eax,%eax
801033ee:	74 58                	je     80103448 <mpinit+0x198>
    lapic = 0;
    ioapicid = 0;
    return;
  }

  if(mp->imcrp){
801033f0:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
801033f4:	74 15                	je     8010340b <mpinit+0x15b>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801033f6:	b8 70 00 00 00       	mov    $0x70,%eax
801033fb:	ba 22 00 00 00       	mov    $0x22,%edx
80103400:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103401:	ba 23 00 00 00       	mov    $0x23,%edx
80103406:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103407:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010340a:	ee                   	out    %al,(%dx)
  }
}
8010340b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010340e:	5b                   	pop    %ebx
8010340f:	5e                   	pop    %esi
80103410:	5f                   	pop    %edi
80103411:	5d                   	pop    %ebp
80103412:	c3                   	ret    
80103413:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103417:	90                   	nop
    switch(*p){
80103418:	83 e8 03             	sub    $0x3,%eax
8010341b:	3c 01                	cmp    $0x1,%al
8010341d:	76 89                	jbe    801033a8 <mpinit+0xf8>
      ismp = 0;
8010341f:	c7 05 c4 12 11 80 00 	movl   $0x0,0x801112c4
80103426:	00 00 00 
      break;
80103429:	eb 80                	jmp    801033ab <mpinit+0xfb>
8010342b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010342f:	90                   	nop
      ioapicid = ioapic->apicno;
80103430:	0f b6 42 01          	movzbl 0x1(%edx),%eax
      p += sizeof(struct mpioapic);
80103434:	83 c2 08             	add    $0x8,%edx
      ioapicid = ioapic->apicno;
80103437:	a2 c0 12 11 80       	mov    %al,0x801112c0
      continue;
8010343c:	e9 6a ff ff ff       	jmp    801033ab <mpinit+0xfb>
80103441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ncpu = 1;
80103448:	c7 05 c0 18 11 80 01 	movl   $0x1,0x801118c0
8010344f:	00 00 00 
    lapic = 0;
80103452:	c7 05 dc 11 11 80 00 	movl   $0x0,0x801111dc
80103459:	00 00 00 
    ioapicid = 0;
8010345c:	c6 05 c0 12 11 80 00 	movb   $0x0,0x801112c0
}
80103463:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103466:	5b                   	pop    %ebx
80103467:	5e                   	pop    %esi
80103468:	5f                   	pop    %edi
80103469:	5d                   	pop    %ebp
8010346a:	c3                   	ret    
8010346b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010346f:	90                   	nop
  return mpsearch1(0xF0000, 0x10000);
80103470:	ba 00 00 01 00       	mov    $0x10000,%edx
80103475:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010347a:	e8 b1 fd ff ff       	call   80103230 <mpsearch1>
8010347f:	89 c3                	mov    %eax,%ebx
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103481:	85 c0                	test   %eax,%eax
80103483:	0f 85 7b fe ff ff    	jne    80103304 <mpinit+0x54>
80103489:	eb 80                	jmp    8010340b <mpinit+0x15b>
8010348b:	66 90                	xchg   %ax,%ax
8010348d:	66 90                	xchg   %ax,%ax
8010348f:	90                   	nop

80103490 <picenable>:
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
80103490:	f3 0f 1e fb          	endbr32 
80103494:	55                   	push   %ebp
  picsetmask(irqmask & ~(1<<irq));
80103495:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
8010349a:	ba 21 00 00 00       	mov    $0x21,%edx
{
8010349f:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
801034a1:	8b 4d 08             	mov    0x8(%ebp),%ecx
801034a4:	d3 c0                	rol    %cl,%eax
801034a6:	66 23 05 00 a0 10 80 	and    0x8010a000,%ax
  irqmask = mask;
801034ad:	66 a3 00 a0 10 80    	mov    %ax,0x8010a000
801034b3:	ee                   	out    %al,(%dx)
801034b4:	ba a1 00 00 00       	mov    $0xa1,%edx
  outb(IO_PIC2+1, mask >> 8);
801034b9:	66 c1 e8 08          	shr    $0x8,%ax
801034bd:	ee                   	out    %al,(%dx)
}
801034be:	5d                   	pop    %ebp
801034bf:	c3                   	ret    

801034c0 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
801034c0:	f3 0f 1e fb          	endbr32 
801034c4:	55                   	push   %ebp
801034c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801034ca:	89 e5                	mov    %esp,%ebp
801034cc:	57                   	push   %edi
801034cd:	56                   	push   %esi
801034ce:	53                   	push   %ebx
801034cf:	bb 21 00 00 00       	mov    $0x21,%ebx
801034d4:	89 da                	mov    %ebx,%edx
801034d6:	ee                   	out    %al,(%dx)
801034d7:	b9 a1 00 00 00       	mov    $0xa1,%ecx
801034dc:	89 ca                	mov    %ecx,%edx
801034de:	ee                   	out    %al,(%dx)
801034df:	be 11 00 00 00       	mov    $0x11,%esi
801034e4:	ba 20 00 00 00       	mov    $0x20,%edx
801034e9:	89 f0                	mov    %esi,%eax
801034eb:	ee                   	out    %al,(%dx)
801034ec:	b8 20 00 00 00       	mov    $0x20,%eax
801034f1:	89 da                	mov    %ebx,%edx
801034f3:	ee                   	out    %al,(%dx)
801034f4:	b8 04 00 00 00       	mov    $0x4,%eax
801034f9:	ee                   	out    %al,(%dx)
801034fa:	bf 03 00 00 00       	mov    $0x3,%edi
801034ff:	89 f8                	mov    %edi,%eax
80103501:	ee                   	out    %al,(%dx)
80103502:	ba a0 00 00 00       	mov    $0xa0,%edx
80103507:	89 f0                	mov    %esi,%eax
80103509:	ee                   	out    %al,(%dx)
8010350a:	b8 28 00 00 00       	mov    $0x28,%eax
8010350f:	89 ca                	mov    %ecx,%edx
80103511:	ee                   	out    %al,(%dx)
80103512:	b8 02 00 00 00       	mov    $0x2,%eax
80103517:	ee                   	out    %al,(%dx)
80103518:	89 f8                	mov    %edi,%eax
8010351a:	ee                   	out    %al,(%dx)
8010351b:	bf 68 00 00 00       	mov    $0x68,%edi
80103520:	ba 20 00 00 00       	mov    $0x20,%edx
80103525:	89 f8                	mov    %edi,%eax
80103527:	ee                   	out    %al,(%dx)
80103528:	be 0a 00 00 00       	mov    $0xa,%esi
8010352d:	89 f0                	mov    %esi,%eax
8010352f:	ee                   	out    %al,(%dx)
80103530:	ba a0 00 00 00       	mov    $0xa0,%edx
80103535:	89 f8                	mov    %edi,%eax
80103537:	ee                   	out    %al,(%dx)
80103538:	89 f0                	mov    %esi,%eax
8010353a:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
8010353b:	0f b7 05 00 a0 10 80 	movzwl 0x8010a000,%eax
80103542:	66 83 f8 ff          	cmp    $0xffff,%ax
80103546:	74 0a                	je     80103552 <picinit+0x92>
80103548:	89 da                	mov    %ebx,%edx
8010354a:	ee                   	out    %al,(%dx)
  outb(IO_PIC2+1, mask >> 8);
8010354b:	66 c1 e8 08          	shr    $0x8,%ax
8010354f:	89 ca                	mov    %ecx,%edx
80103551:	ee                   	out    %al,(%dx)
    picsetmask(irqmask);
}
80103552:	5b                   	pop    %ebx
80103553:	5e                   	pop    %esi
80103554:	5f                   	pop    %edi
80103555:	5d                   	pop    %ebp
80103556:	c3                   	ret    
80103557:	66 90                	xchg   %ax,%ax
80103559:	66 90                	xchg   %ax,%ax
8010355b:	66 90                	xchg   %ax,%ax
8010355d:	66 90                	xchg   %ax,%ax
8010355f:	90                   	nop

80103560 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103560:	f3 0f 1e fb          	endbr32 
80103564:	55                   	push   %ebp
80103565:	89 e5                	mov    %esp,%ebp
80103567:	57                   	push   %edi
80103568:	56                   	push   %esi
80103569:	53                   	push   %ebx
8010356a:	83 ec 0c             	sub    $0xc,%esp
8010356d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103570:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80103573:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103579:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010357f:	e8 6c d8 ff ff       	call   80100df0 <filealloc>
80103584:	89 03                	mov    %eax,(%ebx)
80103586:	85 c0                	test   %eax,%eax
80103588:	0f 84 ac 00 00 00    	je     8010363a <pipealloc+0xda>
8010358e:	e8 5d d8 ff ff       	call   80100df0 <filealloc>
80103593:	89 06                	mov    %eax,(%esi)
80103595:	85 c0                	test   %eax,%eax
80103597:	0f 84 8b 00 00 00    	je     80103628 <pipealloc+0xc8>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
8010359d:	e8 9e f0 ff ff       	call   80102640 <kalloc>
801035a2:	89 c7                	mov    %eax,%edi
801035a4:	85 c0                	test   %eax,%eax
801035a6:	0f 84 b4 00 00 00    	je     80103660 <pipealloc+0x100>
    goto bad;
  p->readopen = 1;
801035ac:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801035b3:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
801035b6:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
801035b9:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801035c0:	00 00 00 
  p->nwrite = 0;
801035c3:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801035ca:	00 00 00 
  p->nread = 0;
801035cd:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801035d4:	00 00 00 
  initlock(&p->lock, "pipe");
801035d7:	68 f2 77 10 80       	push   $0x801077f2
801035dc:	50                   	push   %eax
801035dd:	e8 4e 0f 00 00       	call   80104530 <initlock>
  (*f0)->type = FD_PIPE;
801035e2:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801035e4:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801035e7:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801035ed:	8b 03                	mov    (%ebx),%eax
801035ef:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801035f3:	8b 03                	mov    (%ebx),%eax
801035f5:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801035f9:	8b 03                	mov    (%ebx),%eax
801035fb:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801035fe:	8b 06                	mov    (%esi),%eax
80103600:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103606:	8b 06                	mov    (%esi),%eax
80103608:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
8010360c:	8b 06                	mov    (%esi),%eax
8010360e:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103612:	8b 06                	mov    (%esi),%eax
80103614:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103617:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010361a:	31 c0                	xor    %eax,%eax
}
8010361c:	5b                   	pop    %ebx
8010361d:	5e                   	pop    %esi
8010361e:	5f                   	pop    %edi
8010361f:	5d                   	pop    %ebp
80103620:	c3                   	ret    
80103621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103628:	8b 03                	mov    (%ebx),%eax
8010362a:	85 c0                	test   %eax,%eax
8010362c:	74 1e                	je     8010364c <pipealloc+0xec>
    fileclose(*f0);
8010362e:	83 ec 0c             	sub    $0xc,%esp
80103631:	50                   	push   %eax
80103632:	e8 79 d8 ff ff       	call   80100eb0 <fileclose>
80103637:	83 c4 10             	add    $0x10,%esp
  if(*f1)
8010363a:	8b 06                	mov    (%esi),%eax
8010363c:	85 c0                	test   %eax,%eax
8010363e:	74 0c                	je     8010364c <pipealloc+0xec>
    fileclose(*f1);
80103640:	83 ec 0c             	sub    $0xc,%esp
80103643:	50                   	push   %eax
80103644:	e8 67 d8 ff ff       	call   80100eb0 <fileclose>
80103649:	83 c4 10             	add    $0x10,%esp
}
8010364c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010364f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103654:	5b                   	pop    %ebx
80103655:	5e                   	pop    %esi
80103656:	5f                   	pop    %edi
80103657:	5d                   	pop    %ebp
80103658:	c3                   	ret    
80103659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103660:	8b 03                	mov    (%ebx),%eax
80103662:	85 c0                	test   %eax,%eax
80103664:	75 c8                	jne    8010362e <pipealloc+0xce>
80103666:	eb d2                	jmp    8010363a <pipealloc+0xda>
80103668:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010366f:	90                   	nop

80103670 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103670:	f3 0f 1e fb          	endbr32 
80103674:	55                   	push   %ebp
80103675:	89 e5                	mov    %esp,%ebp
80103677:	56                   	push   %esi
80103678:	53                   	push   %ebx
80103679:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010367c:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010367f:	83 ec 0c             	sub    $0xc,%esp
80103682:	53                   	push   %ebx
80103683:	e8 c8 0e 00 00       	call   80104550 <acquire>
  if(writable){
80103688:	83 c4 10             	add    $0x10,%esp
8010368b:	85 f6                	test   %esi,%esi
8010368d:	74 41                	je     801036d0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010368f:	83 ec 0c             	sub    $0xc,%esp
80103692:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103698:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010369f:	00 00 00 
    wakeup(&p->nread);
801036a2:	50                   	push   %eax
801036a3:	e8 c8 0a 00 00       	call   80104170 <wakeup>
801036a8:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801036ab:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801036b1:	85 d2                	test   %edx,%edx
801036b3:	75 0a                	jne    801036bf <pipeclose+0x4f>
801036b5:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801036bb:	85 c0                	test   %eax,%eax
801036bd:	74 31                	je     801036f0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801036bf:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801036c2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801036c5:	5b                   	pop    %ebx
801036c6:	5e                   	pop    %esi
801036c7:	5d                   	pop    %ebp
    release(&p->lock);
801036c8:	e9 63 10 00 00       	jmp    80104730 <release>
801036cd:	8d 76 00             	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
801036d0:	83 ec 0c             	sub    $0xc,%esp
801036d3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801036d9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801036e0:	00 00 00 
    wakeup(&p->nwrite);
801036e3:	50                   	push   %eax
801036e4:	e8 87 0a 00 00       	call   80104170 <wakeup>
801036e9:	83 c4 10             	add    $0x10,%esp
801036ec:	eb bd                	jmp    801036ab <pipeclose+0x3b>
801036ee:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801036f0:	83 ec 0c             	sub    $0xc,%esp
801036f3:	53                   	push   %ebx
801036f4:	e8 37 10 00 00       	call   80104730 <release>
    kfree((char*)p);
801036f9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801036fc:	83 c4 10             	add    $0x10,%esp
}
801036ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103702:	5b                   	pop    %ebx
80103703:	5e                   	pop    %esi
80103704:	5d                   	pop    %ebp
    kfree((char*)p);
80103705:	e9 76 ed ff ff       	jmp    80102480 <kfree>
8010370a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103710 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103710:	f3 0f 1e fb          	endbr32 
80103714:	55                   	push   %ebp
80103715:	89 e5                	mov    %esp,%ebp
80103717:	57                   	push   %edi
80103718:	56                   	push   %esi
80103719:	53                   	push   %ebx
8010371a:	83 ec 28             	sub    $0x28,%esp
8010371d:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  acquire(&p->lock);
80103720:	57                   	push   %edi
80103721:	e8 2a 0e 00 00       	call   80104550 <acquire>
  for(i = 0; i < n; i++){
80103726:	8b 45 10             	mov    0x10(%ebp),%eax
80103729:	83 c4 10             	add    $0x10,%esp
8010372c:	85 c0                	test   %eax,%eax
8010372e:	0f 8e bc 00 00 00    	jle    801037f0 <pipewrite+0xe0>
80103734:	8b 45 0c             	mov    0xc(%ebp),%eax
80103737:	8b 8f 38 02 00 00    	mov    0x238(%edi),%ecx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
8010373d:	8d b7 34 02 00 00    	lea    0x234(%edi),%esi
80103743:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103746:	03 45 10             	add    0x10(%ebp),%eax
80103749:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010374c:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103752:	8d 9f 38 02 00 00    	lea    0x238(%edi),%ebx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103758:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
8010375e:	39 d1                	cmp    %edx,%ecx
80103760:	74 3d                	je     8010379f <pipewrite+0x8f>
80103762:	eb 5e                	jmp    801037c2 <pipewrite+0xb2>
80103764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || proc->killed){
80103768:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010376e:	8b 48 24             	mov    0x24(%eax),%ecx
80103771:	85 c9                	test   %ecx,%ecx
80103773:	75 34                	jne    801037a9 <pipewrite+0x99>
      wakeup(&p->nread);
80103775:	83 ec 0c             	sub    $0xc,%esp
80103778:	56                   	push   %esi
80103779:	e8 f2 09 00 00       	call   80104170 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010377e:	58                   	pop    %eax
8010377f:	5a                   	pop    %edx
80103780:	57                   	push   %edi
80103781:	53                   	push   %ebx
80103782:	e8 29 08 00 00       	call   80103fb0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103787:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
8010378d:	8b 97 38 02 00 00    	mov    0x238(%edi),%edx
80103793:	83 c4 10             	add    $0x10,%esp
80103796:	05 00 02 00 00       	add    $0x200,%eax
8010379b:	39 c2                	cmp    %eax,%edx
8010379d:	75 29                	jne    801037c8 <pipewrite+0xb8>
      if(p->readopen == 0 || proc->killed){
8010379f:	8b 87 3c 02 00 00    	mov    0x23c(%edi),%eax
801037a5:	85 c0                	test   %eax,%eax
801037a7:	75 bf                	jne    80103768 <pipewrite+0x58>
        release(&p->lock);
801037a9:	83 ec 0c             	sub    $0xc,%esp
801037ac:	57                   	push   %edi
801037ad:	e8 7e 0f 00 00       	call   80104730 <release>
        return -1;
801037b2:	83 c4 10             	add    $0x10,%esp
801037b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801037ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801037bd:	5b                   	pop    %ebx
801037be:	5e                   	pop    %esi
801037bf:	5f                   	pop    %edi
801037c0:	5d                   	pop    %ebp
801037c1:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801037c2:	89 ca                	mov    %ecx,%edx
801037c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801037c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801037cb:	8d 4a 01             	lea    0x1(%edx),%ecx
801037ce:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801037d4:	89 8f 38 02 00 00    	mov    %ecx,0x238(%edi)
801037da:	0f b6 18             	movzbl (%eax),%ebx
801037dd:	83 c0 01             	add    $0x1,%eax
801037e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801037e3:	88 5c 17 34          	mov    %bl,0x34(%edi,%edx,1)
  for(i = 0; i < n; i++){
801037e7:	3b 45 e0             	cmp    -0x20(%ebp),%eax
801037ea:	0f 85 5c ff ff ff    	jne    8010374c <pipewrite+0x3c>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801037f0:	83 ec 0c             	sub    $0xc,%esp
801037f3:	8d 97 34 02 00 00    	lea    0x234(%edi),%edx
801037f9:	52                   	push   %edx
801037fa:	e8 71 09 00 00       	call   80104170 <wakeup>
  release(&p->lock);
801037ff:	89 3c 24             	mov    %edi,(%esp)
80103802:	e8 29 0f 00 00       	call   80104730 <release>
  return n;
80103807:	8b 45 10             	mov    0x10(%ebp),%eax
8010380a:	83 c4 10             	add    $0x10,%esp
8010380d:	eb ab                	jmp    801037ba <pipewrite+0xaa>
8010380f:	90                   	nop

80103810 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103810:	f3 0f 1e fb          	endbr32 
80103814:	55                   	push   %ebp
80103815:	89 e5                	mov    %esp,%ebp
80103817:	57                   	push   %edi
80103818:	56                   	push   %esi
80103819:	53                   	push   %ebx
8010381a:	83 ec 18             	sub    $0x18,%esp
8010381d:	8b 75 08             	mov    0x8(%ebp),%esi
80103820:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80103823:	56                   	push   %esi
80103824:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010382a:	e8 21 0d 00 00       	call   80104550 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010382f:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103835:	83 c4 10             	add    $0x10,%esp
80103838:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
8010383e:	74 35                	je     80103875 <piperead+0x65>
80103840:	eb 3d                	jmp    8010387f <piperead+0x6f>
80103842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(proc->killed){
80103848:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010384f:	8b 4a 24             	mov    0x24(%edx),%ecx
80103852:	85 c9                	test   %ecx,%ecx
80103854:	0f 85 8e 00 00 00    	jne    801038e8 <piperead+0xd8>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
8010385a:	83 ec 08             	sub    $0x8,%esp
8010385d:	56                   	push   %esi
8010385e:	53                   	push   %ebx
8010385f:	e8 4c 07 00 00       	call   80103fb0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103864:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
8010386a:	83 c4 10             	add    $0x10,%esp
8010386d:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103873:	75 0a                	jne    8010387f <piperead+0x6f>
80103875:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
8010387b:	85 c0                	test   %eax,%eax
8010387d:	75 c9                	jne    80103848 <piperead+0x38>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010387f:	8b 55 10             	mov    0x10(%ebp),%edx
80103882:	31 db                	xor    %ebx,%ebx
80103884:	85 d2                	test   %edx,%edx
80103886:	7f 27                	jg     801038af <piperead+0x9f>
80103888:	eb 33                	jmp    801038bd <piperead+0xad>
8010388a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103890:	8d 4a 01             	lea    0x1(%edx),%ecx
80103893:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103899:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010389f:	0f b6 54 16 34       	movzbl 0x34(%esi,%edx,1),%edx
801038a4:	88 14 1f             	mov    %dl,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801038a7:	83 c3 01             	add    $0x1,%ebx
801038aa:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801038ad:	74 0e                	je     801038bd <piperead+0xad>
    if(p->nread == p->nwrite)
801038af:	8b 96 34 02 00 00    	mov    0x234(%esi),%edx
801038b5:	3b 96 38 02 00 00    	cmp    0x238(%esi),%edx
801038bb:	75 d3                	jne    80103890 <piperead+0x80>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801038bd:	83 ec 0c             	sub    $0xc,%esp
801038c0:	8d 96 38 02 00 00    	lea    0x238(%esi),%edx
801038c6:	52                   	push   %edx
801038c7:	e8 a4 08 00 00       	call   80104170 <wakeup>
  release(&p->lock);
801038cc:	89 34 24             	mov    %esi,(%esp)
801038cf:	e8 5c 0e 00 00       	call   80104730 <release>
  return i;
801038d4:	83 c4 10             	add    $0x10,%esp
}
801038d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038da:	89 d8                	mov    %ebx,%eax
801038dc:	5b                   	pop    %ebx
801038dd:	5e                   	pop    %esi
801038de:	5f                   	pop    %edi
801038df:	5d                   	pop    %ebp
801038e0:	c3                   	ret    
801038e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
801038e8:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801038eb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801038f0:	56                   	push   %esi
801038f1:	e8 3a 0e 00 00       	call   80104730 <release>
      return -1;
801038f6:	83 c4 10             	add    $0x10,%esp
}
801038f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038fc:	89 d8                	mov    %ebx,%eax
801038fe:	5b                   	pop    %ebx
801038ff:	5e                   	pop    %esi
80103900:	5f                   	pop    %edi
80103901:	5d                   	pop    %ebp
80103902:	c3                   	ret    
80103903:	66 90                	xchg   %ax,%ax
80103905:	66 90                	xchg   %ax,%ax
80103907:	66 90                	xchg   %ax,%ax
80103909:	66 90                	xchg   %ax,%ax
8010390b:	66 90                	xchg   %ax,%ax
8010390d:	66 90                	xchg   %ax,%ax
8010390f:	90                   	nop

80103910 <allocproc>:
// state required to run in the kernel.
// Otherwise return 0.
// Must hold ptable.lock.
static struct proc*
allocproc(void)
{
80103910:	55                   	push   %ebp
80103911:	89 e5                	mov    %esp,%ebp
80103913:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103914:	bb 14 19 11 80       	mov    $0x80111914,%ebx
{
80103919:	83 ec 04             	sub    $0x4,%esp
8010391c:	eb 10                	jmp    8010392e <allocproc+0x1e>
8010391e:	66 90                	xchg   %ax,%ax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103920:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103926:	81 fb 14 3a 11 80    	cmp    $0x80113a14,%ebx
8010392c:	74 6b                	je     80103999 <allocproc+0x89>
    if(p->state == UNUSED)
8010392e:	8b 43 0c             	mov    0xc(%ebx),%eax
80103931:	85 c0                	test   %eax,%eax
80103933:	75 eb                	jne    80103920 <allocproc+0x10>
      goto found;
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103935:	a1 08 a0 10 80       	mov    0x8010a008,%eax
  p->state = EMBRYO;
8010393a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103941:	89 43 10             	mov    %eax,0x10(%ebx)
80103944:	8d 50 01             	lea    0x1(%eax),%edx
80103947:	89 15 08 a0 10 80    	mov    %edx,0x8010a008

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010394d:	e8 ee ec ff ff       	call   80102640 <kalloc>
80103952:	89 43 08             	mov    %eax,0x8(%ebx)
80103955:	85 c0                	test   %eax,%eax
80103957:	74 39                	je     80103992 <allocproc+0x82>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103959:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010395f:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103962:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103967:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
8010396a:	c7 40 14 72 5a 10 80 	movl   $0x80105a72,0x14(%eax)
  p->context = (struct context*)sp;
80103971:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103974:	6a 14                	push   $0x14
80103976:	6a 00                	push   $0x0
80103978:	50                   	push   %eax
80103979:	e8 02 0e 00 00       	call   80104780 <memset>
  p->context->eip = (uint)forkret;
8010397e:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103981:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103984:	c7 40 10 b0 39 10 80 	movl   $0x801039b0,0x10(%eax)
}
8010398b:	89 d8                	mov    %ebx,%eax
8010398d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103990:	c9                   	leave  
80103991:	c3                   	ret    
    p->state = UNUSED;
80103992:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103999:	31 db                	xor    %ebx,%ebx
}
8010399b:	89 d8                	mov    %ebx,%eax
8010399d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039a0:	c9                   	leave  
801039a1:	c3                   	ret    
801039a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801039b0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801039b0:	f3 0f 1e fb          	endbr32 
801039b4:	55                   	push   %ebp
801039b5:	89 e5                	mov    %esp,%ebp
801039b7:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801039ba:	68 e0 18 11 80       	push   $0x801118e0
801039bf:	e8 6c 0d 00 00       	call   80104730 <release>

  if (first) {
801039c4:	a1 04 a0 10 80       	mov    0x8010a004,%eax
801039c9:	83 c4 10             	add    $0x10,%esp
801039cc:	85 c0                	test   %eax,%eax
801039ce:	75 08                	jne    801039d8 <forkret+0x28>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801039d0:	c9                   	leave  
801039d1:	c3                   	ret    
801039d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    first = 0;
801039d8:	c7 05 04 a0 10 80 00 	movl   $0x0,0x8010a004
801039df:	00 00 00 
    iinit(ROOTDEV);
801039e2:	83 ec 0c             	sub    $0xc,%esp
801039e5:	6a 01                	push   $0x1
801039e7:	e8 34 db ff ff       	call   80101520 <iinit>
    initlog(ROOTDEV);
801039ec:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801039f3:	e8 28 f3 ff ff       	call   80102d20 <initlog>
}
801039f8:	83 c4 10             	add    $0x10,%esp
801039fb:	c9                   	leave  
801039fc:	c3                   	ret    
801039fd:	8d 76 00             	lea    0x0(%esi),%esi

80103a00 <pinit>:
{
80103a00:	f3 0f 1e fb          	endbr32 
80103a04:	55                   	push   %ebp
80103a05:	89 e5                	mov    %esp,%ebp
80103a07:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103a0a:	68 f7 77 10 80       	push   $0x801077f7
80103a0f:	68 e0 18 11 80       	push   $0x801118e0
80103a14:	e8 17 0b 00 00       	call   80104530 <initlock>
}
80103a19:	83 c4 10             	add    $0x10,%esp
80103a1c:	c9                   	leave  
80103a1d:	c3                   	ret    
80103a1e:	66 90                	xchg   %ax,%ax

80103a20 <userinit>:
{
80103a20:	f3 0f 1e fb          	endbr32 
80103a24:	55                   	push   %ebp
80103a25:	89 e5                	mov    %esp,%ebp
80103a27:	53                   	push   %ebx
80103a28:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103a2b:	68 e0 18 11 80       	push   $0x801118e0
80103a30:	e8 1b 0b 00 00       	call   80104550 <acquire>
  p = allocproc();
80103a35:	e8 d6 fe ff ff       	call   80103910 <allocproc>
80103a3a:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103a3c:	a3 bc a5 10 80       	mov    %eax,0x8010a5bc
  if((p->pgdir = setupkvm()) == 0)
80103a41:	e8 da 31 00 00       	call   80106c20 <setupkvm>
80103a46:	83 c4 10             	add    $0x10,%esp
80103a49:	89 43 04             	mov    %eax,0x4(%ebx)
80103a4c:	85 c0                	test   %eax,%eax
80103a4e:	0f 84 b1 00 00 00    	je     80103b05 <userinit+0xe5>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103a54:	83 ec 04             	sub    $0x4,%esp
80103a57:	68 2c 00 00 00       	push   $0x2c
80103a5c:	68 60 a4 10 80       	push   $0x8010a460
80103a61:	50                   	push   %eax
80103a62:	e8 19 33 00 00       	call   80106d80 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103a67:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103a6a:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103a70:	6a 4c                	push   $0x4c
80103a72:	6a 00                	push   $0x0
80103a74:	ff 73 18             	pushl  0x18(%ebx)
80103a77:	e8 04 0d 00 00       	call   80104780 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a7c:	8b 43 18             	mov    0x18(%ebx),%eax
80103a7f:	ba 23 00 00 00       	mov    $0x23,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a84:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a87:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a8c:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a90:	8b 43 18             	mov    0x18(%ebx),%eax
80103a93:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103a97:	8b 43 18             	mov    0x18(%ebx),%eax
80103a9a:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a9e:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103aa2:	8b 43 18             	mov    0x18(%ebx),%eax
80103aa5:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103aa9:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103aad:	8b 43 18             	mov    0x18(%ebx),%eax
80103ab0:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103ab7:	8b 43 18             	mov    0x18(%ebx),%eax
80103aba:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103ac1:	8b 43 18             	mov    0x18(%ebx),%eax
80103ac4:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103acb:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103ace:	6a 10                	push   $0x10
80103ad0:	68 17 78 10 80       	push   $0x80107817
80103ad5:	50                   	push   %eax
80103ad6:	e8 65 0e 00 00       	call   80104940 <safestrcpy>
  p->cwd = namei("/");
80103adb:	c7 04 24 20 78 10 80 	movl   $0x80107820,(%esp)
80103ae2:	e8 39 e5 ff ff       	call   80102020 <namei>
  p->state = RUNNABLE;
80103ae7:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  p->cwd = namei("/");
80103aee:	89 43 68             	mov    %eax,0x68(%ebx)
  release(&ptable.lock);
80103af1:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
80103af8:	e8 33 0c 00 00       	call   80104730 <release>
}
80103afd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b00:	83 c4 10             	add    $0x10,%esp
80103b03:	c9                   	leave  
80103b04:	c3                   	ret    
    panic("userinit: out of memory?");
80103b05:	83 ec 0c             	sub    $0xc,%esp
80103b08:	68 fe 77 10 80       	push   $0x801077fe
80103b0d:	e8 6e c8 ff ff       	call   80100380 <panic>
80103b12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103b20 <growproc>:
{
80103b20:	f3 0f 1e fb          	endbr32 
80103b24:	55                   	push   %ebp
80103b25:	89 e5                	mov    %esp,%ebp
80103b27:	83 ec 08             	sub    $0x8,%esp
  sz = proc->sz;
80103b2a:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
{
80103b31:	8b 4d 08             	mov    0x8(%ebp),%ecx
  sz = proc->sz;
80103b34:	8b 02                	mov    (%edx),%eax
  if(n > 0){
80103b36:	85 c9                	test   %ecx,%ecx
80103b38:	7f 1e                	jg     80103b58 <growproc+0x38>
  } else if(n < 0){
80103b3a:	75 44                	jne    80103b80 <growproc+0x60>
  proc->sz = sz;
80103b3c:	89 02                	mov    %eax,(%edx)
  switchuvm(proc);
80103b3e:	83 ec 0c             	sub    $0xc,%esp
80103b41:	65 ff 35 04 00 00 00 	pushl  %gs:0x4
80103b48:	e8 83 31 00 00       	call   80106cd0 <switchuvm>
  return 0;
80103b4d:	83 c4 10             	add    $0x10,%esp
80103b50:	31 c0                	xor    %eax,%eax
}
80103b52:	c9                   	leave  
80103b53:	c3                   	ret    
80103b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80103b58:	83 ec 04             	sub    $0x4,%esp
80103b5b:	01 c1                	add    %eax,%ecx
80103b5d:	51                   	push   %ecx
80103b5e:	50                   	push   %eax
80103b5f:	ff 72 04             	pushl  0x4(%edx)
80103b62:	e8 69 33 00 00       	call   80106ed0 <allocuvm>
80103b67:	83 c4 10             	add    $0x10,%esp
80103b6a:	85 c0                	test   %eax,%eax
80103b6c:	74 28                	je     80103b96 <growproc+0x76>
80103b6e:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103b75:	eb c5                	jmp    80103b3c <growproc+0x1c>
80103b77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b7e:	66 90                	xchg   %ax,%ax
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80103b80:	83 ec 04             	sub    $0x4,%esp
80103b83:	01 c1                	add    %eax,%ecx
80103b85:	51                   	push   %ecx
80103b86:	50                   	push   %eax
80103b87:	ff 72 04             	pushl  0x4(%edx)
80103b8a:	e8 71 34 00 00       	call   80107000 <deallocuvm>
80103b8f:	83 c4 10             	add    $0x10,%esp
80103b92:	85 c0                	test   %eax,%eax
80103b94:	75 d8                	jne    80103b6e <growproc+0x4e>
}
80103b96:	c9                   	leave  
      return -1;
80103b97:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103b9c:	c3                   	ret    
80103b9d:	8d 76 00             	lea    0x0(%esi),%esi

80103ba0 <fork>:
{
80103ba0:	f3 0f 1e fb          	endbr32 
80103ba4:	55                   	push   %ebp
80103ba5:	89 e5                	mov    %esp,%ebp
80103ba7:	57                   	push   %edi
80103ba8:	56                   	push   %esi
80103ba9:	53                   	push   %ebx
80103baa:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);
80103bad:	68 e0 18 11 80       	push   $0x801118e0
80103bb2:	e8 99 09 00 00       	call   80104550 <acquire>
  if((np = allocproc()) == 0){
80103bb7:	e8 54 fd ff ff       	call   80103910 <allocproc>
80103bbc:	83 c4 10             	add    $0x10,%esp
80103bbf:	85 c0                	test   %eax,%eax
80103bc1:	0f 84 c9 00 00 00    	je     80103c90 <fork+0xf0>
80103bc7:	89 c3                	mov    %eax,%ebx
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80103bc9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103bcf:	83 ec 08             	sub    $0x8,%esp
80103bd2:	ff 30                	pushl  (%eax)
80103bd4:	ff 70 04             	pushl  0x4(%eax)
80103bd7:	e8 04 35 00 00       	call   801070e0 <copyuvm>
80103bdc:	83 c4 10             	add    $0x10,%esp
80103bdf:	89 43 04             	mov    %eax,0x4(%ebx)
80103be2:	85 c0                	test   %eax,%eax
80103be4:	0f 84 bd 00 00 00    	je     80103ca7 <fork+0x107>
  np->sz = proc->sz;
80103bea:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  *np->tf = *proc->tf;
80103bf0:	8b 7b 18             	mov    0x18(%ebx),%edi
80103bf3:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = proc->sz;
80103bf8:	8b 00                	mov    (%eax),%eax
80103bfa:	89 03                	mov    %eax,(%ebx)
  np->parent = proc;
80103bfc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103c02:	89 43 14             	mov    %eax,0x14(%ebx)
  *np->tf = *proc->tf;
80103c05:	8b 70 18             	mov    0x18(%eax),%esi
80103c08:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103c0a:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103c0c:	8b 43 18             	mov    0x18(%ebx),%eax
80103c0f:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103c16:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80103c1d:	8d 76 00             	lea    0x0(%esi),%esi
    if(proc->ofile[i])
80103c20:	8b 44 b2 28          	mov    0x28(%edx,%esi,4),%eax
80103c24:	85 c0                	test   %eax,%eax
80103c26:	74 17                	je     80103c3f <fork+0x9f>
      np->ofile[i] = filedup(proc->ofile[i]);
80103c28:	83 ec 0c             	sub    $0xc,%esp
80103c2b:	50                   	push   %eax
80103c2c:	e8 2f d2 ff ff       	call   80100e60 <filedup>
80103c31:	83 c4 10             	add    $0x10,%esp
80103c34:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
80103c38:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  for(i = 0; i < NOFILE; i++)
80103c3f:	83 c6 01             	add    $0x1,%esi
80103c42:	83 fe 10             	cmp    $0x10,%esi
80103c45:	75 d9                	jne    80103c20 <fork+0x80>
  np->cwd = idup(proc->cwd);
80103c47:	83 ec 0c             	sub    $0xc,%esp
80103c4a:	ff 72 68             	pushl  0x68(%edx)
80103c4d:	e8 8e da ff ff       	call   801016e0 <idup>
  safestrcpy(np->name, proc->name, sizeof(proc->name));
80103c52:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(proc->cwd);
80103c55:	89 43 68             	mov    %eax,0x68(%ebx)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
80103c58:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103c5e:	6a 10                	push   $0x10
80103c60:	83 c0 6c             	add    $0x6c,%eax
80103c63:	50                   	push   %eax
80103c64:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103c67:	50                   	push   %eax
80103c68:	e8 d3 0c 00 00       	call   80104940 <safestrcpy>
  np->state = RUNNABLE;
80103c6d:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  pid = np->pid;
80103c74:	8b 73 10             	mov    0x10(%ebx),%esi
  release(&ptable.lock);
80103c77:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
80103c7e:	e8 ad 0a 00 00       	call   80104730 <release>
  return pid;
80103c83:	83 c4 10             	add    $0x10,%esp
}
80103c86:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c89:	89 f0                	mov    %esi,%eax
80103c8b:	5b                   	pop    %ebx
80103c8c:	5e                   	pop    %esi
80103c8d:	5f                   	pop    %edi
80103c8e:	5d                   	pop    %ebp
80103c8f:	c3                   	ret    
    release(&ptable.lock);
80103c90:	83 ec 0c             	sub    $0xc,%esp
    return -1;
80103c93:	be ff ff ff ff       	mov    $0xffffffff,%esi
    release(&ptable.lock);
80103c98:	68 e0 18 11 80       	push   $0x801118e0
80103c9d:	e8 8e 0a 00 00       	call   80104730 <release>
    return -1;
80103ca2:	83 c4 10             	add    $0x10,%esp
80103ca5:	eb df                	jmp    80103c86 <fork+0xe6>
    kfree(np->kstack);
80103ca7:	83 ec 0c             	sub    $0xc,%esp
80103caa:	ff 73 08             	pushl  0x8(%ebx)
    return -1;
80103cad:	be ff ff ff ff       	mov    $0xffffffff,%esi
    kfree(np->kstack);
80103cb2:	e8 c9 e7 ff ff       	call   80102480 <kfree>
    np->kstack = 0;
80103cb7:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103cbe:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    release(&ptable.lock);
80103cc5:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
80103ccc:	e8 5f 0a 00 00       	call   80104730 <release>
    return -1;
80103cd1:	83 c4 10             	add    $0x10,%esp
80103cd4:	eb b0                	jmp    80103c86 <fork+0xe6>
80103cd6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cdd:	8d 76 00             	lea    0x0(%esi),%esi

80103ce0 <scheduler>:
{
80103ce0:	f3 0f 1e fb          	endbr32 
80103ce4:	55                   	push   %ebp
80103ce5:	89 e5                	mov    %esp,%ebp
80103ce7:	53                   	push   %ebx
80103ce8:	83 ec 04             	sub    $0x4,%esp
80103ceb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103cef:	90                   	nop
  asm volatile("sti");
80103cf0:	fb                   	sti    
    acquire(&ptable.lock);
80103cf1:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cf4:	bb 14 19 11 80       	mov    $0x80111914,%ebx
    acquire(&ptable.lock);
80103cf9:	68 e0 18 11 80       	push   $0x801118e0
80103cfe:	e8 4d 08 00 00       	call   80104550 <acquire>
80103d03:	83 c4 10             	add    $0x10,%esp
80103d06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d0d:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->state != RUNNABLE)
80103d10:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103d14:	75 3e                	jne    80103d54 <scheduler+0x74>
      switchuvm(p);
80103d16:	83 ec 0c             	sub    $0xc,%esp
      proc = p;
80103d19:	65 89 1d 04 00 00 00 	mov    %ebx,%gs:0x4
      switchuvm(p);
80103d20:	53                   	push   %ebx
80103d21:	e8 aa 2f 00 00       	call   80106cd0 <switchuvm>
      swtch(&cpu->scheduler, p->context);
80103d26:	58                   	pop    %eax
80103d27:	5a                   	pop    %edx
80103d28:	ff 73 1c             	pushl  0x1c(%ebx)
80103d2b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
      p->state = RUNNING;
80103d31:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&cpu->scheduler, p->context);
80103d38:	83 c0 04             	add    $0x4,%eax
80103d3b:	50                   	push   %eax
80103d3c:	e8 62 0c 00 00       	call   801049a3 <swtch>
      switchkvm();
80103d41:	e8 6a 2f 00 00       	call   80106cb0 <switchkvm>
      proc = 0;
80103d46:	83 c4 10             	add    $0x10,%esp
80103d49:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80103d50:	00 00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d54:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103d5a:	81 fb 14 3a 11 80    	cmp    $0x80113a14,%ebx
80103d60:	75 ae                	jne    80103d10 <scheduler+0x30>
    release(&ptable.lock);
80103d62:	83 ec 0c             	sub    $0xc,%esp
80103d65:	68 e0 18 11 80       	push   $0x801118e0
80103d6a:	e8 c1 09 00 00       	call   80104730 <release>
    sti();
80103d6f:	83 c4 10             	add    $0x10,%esp
80103d72:	e9 79 ff ff ff       	jmp    80103cf0 <scheduler+0x10>
80103d77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d7e:	66 90                	xchg   %ax,%ax

80103d80 <sched>:
{
80103d80:	f3 0f 1e fb          	endbr32 
80103d84:	55                   	push   %ebp
80103d85:	89 e5                	mov    %esp,%ebp
80103d87:	53                   	push   %ebx
80103d88:	83 ec 10             	sub    $0x10,%esp
  if(!holding(&ptable.lock))
80103d8b:	68 e0 18 11 80       	push   $0x801118e0
80103d90:	e8 eb 08 00 00       	call   80104680 <holding>
80103d95:	83 c4 10             	add    $0x10,%esp
80103d98:	85 c0                	test   %eax,%eax
80103d9a:	74 4c                	je     80103de8 <sched+0x68>
  if(cpu->ncli != 1)
80103d9c:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80103da3:	83 ba ac 00 00 00 01 	cmpl   $0x1,0xac(%edx)
80103daa:	75 63                	jne    80103e0f <sched+0x8f>
  if(proc->state == RUNNING)
80103dac:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103db2:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80103db6:	74 4a                	je     80103e02 <sched+0x82>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103db8:	9c                   	pushf  
80103db9:	59                   	pop    %ecx
  if(readeflags()&FL_IF)
80103dba:	80 e5 02             	and    $0x2,%ch
80103dbd:	75 36                	jne    80103df5 <sched+0x75>
  swtch(&proc->context, cpu->scheduler);
80103dbf:	83 ec 08             	sub    $0x8,%esp
80103dc2:	83 c0 1c             	add    $0x1c,%eax
  intena = cpu->intena;
80103dc5:	8b 9a b0 00 00 00    	mov    0xb0(%edx),%ebx
  swtch(&proc->context, cpu->scheduler);
80103dcb:	ff 72 04             	pushl  0x4(%edx)
80103dce:	50                   	push   %eax
80103dcf:	e8 cf 0b 00 00       	call   801049a3 <swtch>
  cpu->intena = intena;
80103dd4:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
}
80103dda:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80103ddd:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
}
80103de3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103de6:	c9                   	leave  
80103de7:	c3                   	ret    
    panic("sched ptable.lock");
80103de8:	83 ec 0c             	sub    $0xc,%esp
80103deb:	68 22 78 10 80       	push   $0x80107822
80103df0:	e8 8b c5 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
80103df5:	83 ec 0c             	sub    $0xc,%esp
80103df8:	68 4e 78 10 80       	push   $0x8010784e
80103dfd:	e8 7e c5 ff ff       	call   80100380 <panic>
    panic("sched running");
80103e02:	83 ec 0c             	sub    $0xc,%esp
80103e05:	68 40 78 10 80       	push   $0x80107840
80103e0a:	e8 71 c5 ff ff       	call   80100380 <panic>
    panic("sched locks");
80103e0f:	83 ec 0c             	sub    $0xc,%esp
80103e12:	68 34 78 10 80       	push   $0x80107834
80103e17:	e8 64 c5 ff ff       	call   80100380 <panic>
80103e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103e20 <exit>:
{
80103e20:	f3 0f 1e fb          	endbr32 
80103e24:	55                   	push   %ebp
  if(proc == initproc)
80103e25:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
{
80103e2c:	89 e5                	mov    %esp,%ebp
80103e2e:	56                   	push   %esi
80103e2f:	53                   	push   %ebx
80103e30:	31 db                	xor    %ebx,%ebx
  if(proc == initproc)
80103e32:	3b 15 bc a5 10 80    	cmp    0x8010a5bc,%edx
80103e38:	0f 84 23 01 00 00    	je     80103f61 <exit+0x141>
80103e3e:	66 90                	xchg   %ax,%ax
    if(proc->ofile[fd]){
80103e40:	8d 73 08             	lea    0x8(%ebx),%esi
80103e43:	8b 44 b2 08          	mov    0x8(%edx,%esi,4),%eax
80103e47:	85 c0                	test   %eax,%eax
80103e49:	74 1b                	je     80103e66 <exit+0x46>
      fileclose(proc->ofile[fd]);
80103e4b:	83 ec 0c             	sub    $0xc,%esp
80103e4e:	50                   	push   %eax
80103e4f:	e8 5c d0 ff ff       	call   80100eb0 <fileclose>
      proc->ofile[fd] = 0;
80103e54:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103e5b:	83 c4 10             	add    $0x10,%esp
80103e5e:	c7 44 b2 08 00 00 00 	movl   $0x0,0x8(%edx,%esi,4)
80103e65:	00 
  for(fd = 0; fd < NOFILE; fd++){
80103e66:	83 c3 01             	add    $0x1,%ebx
80103e69:	83 fb 10             	cmp    $0x10,%ebx
80103e6c:	75 d2                	jne    80103e40 <exit+0x20>
  begin_op();
80103e6e:	e8 4d ef ff ff       	call   80102dc0 <begin_op>
  iput(proc->cwd);
80103e73:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e79:	83 ec 0c             	sub    $0xc,%esp
80103e7c:	ff 70 68             	pushl  0x68(%eax)
80103e7f:	e8 fc d9 ff ff       	call   80101880 <iput>
  end_op();
80103e84:	e8 a7 ef ff ff       	call   80102e30 <end_op>
  proc->cwd = 0;
80103e89:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e8f:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
  acquire(&ptable.lock);
80103e96:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
80103e9d:	e8 ae 06 00 00       	call   80104550 <acquire>
  wakeup1(proc->parent);
80103ea2:	65 8b 1d 04 00 00 00 	mov    %gs:0x4,%ebx
80103ea9:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103eac:	b8 14 19 11 80       	mov    $0x80111914,%eax
  wakeup1(proc->parent);
80103eb1:	8b 53 14             	mov    0x14(%ebx),%edx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103eb4:	eb 16                	jmp    80103ecc <exit+0xac>
80103eb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ebd:	8d 76 00             	lea    0x0(%esi),%esi
80103ec0:	05 84 00 00 00       	add    $0x84,%eax
80103ec5:	3d 14 3a 11 80       	cmp    $0x80113a14,%eax
80103eca:	74 1e                	je     80103eea <exit+0xca>
    if(p->state == SLEEPING && p->chan == chan)
80103ecc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103ed0:	75 ee                	jne    80103ec0 <exit+0xa0>
80103ed2:	3b 50 20             	cmp    0x20(%eax),%edx
80103ed5:	75 e9                	jne    80103ec0 <exit+0xa0>
      p->state = RUNNABLE;
80103ed7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ede:	05 84 00 00 00       	add    $0x84,%eax
80103ee3:	3d 14 3a 11 80       	cmp    $0x80113a14,%eax
80103ee8:	75 e2                	jne    80103ecc <exit+0xac>
      p->parent = initproc;
80103eea:	8b 0d bc a5 10 80    	mov    0x8010a5bc,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ef0:	ba 14 19 11 80       	mov    $0x80111914,%edx
80103ef5:	eb 17                	jmp    80103f0e <exit+0xee>
80103ef7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103efe:	66 90                	xchg   %ax,%ax
80103f00:	81 c2 84 00 00 00    	add    $0x84,%edx
80103f06:	81 fa 14 3a 11 80    	cmp    $0x80113a14,%edx
80103f0c:	74 3a                	je     80103f48 <exit+0x128>
    if(p->parent == proc){
80103f0e:	3b 5a 14             	cmp    0x14(%edx),%ebx
80103f11:	75 ed                	jne    80103f00 <exit+0xe0>
      if(p->state == ZOMBIE)
80103f13:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103f17:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103f1a:	75 e4                	jne    80103f00 <exit+0xe0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f1c:	b8 14 19 11 80       	mov    $0x80111914,%eax
80103f21:	eb 11                	jmp    80103f34 <exit+0x114>
80103f23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f27:	90                   	nop
80103f28:	05 84 00 00 00       	add    $0x84,%eax
80103f2d:	3d 14 3a 11 80       	cmp    $0x80113a14,%eax
80103f32:	74 cc                	je     80103f00 <exit+0xe0>
    if(p->state == SLEEPING && p->chan == chan)
80103f34:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f38:	75 ee                	jne    80103f28 <exit+0x108>
80103f3a:	3b 48 20             	cmp    0x20(%eax),%ecx
80103f3d:	75 e9                	jne    80103f28 <exit+0x108>
      p->state = RUNNABLE;
80103f3f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103f46:	eb e0                	jmp    80103f28 <exit+0x108>
  proc->state = ZOMBIE;
80103f48:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103f4f:	e8 2c fe ff ff       	call   80103d80 <sched>
  panic("zombie exit");
80103f54:	83 ec 0c             	sub    $0xc,%esp
80103f57:	68 6f 78 10 80       	push   $0x8010786f
80103f5c:	e8 1f c4 ff ff       	call   80100380 <panic>
    panic("init exiting");
80103f61:	83 ec 0c             	sub    $0xc,%esp
80103f64:	68 62 78 10 80       	push   $0x80107862
80103f69:	e8 12 c4 ff ff       	call   80100380 <panic>
80103f6e:	66 90                	xchg   %ax,%ax

80103f70 <yield>:
{
80103f70:	f3 0f 1e fb          	endbr32 
80103f74:	55                   	push   %ebp
80103f75:	89 e5                	mov    %esp,%ebp
80103f77:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103f7a:	68 e0 18 11 80       	push   $0x801118e0
80103f7f:	e8 cc 05 00 00       	call   80104550 <acquire>
  proc->state = RUNNABLE;
80103f84:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103f8a:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103f91:	e8 ea fd ff ff       	call   80103d80 <sched>
  release(&ptable.lock);
80103f96:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
80103f9d:	e8 8e 07 00 00       	call   80104730 <release>
}
80103fa2:	83 c4 10             	add    $0x10,%esp
80103fa5:	c9                   	leave  
80103fa6:	c3                   	ret    
80103fa7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103fae:	66 90                	xchg   %ax,%ax

80103fb0 <sleep>:
{
80103fb0:	f3 0f 1e fb          	endbr32 
80103fb4:	55                   	push   %ebp
  if(proc == 0)
80103fb5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
80103fbb:	89 e5                	mov    %esp,%ebp
80103fbd:	56                   	push   %esi
80103fbe:	8b 75 08             	mov    0x8(%ebp),%esi
80103fc1:	53                   	push   %ebx
80103fc2:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(proc == 0)
80103fc5:	85 c0                	test   %eax,%eax
80103fc7:	0f 84 9b 00 00 00    	je     80104068 <sleep+0xb8>
  if(lk == 0)
80103fcd:	85 db                	test   %ebx,%ebx
80103fcf:	0f 84 86 00 00 00    	je     8010405b <sleep+0xab>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103fd5:	81 fb e0 18 11 80    	cmp    $0x801118e0,%ebx
80103fdb:	74 5b                	je     80104038 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103fdd:	83 ec 0c             	sub    $0xc,%esp
80103fe0:	68 e0 18 11 80       	push   $0x801118e0
80103fe5:	e8 66 05 00 00       	call   80104550 <acquire>
    release(lk);
80103fea:	89 1c 24             	mov    %ebx,(%esp)
80103fed:	e8 3e 07 00 00       	call   80104730 <release>
  proc->chan = chan;
80103ff2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103ff8:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80103ffb:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80104002:	e8 79 fd ff ff       	call   80103d80 <sched>
  proc->chan = 0;
80104007:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010400d:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
    release(&ptable.lock);
80104014:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
8010401b:	e8 10 07 00 00       	call   80104730 <release>
    acquire(lk);
80104020:	89 5d 08             	mov    %ebx,0x8(%ebp)
80104023:	83 c4 10             	add    $0x10,%esp
}
80104026:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104029:	5b                   	pop    %ebx
8010402a:	5e                   	pop    %esi
8010402b:	5d                   	pop    %ebp
    acquire(lk);
8010402c:	e9 1f 05 00 00       	jmp    80104550 <acquire>
80104031:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  proc->chan = chan;
80104038:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
8010403b:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80104042:	e8 39 fd ff ff       	call   80103d80 <sched>
  proc->chan = 0;
80104047:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010404d:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
}
80104054:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104057:	5b                   	pop    %ebx
80104058:	5e                   	pop    %esi
80104059:	5d                   	pop    %ebp
8010405a:	c3                   	ret    
    panic("sleep without lk");
8010405b:	83 ec 0c             	sub    $0xc,%esp
8010405e:	68 81 78 10 80       	push   $0x80107881
80104063:	e8 18 c3 ff ff       	call   80100380 <panic>
    panic("sleep");
80104068:	83 ec 0c             	sub    $0xc,%esp
8010406b:	68 7b 78 10 80       	push   $0x8010787b
80104070:	e8 0b c3 ff ff       	call   80100380 <panic>
80104075:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010407c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104080 <wait>:
{
80104080:	f3 0f 1e fb          	endbr32 
80104084:	55                   	push   %ebp
80104085:	89 e5                	mov    %esp,%ebp
80104087:	56                   	push   %esi
80104088:	53                   	push   %ebx
  acquire(&ptable.lock);
80104089:	83 ec 0c             	sub    $0xc,%esp
8010408c:	68 e0 18 11 80       	push   $0x801118e0
80104091:	e8 ba 04 00 00       	call   80104550 <acquire>
80104096:	83 c4 10             	add    $0x10,%esp
      if(p->parent != proc)
80104099:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    havekids = 0;
8010409f:	31 d2                	xor    %edx,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040a1:	bb 14 19 11 80       	mov    $0x80111914,%ebx
801040a6:	eb 16                	jmp    801040be <wait+0x3e>
801040a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040af:	90                   	nop
801040b0:	81 c3 84 00 00 00    	add    $0x84,%ebx
801040b6:	81 fb 14 3a 11 80    	cmp    $0x80113a14,%ebx
801040bc:	74 1e                	je     801040dc <wait+0x5c>
      if(p->parent != proc)
801040be:	39 43 14             	cmp    %eax,0x14(%ebx)
801040c1:	75 ed                	jne    801040b0 <wait+0x30>
      if(p->state == ZOMBIE){
801040c3:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801040c7:	74 37                	je     80104100 <wait+0x80>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040c9:	81 c3 84 00 00 00    	add    $0x84,%ebx
      havekids = 1;
801040cf:	ba 01 00 00 00       	mov    $0x1,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040d4:	81 fb 14 3a 11 80    	cmp    $0x80113a14,%ebx
801040da:	75 e2                	jne    801040be <wait+0x3e>
    if(!havekids || proc->killed){
801040dc:	85 d2                	test   %edx,%edx
801040de:	74 76                	je     80104156 <wait+0xd6>
801040e0:	8b 50 24             	mov    0x24(%eax),%edx
801040e3:	85 d2                	test   %edx,%edx
801040e5:	75 6f                	jne    80104156 <wait+0xd6>
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
801040e7:	83 ec 08             	sub    $0x8,%esp
801040ea:	68 e0 18 11 80       	push   $0x801118e0
801040ef:	50                   	push   %eax
801040f0:	e8 bb fe ff ff       	call   80103fb0 <sleep>
    havekids = 0;
801040f5:	83 c4 10             	add    $0x10,%esp
801040f8:	eb 9f                	jmp    80104099 <wait+0x19>
801040fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104100:	83 ec 0c             	sub    $0xc,%esp
80104103:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80104106:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104109:	e8 72 e3 ff ff       	call   80102480 <kfree>
        freevm(p->pgdir);
8010410e:	59                   	pop    %ecx
8010410f:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80104112:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104119:	e8 12 2f 00 00       	call   80107030 <freevm>
        release(&ptable.lock);
8010411e:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
        p->pid = 0;
80104125:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
8010412c:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104133:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104137:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
8010413e:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104145:	e8 e6 05 00 00       	call   80104730 <release>
        return pid;
8010414a:	83 c4 10             	add    $0x10,%esp
}
8010414d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104150:	89 f0                	mov    %esi,%eax
80104152:	5b                   	pop    %ebx
80104153:	5e                   	pop    %esi
80104154:	5d                   	pop    %ebp
80104155:	c3                   	ret    
      release(&ptable.lock);
80104156:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104159:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010415e:	68 e0 18 11 80       	push   $0x801118e0
80104163:	e8 c8 05 00 00       	call   80104730 <release>
      return -1;
80104168:	83 c4 10             	add    $0x10,%esp
8010416b:	eb e0                	jmp    8010414d <wait+0xcd>
8010416d:	8d 76 00             	lea    0x0(%esi),%esi

80104170 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104170:	f3 0f 1e fb          	endbr32 
80104174:	55                   	push   %ebp
80104175:	89 e5                	mov    %esp,%ebp
80104177:	53                   	push   %ebx
80104178:	83 ec 10             	sub    $0x10,%esp
8010417b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010417e:	68 e0 18 11 80       	push   $0x801118e0
80104183:	e8 c8 03 00 00       	call   80104550 <acquire>
80104188:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010418b:	b8 14 19 11 80       	mov    $0x80111914,%eax
80104190:	eb 12                	jmp    801041a4 <wakeup+0x34>
80104192:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104198:	05 84 00 00 00       	add    $0x84,%eax
8010419d:	3d 14 3a 11 80       	cmp    $0x80113a14,%eax
801041a2:	74 1e                	je     801041c2 <wakeup+0x52>
    if(p->state == SLEEPING && p->chan == chan)
801041a4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801041a8:	75 ee                	jne    80104198 <wakeup+0x28>
801041aa:	3b 58 20             	cmp    0x20(%eax),%ebx
801041ad:	75 e9                	jne    80104198 <wakeup+0x28>
      p->state = RUNNABLE;
801041af:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041b6:	05 84 00 00 00       	add    $0x84,%eax
801041bb:	3d 14 3a 11 80       	cmp    $0x80113a14,%eax
801041c0:	75 e2                	jne    801041a4 <wakeup+0x34>
  wakeup1(chan);
  release(&ptable.lock);
801041c2:	c7 45 08 e0 18 11 80 	movl   $0x801118e0,0x8(%ebp)
}
801041c9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041cc:	c9                   	leave  
  release(&ptable.lock);
801041cd:	e9 5e 05 00 00       	jmp    80104730 <release>
801041d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801041e0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801041e0:	f3 0f 1e fb          	endbr32 
801041e4:	55                   	push   %ebp
801041e5:	89 e5                	mov    %esp,%ebp
801041e7:	53                   	push   %ebx
801041e8:	83 ec 10             	sub    $0x10,%esp
801041eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801041ee:	68 e0 18 11 80       	push   $0x801118e0
801041f3:	e8 58 03 00 00       	call   80104550 <acquire>
801041f8:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041fb:	b8 14 19 11 80       	mov    $0x80111914,%eax
80104200:	eb 12                	jmp    80104214 <kill+0x34>
80104202:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104208:	05 84 00 00 00       	add    $0x84,%eax
8010420d:	3d 14 3a 11 80       	cmp    $0x80113a14,%eax
80104212:	74 34                	je     80104248 <kill+0x68>
    if(p->pid == pid){
80104214:	39 58 10             	cmp    %ebx,0x10(%eax)
80104217:	75 ef                	jne    80104208 <kill+0x28>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104219:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
8010421d:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
80104224:	75 07                	jne    8010422d <kill+0x4d>
        p->state = RUNNABLE;
80104226:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
8010422d:	83 ec 0c             	sub    $0xc,%esp
80104230:	68 e0 18 11 80       	push   $0x801118e0
80104235:	e8 f6 04 00 00       	call   80104730 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
8010423a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
8010423d:	83 c4 10             	add    $0x10,%esp
80104240:	31 c0                	xor    %eax,%eax
}
80104242:	c9                   	leave  
80104243:	c3                   	ret    
80104244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104248:	83 ec 0c             	sub    $0xc,%esp
8010424b:	68 e0 18 11 80       	push   $0x801118e0
80104250:	e8 db 04 00 00       	call   80104730 <release>
}
80104255:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104258:	83 c4 10             	add    $0x10,%esp
8010425b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104260:	c9                   	leave  
80104261:	c3                   	ret    
80104262:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104270 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104270:	f3 0f 1e fb          	endbr32 
80104274:	55                   	push   %ebp
80104275:	89 e5                	mov    %esp,%ebp
80104277:	57                   	push   %edi
80104278:	56                   	push   %esi
80104279:	8d 75 e8             	lea    -0x18(%ebp),%esi
8010427c:	53                   	push   %ebx
8010427d:	bb 80 19 11 80       	mov    $0x80111980,%ebx
80104282:	83 ec 3c             	sub    $0x3c,%esp
80104285:	eb 2b                	jmp    801042b2 <procdump+0x42>
80104287:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010428e:	66 90                	xchg   %ax,%ax
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104290:	83 ec 0c             	sub    $0xc,%esp
80104293:	68 e6 77 10 80       	push   $0x801077e6
80104298:	e8 03 c4 ff ff       	call   801006a0 <cprintf>
8010429d:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042a0:	81 c3 84 00 00 00    	add    $0x84,%ebx
801042a6:	81 fb 80 3a 11 80    	cmp    $0x80113a80,%ebx
801042ac:	0f 84 8e 00 00 00    	je     80104340 <procdump+0xd0>
    if(p->state == UNUSED)
801042b2:	8b 43 a0             	mov    -0x60(%ebx),%eax
801042b5:	85 c0                	test   %eax,%eax
801042b7:	74 e7                	je     801042a0 <procdump+0x30>
      state = "???";
801042b9:	ba 92 78 10 80       	mov    $0x80107892,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801042be:	83 f8 05             	cmp    $0x5,%eax
801042c1:	77 11                	ja     801042d4 <procdump+0x64>
801042c3:	8b 14 85 d4 78 10 80 	mov    -0x7fef872c(,%eax,4),%edx
      state = "???";
801042ca:	b8 92 78 10 80       	mov    $0x80107892,%eax
801042cf:	85 d2                	test   %edx,%edx
801042d1:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801042d4:	53                   	push   %ebx
801042d5:	52                   	push   %edx
801042d6:	ff 73 a4             	pushl  -0x5c(%ebx)
801042d9:	68 96 78 10 80       	push   $0x80107896
801042de:	e8 bd c3 ff ff       	call   801006a0 <cprintf>
    if(p->state == SLEEPING){
801042e3:	83 c4 10             	add    $0x10,%esp
801042e6:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801042ea:	75 a4                	jne    80104290 <procdump+0x20>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801042ec:	83 ec 08             	sub    $0x8,%esp
801042ef:	8d 45 c0             	lea    -0x40(%ebp),%eax
801042f2:	8d 7d c0             	lea    -0x40(%ebp),%edi
801042f5:	50                   	push   %eax
801042f6:	8b 43 b0             	mov    -0x50(%ebx),%eax
801042f9:	8b 40 0c             	mov    0xc(%eax),%eax
801042fc:	83 c0 08             	add    $0x8,%eax
801042ff:	50                   	push   %eax
80104300:	e8 1b 03 00 00       	call   80104620 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104305:	83 c4 10             	add    $0x10,%esp
80104308:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010430f:	90                   	nop
80104310:	8b 17                	mov    (%edi),%edx
80104312:	85 d2                	test   %edx,%edx
80104314:	0f 84 76 ff ff ff    	je     80104290 <procdump+0x20>
        cprintf(" %p", pc[i]);
8010431a:	83 ec 08             	sub    $0x8,%esp
8010431d:	83 c7 04             	add    $0x4,%edi
80104320:	52                   	push   %edx
80104321:	68 e2 72 10 80       	push   $0x801072e2
80104326:	e8 75 c3 ff ff       	call   801006a0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
8010432b:	83 c4 10             	add    $0x10,%esp
8010432e:	39 fe                	cmp    %edi,%esi
80104330:	75 de                	jne    80104310 <procdump+0xa0>
80104332:	e9 59 ff ff ff       	jmp    80104290 <procdump+0x20>
80104337:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010433e:	66 90                	xchg   %ax,%ax
  }
}
80104340:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104343:	5b                   	pop    %ebx
80104344:	5e                   	pop    %esi
80104345:	5f                   	pop    %edi
80104346:	5d                   	pop    %ebp
80104347:	c3                   	ret    
80104348:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010434f:	90                   	nop

80104350 <clone>:

int 
clone(void(*func)(void *), void *arg, void *stack)
{
80104350:	f3 0f 1e fb          	endbr32 
80104354:	55                   	push   %ebp
80104355:	89 e5                	mov    %esp,%ebp
80104357:	57                   	push   %edi
80104358:	56                   	push   %esi
80104359:	53                   	push   %ebx
8010435a:	83 ec 1c             	sub    $0x1c,%esp
  
  struct proc *curproc = proc; // 记录发出 clone 的进程（np->pthread 记录的父线程）
8010435d:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104364:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct proc *np;

  if ((np = allocproc()) == 0) //为新线程分配 PCB/TCB
80104367:	e8 a4 f5 ff ff       	call   80103910 <allocproc>
8010436c:	85 c0                	test   %eax,%eax
8010436e:	0f 84 e9 00 00 00    	je     8010445d <clone+0x10d>
    return -1;

  //由于共享进程映像，只需使用同一个页表即可，无需拷贝内容
  np->pgdir = curproc->pgdir; // 线程间共用同一个页表
80104374:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104377:	89 c3                	mov    %eax,%ebx
  np->sz = curproc->sz;
  np->pthread = curproc; // exit 时用于找到父进程并唤醒
  np->ustack = stack;    //设置自己的线程栈
  np->parent = 0;
  *np->tf = *curproc->tf; // 继承 trapframe
80104379:	b9 13 00 00 00       	mov    $0x13,%ecx
8010437e:	8b 7b 18             	mov    0x18(%ebx),%edi
  np->pgdir = curproc->pgdir; // 线程间共用同一个页表
80104381:	8b 42 04             	mov    0x4(%edx),%eax
80104384:	89 43 04             	mov    %eax,0x4(%ebx)
  np->sz = curproc->sz;
80104387:	8b 02                	mov    (%edx),%eax
  np->pthread = curproc; // exit 时用于找到父进程并唤醒
80104389:	89 53 7c             	mov    %edx,0x7c(%ebx)
  np->sz = curproc->sz;
8010438c:	89 03                	mov    %eax,(%ebx)
  np->ustack = stack;    //设置自己的线程栈
8010438e:	8b 45 10             	mov    0x10(%ebp),%eax
  np->parent = 0;
80104391:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  np->ustack = stack;    //设置自己的线程栈
80104398:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)

  int *sp = stack + 4096 - 8; //下面将在线程栈填写8字节内容
  // 在用户态栈“伪造”现场，将参数和返回地址（无用的）保存在里面
  *(sp + 1) = (int)arg; // *(np->tf->esp+4) = (int)arg
8010439e:	8b 45 0c             	mov    0xc(%ebp),%eax
  *np->tf = *curproc->tf; // 继承 trapframe
801043a1:	8b 72 18             	mov    0x18(%edx),%esi
801043a4:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  *(sp + 1) = (int)arg; // *(np->tf->esp+4) = (int)arg
801043a6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  np->tf->esp = (int)sp; // top of stack
  np->tf->ebp = (int)sp; // 栈帧指针
  np->tf->eax = 0;

  
  for (int i = 0; i < NOFILE; i++) // 复制文件描述符
801043a9:	31 f6                	xor    %esi,%esi
801043ab:	89 d7                	mov    %edx,%edi
  *(sp + 1) = (int)arg; // *(np->tf->esp+4) = (int)arg
801043ad:	89 81 fc 0f 00 00    	mov    %eax,0xffc(%ecx)
  *sp = 0xffffffff;     // 返回地址（没有用到）
801043b3:	c7 81 f8 0f 00 00 ff 	movl   $0xffffffff,0xff8(%ecx)
801043ba:	ff ff ff 
  np->tf->eip = (int)func;
801043bd:	8b 4d 08             	mov    0x8(%ebp),%ecx
801043c0:	8b 43 18             	mov    0x18(%ebx),%eax
801043c3:	89 48 38             	mov    %ecx,0x38(%eax)
  int *sp = stack + 4096 - 8; //下面将在线程栈填写8字节内容
801043c6:	8b 45 10             	mov    0x10(%ebp),%eax
  np->tf->esp = (int)sp; // top of stack
801043c9:	8b 4b 18             	mov    0x18(%ebx),%ecx
  int *sp = stack + 4096 - 8; //下面将在线程栈填写8字节内容
801043cc:	05 f8 0f 00 00       	add    $0xff8,%eax
  np->tf->esp = (int)sp; // top of stack
801043d1:	89 41 44             	mov    %eax,0x44(%ecx)
  np->tf->ebp = (int)sp; // 栈帧指针
801043d4:	8b 4b 18             	mov    0x18(%ebx),%ecx
801043d7:	89 41 08             	mov    %eax,0x8(%ecx)
  np->tf->eax = 0;
801043da:	8b 43 18             	mov    0x18(%ebx),%eax
801043dd:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for (int i = 0; i < NOFILE; i++) // 复制文件描述符
801043e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (curproc->ofile[i])
801043e8:	8b 44 b7 28          	mov    0x28(%edi,%esi,4),%eax
801043ec:	85 c0                	test   %eax,%eax
801043ee:	74 10                	je     80104400 <clone+0xb0>
      np->ofile[i] = filedup(curproc->ofile[i]);
801043f0:	83 ec 0c             	sub    $0xc,%esp
801043f3:	50                   	push   %eax
801043f4:	e8 67 ca ff ff       	call   80100e60 <filedup>
801043f9:	83 c4 10             	add    $0x10,%esp
801043fc:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
  for (int i = 0; i < NOFILE; i++) // 复制文件描述符
80104400:	83 c6 01             	add    $0x1,%esi
80104403:	83 fe 10             	cmp    $0x10,%esi
80104406:	75 e0                	jne    801043e8 <clone+0x98>
  np->cwd = idup(curproc->cwd);
80104408:	83 ec 0c             	sub    $0xc,%esp
8010440b:	ff 77 68             	pushl  0x68(%edi)
8010440e:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80104411:	e8 ca d2 ff ff       	call   801016e0 <idup>

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104416:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104419:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
8010441c:	89 43 68             	mov    %eax,0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010441f:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104422:	83 c2 6c             	add    $0x6c,%edx
80104425:	6a 10                	push   $0x10
80104427:	52                   	push   %edx
80104428:	50                   	push   %eax
80104429:	e8 12 05 00 00       	call   80104940 <safestrcpy>
  int pid = np->pid;
8010442e:	8b 73 10             	mov    0x10(%ebx),%esi

  acquire(&ptable.lock);
80104431:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
80104438:	e8 13 01 00 00       	call   80104550 <acquire>
  np->state = RUNNABLE;
8010443d:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80104444:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
8010444b:	e8 e0 02 00 00       	call   80104730 <release>
  // 返回新线程的 pid
  return pid;
80104450:	83 c4 10             	add    $0x10,%esp
}
80104453:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104456:	89 f0                	mov    %esi,%eax
80104458:	5b                   	pop    %ebx
80104459:	5e                   	pop    %esi
8010445a:	5f                   	pop    %edi
8010445b:	5d                   	pop    %ebp
8010445c:	c3                   	ret    
    return -1;
8010445d:	be ff ff ff ff       	mov    $0xffffffff,%esi
80104462:	eb ef                	jmp    80104453 <clone+0x103>
80104464:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010446b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010446f:	90                   	nop

80104470 <join>:

int 
join(int tid)
{
80104470:	f3 0f 1e fb          	endbr32 
80104474:	55                   	push   %ebp
80104475:	89 e5                	mov    %esp,%ebp
80104477:	57                   	push   %edi
80104478:	56                   	push   %esi
80104479:	53                   	push   %ebx
8010447a:	83 ec 18             	sub    $0x18,%esp
8010447d:	8b 75 08             	mov    0x8(%ebp),%esi
  // cprintf("in join, stack pointer = %p\n", *stack);
  struct proc *curproc = proc;
80104480:	65 8b 3d 04 00 00 00 	mov    %gs:0x4,%edi
  
  acquire(&ptable.lock);
80104487:	68 e0 18 11 80       	push   $0x801118e0
8010448c:	e8 bf 00 00 00       	call   80104550 <acquire>
80104491:	83 c4 10             	add    $0x10,%esp
  struct proc *p;
  int havekids;
  while (1)
  {
    // scan through table looking for zombie children
    havekids = 0;
80104494:	31 c0                	xor    %eax,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104496:	bb 14 19 11 80       	mov    $0x80111914,%ebx
8010449b:	eb 16                	jmp    801044b3 <join+0x43>
8010449d:	8d 76 00             	lea    0x0(%esi),%esi
    {
      if (p->pid != tid) //判定是否自己的子线程
        continue;

      havekids = 1;
801044a0:	b8 01 00 00 00       	mov    $0x1,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044a5:	81 c3 84 00 00 00    	add    $0x84,%ebx
801044ab:	81 fb 14 3a 11 80    	cmp    $0x80113a14,%ebx
801044b1:	74 45                	je     801044f8 <join+0x88>
      if (p->pid != tid) //判定是否自己的子线程
801044b3:	39 73 10             	cmp    %esi,0x10(%ebx)
801044b6:	75 ed                	jne    801044a5 <join+0x35>
      if (p->state == ZOMBIE)
801044b8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801044bc:	75 e2                	jne    801044a0 <join+0x30>
      {
        cprintf("let's free");
801044be:	83 ec 0c             	sub    $0xc,%esp
801044c1:	68 9f 78 10 80       	push   $0x8010789f
801044c6:	e8 d5 c1 ff ff       	call   801006a0 <cprintf>
        kfree(p->kstack); //释放内核栈
801044cb:	5a                   	pop    %edx
801044cc:	ff 73 08             	pushl  0x8(%ebx)
801044cf:	e8 ac df ff ff       	call   80102480 <kfree>
        p->state = UNUSED;
        release(&ptable.lock);
801044d4:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
        p->state = UNUSED;
801044db:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801044e2:	e8 49 02 00 00       	call   80104730 <release>
        return tid;
801044e7:	83 c4 10             	add    $0x10,%esp
801044ea:	89 f0                	mov    %esi,%eax
    }
    // Wait for children to exit
    sleep(curproc, &ptable.lock);
  }
  return 0;
}
801044ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044ef:	5b                   	pop    %ebx
801044f0:	5e                   	pop    %esi
801044f1:	5f                   	pop    %edi
801044f2:	5d                   	pop    %ebp
801044f3:	c3                   	ret    
801044f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (!havekids || curproc->killed)
801044f8:	85 c0                	test   %eax,%eax
801044fa:	74 1d                	je     80104519 <join+0xa9>
801044fc:	8b 47 24             	mov    0x24(%edi),%eax
801044ff:	85 c0                	test   %eax,%eax
80104501:	75 16                	jne    80104519 <join+0xa9>
    sleep(curproc, &ptable.lock);
80104503:	83 ec 08             	sub    $0x8,%esp
80104506:	68 e0 18 11 80       	push   $0x801118e0
8010450b:	57                   	push   %edi
8010450c:	e8 9f fa ff ff       	call   80103fb0 <sleep>
    havekids = 0;
80104511:	83 c4 10             	add    $0x10,%esp
80104514:	e9 7b ff ff ff       	jmp    80104494 <join+0x24>
      release(&ptable.lock);
80104519:	83 ec 0c             	sub    $0xc,%esp
8010451c:	68 e0 18 11 80       	push   $0x801118e0
80104521:	e8 0a 02 00 00       	call   80104730 <release>
      return -1;
80104526:	83 c4 10             	add    $0x10,%esp
80104529:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010452e:	eb bc                	jmp    801044ec <join+0x7c>

80104530 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104530:	f3 0f 1e fb          	endbr32 
80104534:	55                   	push   %ebp
80104535:	89 e5                	mov    %esp,%ebp
80104537:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
8010453a:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
8010453d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104543:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104546:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
8010454d:	5d                   	pop    %ebp
8010454e:	c3                   	ret    
8010454f:	90                   	nop

80104550 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104550:	f3 0f 1e fb          	endbr32 
80104554:	55                   	push   %ebp
80104555:	89 e5                	mov    %esp,%ebp
80104557:	53                   	push   %ebx
80104558:	83 ec 04             	sub    $0x4,%esp
8010455b:	9c                   	pushf  
8010455c:	5a                   	pop    %edx
  asm volatile("cli");
8010455d:	fa                   	cli    
{
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
8010455e:	65 8b 0d 00 00 00 00 	mov    %gs:0x0,%ecx
80104565:	8b 81 ac 00 00 00    	mov    0xac(%ecx),%eax
8010456b:	85 c0                	test   %eax,%eax
8010456d:	75 0c                	jne    8010457b <acquire+0x2b>
    cpu->intena = eflags & FL_IF;
8010456f:	81 e2 00 02 00 00    	and    $0x200,%edx
80104575:	89 91 b0 00 00 00    	mov    %edx,0xb0(%ecx)
  if(holding(lk))
8010457b:	8b 55 08             	mov    0x8(%ebp),%edx
  cpu->ncli += 1;
8010457e:	83 c0 01             	add    $0x1,%eax
80104581:	89 81 ac 00 00 00    	mov    %eax,0xac(%ecx)
  return lock->locked && lock->cpu == cpu;
80104587:	8b 02                	mov    (%edx),%eax
80104589:	85 c0                	test   %eax,%eax
8010458b:	74 05                	je     80104592 <acquire+0x42>
8010458d:	39 4a 08             	cmp    %ecx,0x8(%edx)
80104590:	74 76                	je     80104608 <acquire+0xb8>
  asm volatile("lock; xchgl %0, %1" :
80104592:	b9 01 00 00 00       	mov    $0x1,%ecx
80104597:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010459e:	66 90                	xchg   %ax,%ax
801045a0:	89 c8                	mov    %ecx,%eax
801045a2:	f0 87 02             	lock xchg %eax,(%edx)
  while(xchg(&lk->locked, 1) != 0)
801045a5:	85 c0                	test   %eax,%eax
801045a7:	75 f7                	jne    801045a0 <acquire+0x50>
  __sync_synchronize();
801045a9:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  ebp = (uint*)v - 2;
801045ae:	89 ea                	mov    %ebp,%edx
  lk->cpu = cpu;
801045b0:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801045b6:	8b 4d 08             	mov    0x8(%ebp),%ecx
801045b9:	89 41 08             	mov    %eax,0x8(%ecx)
  for(i = 0; i < 10; i++){
801045bc:	31 c0                	xor    %eax,%eax
801045be:	66 90                	xchg   %ax,%ax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801045c0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801045c6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801045cc:	77 1a                	ja     801045e8 <acquire+0x98>
    pcs[i] = ebp[1];     // saved %eip
801045ce:	8b 5a 04             	mov    0x4(%edx),%ebx
801045d1:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
801045d5:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
801045d8:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
801045da:	83 f8 0a             	cmp    $0xa,%eax
801045dd:	75 e1                	jne    801045c0 <acquire+0x70>
}
801045df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045e2:	c9                   	leave  
801045e3:	c3                   	ret    
801045e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
801045e8:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
801045ec:	83 c1 34             	add    $0x34,%ecx
801045ef:	90                   	nop
    pcs[i] = 0;
801045f0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801045f6:	83 c0 04             	add    $0x4,%eax
801045f9:	39 c8                	cmp    %ecx,%eax
801045fb:	75 f3                	jne    801045f0 <acquire+0xa0>
}
801045fd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104600:	c9                   	leave  
80104601:	c3                   	ret    
80104602:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("acquire");
80104608:	83 ec 0c             	sub    $0xc,%esp
8010460b:	68 ec 78 10 80       	push   $0x801078ec
80104610:	e8 6b bd ff ff       	call   80100380 <panic>
80104615:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010461c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104620 <getcallerpcs>:
{
80104620:	f3 0f 1e fb          	endbr32 
80104624:	55                   	push   %ebp
  for(i = 0; i < 10; i++){
80104625:	31 d2                	xor    %edx,%edx
{
80104627:	89 e5                	mov    %esp,%ebp
80104629:	53                   	push   %ebx
  ebp = (uint*)v - 2;
8010462a:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010462d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104630:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80104633:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104637:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104638:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
8010463e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104644:	77 1a                	ja     80104660 <getcallerpcs+0x40>
    pcs[i] = ebp[1];     // saved %eip
80104646:	8b 58 04             	mov    0x4(%eax),%ebx
80104649:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
8010464c:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
8010464f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104651:	83 fa 0a             	cmp    $0xa,%edx
80104654:	75 e2                	jne    80104638 <getcallerpcs+0x18>
}
80104656:	5b                   	pop    %ebx
80104657:	5d                   	pop    %ebp
80104658:	c3                   	ret    
80104659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104660:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104663:	8d 51 28             	lea    0x28(%ecx),%edx
80104666:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010466d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104670:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104676:	83 c0 04             	add    $0x4,%eax
80104679:	39 d0                	cmp    %edx,%eax
8010467b:	75 f3                	jne    80104670 <getcallerpcs+0x50>
}
8010467d:	5b                   	pop    %ebx
8010467e:	5d                   	pop    %ebp
8010467f:	c3                   	ret    

80104680 <holding>:
{
80104680:	f3 0f 1e fb          	endbr32 
80104684:	55                   	push   %ebp
80104685:	89 e5                	mov    %esp,%ebp
80104687:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu;
8010468a:	8b 02                	mov    (%edx),%eax
8010468c:	85 c0                	test   %eax,%eax
8010468e:	74 18                	je     801046a8 <holding+0x28>
80104690:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104696:	39 42 08             	cmp    %eax,0x8(%edx)
80104699:	0f 94 c0             	sete   %al
}
8010469c:	5d                   	pop    %ebp
  return lock->locked && lock->cpu == cpu;
8010469d:	0f b6 c0             	movzbl %al,%eax
}
801046a0:	c3                   	ret    
801046a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046a8:	31 c0                	xor    %eax,%eax
801046aa:	5d                   	pop    %ebp
801046ab:	c3                   	ret    
801046ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046b0 <pushcli>:
{
801046b0:	f3 0f 1e fb          	endbr32 
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801046b4:	9c                   	pushf  
801046b5:	59                   	pop    %ecx
  asm volatile("cli");
801046b6:	fa                   	cli    
  if(cpu->ncli == 0)
801046b7:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801046be:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
801046c4:	85 c0                	test   %eax,%eax
801046c6:	75 0c                	jne    801046d4 <pushcli+0x24>
    cpu->intena = eflags & FL_IF;
801046c8:	81 e1 00 02 00 00    	and    $0x200,%ecx
801046ce:	89 8a b0 00 00 00    	mov    %ecx,0xb0(%edx)
  cpu->ncli += 1;
801046d4:	83 c0 01             	add    $0x1,%eax
801046d7:	89 82 ac 00 00 00    	mov    %eax,0xac(%edx)
}
801046dd:	c3                   	ret    
801046de:	66 90                	xchg   %ax,%ax

801046e0 <popcli>:

void
popcli(void)
{
801046e0:	f3 0f 1e fb          	endbr32 
801046e4:	55                   	push   %ebp
801046e5:	89 e5                	mov    %esp,%ebp
801046e7:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801046ea:	9c                   	pushf  
801046eb:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801046ec:	f6 c4 02             	test   $0x2,%ah
801046ef:	75 2c                	jne    8010471d <popcli+0x3d>
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
801046f1:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801046f8:	83 aa ac 00 00 00 01 	subl   $0x1,0xac(%edx)
801046ff:	78 0f                	js     80104710 <popcli+0x30>
    panic("popcli");
  if(cpu->ncli == 0 && cpu->intena)
80104701:	75 0b                	jne    8010470e <popcli+0x2e>
80104703:	8b 82 b0 00 00 00    	mov    0xb0(%edx),%eax
80104709:	85 c0                	test   %eax,%eax
8010470b:	74 01                	je     8010470e <popcli+0x2e>
  asm volatile("sti");
8010470d:	fb                   	sti    
    sti();
}
8010470e:	c9                   	leave  
8010470f:	c3                   	ret    
    panic("popcli");
80104710:	83 ec 0c             	sub    $0xc,%esp
80104713:	68 0b 79 10 80       	push   $0x8010790b
80104718:	e8 63 bc ff ff       	call   80100380 <panic>
    panic("popcli - interruptible");
8010471d:	83 ec 0c             	sub    $0xc,%esp
80104720:	68 f4 78 10 80       	push   $0x801078f4
80104725:	e8 56 bc ff ff       	call   80100380 <panic>
8010472a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104730 <release>:
{
80104730:	f3 0f 1e fb          	endbr32 
80104734:	55                   	push   %ebp
80104735:	89 e5                	mov    %esp,%ebp
80104737:	83 ec 08             	sub    $0x8,%esp
8010473a:	8b 45 08             	mov    0x8(%ebp),%eax
  return lock->locked && lock->cpu == cpu;
8010473d:	8b 10                	mov    (%eax),%edx
8010473f:	85 d2                	test   %edx,%edx
80104741:	74 0c                	je     8010474f <release+0x1f>
80104743:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010474a:	39 50 08             	cmp    %edx,0x8(%eax)
8010474d:	74 11                	je     80104760 <release+0x30>
    panic("release");
8010474f:	83 ec 0c             	sub    $0xc,%esp
80104752:	68 12 79 10 80       	push   $0x80107912
80104757:	e8 24 bc ff ff       	call   80100380 <panic>
8010475c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  lk->pcs[0] = 0;
80104760:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104767:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  __sync_synchronize();
8010476e:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->locked = 0;
80104773:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
80104779:	c9                   	leave  
  popcli();
8010477a:	e9 61 ff ff ff       	jmp    801046e0 <popcli>
8010477f:	90                   	nop

80104780 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104780:	f3 0f 1e fb          	endbr32 
80104784:	55                   	push   %ebp
80104785:	89 e5                	mov    %esp,%ebp
80104787:	57                   	push   %edi
80104788:	8b 55 08             	mov    0x8(%ebp),%edx
8010478b:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010478e:	53                   	push   %ebx
8010478f:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
80104792:	89 d7                	mov    %edx,%edi
80104794:	09 cf                	or     %ecx,%edi
80104796:	83 e7 03             	and    $0x3,%edi
80104799:	75 25                	jne    801047c0 <memset+0x40>
    c &= 0xFF;
8010479b:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010479e:	c1 e0 18             	shl    $0x18,%eax
801047a1:	89 fb                	mov    %edi,%ebx
801047a3:	c1 e9 02             	shr    $0x2,%ecx
801047a6:	c1 e3 10             	shl    $0x10,%ebx
801047a9:	09 d8                	or     %ebx,%eax
801047ab:	09 f8                	or     %edi,%eax
801047ad:	c1 e7 08             	shl    $0x8,%edi
801047b0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801047b2:	89 d7                	mov    %edx,%edi
801047b4:	fc                   	cld    
801047b5:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
801047b7:	5b                   	pop    %ebx
801047b8:	89 d0                	mov    %edx,%eax
801047ba:	5f                   	pop    %edi
801047bb:	5d                   	pop    %ebp
801047bc:	c3                   	ret    
801047bd:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("cld; rep stosb" :
801047c0:	89 d7                	mov    %edx,%edi
801047c2:	fc                   	cld    
801047c3:	f3 aa                	rep stos %al,%es:(%edi)
801047c5:	5b                   	pop    %ebx
801047c6:	89 d0                	mov    %edx,%eax
801047c8:	5f                   	pop    %edi
801047c9:	5d                   	pop    %ebp
801047ca:	c3                   	ret    
801047cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801047cf:	90                   	nop

801047d0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801047d0:	f3 0f 1e fb          	endbr32 
801047d4:	55                   	push   %ebp
801047d5:	89 e5                	mov    %esp,%ebp
801047d7:	56                   	push   %esi
801047d8:	8b 75 10             	mov    0x10(%ebp),%esi
801047db:	8b 55 08             	mov    0x8(%ebp),%edx
801047de:	53                   	push   %ebx
801047df:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801047e2:	85 f6                	test   %esi,%esi
801047e4:	74 2a                	je     80104810 <memcmp+0x40>
801047e6:	01 c6                	add    %eax,%esi
801047e8:	eb 10                	jmp    801047fa <memcmp+0x2a>
801047ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
801047f0:	83 c0 01             	add    $0x1,%eax
801047f3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
801047f6:	39 f0                	cmp    %esi,%eax
801047f8:	74 16                	je     80104810 <memcmp+0x40>
    if(*s1 != *s2)
801047fa:	0f b6 0a             	movzbl (%edx),%ecx
801047fd:	0f b6 18             	movzbl (%eax),%ebx
80104800:	38 d9                	cmp    %bl,%cl
80104802:	74 ec                	je     801047f0 <memcmp+0x20>
      return *s1 - *s2;
80104804:	0f b6 c1             	movzbl %cl,%eax
80104807:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104809:	5b                   	pop    %ebx
8010480a:	5e                   	pop    %esi
8010480b:	5d                   	pop    %ebp
8010480c:	c3                   	ret    
8010480d:	8d 76 00             	lea    0x0(%esi),%esi
80104810:	5b                   	pop    %ebx
  return 0;
80104811:	31 c0                	xor    %eax,%eax
}
80104813:	5e                   	pop    %esi
80104814:	5d                   	pop    %ebp
80104815:	c3                   	ret    
80104816:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010481d:	8d 76 00             	lea    0x0(%esi),%esi

80104820 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104820:	f3 0f 1e fb          	endbr32 
80104824:	55                   	push   %ebp
80104825:	89 e5                	mov    %esp,%ebp
80104827:	57                   	push   %edi
80104828:	8b 55 08             	mov    0x8(%ebp),%edx
8010482b:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010482e:	56                   	push   %esi
8010482f:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104832:	39 d6                	cmp    %edx,%esi
80104834:	73 2a                	jae    80104860 <memmove+0x40>
80104836:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104839:	39 fa                	cmp    %edi,%edx
8010483b:	73 23                	jae    80104860 <memmove+0x40>
8010483d:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
80104840:	85 c9                	test   %ecx,%ecx
80104842:	74 13                	je     80104857 <memmove+0x37>
80104844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *--d = *--s;
80104848:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
8010484c:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
8010484f:	83 e8 01             	sub    $0x1,%eax
80104852:	83 f8 ff             	cmp    $0xffffffff,%eax
80104855:	75 f1                	jne    80104848 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104857:	5e                   	pop    %esi
80104858:	89 d0                	mov    %edx,%eax
8010485a:	5f                   	pop    %edi
8010485b:	5d                   	pop    %ebp
8010485c:	c3                   	ret    
8010485d:	8d 76 00             	lea    0x0(%esi),%esi
    while(n-- > 0)
80104860:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80104863:	89 d7                	mov    %edx,%edi
80104865:	85 c9                	test   %ecx,%ecx
80104867:	74 ee                	je     80104857 <memmove+0x37>
80104869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104870:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104871:	39 f0                	cmp    %esi,%eax
80104873:	75 fb                	jne    80104870 <memmove+0x50>
}
80104875:	5e                   	pop    %esi
80104876:	89 d0                	mov    %edx,%eax
80104878:	5f                   	pop    %edi
80104879:	5d                   	pop    %ebp
8010487a:	c3                   	ret    
8010487b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010487f:	90                   	nop

80104880 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104880:	f3 0f 1e fb          	endbr32 
  return memmove(dst, src, n);
80104884:	eb 9a                	jmp    80104820 <memmove>
80104886:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010488d:	8d 76 00             	lea    0x0(%esi),%esi

80104890 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104890:	f3 0f 1e fb          	endbr32 
80104894:	55                   	push   %ebp
80104895:	89 e5                	mov    %esp,%ebp
80104897:	56                   	push   %esi
80104898:	8b 75 10             	mov    0x10(%ebp),%esi
8010489b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010489e:	53                   	push   %ebx
8010489f:	8b 45 0c             	mov    0xc(%ebp),%eax
  while(n > 0 && *p && *p == *q)
801048a2:	85 f6                	test   %esi,%esi
801048a4:	74 32                	je     801048d8 <strncmp+0x48>
801048a6:	01 c6                	add    %eax,%esi
801048a8:	eb 14                	jmp    801048be <strncmp+0x2e>
801048aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048b0:	38 da                	cmp    %bl,%dl
801048b2:	75 14                	jne    801048c8 <strncmp+0x38>
    n--, p++, q++;
801048b4:	83 c0 01             	add    $0x1,%eax
801048b7:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801048ba:	39 f0                	cmp    %esi,%eax
801048bc:	74 1a                	je     801048d8 <strncmp+0x48>
801048be:	0f b6 11             	movzbl (%ecx),%edx
801048c1:	0f b6 18             	movzbl (%eax),%ebx
801048c4:	84 d2                	test   %dl,%dl
801048c6:	75 e8                	jne    801048b0 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801048c8:	0f b6 c2             	movzbl %dl,%eax
801048cb:	29 d8                	sub    %ebx,%eax
}
801048cd:	5b                   	pop    %ebx
801048ce:	5e                   	pop    %esi
801048cf:	5d                   	pop    %ebp
801048d0:	c3                   	ret    
801048d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048d8:	5b                   	pop    %ebx
    return 0;
801048d9:	31 c0                	xor    %eax,%eax
}
801048db:	5e                   	pop    %esi
801048dc:	5d                   	pop    %ebp
801048dd:	c3                   	ret    
801048de:	66 90                	xchg   %ax,%ax

801048e0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801048e0:	f3 0f 1e fb          	endbr32 
801048e4:	55                   	push   %ebp
801048e5:	89 e5                	mov    %esp,%ebp
801048e7:	57                   	push   %edi
801048e8:	56                   	push   %esi
801048e9:	8b 75 08             	mov    0x8(%ebp),%esi
801048ec:	53                   	push   %ebx
801048ed:	8b 45 10             	mov    0x10(%ebp),%eax
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801048f0:	89 f2                	mov    %esi,%edx
801048f2:	eb 1b                	jmp    8010490f <strncpy+0x2f>
801048f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048f8:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
801048fc:	8b 7d 0c             	mov    0xc(%ebp),%edi
801048ff:	83 c2 01             	add    $0x1,%edx
80104902:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80104906:	89 f9                	mov    %edi,%ecx
80104908:	88 4a ff             	mov    %cl,-0x1(%edx)
8010490b:	84 c9                	test   %cl,%cl
8010490d:	74 09                	je     80104918 <strncpy+0x38>
8010490f:	89 c3                	mov    %eax,%ebx
80104911:	83 e8 01             	sub    $0x1,%eax
80104914:	85 db                	test   %ebx,%ebx
80104916:	7f e0                	jg     801048f8 <strncpy+0x18>
    ;
  while(n-- > 0)
80104918:	89 d1                	mov    %edx,%ecx
8010491a:	85 c0                	test   %eax,%eax
8010491c:	7e 15                	jle    80104933 <strncpy+0x53>
8010491e:	66 90                	xchg   %ax,%ax
    *s++ = 0;
80104920:	83 c1 01             	add    $0x1,%ecx
80104923:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
  while(n-- > 0)
80104927:	89 c8                	mov    %ecx,%eax
80104929:	f7 d0                	not    %eax
8010492b:	01 d0                	add    %edx,%eax
8010492d:	01 d8                	add    %ebx,%eax
8010492f:	85 c0                	test   %eax,%eax
80104931:	7f ed                	jg     80104920 <strncpy+0x40>
  return os;
}
80104933:	5b                   	pop    %ebx
80104934:	89 f0                	mov    %esi,%eax
80104936:	5e                   	pop    %esi
80104937:	5f                   	pop    %edi
80104938:	5d                   	pop    %ebp
80104939:	c3                   	ret    
8010493a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104940 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104940:	f3 0f 1e fb          	endbr32 
80104944:	55                   	push   %ebp
80104945:	89 e5                	mov    %esp,%ebp
80104947:	56                   	push   %esi
80104948:	8b 55 10             	mov    0x10(%ebp),%edx
8010494b:	8b 75 08             	mov    0x8(%ebp),%esi
8010494e:	53                   	push   %ebx
8010494f:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104952:	85 d2                	test   %edx,%edx
80104954:	7e 21                	jle    80104977 <safestrcpy+0x37>
80104956:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
8010495a:	89 f2                	mov    %esi,%edx
8010495c:	eb 12                	jmp    80104970 <safestrcpy+0x30>
8010495e:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104960:	0f b6 08             	movzbl (%eax),%ecx
80104963:	83 c0 01             	add    $0x1,%eax
80104966:	83 c2 01             	add    $0x1,%edx
80104969:	88 4a ff             	mov    %cl,-0x1(%edx)
8010496c:	84 c9                	test   %cl,%cl
8010496e:	74 04                	je     80104974 <safestrcpy+0x34>
80104970:	39 d8                	cmp    %ebx,%eax
80104972:	75 ec                	jne    80104960 <safestrcpy+0x20>
    ;
  *s = 0;
80104974:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104977:	89 f0                	mov    %esi,%eax
80104979:	5b                   	pop    %ebx
8010497a:	5e                   	pop    %esi
8010497b:	5d                   	pop    %ebp
8010497c:	c3                   	ret    
8010497d:	8d 76 00             	lea    0x0(%esi),%esi

80104980 <strlen>:

int
strlen(const char *s)
{
80104980:	f3 0f 1e fb          	endbr32 
80104984:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104985:	31 c0                	xor    %eax,%eax
{
80104987:	89 e5                	mov    %esp,%ebp
80104989:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
8010498c:	80 3a 00             	cmpb   $0x0,(%edx)
8010498f:	74 10                	je     801049a1 <strlen+0x21>
80104991:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104998:	83 c0 01             	add    $0x1,%eax
8010499b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
8010499f:	75 f7                	jne    80104998 <strlen+0x18>
    ;
  return n;
}
801049a1:	5d                   	pop    %ebp
801049a2:	c3                   	ret    

801049a3 <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
801049a3:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801049a7:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
801049ab:	55                   	push   %ebp
  pushl %ebx
801049ac:	53                   	push   %ebx
  pushl %esi
801049ad:	56                   	push   %esi
  pushl %edi
801049ae:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801049af:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801049b1:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
801049b3:	5f                   	pop    %edi
  popl %esi
801049b4:	5e                   	pop    %esi
  popl %ebx
801049b5:	5b                   	pop    %ebx
  popl %ebp
801049b6:	5d                   	pop    %ebp
  ret
801049b7:	c3                   	ret    
801049b8:	66 90                	xchg   %ax,%ax
801049ba:	66 90                	xchg   %ax,%ax
801049bc:	66 90                	xchg   %ax,%ax
801049be:	66 90                	xchg   %ax,%ax

801049c0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801049c0:	f3 0f 1e fb          	endbr32 
801049c4:	55                   	push   %ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
801049c5:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801049cc:	8b 12                	mov    (%edx),%edx
{
801049ce:	89 e5                	mov    %esp,%ebp
801049d0:	8b 45 08             	mov    0x8(%ebp),%eax
  if(addr >= proc->sz || addr+4 > proc->sz)
801049d3:	39 c2                	cmp    %eax,%edx
801049d5:	76 19                	jbe    801049f0 <fetchint+0x30>
801049d7:	8d 48 04             	lea    0x4(%eax),%ecx
801049da:	39 ca                	cmp    %ecx,%edx
801049dc:	72 12                	jb     801049f0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801049de:	8b 10                	mov    (%eax),%edx
801049e0:	8b 45 0c             	mov    0xc(%ebp),%eax
801049e3:	89 10                	mov    %edx,(%eax)
  return 0;
801049e5:	31 c0                	xor    %eax,%eax
}
801049e7:	5d                   	pop    %ebp
801049e8:	c3                   	ret    
801049e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801049f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801049f5:	5d                   	pop    %ebp
801049f6:	c3                   	ret    
801049f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049fe:	66 90                	xchg   %ax,%ax

80104a00 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104a00:	f3 0f 1e fb          	endbr32 
80104a04:	55                   	push   %ebp
  char *s, *ep;

  if(addr >= proc->sz)
80104a05:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
80104a0b:	89 e5                	mov    %esp,%ebp
80104a0d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(addr >= proc->sz)
80104a10:	39 08                	cmp    %ecx,(%eax)
80104a12:	76 2c                	jbe    80104a40 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80104a14:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a17:	89 08                	mov    %ecx,(%eax)
  ep = (char*)proc->sz;
80104a19:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a1f:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++)
80104a21:	39 d1                	cmp    %edx,%ecx
80104a23:	73 1b                	jae    80104a40 <fetchstr+0x40>
80104a25:	89 c8                	mov    %ecx,%eax
80104a27:	eb 0e                	jmp    80104a37 <fetchstr+0x37>
80104a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a30:	83 c0 01             	add    $0x1,%eax
80104a33:	39 c2                	cmp    %eax,%edx
80104a35:	76 09                	jbe    80104a40 <fetchstr+0x40>
    if(*s == 0)
80104a37:	80 38 00             	cmpb   $0x0,(%eax)
80104a3a:	75 f4                	jne    80104a30 <fetchstr+0x30>
      return s - *pp;
80104a3c:	29 c8                	sub    %ecx,%eax
  return -1;
}
80104a3e:	5d                   	pop    %ebp
80104a3f:	c3                   	ret    
    return -1;
80104a40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a45:	5d                   	pop    %ebp
80104a46:	c3                   	ret    
80104a47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a4e:	66 90                	xchg   %ax,%ax

80104a50 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104a50:	f3 0f 1e fb          	endbr32 
80104a54:	55                   	push   %ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104a55:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104a5c:	8b 42 18             	mov    0x18(%edx),%eax
  if(addr >= proc->sz || addr+4 > proc->sz)
80104a5f:	8b 12                	mov    (%edx),%edx
{
80104a61:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104a63:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104a66:	8b 40 44             	mov    0x44(%eax),%eax
80104a69:	8d 04 88             	lea    (%eax,%ecx,4),%eax
80104a6c:	8d 48 04             	lea    0x4(%eax),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104a6f:	39 d1                	cmp    %edx,%ecx
80104a71:	73 1d                	jae    80104a90 <argint+0x40>
80104a73:	8d 48 08             	lea    0x8(%eax),%ecx
80104a76:	39 ca                	cmp    %ecx,%edx
80104a78:	72 16                	jb     80104a90 <argint+0x40>
  *ip = *(int*)(addr);
80104a7a:	8b 50 04             	mov    0x4(%eax),%edx
80104a7d:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a80:	89 10                	mov    %edx,(%eax)
  return 0;
80104a82:	31 c0                	xor    %eax,%eax
}
80104a84:	5d                   	pop    %ebp
80104a85:	c3                   	ret    
80104a86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a8d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104a90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a95:	5d                   	pop    %ebp
80104a96:	c3                   	ret    
80104a97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a9e:	66 90                	xchg   %ax,%ax

80104aa0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104aa0:	f3 0f 1e fb          	endbr32 
80104aa4:	55                   	push   %ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104aa5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104aab:	8b 50 18             	mov    0x18(%eax),%edx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104aae:	8b 00                	mov    (%eax),%eax
{
80104ab0:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104ab2:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104ab5:	8b 52 44             	mov    0x44(%edx),%edx
80104ab8:	8d 14 8a             	lea    (%edx,%ecx,4),%edx
80104abb:	8d 4a 04             	lea    0x4(%edx),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104abe:	39 c1                	cmp    %eax,%ecx
80104ac0:	73 26                	jae    80104ae8 <argptr+0x48>
80104ac2:	8d 4a 08             	lea    0x8(%edx),%ecx
80104ac5:	39 c8                	cmp    %ecx,%eax
80104ac7:	72 1f                	jb     80104ae8 <argptr+0x48>
  *ip = *(int*)(addr);
80104ac9:	8b 52 04             	mov    0x4(%edx),%edx
  int i;

  if(argint(n, &i) < 0)
    return -1;
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
80104acc:	39 c2                	cmp    %eax,%edx
80104ace:	73 18                	jae    80104ae8 <argptr+0x48>
80104ad0:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104ad3:	01 d1                	add    %edx,%ecx
80104ad5:	39 c1                	cmp    %eax,%ecx
80104ad7:	77 0f                	ja     80104ae8 <argptr+0x48>
    return -1;
  *pp = (char*)i;
80104ad9:	8b 45 0c             	mov    0xc(%ebp),%eax
80104adc:	89 10                	mov    %edx,(%eax)
  return 0;
80104ade:	31 c0                	xor    %eax,%eax
}
80104ae0:	5d                   	pop    %ebp
80104ae1:	c3                   	ret    
80104ae2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104ae8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104aed:	5d                   	pop    %ebp
80104aee:	c3                   	ret    
80104aef:	90                   	nop

80104af0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104af0:	f3 0f 1e fb          	endbr32 
80104af4:	55                   	push   %ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104af5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104afb:	8b 50 18             	mov    0x18(%eax),%edx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104afe:	8b 00                	mov    (%eax),%eax
{
80104b00:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104b02:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104b05:	8b 52 44             	mov    0x44(%edx),%edx
80104b08:	8d 14 8a             	lea    (%edx,%ecx,4),%edx
80104b0b:	8d 4a 04             	lea    0x4(%edx),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104b0e:	39 c1                	cmp    %eax,%ecx
80104b10:	73 3e                	jae    80104b50 <argstr+0x60>
80104b12:	8d 4a 08             	lea    0x8(%edx),%ecx
80104b15:	39 c8                	cmp    %ecx,%eax
80104b17:	72 37                	jb     80104b50 <argstr+0x60>
  *ip = *(int*)(addr);
80104b19:	8b 4a 04             	mov    0x4(%edx),%ecx
  if(addr >= proc->sz)
80104b1c:	39 c1                	cmp    %eax,%ecx
80104b1e:	73 30                	jae    80104b50 <argstr+0x60>
  *pp = (char*)addr;
80104b20:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b23:	89 08                	mov    %ecx,(%eax)
  ep = (char*)proc->sz;
80104b25:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b2b:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++)
80104b2d:	39 d1                	cmp    %edx,%ecx
80104b2f:	73 1f                	jae    80104b50 <argstr+0x60>
80104b31:	89 c8                	mov    %ecx,%eax
80104b33:	eb 0a                	jmp    80104b3f <argstr+0x4f>
80104b35:	8d 76 00             	lea    0x0(%esi),%esi
80104b38:	83 c0 01             	add    $0x1,%eax
80104b3b:	39 c2                	cmp    %eax,%edx
80104b3d:	76 11                	jbe    80104b50 <argstr+0x60>
    if(*s == 0)
80104b3f:	80 38 00             	cmpb   $0x0,(%eax)
80104b42:	75 f4                	jne    80104b38 <argstr+0x48>
      return s - *pp;
80104b44:	29 c8                	sub    %ecx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104b46:	5d                   	pop    %ebp
80104b47:	c3                   	ret    
80104b48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b4f:	90                   	nop
    return -1;
80104b50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b55:	5d                   	pop    %ebp
80104b56:	c3                   	ret    
80104b57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b5e:	66 90                	xchg   %ax,%ax

80104b60 <syscall>:
[SYS_join]    sys_join,
};

void
syscall(void)
{
80104b60:	f3 0f 1e fb          	endbr32 
80104b64:	55                   	push   %ebp
80104b65:	89 e5                	mov    %esp,%ebp
80104b67:	83 ec 08             	sub    $0x8,%esp
  int num;

  num = proc->tf->eax;
80104b6a:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104b71:	8b 42 18             	mov    0x18(%edx),%eax
80104b74:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104b77:	8d 48 ff             	lea    -0x1(%eax),%ecx
80104b7a:	83 f9 16             	cmp    $0x16,%ecx
80104b7d:	77 21                	ja     80104ba0 <syscall+0x40>
80104b7f:	8b 0c 85 40 79 10 80 	mov    -0x7fef86c0(,%eax,4),%ecx
80104b86:	85 c9                	test   %ecx,%ecx
80104b88:	74 16                	je     80104ba0 <syscall+0x40>
    proc->tf->eax = syscalls[num]();
80104b8a:	ff d1                	call   *%ecx
80104b8c:	89 c2                	mov    %eax,%edx
80104b8e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b94:	8b 40 18             	mov    0x18(%eax),%eax
80104b97:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  }
}
80104b9a:	c9                   	leave  
80104b9b:	c3                   	ret    
80104b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104ba0:	50                   	push   %eax
            proc->pid, proc->name, num);
80104ba1:	8d 42 6c             	lea    0x6c(%edx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104ba4:	50                   	push   %eax
80104ba5:	ff 72 10             	pushl  0x10(%edx)
80104ba8:	68 1a 79 10 80       	push   $0x8010791a
80104bad:	e8 ee ba ff ff       	call   801006a0 <cprintf>
    proc->tf->eax = -1;
80104bb2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bb8:	83 c4 10             	add    $0x10,%esp
80104bbb:	8b 40 18             	mov    0x18(%eax),%eax
80104bbe:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104bc5:	c9                   	leave  
80104bc6:	c3                   	ret    
80104bc7:	66 90                	xchg   %ax,%ax
80104bc9:	66 90                	xchg   %ax,%ax
80104bcb:	66 90                	xchg   %ax,%ax
80104bcd:	66 90                	xchg   %ax,%ax
80104bcf:	90                   	nop

80104bd0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	57                   	push   %edi
80104bd4:	56                   	push   %esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104bd5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104bd8:	53                   	push   %ebx
80104bd9:	83 ec 44             	sub    $0x44,%esp
80104bdc:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104bdf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104be2:	57                   	push   %edi
80104be3:	50                   	push   %eax
{
80104be4:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104be7:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104bea:	e8 51 d4 ff ff       	call   80102040 <nameiparent>
80104bef:	83 c4 10             	add    $0x10,%esp
80104bf2:	85 c0                	test   %eax,%eax
80104bf4:	0f 84 46 01 00 00    	je     80104d40 <create+0x170>
    return 0;
  ilock(dp);
80104bfa:	83 ec 0c             	sub    $0xc,%esp
80104bfd:	89 c3                	mov    %eax,%ebx
80104bff:	50                   	push   %eax
80104c00:	e8 0b cb ff ff       	call   80101710 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104c05:	83 c4 0c             	add    $0xc,%esp
80104c08:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104c0b:	50                   	push   %eax
80104c0c:	57                   	push   %edi
80104c0d:	53                   	push   %ebx
80104c0e:	e8 8d d0 ff ff       	call   80101ca0 <dirlookup>
80104c13:	83 c4 10             	add    $0x10,%esp
80104c16:	89 c6                	mov    %eax,%esi
80104c18:	85 c0                	test   %eax,%eax
80104c1a:	74 54                	je     80104c70 <create+0xa0>
    iunlockput(dp);
80104c1c:	83 ec 0c             	sub    $0xc,%esp
80104c1f:	53                   	push   %ebx
80104c20:	e8 cb cd ff ff       	call   801019f0 <iunlockput>
    ilock(ip);
80104c25:	89 34 24             	mov    %esi,(%esp)
80104c28:	e8 e3 ca ff ff       	call   80101710 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104c2d:	83 c4 10             	add    $0x10,%esp
80104c30:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104c35:	75 19                	jne    80104c50 <create+0x80>
80104c37:	66 83 7e 10 02       	cmpw   $0x2,0x10(%esi)
80104c3c:	75 12                	jne    80104c50 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104c3e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c41:	89 f0                	mov    %esi,%eax
80104c43:	5b                   	pop    %ebx
80104c44:	5e                   	pop    %esi
80104c45:	5f                   	pop    %edi
80104c46:	5d                   	pop    %ebp
80104c47:	c3                   	ret    
80104c48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c4f:	90                   	nop
    iunlockput(ip);
80104c50:	83 ec 0c             	sub    $0xc,%esp
80104c53:	56                   	push   %esi
    return 0;
80104c54:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80104c56:	e8 95 cd ff ff       	call   801019f0 <iunlockput>
    return 0;
80104c5b:	83 c4 10             	add    $0x10,%esp
}
80104c5e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c61:	89 f0                	mov    %esi,%eax
80104c63:	5b                   	pop    %ebx
80104c64:	5e                   	pop    %esi
80104c65:	5f                   	pop    %edi
80104c66:	5d                   	pop    %ebp
80104c67:	c3                   	ret    
80104c68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c6f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80104c70:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104c74:	83 ec 08             	sub    $0x8,%esp
80104c77:	50                   	push   %eax
80104c78:	ff 33                	pushl  (%ebx)
80104c7a:	e8 11 c9 ff ff       	call   80101590 <ialloc>
80104c7f:	83 c4 10             	add    $0x10,%esp
80104c82:	89 c6                	mov    %eax,%esi
80104c84:	85 c0                	test   %eax,%eax
80104c86:	0f 84 cd 00 00 00    	je     80104d59 <create+0x189>
  ilock(ip);
80104c8c:	83 ec 0c             	sub    $0xc,%esp
80104c8f:	50                   	push   %eax
80104c90:	e8 7b ca ff ff       	call   80101710 <ilock>
  ip->major = major;
80104c95:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104c99:	66 89 46 12          	mov    %ax,0x12(%esi)
  ip->minor = minor;
80104c9d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104ca1:	66 89 46 14          	mov    %ax,0x14(%esi)
  ip->nlink = 1;
80104ca5:	b8 01 00 00 00       	mov    $0x1,%eax
80104caa:	66 89 46 16          	mov    %ax,0x16(%esi)
  iupdate(ip);
80104cae:	89 34 24             	mov    %esi,(%esp)
80104cb1:	e8 9a c9 ff ff       	call   80101650 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104cb6:	83 c4 10             	add    $0x10,%esp
80104cb9:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104cbe:	74 30                	je     80104cf0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104cc0:	83 ec 04             	sub    $0x4,%esp
80104cc3:	ff 76 04             	pushl  0x4(%esi)
80104cc6:	57                   	push   %edi
80104cc7:	53                   	push   %ebx
80104cc8:	e8 93 d2 ff ff       	call   80101f60 <dirlink>
80104ccd:	83 c4 10             	add    $0x10,%esp
80104cd0:	85 c0                	test   %eax,%eax
80104cd2:	78 78                	js     80104d4c <create+0x17c>
  iunlockput(dp);
80104cd4:	83 ec 0c             	sub    $0xc,%esp
80104cd7:	53                   	push   %ebx
80104cd8:	e8 13 cd ff ff       	call   801019f0 <iunlockput>
  return ip;
80104cdd:	83 c4 10             	add    $0x10,%esp
}
80104ce0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ce3:	89 f0                	mov    %esi,%eax
80104ce5:	5b                   	pop    %ebx
80104ce6:	5e                   	pop    %esi
80104ce7:	5f                   	pop    %edi
80104ce8:	5d                   	pop    %ebp
80104ce9:	c3                   	ret    
80104cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104cf0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104cf3:	66 83 43 16 01       	addw   $0x1,0x16(%ebx)
    iupdate(dp);
80104cf8:	53                   	push   %ebx
80104cf9:	e8 52 c9 ff ff       	call   80101650 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104cfe:	83 c4 0c             	add    $0xc,%esp
80104d01:	ff 76 04             	pushl  0x4(%esi)
80104d04:	68 bc 79 10 80       	push   $0x801079bc
80104d09:	56                   	push   %esi
80104d0a:	e8 51 d2 ff ff       	call   80101f60 <dirlink>
80104d0f:	83 c4 10             	add    $0x10,%esp
80104d12:	85 c0                	test   %eax,%eax
80104d14:	78 18                	js     80104d2e <create+0x15e>
80104d16:	83 ec 04             	sub    $0x4,%esp
80104d19:	ff 73 04             	pushl  0x4(%ebx)
80104d1c:	68 bb 79 10 80       	push   $0x801079bb
80104d21:	56                   	push   %esi
80104d22:	e8 39 d2 ff ff       	call   80101f60 <dirlink>
80104d27:	83 c4 10             	add    $0x10,%esp
80104d2a:	85 c0                	test   %eax,%eax
80104d2c:	79 92                	jns    80104cc0 <create+0xf0>
      panic("create dots");
80104d2e:	83 ec 0c             	sub    $0xc,%esp
80104d31:	68 af 79 10 80       	push   $0x801079af
80104d36:	e8 45 b6 ff ff       	call   80100380 <panic>
80104d3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d3f:	90                   	nop
}
80104d40:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104d43:	31 f6                	xor    %esi,%esi
}
80104d45:	5b                   	pop    %ebx
80104d46:	89 f0                	mov    %esi,%eax
80104d48:	5e                   	pop    %esi
80104d49:	5f                   	pop    %edi
80104d4a:	5d                   	pop    %ebp
80104d4b:	c3                   	ret    
    panic("create: dirlink");
80104d4c:	83 ec 0c             	sub    $0xc,%esp
80104d4f:	68 be 79 10 80       	push   $0x801079be
80104d54:	e8 27 b6 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80104d59:	83 ec 0c             	sub    $0xc,%esp
80104d5c:	68 a0 79 10 80       	push   $0x801079a0
80104d61:	e8 1a b6 ff ff       	call   80100380 <panic>
80104d66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d6d:	8d 76 00             	lea    0x0(%esi),%esi

80104d70 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104d70:	55                   	push   %ebp
80104d71:	89 e5                	mov    %esp,%ebp
80104d73:	56                   	push   %esi
80104d74:	89 d6                	mov    %edx,%esi
80104d76:	53                   	push   %ebx
80104d77:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104d79:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104d7c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104d7f:	50                   	push   %eax
80104d80:	6a 00                	push   $0x0
80104d82:	e8 c9 fc ff ff       	call   80104a50 <argint>
80104d87:	83 c4 10             	add    $0x10,%esp
80104d8a:	85 c0                	test   %eax,%eax
80104d8c:	78 32                	js     80104dc0 <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80104d8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d91:	83 f8 0f             	cmp    $0xf,%eax
80104d94:	77 2a                	ja     80104dc0 <argfd.constprop.0+0x50>
80104d96:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104d9d:	8b 54 82 28          	mov    0x28(%edx,%eax,4),%edx
80104da1:	85 d2                	test   %edx,%edx
80104da3:	74 1b                	je     80104dc0 <argfd.constprop.0+0x50>
  if(pfd)
80104da5:	85 db                	test   %ebx,%ebx
80104da7:	74 02                	je     80104dab <argfd.constprop.0+0x3b>
    *pfd = fd;
80104da9:	89 03                	mov    %eax,(%ebx)
    *pf = f;
80104dab:	89 16                	mov    %edx,(%esi)
  return 0;
80104dad:	31 c0                	xor    %eax,%eax
}
80104daf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104db2:	5b                   	pop    %ebx
80104db3:	5e                   	pop    %esi
80104db4:	5d                   	pop    %ebp
80104db5:	c3                   	ret    
80104db6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dbd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104dc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104dc5:	eb e8                	jmp    80104daf <argfd.constprop.0+0x3f>
80104dc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dce:	66 90                	xchg   %ax,%ax

80104dd0 <sys_dup>:
{
80104dd0:	f3 0f 1e fb          	endbr32 
80104dd4:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104dd5:	31 c0                	xor    %eax,%eax
{
80104dd7:	89 e5                	mov    %esp,%ebp
80104dd9:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104dda:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104ddd:	83 ec 14             	sub    $0x14,%esp
  if(argfd(0, 0, &f) < 0)
80104de0:	e8 8b ff ff ff       	call   80104d70 <argfd.constprop.0>
80104de5:	85 c0                	test   %eax,%eax
80104de7:	78 1f                	js     80104e08 <sys_dup+0x38>
  if((fd=fdalloc(f)) < 0)
80104de9:	8b 55 f4             	mov    -0xc(%ebp),%edx
    if(proc->ofile[fd] == 0){
80104dec:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  for(fd = 0; fd < NOFILE; fd++){
80104df2:	31 db                	xor    %ebx,%ebx
80104df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->ofile[fd] == 0){
80104df8:	8b 4c 98 28          	mov    0x28(%eax,%ebx,4),%ecx
80104dfc:	85 c9                	test   %ecx,%ecx
80104dfe:	74 18                	je     80104e18 <sys_dup+0x48>
  for(fd = 0; fd < NOFILE; fd++){
80104e00:	83 c3 01             	add    $0x1,%ebx
80104e03:	83 fb 10             	cmp    $0x10,%ebx
80104e06:	75 f0                	jne    80104df8 <sys_dup+0x28>
    return -1;
80104e08:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104e0d:	89 d8                	mov    %ebx,%eax
80104e0f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e12:	c9                   	leave  
80104e13:	c3                   	ret    
80104e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  filedup(f);
80104e18:	83 ec 0c             	sub    $0xc,%esp
      proc->ofile[fd] = f;
80104e1b:	89 54 98 28          	mov    %edx,0x28(%eax,%ebx,4)
  filedup(f);
80104e1f:	52                   	push   %edx
80104e20:	e8 3b c0 ff ff       	call   80100e60 <filedup>
}
80104e25:	89 d8                	mov    %ebx,%eax
  return fd;
80104e27:	83 c4 10             	add    $0x10,%esp
}
80104e2a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e2d:	c9                   	leave  
80104e2e:	c3                   	ret    
80104e2f:	90                   	nop

80104e30 <sys_read>:
{
80104e30:	f3 0f 1e fb          	endbr32 
80104e34:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e35:	31 c0                	xor    %eax,%eax
{
80104e37:	89 e5                	mov    %esp,%ebp
80104e39:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e3c:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104e3f:	e8 2c ff ff ff       	call   80104d70 <argfd.constprop.0>
80104e44:	85 c0                	test   %eax,%eax
80104e46:	78 48                	js     80104e90 <sys_read+0x60>
80104e48:	83 ec 08             	sub    $0x8,%esp
80104e4b:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e4e:	50                   	push   %eax
80104e4f:	6a 02                	push   $0x2
80104e51:	e8 fa fb ff ff       	call   80104a50 <argint>
80104e56:	83 c4 10             	add    $0x10,%esp
80104e59:	85 c0                	test   %eax,%eax
80104e5b:	78 33                	js     80104e90 <sys_read+0x60>
80104e5d:	83 ec 04             	sub    $0x4,%esp
80104e60:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e63:	ff 75 f0             	pushl  -0x10(%ebp)
80104e66:	50                   	push   %eax
80104e67:	6a 01                	push   $0x1
80104e69:	e8 32 fc ff ff       	call   80104aa0 <argptr>
80104e6e:	83 c4 10             	add    $0x10,%esp
80104e71:	85 c0                	test   %eax,%eax
80104e73:	78 1b                	js     80104e90 <sys_read+0x60>
  return fileread(f, p, n);
80104e75:	83 ec 04             	sub    $0x4,%esp
80104e78:	ff 75 f0             	pushl  -0x10(%ebp)
80104e7b:	ff 75 f4             	pushl  -0xc(%ebp)
80104e7e:	ff 75 ec             	pushl  -0x14(%ebp)
80104e81:	e8 5a c1 ff ff       	call   80100fe0 <fileread>
80104e86:	83 c4 10             	add    $0x10,%esp
}
80104e89:	c9                   	leave  
80104e8a:	c3                   	ret    
80104e8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e8f:	90                   	nop
80104e90:	c9                   	leave  
    return -1;
80104e91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e96:	c3                   	ret    
80104e97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e9e:	66 90                	xchg   %ax,%ax

80104ea0 <sys_write>:
{
80104ea0:	f3 0f 1e fb          	endbr32 
80104ea4:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ea5:	31 c0                	xor    %eax,%eax
{
80104ea7:	89 e5                	mov    %esp,%ebp
80104ea9:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104eac:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104eaf:	e8 bc fe ff ff       	call   80104d70 <argfd.constprop.0>
80104eb4:	85 c0                	test   %eax,%eax
80104eb6:	78 48                	js     80104f00 <sys_write+0x60>
80104eb8:	83 ec 08             	sub    $0x8,%esp
80104ebb:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104ebe:	50                   	push   %eax
80104ebf:	6a 02                	push   $0x2
80104ec1:	e8 8a fb ff ff       	call   80104a50 <argint>
80104ec6:	83 c4 10             	add    $0x10,%esp
80104ec9:	85 c0                	test   %eax,%eax
80104ecb:	78 33                	js     80104f00 <sys_write+0x60>
80104ecd:	83 ec 04             	sub    $0x4,%esp
80104ed0:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ed3:	ff 75 f0             	pushl  -0x10(%ebp)
80104ed6:	50                   	push   %eax
80104ed7:	6a 01                	push   $0x1
80104ed9:	e8 c2 fb ff ff       	call   80104aa0 <argptr>
80104ede:	83 c4 10             	add    $0x10,%esp
80104ee1:	85 c0                	test   %eax,%eax
80104ee3:	78 1b                	js     80104f00 <sys_write+0x60>
  return filewrite(f, p, n);
80104ee5:	83 ec 04             	sub    $0x4,%esp
80104ee8:	ff 75 f0             	pushl  -0x10(%ebp)
80104eeb:	ff 75 f4             	pushl  -0xc(%ebp)
80104eee:	ff 75 ec             	pushl  -0x14(%ebp)
80104ef1:	e8 8a c1 ff ff       	call   80101080 <filewrite>
80104ef6:	83 c4 10             	add    $0x10,%esp
}
80104ef9:	c9                   	leave  
80104efa:	c3                   	ret    
80104efb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104eff:	90                   	nop
80104f00:	c9                   	leave  
    return -1;
80104f01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f06:	c3                   	ret    
80104f07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f0e:	66 90                	xchg   %ax,%ax

80104f10 <sys_close>:
{
80104f10:	f3 0f 1e fb          	endbr32 
80104f14:	55                   	push   %ebp
80104f15:	89 e5                	mov    %esp,%ebp
80104f17:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104f1a:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104f1d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f20:	e8 4b fe ff ff       	call   80104d70 <argfd.constprop.0>
80104f25:	85 c0                	test   %eax,%eax
80104f27:	78 27                	js     80104f50 <sys_close+0x40>
  proc->ofile[fd] = 0;
80104f29:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104f2f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104f32:	83 ec 0c             	sub    $0xc,%esp
  proc->ofile[fd] = 0;
80104f35:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104f3c:	00 
  fileclose(f);
80104f3d:	ff 75 f4             	pushl  -0xc(%ebp)
80104f40:	e8 6b bf ff ff       	call   80100eb0 <fileclose>
  return 0;
80104f45:	83 c4 10             	add    $0x10,%esp
80104f48:	31 c0                	xor    %eax,%eax
}
80104f4a:	c9                   	leave  
80104f4b:	c3                   	ret    
80104f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f50:	c9                   	leave  
    return -1;
80104f51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f56:	c3                   	ret    
80104f57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f5e:	66 90                	xchg   %ax,%ax

80104f60 <sys_fstat>:
{
80104f60:	f3 0f 1e fb          	endbr32 
80104f64:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104f65:	31 c0                	xor    %eax,%eax
{
80104f67:	89 e5                	mov    %esp,%ebp
80104f69:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104f6c:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104f6f:	e8 fc fd ff ff       	call   80104d70 <argfd.constprop.0>
80104f74:	85 c0                	test   %eax,%eax
80104f76:	78 30                	js     80104fa8 <sys_fstat+0x48>
80104f78:	83 ec 04             	sub    $0x4,%esp
80104f7b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f7e:	6a 14                	push   $0x14
80104f80:	50                   	push   %eax
80104f81:	6a 01                	push   $0x1
80104f83:	e8 18 fb ff ff       	call   80104aa0 <argptr>
80104f88:	83 c4 10             	add    $0x10,%esp
80104f8b:	85 c0                	test   %eax,%eax
80104f8d:	78 19                	js     80104fa8 <sys_fstat+0x48>
  return filestat(f, st);
80104f8f:	83 ec 08             	sub    $0x8,%esp
80104f92:	ff 75 f4             	pushl  -0xc(%ebp)
80104f95:	ff 75 f0             	pushl  -0x10(%ebp)
80104f98:	e8 f3 bf ff ff       	call   80100f90 <filestat>
80104f9d:	83 c4 10             	add    $0x10,%esp
}
80104fa0:	c9                   	leave  
80104fa1:	c3                   	ret    
80104fa2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104fa8:	c9                   	leave  
    return -1;
80104fa9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fae:	c3                   	ret    
80104faf:	90                   	nop

80104fb0 <sys_link>:
{
80104fb0:	f3 0f 1e fb          	endbr32 
80104fb4:	55                   	push   %ebp
80104fb5:	89 e5                	mov    %esp,%ebp
80104fb7:	57                   	push   %edi
80104fb8:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104fb9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104fbc:	53                   	push   %ebx
80104fbd:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104fc0:	50                   	push   %eax
80104fc1:	6a 00                	push   $0x0
80104fc3:	e8 28 fb ff ff       	call   80104af0 <argstr>
80104fc8:	83 c4 10             	add    $0x10,%esp
80104fcb:	85 c0                	test   %eax,%eax
80104fcd:	0f 88 ff 00 00 00    	js     801050d2 <sys_link+0x122>
80104fd3:	83 ec 08             	sub    $0x8,%esp
80104fd6:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104fd9:	50                   	push   %eax
80104fda:	6a 01                	push   $0x1
80104fdc:	e8 0f fb ff ff       	call   80104af0 <argstr>
80104fe1:	83 c4 10             	add    $0x10,%esp
80104fe4:	85 c0                	test   %eax,%eax
80104fe6:	0f 88 e6 00 00 00    	js     801050d2 <sys_link+0x122>
  begin_op();
80104fec:	e8 cf dd ff ff       	call   80102dc0 <begin_op>
  if((ip = namei(old)) == 0){
80104ff1:	83 ec 0c             	sub    $0xc,%esp
80104ff4:	ff 75 d4             	pushl  -0x2c(%ebp)
80104ff7:	e8 24 d0 ff ff       	call   80102020 <namei>
80104ffc:	83 c4 10             	add    $0x10,%esp
80104fff:	89 c3                	mov    %eax,%ebx
80105001:	85 c0                	test   %eax,%eax
80105003:	0f 84 e8 00 00 00    	je     801050f1 <sys_link+0x141>
  ilock(ip);
80105009:	83 ec 0c             	sub    $0xc,%esp
8010500c:	50                   	push   %eax
8010500d:	e8 fe c6 ff ff       	call   80101710 <ilock>
  if(ip->type == T_DIR){
80105012:	83 c4 10             	add    $0x10,%esp
80105015:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
8010501a:	0f 84 b9 00 00 00    	je     801050d9 <sys_link+0x129>
  iupdate(ip);
80105020:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80105023:	66 83 43 16 01       	addw   $0x1,0x16(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105028:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
8010502b:	53                   	push   %ebx
8010502c:	e8 1f c6 ff ff       	call   80101650 <iupdate>
  iunlock(ip);
80105031:	89 1c 24             	mov    %ebx,(%esp)
80105034:	e8 e7 c7 ff ff       	call   80101820 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105039:	58                   	pop    %eax
8010503a:	5a                   	pop    %edx
8010503b:	57                   	push   %edi
8010503c:	ff 75 d0             	pushl  -0x30(%ebp)
8010503f:	e8 fc cf ff ff       	call   80102040 <nameiparent>
80105044:	83 c4 10             	add    $0x10,%esp
80105047:	89 c6                	mov    %eax,%esi
80105049:	85 c0                	test   %eax,%eax
8010504b:	74 5f                	je     801050ac <sys_link+0xfc>
  ilock(dp);
8010504d:	83 ec 0c             	sub    $0xc,%esp
80105050:	50                   	push   %eax
80105051:	e8 ba c6 ff ff       	call   80101710 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105056:	8b 03                	mov    (%ebx),%eax
80105058:	83 c4 10             	add    $0x10,%esp
8010505b:	39 06                	cmp    %eax,(%esi)
8010505d:	75 41                	jne    801050a0 <sys_link+0xf0>
8010505f:	83 ec 04             	sub    $0x4,%esp
80105062:	ff 73 04             	pushl  0x4(%ebx)
80105065:	57                   	push   %edi
80105066:	56                   	push   %esi
80105067:	e8 f4 ce ff ff       	call   80101f60 <dirlink>
8010506c:	83 c4 10             	add    $0x10,%esp
8010506f:	85 c0                	test   %eax,%eax
80105071:	78 2d                	js     801050a0 <sys_link+0xf0>
  iunlockput(dp);
80105073:	83 ec 0c             	sub    $0xc,%esp
80105076:	56                   	push   %esi
80105077:	e8 74 c9 ff ff       	call   801019f0 <iunlockput>
  iput(ip);
8010507c:	89 1c 24             	mov    %ebx,(%esp)
8010507f:	e8 fc c7 ff ff       	call   80101880 <iput>
  end_op();
80105084:	e8 a7 dd ff ff       	call   80102e30 <end_op>
  return 0;
80105089:	83 c4 10             	add    $0x10,%esp
8010508c:	31 c0                	xor    %eax,%eax
}
8010508e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105091:	5b                   	pop    %ebx
80105092:	5e                   	pop    %esi
80105093:	5f                   	pop    %edi
80105094:	5d                   	pop    %ebp
80105095:	c3                   	ret    
80105096:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010509d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
801050a0:	83 ec 0c             	sub    $0xc,%esp
801050a3:	56                   	push   %esi
801050a4:	e8 47 c9 ff ff       	call   801019f0 <iunlockput>
    goto bad;
801050a9:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801050ac:	83 ec 0c             	sub    $0xc,%esp
801050af:	53                   	push   %ebx
801050b0:	e8 5b c6 ff ff       	call   80101710 <ilock>
  ip->nlink--;
801050b5:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
801050ba:	89 1c 24             	mov    %ebx,(%esp)
801050bd:	e8 8e c5 ff ff       	call   80101650 <iupdate>
  iunlockput(ip);
801050c2:	89 1c 24             	mov    %ebx,(%esp)
801050c5:	e8 26 c9 ff ff       	call   801019f0 <iunlockput>
  end_op();
801050ca:	e8 61 dd ff ff       	call   80102e30 <end_op>
  return -1;
801050cf:	83 c4 10             	add    $0x10,%esp
801050d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050d7:	eb b5                	jmp    8010508e <sys_link+0xde>
    iunlockput(ip);
801050d9:	83 ec 0c             	sub    $0xc,%esp
801050dc:	53                   	push   %ebx
801050dd:	e8 0e c9 ff ff       	call   801019f0 <iunlockput>
    end_op();
801050e2:	e8 49 dd ff ff       	call   80102e30 <end_op>
    return -1;
801050e7:	83 c4 10             	add    $0x10,%esp
801050ea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050ef:	eb 9d                	jmp    8010508e <sys_link+0xde>
    end_op();
801050f1:	e8 3a dd ff ff       	call   80102e30 <end_op>
    return -1;
801050f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050fb:	eb 91                	jmp    8010508e <sys_link+0xde>
801050fd:	8d 76 00             	lea    0x0(%esi),%esi

80105100 <sys_unlink>:
{
80105100:	f3 0f 1e fb          	endbr32 
80105104:	55                   	push   %ebp
80105105:	89 e5                	mov    %esp,%ebp
80105107:	57                   	push   %edi
80105108:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105109:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
8010510c:	53                   	push   %ebx
8010510d:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80105110:	50                   	push   %eax
80105111:	6a 00                	push   $0x0
80105113:	e8 d8 f9 ff ff       	call   80104af0 <argstr>
80105118:	83 c4 10             	add    $0x10,%esp
8010511b:	85 c0                	test   %eax,%eax
8010511d:	0f 88 7d 01 00 00    	js     801052a0 <sys_unlink+0x1a0>
  begin_op();
80105123:	e8 98 dc ff ff       	call   80102dc0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105128:	8d 5d ca             	lea    -0x36(%ebp),%ebx
8010512b:	83 ec 08             	sub    $0x8,%esp
8010512e:	53                   	push   %ebx
8010512f:	ff 75 c0             	pushl  -0x40(%ebp)
80105132:	e8 09 cf ff ff       	call   80102040 <nameiparent>
80105137:	83 c4 10             	add    $0x10,%esp
8010513a:	89 c6                	mov    %eax,%esi
8010513c:	85 c0                	test   %eax,%eax
8010513e:	0f 84 66 01 00 00    	je     801052aa <sys_unlink+0x1aa>
  ilock(dp);
80105144:	83 ec 0c             	sub    $0xc,%esp
80105147:	50                   	push   %eax
80105148:	e8 c3 c5 ff ff       	call   80101710 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010514d:	58                   	pop    %eax
8010514e:	5a                   	pop    %edx
8010514f:	68 bc 79 10 80       	push   $0x801079bc
80105154:	53                   	push   %ebx
80105155:	e8 26 cb ff ff       	call   80101c80 <namecmp>
8010515a:	83 c4 10             	add    $0x10,%esp
8010515d:	85 c0                	test   %eax,%eax
8010515f:	0f 84 03 01 00 00    	je     80105268 <sys_unlink+0x168>
80105165:	83 ec 08             	sub    $0x8,%esp
80105168:	68 bb 79 10 80       	push   $0x801079bb
8010516d:	53                   	push   %ebx
8010516e:	e8 0d cb ff ff       	call   80101c80 <namecmp>
80105173:	83 c4 10             	add    $0x10,%esp
80105176:	85 c0                	test   %eax,%eax
80105178:	0f 84 ea 00 00 00    	je     80105268 <sys_unlink+0x168>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010517e:	83 ec 04             	sub    $0x4,%esp
80105181:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105184:	50                   	push   %eax
80105185:	53                   	push   %ebx
80105186:	56                   	push   %esi
80105187:	e8 14 cb ff ff       	call   80101ca0 <dirlookup>
8010518c:	83 c4 10             	add    $0x10,%esp
8010518f:	89 c3                	mov    %eax,%ebx
80105191:	85 c0                	test   %eax,%eax
80105193:	0f 84 cf 00 00 00    	je     80105268 <sys_unlink+0x168>
  ilock(ip);
80105199:	83 ec 0c             	sub    $0xc,%esp
8010519c:	50                   	push   %eax
8010519d:	e8 6e c5 ff ff       	call   80101710 <ilock>
  if(ip->nlink < 1)
801051a2:	83 c4 10             	add    $0x10,%esp
801051a5:	66 83 7b 16 00       	cmpw   $0x0,0x16(%ebx)
801051aa:	0f 8e 23 01 00 00    	jle    801052d3 <sys_unlink+0x1d3>
  if(ip->type == T_DIR && !isdirempty(ip)){
801051b0:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
801051b5:	8d 7d d8             	lea    -0x28(%ebp),%edi
801051b8:	74 66                	je     80105220 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801051ba:	83 ec 04             	sub    $0x4,%esp
801051bd:	6a 10                	push   $0x10
801051bf:	6a 00                	push   $0x0
801051c1:	57                   	push   %edi
801051c2:	e8 b9 f5 ff ff       	call   80104780 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801051c7:	6a 10                	push   $0x10
801051c9:	ff 75 c4             	pushl  -0x3c(%ebp)
801051cc:	57                   	push   %edi
801051cd:	56                   	push   %esi
801051ce:	e8 7d c9 ff ff       	call   80101b50 <writei>
801051d3:	83 c4 20             	add    $0x20,%esp
801051d6:	83 f8 10             	cmp    $0x10,%eax
801051d9:	0f 85 e7 00 00 00    	jne    801052c6 <sys_unlink+0x1c6>
  if(ip->type == T_DIR){
801051df:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
801051e4:	0f 84 96 00 00 00    	je     80105280 <sys_unlink+0x180>
  iunlockput(dp);
801051ea:	83 ec 0c             	sub    $0xc,%esp
801051ed:	56                   	push   %esi
801051ee:	e8 fd c7 ff ff       	call   801019f0 <iunlockput>
  ip->nlink--;
801051f3:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
801051f8:	89 1c 24             	mov    %ebx,(%esp)
801051fb:	e8 50 c4 ff ff       	call   80101650 <iupdate>
  iunlockput(ip);
80105200:	89 1c 24             	mov    %ebx,(%esp)
80105203:	e8 e8 c7 ff ff       	call   801019f0 <iunlockput>
  end_op();
80105208:	e8 23 dc ff ff       	call   80102e30 <end_op>
  return 0;
8010520d:	83 c4 10             	add    $0x10,%esp
80105210:	31 c0                	xor    %eax,%eax
}
80105212:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105215:	5b                   	pop    %ebx
80105216:	5e                   	pop    %esi
80105217:	5f                   	pop    %edi
80105218:	5d                   	pop    %ebp
80105219:	c3                   	ret    
8010521a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105220:	83 7b 18 20          	cmpl   $0x20,0x18(%ebx)
80105224:	76 94                	jbe    801051ba <sys_unlink+0xba>
80105226:	ba 20 00 00 00       	mov    $0x20,%edx
8010522b:	eb 0b                	jmp    80105238 <sys_unlink+0x138>
8010522d:	8d 76 00             	lea    0x0(%esi),%esi
80105230:	83 c2 10             	add    $0x10,%edx
80105233:	39 53 18             	cmp    %edx,0x18(%ebx)
80105236:	76 82                	jbe    801051ba <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105238:	6a 10                	push   $0x10
8010523a:	52                   	push   %edx
8010523b:	57                   	push   %edi
8010523c:	53                   	push   %ebx
8010523d:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80105240:	e8 0b c8 ff ff       	call   80101a50 <readi>
80105245:	83 c4 10             	add    $0x10,%esp
80105248:	8b 55 b4             	mov    -0x4c(%ebp),%edx
8010524b:	83 f8 10             	cmp    $0x10,%eax
8010524e:	75 69                	jne    801052b9 <sys_unlink+0x1b9>
    if(de.inum != 0)
80105250:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105255:	74 d9                	je     80105230 <sys_unlink+0x130>
    iunlockput(ip);
80105257:	83 ec 0c             	sub    $0xc,%esp
8010525a:	53                   	push   %ebx
8010525b:	e8 90 c7 ff ff       	call   801019f0 <iunlockput>
    goto bad;
80105260:	83 c4 10             	add    $0x10,%esp
80105263:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105267:	90                   	nop
  iunlockput(dp);
80105268:	83 ec 0c             	sub    $0xc,%esp
8010526b:	56                   	push   %esi
8010526c:	e8 7f c7 ff ff       	call   801019f0 <iunlockput>
  end_op();
80105271:	e8 ba db ff ff       	call   80102e30 <end_op>
  return -1;
80105276:	83 c4 10             	add    $0x10,%esp
80105279:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010527e:	eb 92                	jmp    80105212 <sys_unlink+0x112>
    iupdate(dp);
80105280:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105283:	66 83 6e 16 01       	subw   $0x1,0x16(%esi)
    iupdate(dp);
80105288:	56                   	push   %esi
80105289:	e8 c2 c3 ff ff       	call   80101650 <iupdate>
8010528e:	83 c4 10             	add    $0x10,%esp
80105291:	e9 54 ff ff ff       	jmp    801051ea <sys_unlink+0xea>
80105296:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010529d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801052a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052a5:	e9 68 ff ff ff       	jmp    80105212 <sys_unlink+0x112>
    end_op();
801052aa:	e8 81 db ff ff       	call   80102e30 <end_op>
    return -1;
801052af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052b4:	e9 59 ff ff ff       	jmp    80105212 <sys_unlink+0x112>
      panic("isdirempty: readi");
801052b9:	83 ec 0c             	sub    $0xc,%esp
801052bc:	68 e0 79 10 80       	push   $0x801079e0
801052c1:	e8 ba b0 ff ff       	call   80100380 <panic>
    panic("unlink: writei");
801052c6:	83 ec 0c             	sub    $0xc,%esp
801052c9:	68 f2 79 10 80       	push   $0x801079f2
801052ce:	e8 ad b0 ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
801052d3:	83 ec 0c             	sub    $0xc,%esp
801052d6:	68 ce 79 10 80       	push   $0x801079ce
801052db:	e8 a0 b0 ff ff       	call   80100380 <panic>

801052e0 <sys_open>:

int
sys_open(void)
{
801052e0:	f3 0f 1e fb          	endbr32 
801052e4:	55                   	push   %ebp
801052e5:	89 e5                	mov    %esp,%ebp
801052e7:	57                   	push   %edi
801052e8:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801052e9:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801052ec:	53                   	push   %ebx
801052ed:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801052f0:	50                   	push   %eax
801052f1:	6a 00                	push   $0x0
801052f3:	e8 f8 f7 ff ff       	call   80104af0 <argstr>
801052f8:	83 c4 10             	add    $0x10,%esp
801052fb:	85 c0                	test   %eax,%eax
801052fd:	0f 88 9a 00 00 00    	js     8010539d <sys_open+0xbd>
80105303:	83 ec 08             	sub    $0x8,%esp
80105306:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105309:	50                   	push   %eax
8010530a:	6a 01                	push   $0x1
8010530c:	e8 3f f7 ff ff       	call   80104a50 <argint>
80105311:	83 c4 10             	add    $0x10,%esp
80105314:	85 c0                	test   %eax,%eax
80105316:	0f 88 81 00 00 00    	js     8010539d <sys_open+0xbd>
    return -1;

  begin_op();
8010531c:	e8 9f da ff ff       	call   80102dc0 <begin_op>

  if(omode & O_CREATE){
80105321:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105325:	0f 85 7d 00 00 00    	jne    801053a8 <sys_open+0xc8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010532b:	83 ec 0c             	sub    $0xc,%esp
8010532e:	ff 75 e0             	pushl  -0x20(%ebp)
80105331:	e8 ea cc ff ff       	call   80102020 <namei>
80105336:	83 c4 10             	add    $0x10,%esp
80105339:	89 c6                	mov    %eax,%esi
8010533b:	85 c0                	test   %eax,%eax
8010533d:	0f 84 82 00 00 00    	je     801053c5 <sys_open+0xe5>
      end_op();
      return -1;
    }
    ilock(ip);
80105343:	83 ec 0c             	sub    $0xc,%esp
80105346:	50                   	push   %eax
80105347:	e8 c4 c3 ff ff       	call   80101710 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
8010534c:	83 c4 10             	add    $0x10,%esp
8010534f:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
80105354:	0f 84 c6 00 00 00    	je     80105420 <sys_open+0x140>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010535a:	e8 91 ba ff ff       	call   80100df0 <filealloc>
8010535f:	89 c7                	mov    %eax,%edi
80105361:	85 c0                	test   %eax,%eax
80105363:	74 27                	je     8010538c <sys_open+0xac>
    if(proc->ofile[fd] == 0){
80105365:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  for(fd = 0; fd < NOFILE; fd++){
8010536c:	31 db                	xor    %ebx,%ebx
8010536e:	66 90                	xchg   %ax,%ax
    if(proc->ofile[fd] == 0){
80105370:	8b 44 9a 28          	mov    0x28(%edx,%ebx,4),%eax
80105374:	85 c0                	test   %eax,%eax
80105376:	74 60                	je     801053d8 <sys_open+0xf8>
  for(fd = 0; fd < NOFILE; fd++){
80105378:	83 c3 01             	add    $0x1,%ebx
8010537b:	83 fb 10             	cmp    $0x10,%ebx
8010537e:	75 f0                	jne    80105370 <sys_open+0x90>
    if(f)
      fileclose(f);
80105380:	83 ec 0c             	sub    $0xc,%esp
80105383:	57                   	push   %edi
80105384:	e8 27 bb ff ff       	call   80100eb0 <fileclose>
80105389:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010538c:	83 ec 0c             	sub    $0xc,%esp
8010538f:	56                   	push   %esi
80105390:	e8 5b c6 ff ff       	call   801019f0 <iunlockput>
    end_op();
80105395:	e8 96 da ff ff       	call   80102e30 <end_op>
    return -1;
8010539a:	83 c4 10             	add    $0x10,%esp
8010539d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801053a2:	eb 6d                	jmp    80105411 <sys_open+0x131>
801053a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
801053a8:	83 ec 0c             	sub    $0xc,%esp
801053ab:	8b 45 e0             	mov    -0x20(%ebp),%eax
801053ae:	31 c9                	xor    %ecx,%ecx
801053b0:	ba 02 00 00 00       	mov    $0x2,%edx
801053b5:	6a 00                	push   $0x0
801053b7:	e8 14 f8 ff ff       	call   80104bd0 <create>
    if(ip == 0){
801053bc:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
801053bf:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801053c1:	85 c0                	test   %eax,%eax
801053c3:	75 95                	jne    8010535a <sys_open+0x7a>
      end_op();
801053c5:	e8 66 da ff ff       	call   80102e30 <end_op>
      return -1;
801053ca:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801053cf:	eb 40                	jmp    80105411 <sys_open+0x131>
801053d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
801053d8:	83 ec 0c             	sub    $0xc,%esp
      proc->ofile[fd] = f;
801053db:	89 7c 9a 28          	mov    %edi,0x28(%edx,%ebx,4)
  iunlock(ip);
801053df:	56                   	push   %esi
801053e0:	e8 3b c4 ff ff       	call   80101820 <iunlock>
  end_op();
801053e5:	e8 46 da ff ff       	call   80102e30 <end_op>

  f->type = FD_INODE;
801053ea:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801053f0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801053f3:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801053f6:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
801053f9:	89 d0                	mov    %edx,%eax
  f->off = 0;
801053fb:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105402:	f7 d0                	not    %eax
80105404:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105407:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
8010540a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010540d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105411:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105414:	89 d8                	mov    %ebx,%eax
80105416:	5b                   	pop    %ebx
80105417:	5e                   	pop    %esi
80105418:	5f                   	pop    %edi
80105419:	5d                   	pop    %ebp
8010541a:	c3                   	ret    
8010541b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010541f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80105420:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105423:	85 d2                	test   %edx,%edx
80105425:	0f 84 2f ff ff ff    	je     8010535a <sys_open+0x7a>
8010542b:	e9 5c ff ff ff       	jmp    8010538c <sys_open+0xac>

80105430 <sys_mkdir>:

int
sys_mkdir(void)
{
80105430:	f3 0f 1e fb          	endbr32 
80105434:	55                   	push   %ebp
80105435:	89 e5                	mov    %esp,%ebp
80105437:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
8010543a:	e8 81 d9 ff ff       	call   80102dc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010543f:	83 ec 08             	sub    $0x8,%esp
80105442:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105445:	50                   	push   %eax
80105446:	6a 00                	push   $0x0
80105448:	e8 a3 f6 ff ff       	call   80104af0 <argstr>
8010544d:	83 c4 10             	add    $0x10,%esp
80105450:	85 c0                	test   %eax,%eax
80105452:	78 34                	js     80105488 <sys_mkdir+0x58>
80105454:	83 ec 0c             	sub    $0xc,%esp
80105457:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010545a:	31 c9                	xor    %ecx,%ecx
8010545c:	ba 01 00 00 00       	mov    $0x1,%edx
80105461:	6a 00                	push   $0x0
80105463:	e8 68 f7 ff ff       	call   80104bd0 <create>
80105468:	83 c4 10             	add    $0x10,%esp
8010546b:	85 c0                	test   %eax,%eax
8010546d:	74 19                	je     80105488 <sys_mkdir+0x58>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010546f:	83 ec 0c             	sub    $0xc,%esp
80105472:	50                   	push   %eax
80105473:	e8 78 c5 ff ff       	call   801019f0 <iunlockput>
  end_op();
80105478:	e8 b3 d9 ff ff       	call   80102e30 <end_op>
  return 0;
8010547d:	83 c4 10             	add    $0x10,%esp
80105480:	31 c0                	xor    %eax,%eax
}
80105482:	c9                   	leave  
80105483:	c3                   	ret    
80105484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105488:	e8 a3 d9 ff ff       	call   80102e30 <end_op>
    return -1;
8010548d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105492:	c9                   	leave  
80105493:	c3                   	ret    
80105494:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010549b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010549f:	90                   	nop

801054a0 <sys_mknod>:

int
sys_mknod(void)
{
801054a0:	f3 0f 1e fb          	endbr32 
801054a4:	55                   	push   %ebp
801054a5:	89 e5                	mov    %esp,%ebp
801054a7:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801054aa:	e8 11 d9 ff ff       	call   80102dc0 <begin_op>
  if((argstr(0, &path)) < 0 ||
801054af:	83 ec 08             	sub    $0x8,%esp
801054b2:	8d 45 ec             	lea    -0x14(%ebp),%eax
801054b5:	50                   	push   %eax
801054b6:	6a 00                	push   $0x0
801054b8:	e8 33 f6 ff ff       	call   80104af0 <argstr>
801054bd:	83 c4 10             	add    $0x10,%esp
801054c0:	85 c0                	test   %eax,%eax
801054c2:	78 64                	js     80105528 <sys_mknod+0x88>
     argint(1, &major) < 0 ||
801054c4:	83 ec 08             	sub    $0x8,%esp
801054c7:	8d 45 f0             	lea    -0x10(%ebp),%eax
801054ca:	50                   	push   %eax
801054cb:	6a 01                	push   $0x1
801054cd:	e8 7e f5 ff ff       	call   80104a50 <argint>
  if((argstr(0, &path)) < 0 ||
801054d2:	83 c4 10             	add    $0x10,%esp
801054d5:	85 c0                	test   %eax,%eax
801054d7:	78 4f                	js     80105528 <sys_mknod+0x88>
     argint(2, &minor) < 0 ||
801054d9:	83 ec 08             	sub    $0x8,%esp
801054dc:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054df:	50                   	push   %eax
801054e0:	6a 02                	push   $0x2
801054e2:	e8 69 f5 ff ff       	call   80104a50 <argint>
     argint(1, &major) < 0 ||
801054e7:	83 c4 10             	add    $0x10,%esp
801054ea:	85 c0                	test   %eax,%eax
801054ec:	78 3a                	js     80105528 <sys_mknod+0x88>
     (ip = create(path, T_DEV, major, minor)) == 0){
801054ee:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801054f2:	83 ec 0c             	sub    $0xc,%esp
801054f5:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801054f9:	ba 03 00 00 00       	mov    $0x3,%edx
801054fe:	50                   	push   %eax
801054ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105502:	e8 c9 f6 ff ff       	call   80104bd0 <create>
     argint(2, &minor) < 0 ||
80105507:	83 c4 10             	add    $0x10,%esp
8010550a:	85 c0                	test   %eax,%eax
8010550c:	74 1a                	je     80105528 <sys_mknod+0x88>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010550e:	83 ec 0c             	sub    $0xc,%esp
80105511:	50                   	push   %eax
80105512:	e8 d9 c4 ff ff       	call   801019f0 <iunlockput>
  end_op();
80105517:	e8 14 d9 ff ff       	call   80102e30 <end_op>
  return 0;
8010551c:	83 c4 10             	add    $0x10,%esp
8010551f:	31 c0                	xor    %eax,%eax
}
80105521:	c9                   	leave  
80105522:	c3                   	ret    
80105523:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105527:	90                   	nop
    end_op();
80105528:	e8 03 d9 ff ff       	call   80102e30 <end_op>
    return -1;
8010552d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105532:	c9                   	leave  
80105533:	c3                   	ret    
80105534:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010553b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010553f:	90                   	nop

80105540 <sys_chdir>:

int
sys_chdir(void)
{
80105540:	f3 0f 1e fb          	endbr32 
80105544:	55                   	push   %ebp
80105545:	89 e5                	mov    %esp,%ebp
80105547:	53                   	push   %ebx
80105548:	83 ec 14             	sub    $0x14,%esp
  char *path;
  struct inode *ip;

  begin_op();
8010554b:	e8 70 d8 ff ff       	call   80102dc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105550:	83 ec 08             	sub    $0x8,%esp
80105553:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105556:	50                   	push   %eax
80105557:	6a 00                	push   $0x0
80105559:	e8 92 f5 ff ff       	call   80104af0 <argstr>
8010555e:	83 c4 10             	add    $0x10,%esp
80105561:	85 c0                	test   %eax,%eax
80105563:	78 7b                	js     801055e0 <sys_chdir+0xa0>
80105565:	83 ec 0c             	sub    $0xc,%esp
80105568:	ff 75 f4             	pushl  -0xc(%ebp)
8010556b:	e8 b0 ca ff ff       	call   80102020 <namei>
80105570:	83 c4 10             	add    $0x10,%esp
80105573:	89 c3                	mov    %eax,%ebx
80105575:	85 c0                	test   %eax,%eax
80105577:	74 67                	je     801055e0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105579:	83 ec 0c             	sub    $0xc,%esp
8010557c:	50                   	push   %eax
8010557d:	e8 8e c1 ff ff       	call   80101710 <ilock>
  if(ip->type != T_DIR){
80105582:	83 c4 10             	add    $0x10,%esp
80105585:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
8010558a:	75 34                	jne    801055c0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
8010558c:	83 ec 0c             	sub    $0xc,%esp
8010558f:	53                   	push   %ebx
80105590:	e8 8b c2 ff ff       	call   80101820 <iunlock>
  iput(proc->cwd);
80105595:	58                   	pop    %eax
80105596:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010559c:	ff 70 68             	pushl  0x68(%eax)
8010559f:	e8 dc c2 ff ff       	call   80101880 <iput>
  end_op();
801055a4:	e8 87 d8 ff ff       	call   80102e30 <end_op>
  proc->cwd = ip;
801055a9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return 0;
801055af:	83 c4 10             	add    $0x10,%esp
  proc->cwd = ip;
801055b2:	89 58 68             	mov    %ebx,0x68(%eax)
  return 0;
801055b5:	31 c0                	xor    %eax,%eax
}
801055b7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801055ba:	c9                   	leave  
801055bb:	c3                   	ret    
801055bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
801055c0:	83 ec 0c             	sub    $0xc,%esp
801055c3:	53                   	push   %ebx
801055c4:	e8 27 c4 ff ff       	call   801019f0 <iunlockput>
    end_op();
801055c9:	e8 62 d8 ff ff       	call   80102e30 <end_op>
    return -1;
801055ce:	83 c4 10             	add    $0x10,%esp
801055d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055d6:	eb df                	jmp    801055b7 <sys_chdir+0x77>
801055d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055df:	90                   	nop
    end_op();
801055e0:	e8 4b d8 ff ff       	call   80102e30 <end_op>
    return -1;
801055e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055ea:	eb cb                	jmp    801055b7 <sys_chdir+0x77>
801055ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055f0 <sys_exec>:

int
sys_exec(void)
{
801055f0:	f3 0f 1e fb          	endbr32 
801055f4:	55                   	push   %ebp
801055f5:	89 e5                	mov    %esp,%ebp
801055f7:	57                   	push   %edi
801055f8:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801055f9:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801055ff:	53                   	push   %ebx
80105600:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105606:	50                   	push   %eax
80105607:	6a 00                	push   $0x0
80105609:	e8 e2 f4 ff ff       	call   80104af0 <argstr>
8010560e:	83 c4 10             	add    $0x10,%esp
80105611:	85 c0                	test   %eax,%eax
80105613:	0f 88 8b 00 00 00    	js     801056a4 <sys_exec+0xb4>
80105619:	83 ec 08             	sub    $0x8,%esp
8010561c:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105622:	50                   	push   %eax
80105623:	6a 01                	push   $0x1
80105625:	e8 26 f4 ff ff       	call   80104a50 <argint>
8010562a:	83 c4 10             	add    $0x10,%esp
8010562d:	85 c0                	test   %eax,%eax
8010562f:	78 73                	js     801056a4 <sys_exec+0xb4>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105631:	83 ec 04             	sub    $0x4,%esp
80105634:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
8010563a:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
8010563c:	68 80 00 00 00       	push   $0x80
80105641:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105647:	6a 00                	push   $0x0
80105649:	50                   	push   %eax
8010564a:	e8 31 f1 ff ff       	call   80104780 <memset>
8010564f:	83 c4 10             	add    $0x10,%esp
80105652:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105658:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
8010565e:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105665:	83 ec 08             	sub    $0x8,%esp
80105668:	57                   	push   %edi
80105669:	01 f0                	add    %esi,%eax
8010566b:	50                   	push   %eax
8010566c:	e8 4f f3 ff ff       	call   801049c0 <fetchint>
80105671:	83 c4 10             	add    $0x10,%esp
80105674:	85 c0                	test   %eax,%eax
80105676:	78 2c                	js     801056a4 <sys_exec+0xb4>
      return -1;
    if(uarg == 0){
80105678:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010567e:	85 c0                	test   %eax,%eax
80105680:	74 36                	je     801056b8 <sys_exec+0xc8>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105682:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105688:	83 ec 08             	sub    $0x8,%esp
8010568b:	8d 14 31             	lea    (%ecx,%esi,1),%edx
8010568e:	52                   	push   %edx
8010568f:	50                   	push   %eax
80105690:	e8 6b f3 ff ff       	call   80104a00 <fetchstr>
80105695:	83 c4 10             	add    $0x10,%esp
80105698:	85 c0                	test   %eax,%eax
8010569a:	78 08                	js     801056a4 <sys_exec+0xb4>
  for(i=0;; i++){
8010569c:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
8010569f:	83 fb 20             	cmp    $0x20,%ebx
801056a2:	75 b4                	jne    80105658 <sys_exec+0x68>
      return -1;
  }
  return exec(path, argv);
}
801056a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801056a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056ac:	5b                   	pop    %ebx
801056ad:	5e                   	pop    %esi
801056ae:	5f                   	pop    %edi
801056af:	5d                   	pop    %ebp
801056b0:	c3                   	ret    
801056b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
801056b8:	83 ec 08             	sub    $0x8,%esp
801056bb:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
      argv[i] = 0;
801056c1:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801056c8:	00 00 00 00 
  return exec(path, argv);
801056cc:	50                   	push   %eax
801056cd:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801056d3:	e8 a8 b3 ff ff       	call   80100a80 <exec>
801056d8:	83 c4 10             	add    $0x10,%esp
}
801056db:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056de:	5b                   	pop    %ebx
801056df:	5e                   	pop    %esi
801056e0:	5f                   	pop    %edi
801056e1:	5d                   	pop    %ebp
801056e2:	c3                   	ret    
801056e3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801056f0 <sys_pipe>:

int
sys_pipe(void)
{
801056f0:	f3 0f 1e fb          	endbr32 
801056f4:	55                   	push   %ebp
801056f5:	89 e5                	mov    %esp,%ebp
801056f7:	57                   	push   %edi
801056f8:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801056f9:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801056fc:	53                   	push   %ebx
801056fd:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105700:	6a 08                	push   $0x8
80105702:	50                   	push   %eax
80105703:	6a 00                	push   $0x0
80105705:	e8 96 f3 ff ff       	call   80104aa0 <argptr>
8010570a:	83 c4 10             	add    $0x10,%esp
8010570d:	85 c0                	test   %eax,%eax
8010570f:	78 4c                	js     8010575d <sys_pipe+0x6d>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105711:	83 ec 08             	sub    $0x8,%esp
80105714:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105717:	50                   	push   %eax
80105718:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010571b:	50                   	push   %eax
8010571c:	e8 3f de ff ff       	call   80103560 <pipealloc>
80105721:	83 c4 10             	add    $0x10,%esp
80105724:	85 c0                	test   %eax,%eax
80105726:	78 35                	js     8010575d <sys_pipe+0x6d>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105728:	8b 75 e0             	mov    -0x20(%ebp),%esi
    if(proc->ofile[fd] == 0){
8010572b:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
  for(fd = 0; fd < NOFILE; fd++){
80105732:	31 c0                	xor    %eax,%eax
80105734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->ofile[fd] == 0){
80105738:	8b 54 81 28          	mov    0x28(%ecx,%eax,4),%edx
8010573c:	85 d2                	test   %edx,%edx
8010573e:	74 28                	je     80105768 <sys_pipe+0x78>
  for(fd = 0; fd < NOFILE; fd++){
80105740:	83 c0 01             	add    $0x1,%eax
80105743:	83 f8 10             	cmp    $0x10,%eax
80105746:	75 f0                	jne    80105738 <sys_pipe+0x48>
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
    fileclose(rf);
80105748:	83 ec 0c             	sub    $0xc,%esp
8010574b:	56                   	push   %esi
8010574c:	e8 5f b7 ff ff       	call   80100eb0 <fileclose>
    fileclose(wf);
80105751:	58                   	pop    %eax
80105752:	ff 75 e4             	pushl  -0x1c(%ebp)
80105755:	e8 56 b7 ff ff       	call   80100eb0 <fileclose>
    return -1;
8010575a:	83 c4 10             	add    $0x10,%esp
8010575d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105762:	eb 3d                	jmp    801057a1 <sys_pipe+0xb1>
80105764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      proc->ofile[fd] = f;
80105768:	8d 1c 81             	lea    (%ecx,%eax,4),%ebx
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010576b:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010576e:	31 d2                	xor    %edx,%edx
      proc->ofile[fd] = f;
80105770:	89 73 28             	mov    %esi,0x28(%ebx)
  for(fd = 0; fd < NOFILE; fd++){
80105773:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105777:	90                   	nop
    if(proc->ofile[fd] == 0){
80105778:	83 7c 91 28 00       	cmpl   $0x0,0x28(%ecx,%edx,4)
8010577d:	74 11                	je     80105790 <sys_pipe+0xa0>
  for(fd = 0; fd < NOFILE; fd++){
8010577f:	83 c2 01             	add    $0x1,%edx
80105782:	83 fa 10             	cmp    $0x10,%edx
80105785:	75 f1                	jne    80105778 <sys_pipe+0x88>
      proc->ofile[fd0] = 0;
80105787:	c7 43 28 00 00 00 00 	movl   $0x0,0x28(%ebx)
8010578e:	eb b8                	jmp    80105748 <sys_pipe+0x58>
      proc->ofile[fd] = f;
80105790:	89 7c 91 28          	mov    %edi,0x28(%ecx,%edx,4)
  }
  fd[0] = fd0;
80105794:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80105797:	89 01                	mov    %eax,(%ecx)
  fd[1] = fd1;
80105799:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010579c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
8010579f:	31 c0                	xor    %eax,%eax
}
801057a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057a4:	5b                   	pop    %ebx
801057a5:	5e                   	pop    %esi
801057a6:	5f                   	pop    %edi
801057a7:	5d                   	pop    %ebp
801057a8:	c3                   	ret    
801057a9:	66 90                	xchg   %ax,%ax
801057ab:	66 90                	xchg   %ax,%ax
801057ad:	66 90                	xchg   %ax,%ax
801057af:	90                   	nop

801057b0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801057b0:	f3 0f 1e fb          	endbr32 
  return fork();
801057b4:	e9 e7 e3 ff ff       	jmp    80103ba0 <fork>
801057b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801057c0 <sys_exit>:
}

int
sys_exit(void)
{
801057c0:	f3 0f 1e fb          	endbr32 
801057c4:	55                   	push   %ebp
801057c5:	89 e5                	mov    %esp,%ebp
801057c7:	83 ec 08             	sub    $0x8,%esp
  exit();
801057ca:	e8 51 e6 ff ff       	call   80103e20 <exit>
  return 0;  // not reached
}
801057cf:	31 c0                	xor    %eax,%eax
801057d1:	c9                   	leave  
801057d2:	c3                   	ret    
801057d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801057e0 <sys_wait>:

int
sys_wait(void)
{
801057e0:	f3 0f 1e fb          	endbr32 
  return wait();
801057e4:	e9 97 e8 ff ff       	jmp    80104080 <wait>
801057e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801057f0 <sys_kill>:
}

int
sys_kill(void)
{
801057f0:	f3 0f 1e fb          	endbr32 
801057f4:	55                   	push   %ebp
801057f5:	89 e5                	mov    %esp,%ebp
801057f7:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801057fa:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057fd:	50                   	push   %eax
801057fe:	6a 00                	push   $0x0
80105800:	e8 4b f2 ff ff       	call   80104a50 <argint>
80105805:	83 c4 10             	add    $0x10,%esp
80105808:	85 c0                	test   %eax,%eax
8010580a:	78 14                	js     80105820 <sys_kill+0x30>
    return -1;
  return kill(pid);
8010580c:	83 ec 0c             	sub    $0xc,%esp
8010580f:	ff 75 f4             	pushl  -0xc(%ebp)
80105812:	e8 c9 e9 ff ff       	call   801041e0 <kill>
80105817:	83 c4 10             	add    $0x10,%esp
}
8010581a:	c9                   	leave  
8010581b:	c3                   	ret    
8010581c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105820:	c9                   	leave  
    return -1;
80105821:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105826:	c3                   	ret    
80105827:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010582e:	66 90                	xchg   %ax,%ax

80105830 <sys_getpid>:

int
sys_getpid(void)
{
80105830:	f3 0f 1e fb          	endbr32 
  return proc->pid;
80105834:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010583a:	8b 40 10             	mov    0x10(%eax),%eax
}
8010583d:	c3                   	ret    
8010583e:	66 90                	xchg   %ax,%ax

80105840 <sys_sbrk>:

int
sys_sbrk(void)
{
80105840:	f3 0f 1e fb          	endbr32 
80105844:	55                   	push   %ebp
80105845:	89 e5                	mov    %esp,%ebp
80105847:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105848:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
8010584b:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010584e:	50                   	push   %eax
8010584f:	6a 00                	push   $0x0
80105851:	e8 fa f1 ff ff       	call   80104a50 <argint>
80105856:	83 c4 10             	add    $0x10,%esp
80105859:	85 c0                	test   %eax,%eax
8010585b:	78 23                	js     80105880 <sys_sbrk+0x40>
    return -1;
  addr = proc->sz;
8010585d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(growproc(n) < 0)
80105863:	83 ec 0c             	sub    $0xc,%esp
  addr = proc->sz;
80105866:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105868:	ff 75 f4             	pushl  -0xc(%ebp)
8010586b:	e8 b0 e2 ff ff       	call   80103b20 <growproc>
80105870:	83 c4 10             	add    $0x10,%esp
80105873:	85 c0                	test   %eax,%eax
80105875:	78 09                	js     80105880 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105877:	89 d8                	mov    %ebx,%eax
80105879:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010587c:	c9                   	leave  
8010587d:	c3                   	ret    
8010587e:	66 90                	xchg   %ax,%ax
    return -1;
80105880:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105885:	eb f0                	jmp    80105877 <sys_sbrk+0x37>
80105887:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010588e:	66 90                	xchg   %ax,%ax

80105890 <sys_sleep>:

int
sys_sleep(void)
{
80105890:	f3 0f 1e fb          	endbr32 
80105894:	55                   	push   %ebp
80105895:	89 e5                	mov    %esp,%ebp
80105897:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105898:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
8010589b:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010589e:	50                   	push   %eax
8010589f:	6a 00                	push   $0x0
801058a1:	e8 aa f1 ff ff       	call   80104a50 <argint>
801058a6:	83 c4 10             	add    $0x10,%esp
801058a9:	85 c0                	test   %eax,%eax
801058ab:	0f 88 86 00 00 00    	js     80105937 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801058b1:	83 ec 0c             	sub    $0xc,%esp
801058b4:	68 20 3a 11 80       	push   $0x80113a20
801058b9:	e8 92 ec ff ff       	call   80104550 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801058be:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
801058c1:	8b 1d 60 42 11 80    	mov    0x80114260,%ebx
  while(ticks - ticks0 < n){
801058c7:	83 c4 10             	add    $0x10,%esp
801058ca:	85 d2                	test   %edx,%edx
801058cc:	75 23                	jne    801058f1 <sys_sleep+0x61>
801058ce:	eb 50                	jmp    80105920 <sys_sleep+0x90>
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801058d0:	83 ec 08             	sub    $0x8,%esp
801058d3:	68 20 3a 11 80       	push   $0x80113a20
801058d8:	68 60 42 11 80       	push   $0x80114260
801058dd:	e8 ce e6 ff ff       	call   80103fb0 <sleep>
  while(ticks - ticks0 < n){
801058e2:	a1 60 42 11 80       	mov    0x80114260,%eax
801058e7:	83 c4 10             	add    $0x10,%esp
801058ea:	29 d8                	sub    %ebx,%eax
801058ec:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801058ef:	73 2f                	jae    80105920 <sys_sleep+0x90>
    if(proc->killed){
801058f1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801058f7:	8b 40 24             	mov    0x24(%eax),%eax
801058fa:	85 c0                	test   %eax,%eax
801058fc:	74 d2                	je     801058d0 <sys_sleep+0x40>
      release(&tickslock);
801058fe:	83 ec 0c             	sub    $0xc,%esp
80105901:	68 20 3a 11 80       	push   $0x80113a20
80105906:	e8 25 ee ff ff       	call   80104730 <release>
  }
  release(&tickslock);
  return 0;
}
8010590b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
8010590e:	83 c4 10             	add    $0x10,%esp
80105911:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105916:	c9                   	leave  
80105917:	c3                   	ret    
80105918:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010591f:	90                   	nop
  release(&tickslock);
80105920:	83 ec 0c             	sub    $0xc,%esp
80105923:	68 20 3a 11 80       	push   $0x80113a20
80105928:	e8 03 ee ff ff       	call   80104730 <release>
  return 0;
8010592d:	83 c4 10             	add    $0x10,%esp
80105930:	31 c0                	xor    %eax,%eax
}
80105932:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105935:	c9                   	leave  
80105936:	c3                   	ret    
    return -1;
80105937:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010593c:	eb f4                	jmp    80105932 <sys_sleep+0xa2>
8010593e:	66 90                	xchg   %ax,%ax

80105940 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105940:	f3 0f 1e fb          	endbr32 
80105944:	55                   	push   %ebp
80105945:	89 e5                	mov    %esp,%ebp
80105947:	53                   	push   %ebx
80105948:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
8010594b:	68 20 3a 11 80       	push   $0x80113a20
80105950:	e8 fb eb ff ff       	call   80104550 <acquire>
  xticks = ticks;
80105955:	8b 1d 60 42 11 80    	mov    0x80114260,%ebx
  release(&tickslock);
8010595b:	c7 04 24 20 3a 11 80 	movl   $0x80113a20,(%esp)
80105962:	e8 c9 ed ff ff       	call   80104730 <release>
  return xticks;
}
80105967:	89 d8                	mov    %ebx,%eax
80105969:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010596c:	c9                   	leave  
8010596d:	c3                   	ret    
8010596e:	66 90                	xchg   %ax,%ax

80105970 <sys_clone>:

int sys_clone(void)
{
80105970:	f3 0f 1e fb          	endbr32 
80105974:	55                   	push   %ebp
80105975:	89 e5                	mov    %esp,%ebp
80105977:	83 ec 20             	sub    $0x20,%esp
  int f, a, s;
  if(argint(0, &f) < 0) return -1;
8010597a:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010597d:	50                   	push   %eax
8010597e:	6a 00                	push   $0x0
80105980:	e8 cb f0 ff ff       	call   80104a50 <argint>
80105985:	83 c4 10             	add    $0x10,%esp
80105988:	85 c0                	test   %eax,%eax
8010598a:	78 44                	js     801059d0 <sys_clone+0x60>
  if(argint(1, &a) < 0) return -1;
8010598c:	83 ec 08             	sub    $0x8,%esp
8010598f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105992:	50                   	push   %eax
80105993:	6a 01                	push   $0x1
80105995:	e8 b6 f0 ff ff       	call   80104a50 <argint>
8010599a:	83 c4 10             	add    $0x10,%esp
8010599d:	85 c0                	test   %eax,%eax
8010599f:	78 2f                	js     801059d0 <sys_clone+0x60>
  if(argint(2, &s) < 0) return -1;
801059a1:	83 ec 08             	sub    $0x8,%esp
801059a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059a7:	50                   	push   %eax
801059a8:	6a 02                	push   $0x2
801059aa:	e8 a1 f0 ff ff       	call   80104a50 <argint>
801059af:	83 c4 10             	add    $0x10,%esp
801059b2:	85 c0                	test   %eax,%eax
801059b4:	78 1a                	js     801059d0 <sys_clone+0x60>
  return clone((void (*)(void *))f, (void*)a, (void*)s);
801059b6:	83 ec 04             	sub    $0x4,%esp
801059b9:	ff 75 f4             	pushl  -0xc(%ebp)
801059bc:	ff 75 f0             	pushl  -0x10(%ebp)
801059bf:	ff 75 ec             	pushl  -0x14(%ebp)
801059c2:	e8 89 e9 ff ff       	call   80104350 <clone>
801059c7:	83 c4 10             	add    $0x10,%esp
}
801059ca:	c9                   	leave  
801059cb:	c3                   	ret    
801059cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059d0:	c9                   	leave  
  if(argint(0, &f) < 0) return -1;
801059d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059d6:	c3                   	ret    
801059d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059de:	66 90                	xchg   %ax,%ax

801059e0 <sys_join>:

int sys_join(void) 
{
801059e0:	f3 0f 1e fb          	endbr32 
801059e4:	55                   	push   %ebp
801059e5:	89 e5                	mov    %esp,%ebp
801059e7:	83 ec 20             	sub    $0x20,%esp
  int n;
  if(argint(0, &n) < 0) return -1;
801059ea:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059ed:	50                   	push   %eax
801059ee:	6a 00                	push   $0x0
801059f0:	e8 5b f0 ff ff       	call   80104a50 <argint>
801059f5:	83 c4 10             	add    $0x10,%esp
801059f8:	85 c0                	test   %eax,%eax
801059fa:	78 14                	js     80105a10 <sys_join+0x30>
  return join(n);
801059fc:	83 ec 0c             	sub    $0xc,%esp
801059ff:	ff 75 f4             	pushl  -0xc(%ebp)
80105a02:	e8 69 ea ff ff       	call   80104470 <join>
80105a07:	83 c4 10             	add    $0x10,%esp
80105a0a:	c9                   	leave  
80105a0b:	c3                   	ret    
80105a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a10:	c9                   	leave  
  if(argint(0, &n) < 0) return -1;
80105a11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a16:	c3                   	ret    
80105a17:	66 90                	xchg   %ax,%ax
80105a19:	66 90                	xchg   %ax,%ax
80105a1b:	66 90                	xchg   %ax,%ax
80105a1d:	66 90                	xchg   %ax,%ax
80105a1f:	90                   	nop

80105a20 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
80105a20:	f3 0f 1e fb          	endbr32 
80105a24:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105a25:	b8 34 00 00 00       	mov    $0x34,%eax
80105a2a:	ba 43 00 00 00       	mov    $0x43,%edx
80105a2f:	89 e5                	mov    %esp,%ebp
80105a31:	83 ec 14             	sub    $0x14,%esp
80105a34:	ee                   	out    %al,(%dx)
80105a35:	ba 40 00 00 00       	mov    $0x40,%edx
80105a3a:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
80105a3f:	ee                   	out    %al,(%dx)
80105a40:	b8 2e 00 00 00       	mov    $0x2e,%eax
80105a45:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  picenable(IRQ_TIMER);
80105a46:	6a 00                	push   $0x0
80105a48:	e8 43 da ff ff       	call   80103490 <picenable>
}
80105a4d:	83 c4 10             	add    $0x10,%esp
80105a50:	c9                   	leave  
80105a51:	c3                   	ret    

80105a52 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105a52:	1e                   	push   %ds
  pushl %es
80105a53:	06                   	push   %es
  pushl %fs
80105a54:	0f a0                	push   %fs
  pushl %gs
80105a56:	0f a8                	push   %gs
  pushal
80105a58:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80105a59:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105a5d:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105a5f:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
80105a61:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
80105a65:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80105a67:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
80105a69:	54                   	push   %esp
  call trap
80105a6a:	e8 c1 00 00 00       	call   80105b30 <trap>
  addl $4, %esp
80105a6f:	83 c4 04             	add    $0x4,%esp

80105a72 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105a72:	61                   	popa   
  popl %gs
80105a73:	0f a9                	pop    %gs
  popl %fs
80105a75:	0f a1                	pop    %fs
  popl %es
80105a77:	07                   	pop    %es
  popl %ds
80105a78:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105a79:	83 c4 08             	add    $0x8,%esp
  iret
80105a7c:	cf                   	iret   
80105a7d:	66 90                	xchg   %ax,%ax
80105a7f:	90                   	nop

80105a80 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105a80:	f3 0f 1e fb          	endbr32 
80105a84:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105a85:	31 c0                	xor    %eax,%eax
{
80105a87:	89 e5                	mov    %esp,%ebp
80105a89:	83 ec 08             	sub    $0x8,%esp
80105a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105a90:	8b 14 85 0c a0 10 80 	mov    -0x7fef5ff4(,%eax,4),%edx
80105a97:	c7 04 c5 62 3a 11 80 	movl   $0x8e000008,-0x7feec59e(,%eax,8)
80105a9e:	08 00 00 8e 
80105aa2:	66 89 14 c5 60 3a 11 	mov    %dx,-0x7feec5a0(,%eax,8)
80105aa9:	80 
80105aaa:	c1 ea 10             	shr    $0x10,%edx
80105aad:	66 89 14 c5 66 3a 11 	mov    %dx,-0x7feec59a(,%eax,8)
80105ab4:	80 
  for(i = 0; i < 256; i++)
80105ab5:	83 c0 01             	add    $0x1,%eax
80105ab8:	3d 00 01 00 00       	cmp    $0x100,%eax
80105abd:	75 d1                	jne    80105a90 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80105abf:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105ac2:	a1 0c a1 10 80       	mov    0x8010a10c,%eax
80105ac7:	c7 05 62 3c 11 80 08 	movl   $0xef000008,0x80113c62
80105ace:	00 00 ef 
  initlock(&tickslock, "time");
80105ad1:	68 01 7a 10 80       	push   $0x80107a01
80105ad6:	68 20 3a 11 80       	push   $0x80113a20
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105adb:	66 a3 60 3c 11 80    	mov    %ax,0x80113c60
80105ae1:	c1 e8 10             	shr    $0x10,%eax
80105ae4:	66 a3 66 3c 11 80    	mov    %ax,0x80113c66
  initlock(&tickslock, "time");
80105aea:	e8 41 ea ff ff       	call   80104530 <initlock>
}
80105aef:	83 c4 10             	add    $0x10,%esp
80105af2:	c9                   	leave  
80105af3:	c3                   	ret    
80105af4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105afb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105aff:	90                   	nop

80105b00 <idtinit>:

void
idtinit(void)
{
80105b00:	f3 0f 1e fb          	endbr32 
80105b04:	55                   	push   %ebp
  pd[0] = size-1;
80105b05:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105b0a:	89 e5                	mov    %esp,%ebp
80105b0c:	83 ec 10             	sub    $0x10,%esp
80105b0f:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105b13:	b8 60 3a 11 80       	mov    $0x80113a60,%eax
80105b18:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105b1c:	c1 e8 10             	shr    $0x10,%eax
80105b1f:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105b23:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105b26:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105b29:	c9                   	leave  
80105b2a:	c3                   	ret    
80105b2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b2f:	90                   	nop

80105b30 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105b30:	f3 0f 1e fb          	endbr32 
80105b34:	55                   	push   %ebp
80105b35:	89 e5                	mov    %esp,%ebp
80105b37:	57                   	push   %edi
80105b38:	56                   	push   %esi
80105b39:	53                   	push   %ebx
80105b3a:	83 ec 0c             	sub    $0xc,%esp
80105b3d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105b40:	8b 43 30             	mov    0x30(%ebx),%eax
80105b43:	83 f8 40             	cmp    $0x40,%eax
80105b46:	0f 84 e4 00 00 00    	je     80105c30 <trap+0x100>
    if(proc->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105b4c:	83 e8 20             	sub    $0x20,%eax
80105b4f:	83 f8 1f             	cmp    $0x1f,%eax
80105b52:	77 59                	ja     80105bad <trap+0x7d>
80105b54:	3e ff 24 85 a8 7a 10 	notrack jmp *-0x7fef8558(,%eax,4)
80105b5b:	80 
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
80105b5c:	e8 4f cd ff ff       	call   801028b0 <cpunum>
80105b61:	85 c0                	test   %eax,%eax
80105b63:	0f 84 af 01 00 00    	je     80105d18 <trap+0x1e8>
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
    lapiceoi();
80105b69:	e8 e2 cd ff ff       	call   80102950 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105b6e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105b74:	85 c0                	test   %eax,%eax
80105b76:	74 2d                	je     80105ba5 <trap+0x75>
80105b78:	8b 50 24             	mov    0x24(%eax),%edx
80105b7b:	85 d2                	test   %edx,%edx
80105b7d:	0f 85 80 00 00 00    	jne    80105c03 <trap+0xd3>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105b83:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105b87:	0f 84 63 01 00 00    	je     80105cf0 <trap+0x1c0>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105b8d:	8b 40 24             	mov    0x24(%eax),%eax
80105b90:	85 c0                	test   %eax,%eax
80105b92:	74 11                	je     80105ba5 <trap+0x75>
80105b94:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105b98:	83 e0 03             	and    $0x3,%eax
80105b9b:	66 83 f8 03          	cmp    $0x3,%ax
80105b9f:	0f 84 b5 00 00 00    	je     80105c5a <trap+0x12a>
    exit();
}
80105ba5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ba8:	5b                   	pop    %ebx
80105ba9:	5e                   	pop    %esi
80105baa:	5f                   	pop    %edi
80105bab:	5d                   	pop    %ebp
80105bac:	c3                   	ret    
    if(proc == 0 || (tf->cs&3) == 0){
80105bad:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
80105bb4:	8b 73 38             	mov    0x38(%ebx),%esi
80105bb7:	85 c9                	test   %ecx,%ecx
80105bb9:	0f 84 8d 01 00 00    	je     80105d4c <trap+0x21c>
80105bbf:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105bc3:	0f 84 83 01 00 00    	je     80105d4c <trap+0x21c>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105bc9:	0f 20 d7             	mov    %cr2,%edi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105bcc:	e8 df cc ff ff       	call   801028b0 <cpunum>
80105bd1:	57                   	push   %edi
80105bd2:	89 c2                	mov    %eax,%edx
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80105bd4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105bda:	56                   	push   %esi
80105bdb:	52                   	push   %edx
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80105bdc:	8d 50 6c             	lea    0x6c(%eax),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105bdf:	ff 73 34             	pushl  0x34(%ebx)
80105be2:	ff 73 30             	pushl  0x30(%ebx)
80105be5:	52                   	push   %edx
80105be6:	ff 70 10             	pushl  0x10(%eax)
80105be9:	68 64 7a 10 80       	push   $0x80107a64
80105bee:	e8 ad aa ff ff       	call   801006a0 <cprintf>
    proc->killed = 1;
80105bf3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105bf9:	83 c4 20             	add    $0x20,%esp
80105bfc:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105c03:	0f b7 53 3c          	movzwl 0x3c(%ebx),%edx
80105c07:	83 e2 03             	and    $0x3,%edx
80105c0a:	66 83 fa 03          	cmp    $0x3,%dx
80105c0e:	0f 85 6f ff ff ff    	jne    80105b83 <trap+0x53>
    exit();
80105c14:	e8 07 e2 ff ff       	call   80103e20 <exit>
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105c19:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105c1f:	85 c0                	test   %eax,%eax
80105c21:	0f 85 5c ff ff ff    	jne    80105b83 <trap+0x53>
80105c27:	e9 79 ff ff ff       	jmp    80105ba5 <trap+0x75>
80105c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed)
80105c30:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105c36:	8b 70 24             	mov    0x24(%eax),%esi
80105c39:	85 f6                	test   %esi,%esi
80105c3b:	0f 85 9f 00 00 00    	jne    80105ce0 <trap+0x1b0>
    proc->tf = tf;
80105c41:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105c44:	e8 17 ef ff ff       	call   80104b60 <syscall>
    if(proc->killed)
80105c49:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105c4f:	8b 58 24             	mov    0x24(%eax),%ebx
80105c52:	85 db                	test   %ebx,%ebx
80105c54:	0f 84 4b ff ff ff    	je     80105ba5 <trap+0x75>
}
80105c5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c5d:	5b                   	pop    %ebx
80105c5e:	5e                   	pop    %esi
80105c5f:	5f                   	pop    %edi
80105c60:	5d                   	pop    %ebp
      exit();
80105c61:	e9 ba e1 ff ff       	jmp    80103e20 <exit>
    ideintr();
80105c66:	e8 65 c5 ff ff       	call   801021d0 <ideintr>
    lapiceoi();
80105c6b:	e8 e0 cc ff ff       	call   80102950 <lapiceoi>
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105c70:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105c76:	85 c0                	test   %eax,%eax
80105c78:	0f 85 fa fe ff ff    	jne    80105b78 <trap+0x48>
80105c7e:	e9 22 ff ff ff       	jmp    80105ba5 <trap+0x75>
    kbdintr();
80105c83:	e8 08 cb ff ff       	call   80102790 <kbdintr>
    lapiceoi();
80105c88:	e8 c3 cc ff ff       	call   80102950 <lapiceoi>
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105c8d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105c93:	85 c0                	test   %eax,%eax
80105c95:	0f 85 dd fe ff ff    	jne    80105b78 <trap+0x48>
80105c9b:	e9 05 ff ff ff       	jmp    80105ba5 <trap+0x75>
    uartintr();
80105ca0:	e8 5b 02 00 00       	call   80105f00 <uartintr>
80105ca5:	e9 bf fe ff ff       	jmp    80105b69 <trap+0x39>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105caa:	8b 7b 38             	mov    0x38(%ebx),%edi
80105cad:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105cb1:	e8 fa cb ff ff       	call   801028b0 <cpunum>
80105cb6:	57                   	push   %edi
80105cb7:	56                   	push   %esi
80105cb8:	50                   	push   %eax
80105cb9:	68 0c 7a 10 80       	push   $0x80107a0c
80105cbe:	e8 dd a9 ff ff       	call   801006a0 <cprintf>
    lapiceoi();
80105cc3:	e8 88 cc ff ff       	call   80102950 <lapiceoi>
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105cc8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    break;
80105cce:	83 c4 10             	add    $0x10,%esp
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105cd1:	85 c0                	test   %eax,%eax
80105cd3:	0f 85 9f fe ff ff    	jne    80105b78 <trap+0x48>
80105cd9:	e9 c7 fe ff ff       	jmp    80105ba5 <trap+0x75>
80105cde:	66 90                	xchg   %ax,%ax
      exit();
80105ce0:	e8 3b e1 ff ff       	call   80103e20 <exit>
80105ce5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105ceb:	e9 51 ff ff ff       	jmp    80105c41 <trap+0x111>
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105cf0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105cf4:	0f 85 93 fe ff ff    	jne    80105b8d <trap+0x5d>
    yield();
80105cfa:	e8 71 e2 ff ff       	call   80103f70 <yield>
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105cff:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105d05:	85 c0                	test   %eax,%eax
80105d07:	0f 85 80 fe ff ff    	jne    80105b8d <trap+0x5d>
80105d0d:	e9 93 fe ff ff       	jmp    80105ba5 <trap+0x75>
80105d12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105d18:	83 ec 0c             	sub    $0xc,%esp
80105d1b:	68 20 3a 11 80       	push   $0x80113a20
80105d20:	e8 2b e8 ff ff       	call   80104550 <acquire>
      wakeup(&ticks);
80105d25:	c7 04 24 60 42 11 80 	movl   $0x80114260,(%esp)
      ticks++;
80105d2c:	83 05 60 42 11 80 01 	addl   $0x1,0x80114260
      wakeup(&ticks);
80105d33:	e8 38 e4 ff ff       	call   80104170 <wakeup>
      release(&tickslock);
80105d38:	c7 04 24 20 3a 11 80 	movl   $0x80113a20,(%esp)
80105d3f:	e8 ec e9 ff ff       	call   80104730 <release>
80105d44:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80105d47:	e9 1d fe ff ff       	jmp    80105b69 <trap+0x39>
80105d4c:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105d4f:	e8 5c cb ff ff       	call   801028b0 <cpunum>
80105d54:	83 ec 0c             	sub    $0xc,%esp
80105d57:	57                   	push   %edi
80105d58:	56                   	push   %esi
80105d59:	50                   	push   %eax
80105d5a:	ff 73 30             	pushl  0x30(%ebx)
80105d5d:	68 30 7a 10 80       	push   $0x80107a30
80105d62:	e8 39 a9 ff ff       	call   801006a0 <cprintf>
      panic("trap");
80105d67:	83 c4 14             	add    $0x14,%esp
80105d6a:	68 06 7a 10 80       	push   $0x80107a06
80105d6f:	e8 0c a6 ff ff       	call   80100380 <panic>
80105d74:	66 90                	xchg   %ax,%ax
80105d76:	66 90                	xchg   %ax,%ax
80105d78:	66 90                	xchg   %ax,%ax
80105d7a:	66 90                	xchg   %ax,%ax
80105d7c:	66 90                	xchg   %ax,%ax
80105d7e:	66 90                	xchg   %ax,%ax

80105d80 <uartgetc>:
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105d80:	f3 0f 1e fb          	endbr32 
  if(!uart)
80105d84:	a1 c0 a5 10 80       	mov    0x8010a5c0,%eax
80105d89:	85 c0                	test   %eax,%eax
80105d8b:	74 1b                	je     80105da8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d8d:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d92:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105d93:	a8 01                	test   $0x1,%al
80105d95:	74 11                	je     80105da8 <uartgetc+0x28>
80105d97:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d9c:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105d9d:	0f b6 c0             	movzbl %al,%eax
80105da0:	c3                   	ret    
80105da1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105da8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105dad:	c3                   	ret    
80105dae:	66 90                	xchg   %ax,%ax

80105db0 <uartputc.part.0>:
uartputc(int c)
80105db0:	55                   	push   %ebp
80105db1:	89 e5                	mov    %esp,%ebp
80105db3:	57                   	push   %edi
80105db4:	89 c7                	mov    %eax,%edi
80105db6:	56                   	push   %esi
80105db7:	be fd 03 00 00       	mov    $0x3fd,%esi
80105dbc:	53                   	push   %ebx
80105dbd:	bb 80 00 00 00       	mov    $0x80,%ebx
80105dc2:	83 ec 0c             	sub    $0xc,%esp
80105dc5:	eb 1b                	jmp    80105de2 <uartputc.part.0+0x32>
80105dc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dce:	66 90                	xchg   %ax,%ax
    microdelay(10);
80105dd0:	83 ec 0c             	sub    $0xc,%esp
80105dd3:	6a 0a                	push   $0xa
80105dd5:	e8 96 cb ff ff       	call   80102970 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105dda:	83 c4 10             	add    $0x10,%esp
80105ddd:	83 eb 01             	sub    $0x1,%ebx
80105de0:	74 07                	je     80105de9 <uartputc.part.0+0x39>
80105de2:	89 f2                	mov    %esi,%edx
80105de4:	ec                   	in     (%dx),%al
80105de5:	a8 20                	test   $0x20,%al
80105de7:	74 e7                	je     80105dd0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105de9:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105dee:	89 f8                	mov    %edi,%eax
80105df0:	ee                   	out    %al,(%dx)
}
80105df1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105df4:	5b                   	pop    %ebx
80105df5:	5e                   	pop    %esi
80105df6:	5f                   	pop    %edi
80105df7:	5d                   	pop    %ebp
80105df8:	c3                   	ret    
80105df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e00 <uartinit>:
{
80105e00:	f3 0f 1e fb          	endbr32 
80105e04:	55                   	push   %ebp
80105e05:	31 c9                	xor    %ecx,%ecx
80105e07:	89 c8                	mov    %ecx,%eax
80105e09:	89 e5                	mov    %esp,%ebp
80105e0b:	57                   	push   %edi
80105e0c:	56                   	push   %esi
80105e0d:	53                   	push   %ebx
80105e0e:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105e13:	89 da                	mov    %ebx,%edx
80105e15:	83 ec 0c             	sub    $0xc,%esp
80105e18:	ee                   	out    %al,(%dx)
80105e19:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105e1e:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105e23:	89 fa                	mov    %edi,%edx
80105e25:	ee                   	out    %al,(%dx)
80105e26:	b8 0c 00 00 00       	mov    $0xc,%eax
80105e2b:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e30:	ee                   	out    %al,(%dx)
80105e31:	be f9 03 00 00       	mov    $0x3f9,%esi
80105e36:	89 c8                	mov    %ecx,%eax
80105e38:	89 f2                	mov    %esi,%edx
80105e3a:	ee                   	out    %al,(%dx)
80105e3b:	b8 03 00 00 00       	mov    $0x3,%eax
80105e40:	89 fa                	mov    %edi,%edx
80105e42:	ee                   	out    %al,(%dx)
80105e43:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105e48:	89 c8                	mov    %ecx,%eax
80105e4a:	ee                   	out    %al,(%dx)
80105e4b:	b8 01 00 00 00       	mov    $0x1,%eax
80105e50:	89 f2                	mov    %esi,%edx
80105e52:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105e53:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105e58:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105e59:	3c ff                	cmp    $0xff,%al
80105e5b:	74 62                	je     80105ebf <uartinit+0xbf>
  uart = 1;
80105e5d:	c7 05 c0 a5 10 80 01 	movl   $0x1,0x8010a5c0
80105e64:	00 00 00 
80105e67:	89 da                	mov    %ebx,%edx
80105e69:	ec                   	in     (%dx),%al
80105e6a:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e6f:	ec                   	in     (%dx),%al
  picenable(IRQ_COM1);
80105e70:	83 ec 0c             	sub    $0xc,%esp
  ioapicenable(IRQ_COM1, 0);
80105e73:	be 76 00 00 00       	mov    $0x76,%esi
  picenable(IRQ_COM1);
80105e78:	6a 04                	push   $0x4
80105e7a:	e8 11 d6 ff ff       	call   80103490 <picenable>
  ioapicenable(IRQ_COM1, 0);
80105e7f:	59                   	pop    %ecx
80105e80:	5b                   	pop    %ebx
80105e81:	6a 00                	push   $0x0
80105e83:	6a 04                	push   $0x4
  for(p="xv6...\n"; *p; p++)
80105e85:	bb 28 7b 10 80       	mov    $0x80107b28,%ebx
  ioapicenable(IRQ_COM1, 0);
80105e8a:	e8 a1 c5 ff ff       	call   80102430 <ioapicenable>
80105e8f:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105e92:	b8 78 00 00 00       	mov    $0x78,%eax
80105e97:	eb 0b                	jmp    80105ea4 <uartinit+0xa4>
80105e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ea0:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
  if(!uart)
80105ea4:	8b 15 c0 a5 10 80    	mov    0x8010a5c0,%edx
80105eaa:	85 d2                	test   %edx,%edx
80105eac:	74 08                	je     80105eb6 <uartinit+0xb6>
    uartputc(*p);
80105eae:	0f be c0             	movsbl %al,%eax
80105eb1:	e8 fa fe ff ff       	call   80105db0 <uartputc.part.0>
  for(p="xv6...\n"; *p; p++)
80105eb6:	89 f0                	mov    %esi,%eax
80105eb8:	83 c3 01             	add    $0x1,%ebx
80105ebb:	84 c0                	test   %al,%al
80105ebd:	75 e1                	jne    80105ea0 <uartinit+0xa0>
}
80105ebf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ec2:	5b                   	pop    %ebx
80105ec3:	5e                   	pop    %esi
80105ec4:	5f                   	pop    %edi
80105ec5:	5d                   	pop    %ebp
80105ec6:	c3                   	ret    
80105ec7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ece:	66 90                	xchg   %ax,%ax

80105ed0 <uartputc>:
{
80105ed0:	f3 0f 1e fb          	endbr32 
80105ed4:	55                   	push   %ebp
  if(!uart)
80105ed5:	8b 15 c0 a5 10 80    	mov    0x8010a5c0,%edx
{
80105edb:	89 e5                	mov    %esp,%ebp
80105edd:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105ee0:	85 d2                	test   %edx,%edx
80105ee2:	74 0c                	je     80105ef0 <uartputc+0x20>
}
80105ee4:	5d                   	pop    %ebp
80105ee5:	e9 c6 fe ff ff       	jmp    80105db0 <uartputc.part.0>
80105eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105ef0:	5d                   	pop    %ebp
80105ef1:	c3                   	ret    
80105ef2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105f00 <uartintr>:

void
uartintr(void)
{
80105f00:	f3 0f 1e fb          	endbr32 
80105f04:	55                   	push   %ebp
80105f05:	89 e5                	mov    %esp,%ebp
80105f07:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105f0a:	68 80 5d 10 80       	push   $0x80105d80
80105f0f:	e8 3c a9 ff ff       	call   80100850 <consoleintr>
}
80105f14:	83 c4 10             	add    $0x10,%esp
80105f17:	c9                   	leave  
80105f18:	c3                   	ret    

80105f19 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105f19:	6a 00                	push   $0x0
  pushl $0
80105f1b:	6a 00                	push   $0x0
  jmp alltraps
80105f1d:	e9 30 fb ff ff       	jmp    80105a52 <alltraps>

80105f22 <vector1>:
.globl vector1
vector1:
  pushl $0
80105f22:	6a 00                	push   $0x0
  pushl $1
80105f24:	6a 01                	push   $0x1
  jmp alltraps
80105f26:	e9 27 fb ff ff       	jmp    80105a52 <alltraps>

80105f2b <vector2>:
.globl vector2
vector2:
  pushl $0
80105f2b:	6a 00                	push   $0x0
  pushl $2
80105f2d:	6a 02                	push   $0x2
  jmp alltraps
80105f2f:	e9 1e fb ff ff       	jmp    80105a52 <alltraps>

80105f34 <vector3>:
.globl vector3
vector3:
  pushl $0
80105f34:	6a 00                	push   $0x0
  pushl $3
80105f36:	6a 03                	push   $0x3
  jmp alltraps
80105f38:	e9 15 fb ff ff       	jmp    80105a52 <alltraps>

80105f3d <vector4>:
.globl vector4
vector4:
  pushl $0
80105f3d:	6a 00                	push   $0x0
  pushl $4
80105f3f:	6a 04                	push   $0x4
  jmp alltraps
80105f41:	e9 0c fb ff ff       	jmp    80105a52 <alltraps>

80105f46 <vector5>:
.globl vector5
vector5:
  pushl $0
80105f46:	6a 00                	push   $0x0
  pushl $5
80105f48:	6a 05                	push   $0x5
  jmp alltraps
80105f4a:	e9 03 fb ff ff       	jmp    80105a52 <alltraps>

80105f4f <vector6>:
.globl vector6
vector6:
  pushl $0
80105f4f:	6a 00                	push   $0x0
  pushl $6
80105f51:	6a 06                	push   $0x6
  jmp alltraps
80105f53:	e9 fa fa ff ff       	jmp    80105a52 <alltraps>

80105f58 <vector7>:
.globl vector7
vector7:
  pushl $0
80105f58:	6a 00                	push   $0x0
  pushl $7
80105f5a:	6a 07                	push   $0x7
  jmp alltraps
80105f5c:	e9 f1 fa ff ff       	jmp    80105a52 <alltraps>

80105f61 <vector8>:
.globl vector8
vector8:
  pushl $8
80105f61:	6a 08                	push   $0x8
  jmp alltraps
80105f63:	e9 ea fa ff ff       	jmp    80105a52 <alltraps>

80105f68 <vector9>:
.globl vector9
vector9:
  pushl $0
80105f68:	6a 00                	push   $0x0
  pushl $9
80105f6a:	6a 09                	push   $0x9
  jmp alltraps
80105f6c:	e9 e1 fa ff ff       	jmp    80105a52 <alltraps>

80105f71 <vector10>:
.globl vector10
vector10:
  pushl $10
80105f71:	6a 0a                	push   $0xa
  jmp alltraps
80105f73:	e9 da fa ff ff       	jmp    80105a52 <alltraps>

80105f78 <vector11>:
.globl vector11
vector11:
  pushl $11
80105f78:	6a 0b                	push   $0xb
  jmp alltraps
80105f7a:	e9 d3 fa ff ff       	jmp    80105a52 <alltraps>

80105f7f <vector12>:
.globl vector12
vector12:
  pushl $12
80105f7f:	6a 0c                	push   $0xc
  jmp alltraps
80105f81:	e9 cc fa ff ff       	jmp    80105a52 <alltraps>

80105f86 <vector13>:
.globl vector13
vector13:
  pushl $13
80105f86:	6a 0d                	push   $0xd
  jmp alltraps
80105f88:	e9 c5 fa ff ff       	jmp    80105a52 <alltraps>

80105f8d <vector14>:
.globl vector14
vector14:
  pushl $14
80105f8d:	6a 0e                	push   $0xe
  jmp alltraps
80105f8f:	e9 be fa ff ff       	jmp    80105a52 <alltraps>

80105f94 <vector15>:
.globl vector15
vector15:
  pushl $0
80105f94:	6a 00                	push   $0x0
  pushl $15
80105f96:	6a 0f                	push   $0xf
  jmp alltraps
80105f98:	e9 b5 fa ff ff       	jmp    80105a52 <alltraps>

80105f9d <vector16>:
.globl vector16
vector16:
  pushl $0
80105f9d:	6a 00                	push   $0x0
  pushl $16
80105f9f:	6a 10                	push   $0x10
  jmp alltraps
80105fa1:	e9 ac fa ff ff       	jmp    80105a52 <alltraps>

80105fa6 <vector17>:
.globl vector17
vector17:
  pushl $17
80105fa6:	6a 11                	push   $0x11
  jmp alltraps
80105fa8:	e9 a5 fa ff ff       	jmp    80105a52 <alltraps>

80105fad <vector18>:
.globl vector18
vector18:
  pushl $0
80105fad:	6a 00                	push   $0x0
  pushl $18
80105faf:	6a 12                	push   $0x12
  jmp alltraps
80105fb1:	e9 9c fa ff ff       	jmp    80105a52 <alltraps>

80105fb6 <vector19>:
.globl vector19
vector19:
  pushl $0
80105fb6:	6a 00                	push   $0x0
  pushl $19
80105fb8:	6a 13                	push   $0x13
  jmp alltraps
80105fba:	e9 93 fa ff ff       	jmp    80105a52 <alltraps>

80105fbf <vector20>:
.globl vector20
vector20:
  pushl $0
80105fbf:	6a 00                	push   $0x0
  pushl $20
80105fc1:	6a 14                	push   $0x14
  jmp alltraps
80105fc3:	e9 8a fa ff ff       	jmp    80105a52 <alltraps>

80105fc8 <vector21>:
.globl vector21
vector21:
  pushl $0
80105fc8:	6a 00                	push   $0x0
  pushl $21
80105fca:	6a 15                	push   $0x15
  jmp alltraps
80105fcc:	e9 81 fa ff ff       	jmp    80105a52 <alltraps>

80105fd1 <vector22>:
.globl vector22
vector22:
  pushl $0
80105fd1:	6a 00                	push   $0x0
  pushl $22
80105fd3:	6a 16                	push   $0x16
  jmp alltraps
80105fd5:	e9 78 fa ff ff       	jmp    80105a52 <alltraps>

80105fda <vector23>:
.globl vector23
vector23:
  pushl $0
80105fda:	6a 00                	push   $0x0
  pushl $23
80105fdc:	6a 17                	push   $0x17
  jmp alltraps
80105fde:	e9 6f fa ff ff       	jmp    80105a52 <alltraps>

80105fe3 <vector24>:
.globl vector24
vector24:
  pushl $0
80105fe3:	6a 00                	push   $0x0
  pushl $24
80105fe5:	6a 18                	push   $0x18
  jmp alltraps
80105fe7:	e9 66 fa ff ff       	jmp    80105a52 <alltraps>

80105fec <vector25>:
.globl vector25
vector25:
  pushl $0
80105fec:	6a 00                	push   $0x0
  pushl $25
80105fee:	6a 19                	push   $0x19
  jmp alltraps
80105ff0:	e9 5d fa ff ff       	jmp    80105a52 <alltraps>

80105ff5 <vector26>:
.globl vector26
vector26:
  pushl $0
80105ff5:	6a 00                	push   $0x0
  pushl $26
80105ff7:	6a 1a                	push   $0x1a
  jmp alltraps
80105ff9:	e9 54 fa ff ff       	jmp    80105a52 <alltraps>

80105ffe <vector27>:
.globl vector27
vector27:
  pushl $0
80105ffe:	6a 00                	push   $0x0
  pushl $27
80106000:	6a 1b                	push   $0x1b
  jmp alltraps
80106002:	e9 4b fa ff ff       	jmp    80105a52 <alltraps>

80106007 <vector28>:
.globl vector28
vector28:
  pushl $0
80106007:	6a 00                	push   $0x0
  pushl $28
80106009:	6a 1c                	push   $0x1c
  jmp alltraps
8010600b:	e9 42 fa ff ff       	jmp    80105a52 <alltraps>

80106010 <vector29>:
.globl vector29
vector29:
  pushl $0
80106010:	6a 00                	push   $0x0
  pushl $29
80106012:	6a 1d                	push   $0x1d
  jmp alltraps
80106014:	e9 39 fa ff ff       	jmp    80105a52 <alltraps>

80106019 <vector30>:
.globl vector30
vector30:
  pushl $0
80106019:	6a 00                	push   $0x0
  pushl $30
8010601b:	6a 1e                	push   $0x1e
  jmp alltraps
8010601d:	e9 30 fa ff ff       	jmp    80105a52 <alltraps>

80106022 <vector31>:
.globl vector31
vector31:
  pushl $0
80106022:	6a 00                	push   $0x0
  pushl $31
80106024:	6a 1f                	push   $0x1f
  jmp alltraps
80106026:	e9 27 fa ff ff       	jmp    80105a52 <alltraps>

8010602b <vector32>:
.globl vector32
vector32:
  pushl $0
8010602b:	6a 00                	push   $0x0
  pushl $32
8010602d:	6a 20                	push   $0x20
  jmp alltraps
8010602f:	e9 1e fa ff ff       	jmp    80105a52 <alltraps>

80106034 <vector33>:
.globl vector33
vector33:
  pushl $0
80106034:	6a 00                	push   $0x0
  pushl $33
80106036:	6a 21                	push   $0x21
  jmp alltraps
80106038:	e9 15 fa ff ff       	jmp    80105a52 <alltraps>

8010603d <vector34>:
.globl vector34
vector34:
  pushl $0
8010603d:	6a 00                	push   $0x0
  pushl $34
8010603f:	6a 22                	push   $0x22
  jmp alltraps
80106041:	e9 0c fa ff ff       	jmp    80105a52 <alltraps>

80106046 <vector35>:
.globl vector35
vector35:
  pushl $0
80106046:	6a 00                	push   $0x0
  pushl $35
80106048:	6a 23                	push   $0x23
  jmp alltraps
8010604a:	e9 03 fa ff ff       	jmp    80105a52 <alltraps>

8010604f <vector36>:
.globl vector36
vector36:
  pushl $0
8010604f:	6a 00                	push   $0x0
  pushl $36
80106051:	6a 24                	push   $0x24
  jmp alltraps
80106053:	e9 fa f9 ff ff       	jmp    80105a52 <alltraps>

80106058 <vector37>:
.globl vector37
vector37:
  pushl $0
80106058:	6a 00                	push   $0x0
  pushl $37
8010605a:	6a 25                	push   $0x25
  jmp alltraps
8010605c:	e9 f1 f9 ff ff       	jmp    80105a52 <alltraps>

80106061 <vector38>:
.globl vector38
vector38:
  pushl $0
80106061:	6a 00                	push   $0x0
  pushl $38
80106063:	6a 26                	push   $0x26
  jmp alltraps
80106065:	e9 e8 f9 ff ff       	jmp    80105a52 <alltraps>

8010606a <vector39>:
.globl vector39
vector39:
  pushl $0
8010606a:	6a 00                	push   $0x0
  pushl $39
8010606c:	6a 27                	push   $0x27
  jmp alltraps
8010606e:	e9 df f9 ff ff       	jmp    80105a52 <alltraps>

80106073 <vector40>:
.globl vector40
vector40:
  pushl $0
80106073:	6a 00                	push   $0x0
  pushl $40
80106075:	6a 28                	push   $0x28
  jmp alltraps
80106077:	e9 d6 f9 ff ff       	jmp    80105a52 <alltraps>

8010607c <vector41>:
.globl vector41
vector41:
  pushl $0
8010607c:	6a 00                	push   $0x0
  pushl $41
8010607e:	6a 29                	push   $0x29
  jmp alltraps
80106080:	e9 cd f9 ff ff       	jmp    80105a52 <alltraps>

80106085 <vector42>:
.globl vector42
vector42:
  pushl $0
80106085:	6a 00                	push   $0x0
  pushl $42
80106087:	6a 2a                	push   $0x2a
  jmp alltraps
80106089:	e9 c4 f9 ff ff       	jmp    80105a52 <alltraps>

8010608e <vector43>:
.globl vector43
vector43:
  pushl $0
8010608e:	6a 00                	push   $0x0
  pushl $43
80106090:	6a 2b                	push   $0x2b
  jmp alltraps
80106092:	e9 bb f9 ff ff       	jmp    80105a52 <alltraps>

80106097 <vector44>:
.globl vector44
vector44:
  pushl $0
80106097:	6a 00                	push   $0x0
  pushl $44
80106099:	6a 2c                	push   $0x2c
  jmp alltraps
8010609b:	e9 b2 f9 ff ff       	jmp    80105a52 <alltraps>

801060a0 <vector45>:
.globl vector45
vector45:
  pushl $0
801060a0:	6a 00                	push   $0x0
  pushl $45
801060a2:	6a 2d                	push   $0x2d
  jmp alltraps
801060a4:	e9 a9 f9 ff ff       	jmp    80105a52 <alltraps>

801060a9 <vector46>:
.globl vector46
vector46:
  pushl $0
801060a9:	6a 00                	push   $0x0
  pushl $46
801060ab:	6a 2e                	push   $0x2e
  jmp alltraps
801060ad:	e9 a0 f9 ff ff       	jmp    80105a52 <alltraps>

801060b2 <vector47>:
.globl vector47
vector47:
  pushl $0
801060b2:	6a 00                	push   $0x0
  pushl $47
801060b4:	6a 2f                	push   $0x2f
  jmp alltraps
801060b6:	e9 97 f9 ff ff       	jmp    80105a52 <alltraps>

801060bb <vector48>:
.globl vector48
vector48:
  pushl $0
801060bb:	6a 00                	push   $0x0
  pushl $48
801060bd:	6a 30                	push   $0x30
  jmp alltraps
801060bf:	e9 8e f9 ff ff       	jmp    80105a52 <alltraps>

801060c4 <vector49>:
.globl vector49
vector49:
  pushl $0
801060c4:	6a 00                	push   $0x0
  pushl $49
801060c6:	6a 31                	push   $0x31
  jmp alltraps
801060c8:	e9 85 f9 ff ff       	jmp    80105a52 <alltraps>

801060cd <vector50>:
.globl vector50
vector50:
  pushl $0
801060cd:	6a 00                	push   $0x0
  pushl $50
801060cf:	6a 32                	push   $0x32
  jmp alltraps
801060d1:	e9 7c f9 ff ff       	jmp    80105a52 <alltraps>

801060d6 <vector51>:
.globl vector51
vector51:
  pushl $0
801060d6:	6a 00                	push   $0x0
  pushl $51
801060d8:	6a 33                	push   $0x33
  jmp alltraps
801060da:	e9 73 f9 ff ff       	jmp    80105a52 <alltraps>

801060df <vector52>:
.globl vector52
vector52:
  pushl $0
801060df:	6a 00                	push   $0x0
  pushl $52
801060e1:	6a 34                	push   $0x34
  jmp alltraps
801060e3:	e9 6a f9 ff ff       	jmp    80105a52 <alltraps>

801060e8 <vector53>:
.globl vector53
vector53:
  pushl $0
801060e8:	6a 00                	push   $0x0
  pushl $53
801060ea:	6a 35                	push   $0x35
  jmp alltraps
801060ec:	e9 61 f9 ff ff       	jmp    80105a52 <alltraps>

801060f1 <vector54>:
.globl vector54
vector54:
  pushl $0
801060f1:	6a 00                	push   $0x0
  pushl $54
801060f3:	6a 36                	push   $0x36
  jmp alltraps
801060f5:	e9 58 f9 ff ff       	jmp    80105a52 <alltraps>

801060fa <vector55>:
.globl vector55
vector55:
  pushl $0
801060fa:	6a 00                	push   $0x0
  pushl $55
801060fc:	6a 37                	push   $0x37
  jmp alltraps
801060fe:	e9 4f f9 ff ff       	jmp    80105a52 <alltraps>

80106103 <vector56>:
.globl vector56
vector56:
  pushl $0
80106103:	6a 00                	push   $0x0
  pushl $56
80106105:	6a 38                	push   $0x38
  jmp alltraps
80106107:	e9 46 f9 ff ff       	jmp    80105a52 <alltraps>

8010610c <vector57>:
.globl vector57
vector57:
  pushl $0
8010610c:	6a 00                	push   $0x0
  pushl $57
8010610e:	6a 39                	push   $0x39
  jmp alltraps
80106110:	e9 3d f9 ff ff       	jmp    80105a52 <alltraps>

80106115 <vector58>:
.globl vector58
vector58:
  pushl $0
80106115:	6a 00                	push   $0x0
  pushl $58
80106117:	6a 3a                	push   $0x3a
  jmp alltraps
80106119:	e9 34 f9 ff ff       	jmp    80105a52 <alltraps>

8010611e <vector59>:
.globl vector59
vector59:
  pushl $0
8010611e:	6a 00                	push   $0x0
  pushl $59
80106120:	6a 3b                	push   $0x3b
  jmp alltraps
80106122:	e9 2b f9 ff ff       	jmp    80105a52 <alltraps>

80106127 <vector60>:
.globl vector60
vector60:
  pushl $0
80106127:	6a 00                	push   $0x0
  pushl $60
80106129:	6a 3c                	push   $0x3c
  jmp alltraps
8010612b:	e9 22 f9 ff ff       	jmp    80105a52 <alltraps>

80106130 <vector61>:
.globl vector61
vector61:
  pushl $0
80106130:	6a 00                	push   $0x0
  pushl $61
80106132:	6a 3d                	push   $0x3d
  jmp alltraps
80106134:	e9 19 f9 ff ff       	jmp    80105a52 <alltraps>

80106139 <vector62>:
.globl vector62
vector62:
  pushl $0
80106139:	6a 00                	push   $0x0
  pushl $62
8010613b:	6a 3e                	push   $0x3e
  jmp alltraps
8010613d:	e9 10 f9 ff ff       	jmp    80105a52 <alltraps>

80106142 <vector63>:
.globl vector63
vector63:
  pushl $0
80106142:	6a 00                	push   $0x0
  pushl $63
80106144:	6a 3f                	push   $0x3f
  jmp alltraps
80106146:	e9 07 f9 ff ff       	jmp    80105a52 <alltraps>

8010614b <vector64>:
.globl vector64
vector64:
  pushl $0
8010614b:	6a 00                	push   $0x0
  pushl $64
8010614d:	6a 40                	push   $0x40
  jmp alltraps
8010614f:	e9 fe f8 ff ff       	jmp    80105a52 <alltraps>

80106154 <vector65>:
.globl vector65
vector65:
  pushl $0
80106154:	6a 00                	push   $0x0
  pushl $65
80106156:	6a 41                	push   $0x41
  jmp alltraps
80106158:	e9 f5 f8 ff ff       	jmp    80105a52 <alltraps>

8010615d <vector66>:
.globl vector66
vector66:
  pushl $0
8010615d:	6a 00                	push   $0x0
  pushl $66
8010615f:	6a 42                	push   $0x42
  jmp alltraps
80106161:	e9 ec f8 ff ff       	jmp    80105a52 <alltraps>

80106166 <vector67>:
.globl vector67
vector67:
  pushl $0
80106166:	6a 00                	push   $0x0
  pushl $67
80106168:	6a 43                	push   $0x43
  jmp alltraps
8010616a:	e9 e3 f8 ff ff       	jmp    80105a52 <alltraps>

8010616f <vector68>:
.globl vector68
vector68:
  pushl $0
8010616f:	6a 00                	push   $0x0
  pushl $68
80106171:	6a 44                	push   $0x44
  jmp alltraps
80106173:	e9 da f8 ff ff       	jmp    80105a52 <alltraps>

80106178 <vector69>:
.globl vector69
vector69:
  pushl $0
80106178:	6a 00                	push   $0x0
  pushl $69
8010617a:	6a 45                	push   $0x45
  jmp alltraps
8010617c:	e9 d1 f8 ff ff       	jmp    80105a52 <alltraps>

80106181 <vector70>:
.globl vector70
vector70:
  pushl $0
80106181:	6a 00                	push   $0x0
  pushl $70
80106183:	6a 46                	push   $0x46
  jmp alltraps
80106185:	e9 c8 f8 ff ff       	jmp    80105a52 <alltraps>

8010618a <vector71>:
.globl vector71
vector71:
  pushl $0
8010618a:	6a 00                	push   $0x0
  pushl $71
8010618c:	6a 47                	push   $0x47
  jmp alltraps
8010618e:	e9 bf f8 ff ff       	jmp    80105a52 <alltraps>

80106193 <vector72>:
.globl vector72
vector72:
  pushl $0
80106193:	6a 00                	push   $0x0
  pushl $72
80106195:	6a 48                	push   $0x48
  jmp alltraps
80106197:	e9 b6 f8 ff ff       	jmp    80105a52 <alltraps>

8010619c <vector73>:
.globl vector73
vector73:
  pushl $0
8010619c:	6a 00                	push   $0x0
  pushl $73
8010619e:	6a 49                	push   $0x49
  jmp alltraps
801061a0:	e9 ad f8 ff ff       	jmp    80105a52 <alltraps>

801061a5 <vector74>:
.globl vector74
vector74:
  pushl $0
801061a5:	6a 00                	push   $0x0
  pushl $74
801061a7:	6a 4a                	push   $0x4a
  jmp alltraps
801061a9:	e9 a4 f8 ff ff       	jmp    80105a52 <alltraps>

801061ae <vector75>:
.globl vector75
vector75:
  pushl $0
801061ae:	6a 00                	push   $0x0
  pushl $75
801061b0:	6a 4b                	push   $0x4b
  jmp alltraps
801061b2:	e9 9b f8 ff ff       	jmp    80105a52 <alltraps>

801061b7 <vector76>:
.globl vector76
vector76:
  pushl $0
801061b7:	6a 00                	push   $0x0
  pushl $76
801061b9:	6a 4c                	push   $0x4c
  jmp alltraps
801061bb:	e9 92 f8 ff ff       	jmp    80105a52 <alltraps>

801061c0 <vector77>:
.globl vector77
vector77:
  pushl $0
801061c0:	6a 00                	push   $0x0
  pushl $77
801061c2:	6a 4d                	push   $0x4d
  jmp alltraps
801061c4:	e9 89 f8 ff ff       	jmp    80105a52 <alltraps>

801061c9 <vector78>:
.globl vector78
vector78:
  pushl $0
801061c9:	6a 00                	push   $0x0
  pushl $78
801061cb:	6a 4e                	push   $0x4e
  jmp alltraps
801061cd:	e9 80 f8 ff ff       	jmp    80105a52 <alltraps>

801061d2 <vector79>:
.globl vector79
vector79:
  pushl $0
801061d2:	6a 00                	push   $0x0
  pushl $79
801061d4:	6a 4f                	push   $0x4f
  jmp alltraps
801061d6:	e9 77 f8 ff ff       	jmp    80105a52 <alltraps>

801061db <vector80>:
.globl vector80
vector80:
  pushl $0
801061db:	6a 00                	push   $0x0
  pushl $80
801061dd:	6a 50                	push   $0x50
  jmp alltraps
801061df:	e9 6e f8 ff ff       	jmp    80105a52 <alltraps>

801061e4 <vector81>:
.globl vector81
vector81:
  pushl $0
801061e4:	6a 00                	push   $0x0
  pushl $81
801061e6:	6a 51                	push   $0x51
  jmp alltraps
801061e8:	e9 65 f8 ff ff       	jmp    80105a52 <alltraps>

801061ed <vector82>:
.globl vector82
vector82:
  pushl $0
801061ed:	6a 00                	push   $0x0
  pushl $82
801061ef:	6a 52                	push   $0x52
  jmp alltraps
801061f1:	e9 5c f8 ff ff       	jmp    80105a52 <alltraps>

801061f6 <vector83>:
.globl vector83
vector83:
  pushl $0
801061f6:	6a 00                	push   $0x0
  pushl $83
801061f8:	6a 53                	push   $0x53
  jmp alltraps
801061fa:	e9 53 f8 ff ff       	jmp    80105a52 <alltraps>

801061ff <vector84>:
.globl vector84
vector84:
  pushl $0
801061ff:	6a 00                	push   $0x0
  pushl $84
80106201:	6a 54                	push   $0x54
  jmp alltraps
80106203:	e9 4a f8 ff ff       	jmp    80105a52 <alltraps>

80106208 <vector85>:
.globl vector85
vector85:
  pushl $0
80106208:	6a 00                	push   $0x0
  pushl $85
8010620a:	6a 55                	push   $0x55
  jmp alltraps
8010620c:	e9 41 f8 ff ff       	jmp    80105a52 <alltraps>

80106211 <vector86>:
.globl vector86
vector86:
  pushl $0
80106211:	6a 00                	push   $0x0
  pushl $86
80106213:	6a 56                	push   $0x56
  jmp alltraps
80106215:	e9 38 f8 ff ff       	jmp    80105a52 <alltraps>

8010621a <vector87>:
.globl vector87
vector87:
  pushl $0
8010621a:	6a 00                	push   $0x0
  pushl $87
8010621c:	6a 57                	push   $0x57
  jmp alltraps
8010621e:	e9 2f f8 ff ff       	jmp    80105a52 <alltraps>

80106223 <vector88>:
.globl vector88
vector88:
  pushl $0
80106223:	6a 00                	push   $0x0
  pushl $88
80106225:	6a 58                	push   $0x58
  jmp alltraps
80106227:	e9 26 f8 ff ff       	jmp    80105a52 <alltraps>

8010622c <vector89>:
.globl vector89
vector89:
  pushl $0
8010622c:	6a 00                	push   $0x0
  pushl $89
8010622e:	6a 59                	push   $0x59
  jmp alltraps
80106230:	e9 1d f8 ff ff       	jmp    80105a52 <alltraps>

80106235 <vector90>:
.globl vector90
vector90:
  pushl $0
80106235:	6a 00                	push   $0x0
  pushl $90
80106237:	6a 5a                	push   $0x5a
  jmp alltraps
80106239:	e9 14 f8 ff ff       	jmp    80105a52 <alltraps>

8010623e <vector91>:
.globl vector91
vector91:
  pushl $0
8010623e:	6a 00                	push   $0x0
  pushl $91
80106240:	6a 5b                	push   $0x5b
  jmp alltraps
80106242:	e9 0b f8 ff ff       	jmp    80105a52 <alltraps>

80106247 <vector92>:
.globl vector92
vector92:
  pushl $0
80106247:	6a 00                	push   $0x0
  pushl $92
80106249:	6a 5c                	push   $0x5c
  jmp alltraps
8010624b:	e9 02 f8 ff ff       	jmp    80105a52 <alltraps>

80106250 <vector93>:
.globl vector93
vector93:
  pushl $0
80106250:	6a 00                	push   $0x0
  pushl $93
80106252:	6a 5d                	push   $0x5d
  jmp alltraps
80106254:	e9 f9 f7 ff ff       	jmp    80105a52 <alltraps>

80106259 <vector94>:
.globl vector94
vector94:
  pushl $0
80106259:	6a 00                	push   $0x0
  pushl $94
8010625b:	6a 5e                	push   $0x5e
  jmp alltraps
8010625d:	e9 f0 f7 ff ff       	jmp    80105a52 <alltraps>

80106262 <vector95>:
.globl vector95
vector95:
  pushl $0
80106262:	6a 00                	push   $0x0
  pushl $95
80106264:	6a 5f                	push   $0x5f
  jmp alltraps
80106266:	e9 e7 f7 ff ff       	jmp    80105a52 <alltraps>

8010626b <vector96>:
.globl vector96
vector96:
  pushl $0
8010626b:	6a 00                	push   $0x0
  pushl $96
8010626d:	6a 60                	push   $0x60
  jmp alltraps
8010626f:	e9 de f7 ff ff       	jmp    80105a52 <alltraps>

80106274 <vector97>:
.globl vector97
vector97:
  pushl $0
80106274:	6a 00                	push   $0x0
  pushl $97
80106276:	6a 61                	push   $0x61
  jmp alltraps
80106278:	e9 d5 f7 ff ff       	jmp    80105a52 <alltraps>

8010627d <vector98>:
.globl vector98
vector98:
  pushl $0
8010627d:	6a 00                	push   $0x0
  pushl $98
8010627f:	6a 62                	push   $0x62
  jmp alltraps
80106281:	e9 cc f7 ff ff       	jmp    80105a52 <alltraps>

80106286 <vector99>:
.globl vector99
vector99:
  pushl $0
80106286:	6a 00                	push   $0x0
  pushl $99
80106288:	6a 63                	push   $0x63
  jmp alltraps
8010628a:	e9 c3 f7 ff ff       	jmp    80105a52 <alltraps>

8010628f <vector100>:
.globl vector100
vector100:
  pushl $0
8010628f:	6a 00                	push   $0x0
  pushl $100
80106291:	6a 64                	push   $0x64
  jmp alltraps
80106293:	e9 ba f7 ff ff       	jmp    80105a52 <alltraps>

80106298 <vector101>:
.globl vector101
vector101:
  pushl $0
80106298:	6a 00                	push   $0x0
  pushl $101
8010629a:	6a 65                	push   $0x65
  jmp alltraps
8010629c:	e9 b1 f7 ff ff       	jmp    80105a52 <alltraps>

801062a1 <vector102>:
.globl vector102
vector102:
  pushl $0
801062a1:	6a 00                	push   $0x0
  pushl $102
801062a3:	6a 66                	push   $0x66
  jmp alltraps
801062a5:	e9 a8 f7 ff ff       	jmp    80105a52 <alltraps>

801062aa <vector103>:
.globl vector103
vector103:
  pushl $0
801062aa:	6a 00                	push   $0x0
  pushl $103
801062ac:	6a 67                	push   $0x67
  jmp alltraps
801062ae:	e9 9f f7 ff ff       	jmp    80105a52 <alltraps>

801062b3 <vector104>:
.globl vector104
vector104:
  pushl $0
801062b3:	6a 00                	push   $0x0
  pushl $104
801062b5:	6a 68                	push   $0x68
  jmp alltraps
801062b7:	e9 96 f7 ff ff       	jmp    80105a52 <alltraps>

801062bc <vector105>:
.globl vector105
vector105:
  pushl $0
801062bc:	6a 00                	push   $0x0
  pushl $105
801062be:	6a 69                	push   $0x69
  jmp alltraps
801062c0:	e9 8d f7 ff ff       	jmp    80105a52 <alltraps>

801062c5 <vector106>:
.globl vector106
vector106:
  pushl $0
801062c5:	6a 00                	push   $0x0
  pushl $106
801062c7:	6a 6a                	push   $0x6a
  jmp alltraps
801062c9:	e9 84 f7 ff ff       	jmp    80105a52 <alltraps>

801062ce <vector107>:
.globl vector107
vector107:
  pushl $0
801062ce:	6a 00                	push   $0x0
  pushl $107
801062d0:	6a 6b                	push   $0x6b
  jmp alltraps
801062d2:	e9 7b f7 ff ff       	jmp    80105a52 <alltraps>

801062d7 <vector108>:
.globl vector108
vector108:
  pushl $0
801062d7:	6a 00                	push   $0x0
  pushl $108
801062d9:	6a 6c                	push   $0x6c
  jmp alltraps
801062db:	e9 72 f7 ff ff       	jmp    80105a52 <alltraps>

801062e0 <vector109>:
.globl vector109
vector109:
  pushl $0
801062e0:	6a 00                	push   $0x0
  pushl $109
801062e2:	6a 6d                	push   $0x6d
  jmp alltraps
801062e4:	e9 69 f7 ff ff       	jmp    80105a52 <alltraps>

801062e9 <vector110>:
.globl vector110
vector110:
  pushl $0
801062e9:	6a 00                	push   $0x0
  pushl $110
801062eb:	6a 6e                	push   $0x6e
  jmp alltraps
801062ed:	e9 60 f7 ff ff       	jmp    80105a52 <alltraps>

801062f2 <vector111>:
.globl vector111
vector111:
  pushl $0
801062f2:	6a 00                	push   $0x0
  pushl $111
801062f4:	6a 6f                	push   $0x6f
  jmp alltraps
801062f6:	e9 57 f7 ff ff       	jmp    80105a52 <alltraps>

801062fb <vector112>:
.globl vector112
vector112:
  pushl $0
801062fb:	6a 00                	push   $0x0
  pushl $112
801062fd:	6a 70                	push   $0x70
  jmp alltraps
801062ff:	e9 4e f7 ff ff       	jmp    80105a52 <alltraps>

80106304 <vector113>:
.globl vector113
vector113:
  pushl $0
80106304:	6a 00                	push   $0x0
  pushl $113
80106306:	6a 71                	push   $0x71
  jmp alltraps
80106308:	e9 45 f7 ff ff       	jmp    80105a52 <alltraps>

8010630d <vector114>:
.globl vector114
vector114:
  pushl $0
8010630d:	6a 00                	push   $0x0
  pushl $114
8010630f:	6a 72                	push   $0x72
  jmp alltraps
80106311:	e9 3c f7 ff ff       	jmp    80105a52 <alltraps>

80106316 <vector115>:
.globl vector115
vector115:
  pushl $0
80106316:	6a 00                	push   $0x0
  pushl $115
80106318:	6a 73                	push   $0x73
  jmp alltraps
8010631a:	e9 33 f7 ff ff       	jmp    80105a52 <alltraps>

8010631f <vector116>:
.globl vector116
vector116:
  pushl $0
8010631f:	6a 00                	push   $0x0
  pushl $116
80106321:	6a 74                	push   $0x74
  jmp alltraps
80106323:	e9 2a f7 ff ff       	jmp    80105a52 <alltraps>

80106328 <vector117>:
.globl vector117
vector117:
  pushl $0
80106328:	6a 00                	push   $0x0
  pushl $117
8010632a:	6a 75                	push   $0x75
  jmp alltraps
8010632c:	e9 21 f7 ff ff       	jmp    80105a52 <alltraps>

80106331 <vector118>:
.globl vector118
vector118:
  pushl $0
80106331:	6a 00                	push   $0x0
  pushl $118
80106333:	6a 76                	push   $0x76
  jmp alltraps
80106335:	e9 18 f7 ff ff       	jmp    80105a52 <alltraps>

8010633a <vector119>:
.globl vector119
vector119:
  pushl $0
8010633a:	6a 00                	push   $0x0
  pushl $119
8010633c:	6a 77                	push   $0x77
  jmp alltraps
8010633e:	e9 0f f7 ff ff       	jmp    80105a52 <alltraps>

80106343 <vector120>:
.globl vector120
vector120:
  pushl $0
80106343:	6a 00                	push   $0x0
  pushl $120
80106345:	6a 78                	push   $0x78
  jmp alltraps
80106347:	e9 06 f7 ff ff       	jmp    80105a52 <alltraps>

8010634c <vector121>:
.globl vector121
vector121:
  pushl $0
8010634c:	6a 00                	push   $0x0
  pushl $121
8010634e:	6a 79                	push   $0x79
  jmp alltraps
80106350:	e9 fd f6 ff ff       	jmp    80105a52 <alltraps>

80106355 <vector122>:
.globl vector122
vector122:
  pushl $0
80106355:	6a 00                	push   $0x0
  pushl $122
80106357:	6a 7a                	push   $0x7a
  jmp alltraps
80106359:	e9 f4 f6 ff ff       	jmp    80105a52 <alltraps>

8010635e <vector123>:
.globl vector123
vector123:
  pushl $0
8010635e:	6a 00                	push   $0x0
  pushl $123
80106360:	6a 7b                	push   $0x7b
  jmp alltraps
80106362:	e9 eb f6 ff ff       	jmp    80105a52 <alltraps>

80106367 <vector124>:
.globl vector124
vector124:
  pushl $0
80106367:	6a 00                	push   $0x0
  pushl $124
80106369:	6a 7c                	push   $0x7c
  jmp alltraps
8010636b:	e9 e2 f6 ff ff       	jmp    80105a52 <alltraps>

80106370 <vector125>:
.globl vector125
vector125:
  pushl $0
80106370:	6a 00                	push   $0x0
  pushl $125
80106372:	6a 7d                	push   $0x7d
  jmp alltraps
80106374:	e9 d9 f6 ff ff       	jmp    80105a52 <alltraps>

80106379 <vector126>:
.globl vector126
vector126:
  pushl $0
80106379:	6a 00                	push   $0x0
  pushl $126
8010637b:	6a 7e                	push   $0x7e
  jmp alltraps
8010637d:	e9 d0 f6 ff ff       	jmp    80105a52 <alltraps>

80106382 <vector127>:
.globl vector127
vector127:
  pushl $0
80106382:	6a 00                	push   $0x0
  pushl $127
80106384:	6a 7f                	push   $0x7f
  jmp alltraps
80106386:	e9 c7 f6 ff ff       	jmp    80105a52 <alltraps>

8010638b <vector128>:
.globl vector128
vector128:
  pushl $0
8010638b:	6a 00                	push   $0x0
  pushl $128
8010638d:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106392:	e9 bb f6 ff ff       	jmp    80105a52 <alltraps>

80106397 <vector129>:
.globl vector129
vector129:
  pushl $0
80106397:	6a 00                	push   $0x0
  pushl $129
80106399:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010639e:	e9 af f6 ff ff       	jmp    80105a52 <alltraps>

801063a3 <vector130>:
.globl vector130
vector130:
  pushl $0
801063a3:	6a 00                	push   $0x0
  pushl $130
801063a5:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801063aa:	e9 a3 f6 ff ff       	jmp    80105a52 <alltraps>

801063af <vector131>:
.globl vector131
vector131:
  pushl $0
801063af:	6a 00                	push   $0x0
  pushl $131
801063b1:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801063b6:	e9 97 f6 ff ff       	jmp    80105a52 <alltraps>

801063bb <vector132>:
.globl vector132
vector132:
  pushl $0
801063bb:	6a 00                	push   $0x0
  pushl $132
801063bd:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801063c2:	e9 8b f6 ff ff       	jmp    80105a52 <alltraps>

801063c7 <vector133>:
.globl vector133
vector133:
  pushl $0
801063c7:	6a 00                	push   $0x0
  pushl $133
801063c9:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801063ce:	e9 7f f6 ff ff       	jmp    80105a52 <alltraps>

801063d3 <vector134>:
.globl vector134
vector134:
  pushl $0
801063d3:	6a 00                	push   $0x0
  pushl $134
801063d5:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801063da:	e9 73 f6 ff ff       	jmp    80105a52 <alltraps>

801063df <vector135>:
.globl vector135
vector135:
  pushl $0
801063df:	6a 00                	push   $0x0
  pushl $135
801063e1:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801063e6:	e9 67 f6 ff ff       	jmp    80105a52 <alltraps>

801063eb <vector136>:
.globl vector136
vector136:
  pushl $0
801063eb:	6a 00                	push   $0x0
  pushl $136
801063ed:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801063f2:	e9 5b f6 ff ff       	jmp    80105a52 <alltraps>

801063f7 <vector137>:
.globl vector137
vector137:
  pushl $0
801063f7:	6a 00                	push   $0x0
  pushl $137
801063f9:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801063fe:	e9 4f f6 ff ff       	jmp    80105a52 <alltraps>

80106403 <vector138>:
.globl vector138
vector138:
  pushl $0
80106403:	6a 00                	push   $0x0
  pushl $138
80106405:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
8010640a:	e9 43 f6 ff ff       	jmp    80105a52 <alltraps>

8010640f <vector139>:
.globl vector139
vector139:
  pushl $0
8010640f:	6a 00                	push   $0x0
  pushl $139
80106411:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106416:	e9 37 f6 ff ff       	jmp    80105a52 <alltraps>

8010641b <vector140>:
.globl vector140
vector140:
  pushl $0
8010641b:	6a 00                	push   $0x0
  pushl $140
8010641d:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106422:	e9 2b f6 ff ff       	jmp    80105a52 <alltraps>

80106427 <vector141>:
.globl vector141
vector141:
  pushl $0
80106427:	6a 00                	push   $0x0
  pushl $141
80106429:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010642e:	e9 1f f6 ff ff       	jmp    80105a52 <alltraps>

80106433 <vector142>:
.globl vector142
vector142:
  pushl $0
80106433:	6a 00                	push   $0x0
  pushl $142
80106435:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
8010643a:	e9 13 f6 ff ff       	jmp    80105a52 <alltraps>

8010643f <vector143>:
.globl vector143
vector143:
  pushl $0
8010643f:	6a 00                	push   $0x0
  pushl $143
80106441:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106446:	e9 07 f6 ff ff       	jmp    80105a52 <alltraps>

8010644b <vector144>:
.globl vector144
vector144:
  pushl $0
8010644b:	6a 00                	push   $0x0
  pushl $144
8010644d:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106452:	e9 fb f5 ff ff       	jmp    80105a52 <alltraps>

80106457 <vector145>:
.globl vector145
vector145:
  pushl $0
80106457:	6a 00                	push   $0x0
  pushl $145
80106459:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010645e:	e9 ef f5 ff ff       	jmp    80105a52 <alltraps>

80106463 <vector146>:
.globl vector146
vector146:
  pushl $0
80106463:	6a 00                	push   $0x0
  pushl $146
80106465:	68 92 00 00 00       	push   $0x92
  jmp alltraps
8010646a:	e9 e3 f5 ff ff       	jmp    80105a52 <alltraps>

8010646f <vector147>:
.globl vector147
vector147:
  pushl $0
8010646f:	6a 00                	push   $0x0
  pushl $147
80106471:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106476:	e9 d7 f5 ff ff       	jmp    80105a52 <alltraps>

8010647b <vector148>:
.globl vector148
vector148:
  pushl $0
8010647b:	6a 00                	push   $0x0
  pushl $148
8010647d:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106482:	e9 cb f5 ff ff       	jmp    80105a52 <alltraps>

80106487 <vector149>:
.globl vector149
vector149:
  pushl $0
80106487:	6a 00                	push   $0x0
  pushl $149
80106489:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010648e:	e9 bf f5 ff ff       	jmp    80105a52 <alltraps>

80106493 <vector150>:
.globl vector150
vector150:
  pushl $0
80106493:	6a 00                	push   $0x0
  pushl $150
80106495:	68 96 00 00 00       	push   $0x96
  jmp alltraps
8010649a:	e9 b3 f5 ff ff       	jmp    80105a52 <alltraps>

8010649f <vector151>:
.globl vector151
vector151:
  pushl $0
8010649f:	6a 00                	push   $0x0
  pushl $151
801064a1:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801064a6:	e9 a7 f5 ff ff       	jmp    80105a52 <alltraps>

801064ab <vector152>:
.globl vector152
vector152:
  pushl $0
801064ab:	6a 00                	push   $0x0
  pushl $152
801064ad:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801064b2:	e9 9b f5 ff ff       	jmp    80105a52 <alltraps>

801064b7 <vector153>:
.globl vector153
vector153:
  pushl $0
801064b7:	6a 00                	push   $0x0
  pushl $153
801064b9:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801064be:	e9 8f f5 ff ff       	jmp    80105a52 <alltraps>

801064c3 <vector154>:
.globl vector154
vector154:
  pushl $0
801064c3:	6a 00                	push   $0x0
  pushl $154
801064c5:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801064ca:	e9 83 f5 ff ff       	jmp    80105a52 <alltraps>

801064cf <vector155>:
.globl vector155
vector155:
  pushl $0
801064cf:	6a 00                	push   $0x0
  pushl $155
801064d1:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801064d6:	e9 77 f5 ff ff       	jmp    80105a52 <alltraps>

801064db <vector156>:
.globl vector156
vector156:
  pushl $0
801064db:	6a 00                	push   $0x0
  pushl $156
801064dd:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801064e2:	e9 6b f5 ff ff       	jmp    80105a52 <alltraps>

801064e7 <vector157>:
.globl vector157
vector157:
  pushl $0
801064e7:	6a 00                	push   $0x0
  pushl $157
801064e9:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801064ee:	e9 5f f5 ff ff       	jmp    80105a52 <alltraps>

801064f3 <vector158>:
.globl vector158
vector158:
  pushl $0
801064f3:	6a 00                	push   $0x0
  pushl $158
801064f5:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801064fa:	e9 53 f5 ff ff       	jmp    80105a52 <alltraps>

801064ff <vector159>:
.globl vector159
vector159:
  pushl $0
801064ff:	6a 00                	push   $0x0
  pushl $159
80106501:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106506:	e9 47 f5 ff ff       	jmp    80105a52 <alltraps>

8010650b <vector160>:
.globl vector160
vector160:
  pushl $0
8010650b:	6a 00                	push   $0x0
  pushl $160
8010650d:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106512:	e9 3b f5 ff ff       	jmp    80105a52 <alltraps>

80106517 <vector161>:
.globl vector161
vector161:
  pushl $0
80106517:	6a 00                	push   $0x0
  pushl $161
80106519:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010651e:	e9 2f f5 ff ff       	jmp    80105a52 <alltraps>

80106523 <vector162>:
.globl vector162
vector162:
  pushl $0
80106523:	6a 00                	push   $0x0
  pushl $162
80106525:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
8010652a:	e9 23 f5 ff ff       	jmp    80105a52 <alltraps>

8010652f <vector163>:
.globl vector163
vector163:
  pushl $0
8010652f:	6a 00                	push   $0x0
  pushl $163
80106531:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106536:	e9 17 f5 ff ff       	jmp    80105a52 <alltraps>

8010653b <vector164>:
.globl vector164
vector164:
  pushl $0
8010653b:	6a 00                	push   $0x0
  pushl $164
8010653d:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106542:	e9 0b f5 ff ff       	jmp    80105a52 <alltraps>

80106547 <vector165>:
.globl vector165
vector165:
  pushl $0
80106547:	6a 00                	push   $0x0
  pushl $165
80106549:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010654e:	e9 ff f4 ff ff       	jmp    80105a52 <alltraps>

80106553 <vector166>:
.globl vector166
vector166:
  pushl $0
80106553:	6a 00                	push   $0x0
  pushl $166
80106555:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
8010655a:	e9 f3 f4 ff ff       	jmp    80105a52 <alltraps>

8010655f <vector167>:
.globl vector167
vector167:
  pushl $0
8010655f:	6a 00                	push   $0x0
  pushl $167
80106561:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106566:	e9 e7 f4 ff ff       	jmp    80105a52 <alltraps>

8010656b <vector168>:
.globl vector168
vector168:
  pushl $0
8010656b:	6a 00                	push   $0x0
  pushl $168
8010656d:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106572:	e9 db f4 ff ff       	jmp    80105a52 <alltraps>

80106577 <vector169>:
.globl vector169
vector169:
  pushl $0
80106577:	6a 00                	push   $0x0
  pushl $169
80106579:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010657e:	e9 cf f4 ff ff       	jmp    80105a52 <alltraps>

80106583 <vector170>:
.globl vector170
vector170:
  pushl $0
80106583:	6a 00                	push   $0x0
  pushl $170
80106585:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
8010658a:	e9 c3 f4 ff ff       	jmp    80105a52 <alltraps>

8010658f <vector171>:
.globl vector171
vector171:
  pushl $0
8010658f:	6a 00                	push   $0x0
  pushl $171
80106591:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106596:	e9 b7 f4 ff ff       	jmp    80105a52 <alltraps>

8010659b <vector172>:
.globl vector172
vector172:
  pushl $0
8010659b:	6a 00                	push   $0x0
  pushl $172
8010659d:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801065a2:	e9 ab f4 ff ff       	jmp    80105a52 <alltraps>

801065a7 <vector173>:
.globl vector173
vector173:
  pushl $0
801065a7:	6a 00                	push   $0x0
  pushl $173
801065a9:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801065ae:	e9 9f f4 ff ff       	jmp    80105a52 <alltraps>

801065b3 <vector174>:
.globl vector174
vector174:
  pushl $0
801065b3:	6a 00                	push   $0x0
  pushl $174
801065b5:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801065ba:	e9 93 f4 ff ff       	jmp    80105a52 <alltraps>

801065bf <vector175>:
.globl vector175
vector175:
  pushl $0
801065bf:	6a 00                	push   $0x0
  pushl $175
801065c1:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801065c6:	e9 87 f4 ff ff       	jmp    80105a52 <alltraps>

801065cb <vector176>:
.globl vector176
vector176:
  pushl $0
801065cb:	6a 00                	push   $0x0
  pushl $176
801065cd:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801065d2:	e9 7b f4 ff ff       	jmp    80105a52 <alltraps>

801065d7 <vector177>:
.globl vector177
vector177:
  pushl $0
801065d7:	6a 00                	push   $0x0
  pushl $177
801065d9:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801065de:	e9 6f f4 ff ff       	jmp    80105a52 <alltraps>

801065e3 <vector178>:
.globl vector178
vector178:
  pushl $0
801065e3:	6a 00                	push   $0x0
  pushl $178
801065e5:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801065ea:	e9 63 f4 ff ff       	jmp    80105a52 <alltraps>

801065ef <vector179>:
.globl vector179
vector179:
  pushl $0
801065ef:	6a 00                	push   $0x0
  pushl $179
801065f1:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801065f6:	e9 57 f4 ff ff       	jmp    80105a52 <alltraps>

801065fb <vector180>:
.globl vector180
vector180:
  pushl $0
801065fb:	6a 00                	push   $0x0
  pushl $180
801065fd:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106602:	e9 4b f4 ff ff       	jmp    80105a52 <alltraps>

80106607 <vector181>:
.globl vector181
vector181:
  pushl $0
80106607:	6a 00                	push   $0x0
  pushl $181
80106609:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010660e:	e9 3f f4 ff ff       	jmp    80105a52 <alltraps>

80106613 <vector182>:
.globl vector182
vector182:
  pushl $0
80106613:	6a 00                	push   $0x0
  pushl $182
80106615:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
8010661a:	e9 33 f4 ff ff       	jmp    80105a52 <alltraps>

8010661f <vector183>:
.globl vector183
vector183:
  pushl $0
8010661f:	6a 00                	push   $0x0
  pushl $183
80106621:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106626:	e9 27 f4 ff ff       	jmp    80105a52 <alltraps>

8010662b <vector184>:
.globl vector184
vector184:
  pushl $0
8010662b:	6a 00                	push   $0x0
  pushl $184
8010662d:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106632:	e9 1b f4 ff ff       	jmp    80105a52 <alltraps>

80106637 <vector185>:
.globl vector185
vector185:
  pushl $0
80106637:	6a 00                	push   $0x0
  pushl $185
80106639:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010663e:	e9 0f f4 ff ff       	jmp    80105a52 <alltraps>

80106643 <vector186>:
.globl vector186
vector186:
  pushl $0
80106643:	6a 00                	push   $0x0
  pushl $186
80106645:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
8010664a:	e9 03 f4 ff ff       	jmp    80105a52 <alltraps>

8010664f <vector187>:
.globl vector187
vector187:
  pushl $0
8010664f:	6a 00                	push   $0x0
  pushl $187
80106651:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106656:	e9 f7 f3 ff ff       	jmp    80105a52 <alltraps>

8010665b <vector188>:
.globl vector188
vector188:
  pushl $0
8010665b:	6a 00                	push   $0x0
  pushl $188
8010665d:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106662:	e9 eb f3 ff ff       	jmp    80105a52 <alltraps>

80106667 <vector189>:
.globl vector189
vector189:
  pushl $0
80106667:	6a 00                	push   $0x0
  pushl $189
80106669:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010666e:	e9 df f3 ff ff       	jmp    80105a52 <alltraps>

80106673 <vector190>:
.globl vector190
vector190:
  pushl $0
80106673:	6a 00                	push   $0x0
  pushl $190
80106675:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
8010667a:	e9 d3 f3 ff ff       	jmp    80105a52 <alltraps>

8010667f <vector191>:
.globl vector191
vector191:
  pushl $0
8010667f:	6a 00                	push   $0x0
  pushl $191
80106681:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106686:	e9 c7 f3 ff ff       	jmp    80105a52 <alltraps>

8010668b <vector192>:
.globl vector192
vector192:
  pushl $0
8010668b:	6a 00                	push   $0x0
  pushl $192
8010668d:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106692:	e9 bb f3 ff ff       	jmp    80105a52 <alltraps>

80106697 <vector193>:
.globl vector193
vector193:
  pushl $0
80106697:	6a 00                	push   $0x0
  pushl $193
80106699:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010669e:	e9 af f3 ff ff       	jmp    80105a52 <alltraps>

801066a3 <vector194>:
.globl vector194
vector194:
  pushl $0
801066a3:	6a 00                	push   $0x0
  pushl $194
801066a5:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801066aa:	e9 a3 f3 ff ff       	jmp    80105a52 <alltraps>

801066af <vector195>:
.globl vector195
vector195:
  pushl $0
801066af:	6a 00                	push   $0x0
  pushl $195
801066b1:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801066b6:	e9 97 f3 ff ff       	jmp    80105a52 <alltraps>

801066bb <vector196>:
.globl vector196
vector196:
  pushl $0
801066bb:	6a 00                	push   $0x0
  pushl $196
801066bd:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801066c2:	e9 8b f3 ff ff       	jmp    80105a52 <alltraps>

801066c7 <vector197>:
.globl vector197
vector197:
  pushl $0
801066c7:	6a 00                	push   $0x0
  pushl $197
801066c9:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801066ce:	e9 7f f3 ff ff       	jmp    80105a52 <alltraps>

801066d3 <vector198>:
.globl vector198
vector198:
  pushl $0
801066d3:	6a 00                	push   $0x0
  pushl $198
801066d5:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801066da:	e9 73 f3 ff ff       	jmp    80105a52 <alltraps>

801066df <vector199>:
.globl vector199
vector199:
  pushl $0
801066df:	6a 00                	push   $0x0
  pushl $199
801066e1:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801066e6:	e9 67 f3 ff ff       	jmp    80105a52 <alltraps>

801066eb <vector200>:
.globl vector200
vector200:
  pushl $0
801066eb:	6a 00                	push   $0x0
  pushl $200
801066ed:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801066f2:	e9 5b f3 ff ff       	jmp    80105a52 <alltraps>

801066f7 <vector201>:
.globl vector201
vector201:
  pushl $0
801066f7:	6a 00                	push   $0x0
  pushl $201
801066f9:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801066fe:	e9 4f f3 ff ff       	jmp    80105a52 <alltraps>

80106703 <vector202>:
.globl vector202
vector202:
  pushl $0
80106703:	6a 00                	push   $0x0
  pushl $202
80106705:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
8010670a:	e9 43 f3 ff ff       	jmp    80105a52 <alltraps>

8010670f <vector203>:
.globl vector203
vector203:
  pushl $0
8010670f:	6a 00                	push   $0x0
  pushl $203
80106711:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106716:	e9 37 f3 ff ff       	jmp    80105a52 <alltraps>

8010671b <vector204>:
.globl vector204
vector204:
  pushl $0
8010671b:	6a 00                	push   $0x0
  pushl $204
8010671d:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106722:	e9 2b f3 ff ff       	jmp    80105a52 <alltraps>

80106727 <vector205>:
.globl vector205
vector205:
  pushl $0
80106727:	6a 00                	push   $0x0
  pushl $205
80106729:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010672e:	e9 1f f3 ff ff       	jmp    80105a52 <alltraps>

80106733 <vector206>:
.globl vector206
vector206:
  pushl $0
80106733:	6a 00                	push   $0x0
  pushl $206
80106735:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
8010673a:	e9 13 f3 ff ff       	jmp    80105a52 <alltraps>

8010673f <vector207>:
.globl vector207
vector207:
  pushl $0
8010673f:	6a 00                	push   $0x0
  pushl $207
80106741:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106746:	e9 07 f3 ff ff       	jmp    80105a52 <alltraps>

8010674b <vector208>:
.globl vector208
vector208:
  pushl $0
8010674b:	6a 00                	push   $0x0
  pushl $208
8010674d:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106752:	e9 fb f2 ff ff       	jmp    80105a52 <alltraps>

80106757 <vector209>:
.globl vector209
vector209:
  pushl $0
80106757:	6a 00                	push   $0x0
  pushl $209
80106759:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010675e:	e9 ef f2 ff ff       	jmp    80105a52 <alltraps>

80106763 <vector210>:
.globl vector210
vector210:
  pushl $0
80106763:	6a 00                	push   $0x0
  pushl $210
80106765:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
8010676a:	e9 e3 f2 ff ff       	jmp    80105a52 <alltraps>

8010676f <vector211>:
.globl vector211
vector211:
  pushl $0
8010676f:	6a 00                	push   $0x0
  pushl $211
80106771:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106776:	e9 d7 f2 ff ff       	jmp    80105a52 <alltraps>

8010677b <vector212>:
.globl vector212
vector212:
  pushl $0
8010677b:	6a 00                	push   $0x0
  pushl $212
8010677d:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106782:	e9 cb f2 ff ff       	jmp    80105a52 <alltraps>

80106787 <vector213>:
.globl vector213
vector213:
  pushl $0
80106787:	6a 00                	push   $0x0
  pushl $213
80106789:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010678e:	e9 bf f2 ff ff       	jmp    80105a52 <alltraps>

80106793 <vector214>:
.globl vector214
vector214:
  pushl $0
80106793:	6a 00                	push   $0x0
  pushl $214
80106795:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
8010679a:	e9 b3 f2 ff ff       	jmp    80105a52 <alltraps>

8010679f <vector215>:
.globl vector215
vector215:
  pushl $0
8010679f:	6a 00                	push   $0x0
  pushl $215
801067a1:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801067a6:	e9 a7 f2 ff ff       	jmp    80105a52 <alltraps>

801067ab <vector216>:
.globl vector216
vector216:
  pushl $0
801067ab:	6a 00                	push   $0x0
  pushl $216
801067ad:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801067b2:	e9 9b f2 ff ff       	jmp    80105a52 <alltraps>

801067b7 <vector217>:
.globl vector217
vector217:
  pushl $0
801067b7:	6a 00                	push   $0x0
  pushl $217
801067b9:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801067be:	e9 8f f2 ff ff       	jmp    80105a52 <alltraps>

801067c3 <vector218>:
.globl vector218
vector218:
  pushl $0
801067c3:	6a 00                	push   $0x0
  pushl $218
801067c5:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801067ca:	e9 83 f2 ff ff       	jmp    80105a52 <alltraps>

801067cf <vector219>:
.globl vector219
vector219:
  pushl $0
801067cf:	6a 00                	push   $0x0
  pushl $219
801067d1:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801067d6:	e9 77 f2 ff ff       	jmp    80105a52 <alltraps>

801067db <vector220>:
.globl vector220
vector220:
  pushl $0
801067db:	6a 00                	push   $0x0
  pushl $220
801067dd:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801067e2:	e9 6b f2 ff ff       	jmp    80105a52 <alltraps>

801067e7 <vector221>:
.globl vector221
vector221:
  pushl $0
801067e7:	6a 00                	push   $0x0
  pushl $221
801067e9:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801067ee:	e9 5f f2 ff ff       	jmp    80105a52 <alltraps>

801067f3 <vector222>:
.globl vector222
vector222:
  pushl $0
801067f3:	6a 00                	push   $0x0
  pushl $222
801067f5:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801067fa:	e9 53 f2 ff ff       	jmp    80105a52 <alltraps>

801067ff <vector223>:
.globl vector223
vector223:
  pushl $0
801067ff:	6a 00                	push   $0x0
  pushl $223
80106801:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106806:	e9 47 f2 ff ff       	jmp    80105a52 <alltraps>

8010680b <vector224>:
.globl vector224
vector224:
  pushl $0
8010680b:	6a 00                	push   $0x0
  pushl $224
8010680d:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106812:	e9 3b f2 ff ff       	jmp    80105a52 <alltraps>

80106817 <vector225>:
.globl vector225
vector225:
  pushl $0
80106817:	6a 00                	push   $0x0
  pushl $225
80106819:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010681e:	e9 2f f2 ff ff       	jmp    80105a52 <alltraps>

80106823 <vector226>:
.globl vector226
vector226:
  pushl $0
80106823:	6a 00                	push   $0x0
  pushl $226
80106825:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
8010682a:	e9 23 f2 ff ff       	jmp    80105a52 <alltraps>

8010682f <vector227>:
.globl vector227
vector227:
  pushl $0
8010682f:	6a 00                	push   $0x0
  pushl $227
80106831:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106836:	e9 17 f2 ff ff       	jmp    80105a52 <alltraps>

8010683b <vector228>:
.globl vector228
vector228:
  pushl $0
8010683b:	6a 00                	push   $0x0
  pushl $228
8010683d:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106842:	e9 0b f2 ff ff       	jmp    80105a52 <alltraps>

80106847 <vector229>:
.globl vector229
vector229:
  pushl $0
80106847:	6a 00                	push   $0x0
  pushl $229
80106849:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010684e:	e9 ff f1 ff ff       	jmp    80105a52 <alltraps>

80106853 <vector230>:
.globl vector230
vector230:
  pushl $0
80106853:	6a 00                	push   $0x0
  pushl $230
80106855:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
8010685a:	e9 f3 f1 ff ff       	jmp    80105a52 <alltraps>

8010685f <vector231>:
.globl vector231
vector231:
  pushl $0
8010685f:	6a 00                	push   $0x0
  pushl $231
80106861:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106866:	e9 e7 f1 ff ff       	jmp    80105a52 <alltraps>

8010686b <vector232>:
.globl vector232
vector232:
  pushl $0
8010686b:	6a 00                	push   $0x0
  pushl $232
8010686d:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106872:	e9 db f1 ff ff       	jmp    80105a52 <alltraps>

80106877 <vector233>:
.globl vector233
vector233:
  pushl $0
80106877:	6a 00                	push   $0x0
  pushl $233
80106879:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010687e:	e9 cf f1 ff ff       	jmp    80105a52 <alltraps>

80106883 <vector234>:
.globl vector234
vector234:
  pushl $0
80106883:	6a 00                	push   $0x0
  pushl $234
80106885:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
8010688a:	e9 c3 f1 ff ff       	jmp    80105a52 <alltraps>

8010688f <vector235>:
.globl vector235
vector235:
  pushl $0
8010688f:	6a 00                	push   $0x0
  pushl $235
80106891:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106896:	e9 b7 f1 ff ff       	jmp    80105a52 <alltraps>

8010689b <vector236>:
.globl vector236
vector236:
  pushl $0
8010689b:	6a 00                	push   $0x0
  pushl $236
8010689d:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801068a2:	e9 ab f1 ff ff       	jmp    80105a52 <alltraps>

801068a7 <vector237>:
.globl vector237
vector237:
  pushl $0
801068a7:	6a 00                	push   $0x0
  pushl $237
801068a9:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801068ae:	e9 9f f1 ff ff       	jmp    80105a52 <alltraps>

801068b3 <vector238>:
.globl vector238
vector238:
  pushl $0
801068b3:	6a 00                	push   $0x0
  pushl $238
801068b5:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801068ba:	e9 93 f1 ff ff       	jmp    80105a52 <alltraps>

801068bf <vector239>:
.globl vector239
vector239:
  pushl $0
801068bf:	6a 00                	push   $0x0
  pushl $239
801068c1:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801068c6:	e9 87 f1 ff ff       	jmp    80105a52 <alltraps>

801068cb <vector240>:
.globl vector240
vector240:
  pushl $0
801068cb:	6a 00                	push   $0x0
  pushl $240
801068cd:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801068d2:	e9 7b f1 ff ff       	jmp    80105a52 <alltraps>

801068d7 <vector241>:
.globl vector241
vector241:
  pushl $0
801068d7:	6a 00                	push   $0x0
  pushl $241
801068d9:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801068de:	e9 6f f1 ff ff       	jmp    80105a52 <alltraps>

801068e3 <vector242>:
.globl vector242
vector242:
  pushl $0
801068e3:	6a 00                	push   $0x0
  pushl $242
801068e5:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801068ea:	e9 63 f1 ff ff       	jmp    80105a52 <alltraps>

801068ef <vector243>:
.globl vector243
vector243:
  pushl $0
801068ef:	6a 00                	push   $0x0
  pushl $243
801068f1:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801068f6:	e9 57 f1 ff ff       	jmp    80105a52 <alltraps>

801068fb <vector244>:
.globl vector244
vector244:
  pushl $0
801068fb:	6a 00                	push   $0x0
  pushl $244
801068fd:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106902:	e9 4b f1 ff ff       	jmp    80105a52 <alltraps>

80106907 <vector245>:
.globl vector245
vector245:
  pushl $0
80106907:	6a 00                	push   $0x0
  pushl $245
80106909:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010690e:	e9 3f f1 ff ff       	jmp    80105a52 <alltraps>

80106913 <vector246>:
.globl vector246
vector246:
  pushl $0
80106913:	6a 00                	push   $0x0
  pushl $246
80106915:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
8010691a:	e9 33 f1 ff ff       	jmp    80105a52 <alltraps>

8010691f <vector247>:
.globl vector247
vector247:
  pushl $0
8010691f:	6a 00                	push   $0x0
  pushl $247
80106921:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106926:	e9 27 f1 ff ff       	jmp    80105a52 <alltraps>

8010692b <vector248>:
.globl vector248
vector248:
  pushl $0
8010692b:	6a 00                	push   $0x0
  pushl $248
8010692d:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106932:	e9 1b f1 ff ff       	jmp    80105a52 <alltraps>

80106937 <vector249>:
.globl vector249
vector249:
  pushl $0
80106937:	6a 00                	push   $0x0
  pushl $249
80106939:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010693e:	e9 0f f1 ff ff       	jmp    80105a52 <alltraps>

80106943 <vector250>:
.globl vector250
vector250:
  pushl $0
80106943:	6a 00                	push   $0x0
  pushl $250
80106945:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
8010694a:	e9 03 f1 ff ff       	jmp    80105a52 <alltraps>

8010694f <vector251>:
.globl vector251
vector251:
  pushl $0
8010694f:	6a 00                	push   $0x0
  pushl $251
80106951:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106956:	e9 f7 f0 ff ff       	jmp    80105a52 <alltraps>

8010695b <vector252>:
.globl vector252
vector252:
  pushl $0
8010695b:	6a 00                	push   $0x0
  pushl $252
8010695d:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106962:	e9 eb f0 ff ff       	jmp    80105a52 <alltraps>

80106967 <vector253>:
.globl vector253
vector253:
  pushl $0
80106967:	6a 00                	push   $0x0
  pushl $253
80106969:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010696e:	e9 df f0 ff ff       	jmp    80105a52 <alltraps>

80106973 <vector254>:
.globl vector254
vector254:
  pushl $0
80106973:	6a 00                	push   $0x0
  pushl $254
80106975:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
8010697a:	e9 d3 f0 ff ff       	jmp    80105a52 <alltraps>

8010697f <vector255>:
.globl vector255
vector255:
  pushl $0
8010697f:	6a 00                	push   $0x0
  pushl $255
80106981:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106986:	e9 c7 f0 ff ff       	jmp    80105a52 <alltraps>
8010698b:	66 90                	xchg   %ax,%ax
8010698d:	66 90                	xchg   %ax,%ax
8010698f:	90                   	nop

80106990 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106990:	55                   	push   %ebp
80106991:	89 e5                	mov    %esp,%ebp
80106993:	57                   	push   %edi
80106994:	56                   	push   %esi
80106995:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106997:	c1 ea 16             	shr    $0x16,%edx
{
8010699a:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
8010699b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
8010699e:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
801069a1:	8b 1f                	mov    (%edi),%ebx
801069a3:	f6 c3 01             	test   $0x1,%bl
801069a6:	74 28                	je     801069d0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801069a8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801069ae:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801069b4:	89 f0                	mov    %esi,%eax
}
801069b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
801069b9:	c1 e8 0a             	shr    $0xa,%eax
801069bc:	25 fc 0f 00 00       	and    $0xffc,%eax
801069c1:	01 d8                	add    %ebx,%eax
}
801069c3:	5b                   	pop    %ebx
801069c4:	5e                   	pop    %esi
801069c5:	5f                   	pop    %edi
801069c6:	5d                   	pop    %ebp
801069c7:	c3                   	ret    
801069c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069cf:	90                   	nop
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801069d0:	85 c9                	test   %ecx,%ecx
801069d2:	74 2c                	je     80106a00 <walkpgdir+0x70>
801069d4:	e8 67 bc ff ff       	call   80102640 <kalloc>
801069d9:	89 c3                	mov    %eax,%ebx
801069db:	85 c0                	test   %eax,%eax
801069dd:	74 21                	je     80106a00 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
801069df:	83 ec 04             	sub    $0x4,%esp
801069e2:	68 00 10 00 00       	push   $0x1000
801069e7:	6a 00                	push   $0x0
801069e9:	50                   	push   %eax
801069ea:	e8 91 dd ff ff       	call   80104780 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801069ef:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801069f5:	83 c4 10             	add    $0x10,%esp
801069f8:	83 c8 07             	or     $0x7,%eax
801069fb:	89 07                	mov    %eax,(%edi)
801069fd:	eb b5                	jmp    801069b4 <walkpgdir+0x24>
801069ff:	90                   	nop
}
80106a00:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106a03:	31 c0                	xor    %eax,%eax
}
80106a05:	5b                   	pop    %ebx
80106a06:	5e                   	pop    %esi
80106a07:	5f                   	pop    %edi
80106a08:	5d                   	pop    %ebp
80106a09:	c3                   	ret    
80106a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106a10 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106a10:	55                   	push   %ebp
80106a11:	89 e5                	mov    %esp,%ebp
80106a13:	57                   	push   %edi
80106a14:	89 c7                	mov    %eax,%edi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106a16:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
{
80106a1a:	56                   	push   %esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106a1b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  a = (char*)PGROUNDDOWN((uint)va);
80106a20:	89 d6                	mov    %edx,%esi
{
80106a22:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106a23:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
{
80106a29:	83 ec 1c             	sub    $0x1c,%esp
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106a2c:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106a2f:	8b 45 08             	mov    0x8(%ebp),%eax
80106a32:	29 f0                	sub    %esi,%eax
80106a34:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106a37:	eb 1f                	jmp    80106a58 <mappages+0x48>
80106a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106a40:	f6 00 01             	testb  $0x1,(%eax)
80106a43:	75 45                	jne    80106a8a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106a45:	0b 5d 0c             	or     0xc(%ebp),%ebx
80106a48:	83 cb 01             	or     $0x1,%ebx
80106a4b:	89 18                	mov    %ebx,(%eax)
    if(a == last)
80106a4d:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80106a50:	74 2e                	je     80106a80 <mappages+0x70>
      break;
    a += PGSIZE;
80106a52:	81 c6 00 10 00 00    	add    $0x1000,%esi
  for(;;){
80106a58:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106a5b:	b9 01 00 00 00       	mov    $0x1,%ecx
80106a60:	89 f2                	mov    %esi,%edx
80106a62:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
80106a65:	89 f8                	mov    %edi,%eax
80106a67:	e8 24 ff ff ff       	call   80106990 <walkpgdir>
80106a6c:	85 c0                	test   %eax,%eax
80106a6e:	75 d0                	jne    80106a40 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80106a70:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106a73:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106a78:	5b                   	pop    %ebx
80106a79:	5e                   	pop    %esi
80106a7a:	5f                   	pop    %edi
80106a7b:	5d                   	pop    %ebp
80106a7c:	c3                   	ret    
80106a7d:	8d 76 00             	lea    0x0(%esi),%esi
80106a80:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106a83:	31 c0                	xor    %eax,%eax
}
80106a85:	5b                   	pop    %ebx
80106a86:	5e                   	pop    %esi
80106a87:	5f                   	pop    %edi
80106a88:	5d                   	pop    %ebp
80106a89:	c3                   	ret    
      panic("remap");
80106a8a:	83 ec 0c             	sub    $0xc,%esp
80106a8d:	68 30 7b 10 80       	push   $0x80107b30
80106a92:	e8 e9 98 ff ff       	call   80100380 <panic>
80106a97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a9e:	66 90                	xchg   %ax,%ax

80106aa0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106aa0:	55                   	push   %ebp
80106aa1:	89 e5                	mov    %esp,%ebp
80106aa3:	57                   	push   %edi
80106aa4:	56                   	push   %esi
80106aa5:	89 c6                	mov    %eax,%esi
80106aa7:	53                   	push   %ebx
80106aa8:	89 d3                	mov    %edx,%ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106aaa:	8d 91 ff 0f 00 00    	lea    0xfff(%ecx),%edx
80106ab0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106ab6:	83 ec 1c             	sub    $0x1c,%esp
80106ab9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106abc:	39 da                	cmp    %ebx,%edx
80106abe:	73 61                	jae    80106b21 <deallocuvm.part.0+0x81>
80106ac0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80106ac3:	89 d7                	mov    %edx,%edi
80106ac5:	eb 38                	jmp    80106aff <deallocuvm.part.0+0x5f>
80106ac7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ace:	66 90                	xchg   %ax,%ax
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a += (NPTENTRIES - 1) * PGSIZE;
    else if((*pte & PTE_P) != 0){
80106ad0:	8b 00                	mov    (%eax),%eax
80106ad2:	a8 01                	test   $0x1,%al
80106ad4:	74 1e                	je     80106af4 <deallocuvm.part.0+0x54>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106ad6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106adb:	74 4f                	je     80106b2c <deallocuvm.part.0+0x8c>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106add:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106ae0:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106ae5:	50                   	push   %eax
80106ae6:	e8 95 b9 ff ff       	call   80102480 <kfree>
      *pte = 0;
80106aeb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80106af1:	83 c4 10             	add    $0x10,%esp
  for(; a  < oldsz; a += PGSIZE){
80106af4:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106afa:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80106afd:	73 22                	jae    80106b21 <deallocuvm.part.0+0x81>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106aff:	31 c9                	xor    %ecx,%ecx
80106b01:	89 fa                	mov    %edi,%edx
80106b03:	89 f0                	mov    %esi,%eax
80106b05:	e8 86 fe ff ff       	call   80106990 <walkpgdir>
80106b0a:	89 c3                	mov    %eax,%ebx
    if(!pte)
80106b0c:	85 c0                	test   %eax,%eax
80106b0e:	75 c0                	jne    80106ad0 <deallocuvm.part.0+0x30>
      a += (NPTENTRIES - 1) * PGSIZE;
80106b10:	81 c7 00 f0 3f 00    	add    $0x3ff000,%edi
  for(; a  < oldsz; a += PGSIZE){
80106b16:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106b1c:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80106b1f:	72 de                	jb     80106aff <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80106b21:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106b24:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b27:	5b                   	pop    %ebx
80106b28:	5e                   	pop    %esi
80106b29:	5f                   	pop    %edi
80106b2a:	5d                   	pop    %ebp
80106b2b:	c3                   	ret    
        panic("kfree");
80106b2c:	83 ec 0c             	sub    $0xc,%esp
80106b2f:	68 fa 74 10 80       	push   $0x801074fa
80106b34:	e8 47 98 ff ff       	call   80100380 <panic>
80106b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106b40 <seginit>:
{
80106b40:	f3 0f 1e fb          	endbr32 
80106b44:	55                   	push   %ebp
80106b45:	89 e5                	mov    %esp,%ebp
80106b47:	53                   	push   %ebx
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106b48:	31 db                	xor    %ebx,%ebx
{
80106b4a:	83 ec 14             	sub    $0x14,%esp
  c = &cpus[cpunum()];
80106b4d:	e8 5e bd ff ff       	call   801028b0 <cpunum>
80106b52:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106b58:	8d 90 e0 12 11 80    	lea    -0x7feeed20(%eax),%edx
80106b5e:	8d 88 94 13 11 80    	lea    -0x7feeec6c(%eax),%ecx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106b64:	c7 80 58 13 11 80 ff 	movl   $0xffff,-0x7feeeca8(%eax)
80106b6b:	ff 00 00 
80106b6e:	c7 80 5c 13 11 80 00 	movl   $0xcf9a00,-0x7feeeca4(%eax)
80106b75:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106b78:	c7 80 60 13 11 80 ff 	movl   $0xffff,-0x7feeeca0(%eax)
80106b7f:	ff 00 00 
80106b82:	c7 80 64 13 11 80 00 	movl   $0xcf9200,-0x7feeec9c(%eax)
80106b89:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106b8c:	c7 80 70 13 11 80 ff 	movl   $0xffff,-0x7feeec90(%eax)
80106b93:	ff 00 00 
80106b96:	c7 80 74 13 11 80 00 	movl   $0xcffa00,-0x7feeec8c(%eax)
80106b9d:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106ba0:	c7 80 78 13 11 80 ff 	movl   $0xffff,-0x7feeec88(%eax)
80106ba7:	ff 00 00 
80106baa:	c7 80 7c 13 11 80 00 	movl   $0xcff200,-0x7feeec84(%eax)
80106bb1:	f2 cf 00 
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106bb4:	66 89 9a 88 00 00 00 	mov    %bx,0x88(%edx)
80106bbb:	89 cb                	mov    %ecx,%ebx
80106bbd:	c1 eb 10             	shr    $0x10,%ebx
80106bc0:	66 89 8a 8a 00 00 00 	mov    %cx,0x8a(%edx)
80106bc7:	c1 e9 18             	shr    $0x18,%ecx
80106bca:	88 9a 8c 00 00 00    	mov    %bl,0x8c(%edx)
80106bd0:	bb 92 c0 ff ff       	mov    $0xffffc092,%ebx
80106bd5:	66 89 98 6d 13 11 80 	mov    %bx,-0x7feeec93(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106bdc:	05 50 13 11 80       	add    $0x80111350,%eax
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106be1:	88 8a 8f 00 00 00    	mov    %cl,0x8f(%edx)
  pd[0] = size-1;
80106be7:	b9 37 00 00 00       	mov    $0x37,%ecx
80106bec:	66 89 4d f2          	mov    %cx,-0xe(%ebp)
  pd[1] = (uint)p;
80106bf0:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106bf4:	c1 e8 10             	shr    $0x10,%eax
80106bf7:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106bfb:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106bfe:	0f 01 10             	lgdtl  (%eax)
  asm volatile("movw %0, %%gs" : : "r" (v));
80106c01:	b8 18 00 00 00       	mov    $0x18,%eax
80106c06:	8e e8                	mov    %eax,%gs
  proc = 0;
80106c08:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80106c0f:	00 00 00 00 
  c = &cpus[cpunum()];
80106c13:	65 89 15 00 00 00 00 	mov    %edx,%gs:0x0
}
80106c1a:	83 c4 14             	add    $0x14,%esp
80106c1d:	5b                   	pop    %ebx
80106c1e:	5d                   	pop    %ebp
80106c1f:	c3                   	ret    

80106c20 <setupkvm>:
{
80106c20:	f3 0f 1e fb          	endbr32 
80106c24:	55                   	push   %ebp
80106c25:	89 e5                	mov    %esp,%ebp
80106c27:	56                   	push   %esi
80106c28:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106c29:	e8 12 ba ff ff       	call   80102640 <kalloc>
80106c2e:	85 c0                	test   %eax,%eax
80106c30:	74 4e                	je     80106c80 <setupkvm+0x60>
  memset(pgdir, 0, PGSIZE);
80106c32:	83 ec 04             	sub    $0x4,%esp
80106c35:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106c37:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106c3c:	68 00 10 00 00       	push   $0x1000
80106c41:	6a 00                	push   $0x0
80106c43:	50                   	push   %eax
80106c44:	e8 37 db ff ff       	call   80104780 <memset>
80106c49:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0)
80106c4c:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106c4f:	83 ec 08             	sub    $0x8,%esp
80106c52:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106c55:	ff 73 0c             	pushl  0xc(%ebx)
80106c58:	8b 13                	mov    (%ebx),%edx
80106c5a:	50                   	push   %eax
80106c5b:	29 c1                	sub    %eax,%ecx
80106c5d:	89 f0                	mov    %esi,%eax
80106c5f:	e8 ac fd ff ff       	call   80106a10 <mappages>
80106c64:	83 c4 10             	add    $0x10,%esp
80106c67:	85 c0                	test   %eax,%eax
80106c69:	78 15                	js     80106c80 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106c6b:	83 c3 10             	add    $0x10,%ebx
80106c6e:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106c74:	75 d6                	jne    80106c4c <setupkvm+0x2c>
}
80106c76:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106c79:	89 f0                	mov    %esi,%eax
80106c7b:	5b                   	pop    %ebx
80106c7c:	5e                   	pop    %esi
80106c7d:	5d                   	pop    %ebp
80106c7e:	c3                   	ret    
80106c7f:	90                   	nop
80106c80:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
80106c83:	31 f6                	xor    %esi,%esi
}
80106c85:	89 f0                	mov    %esi,%eax
80106c87:	5b                   	pop    %ebx
80106c88:	5e                   	pop    %esi
80106c89:	5d                   	pop    %ebp
80106c8a:	c3                   	ret    
80106c8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106c8f:	90                   	nop

80106c90 <kvmalloc>:
{
80106c90:	f3 0f 1e fb          	endbr32 
80106c94:	55                   	push   %ebp
80106c95:	89 e5                	mov    %esp,%ebp
80106c97:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106c9a:	e8 81 ff ff ff       	call   80106c20 <setupkvm>
80106c9f:	a3 64 42 11 80       	mov    %eax,0x80114264
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106ca4:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106ca9:	0f 22 d8             	mov    %eax,%cr3
}
80106cac:	c9                   	leave  
80106cad:	c3                   	ret    
80106cae:	66 90                	xchg   %ax,%ax

80106cb0 <switchkvm>:
{
80106cb0:	f3 0f 1e fb          	endbr32 
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106cb4:	a1 64 42 11 80       	mov    0x80114264,%eax
80106cb9:	05 00 00 00 80       	add    $0x80000000,%eax
80106cbe:	0f 22 d8             	mov    %eax,%cr3
}
80106cc1:	c3                   	ret    
80106cc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106cd0 <switchuvm>:
{
80106cd0:	f3 0f 1e fb          	endbr32 
80106cd4:	55                   	push   %ebp
80106cd5:	89 e5                	mov    %esp,%ebp
80106cd7:	53                   	push   %ebx
80106cd8:	83 ec 04             	sub    $0x4,%esp
80106cdb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80106cde:	e8 cd d9 ff ff       	call   801046b0 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106ce3:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106ce9:	b9 67 00 00 00       	mov    $0x67,%ecx
80106cee:	8d 50 08             	lea    0x8(%eax),%edx
80106cf1:	66 89 88 a0 00 00 00 	mov    %cx,0xa0(%eax)
80106cf8:	66 89 90 a2 00 00 00 	mov    %dx,0xa2(%eax)
80106cff:	89 d1                	mov    %edx,%ecx
80106d01:	c1 ea 18             	shr    $0x18,%edx
80106d04:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
80106d0a:	ba 89 40 00 00       	mov    $0x4089,%edx
80106d0f:	c1 e9 10             	shr    $0x10,%ecx
80106d12:	66 89 90 a5 00 00 00 	mov    %dx,0xa5(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80106d19:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106d20:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80106d26:	b9 10 00 00 00       	mov    $0x10,%ecx
80106d2b:	66 89 48 10          	mov    %cx,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80106d2f:	8b 52 08             	mov    0x8(%edx),%edx
80106d32:	81 c2 00 10 00 00    	add    $0x1000,%edx
80106d38:	89 50 0c             	mov    %edx,0xc(%eax)
  cpu->ts.iomb = (ushort) 0xFFFF;
80106d3b:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106d40:	66 89 50 6e          	mov    %dx,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106d44:	b8 30 00 00 00       	mov    $0x30,%eax
80106d49:	0f 00 d8             	ltr    %ax
  if(p->pgdir == 0)
80106d4c:	8b 43 04             	mov    0x4(%ebx),%eax
80106d4f:	85 c0                	test   %eax,%eax
80106d51:	74 11                	je     80106d64 <switchuvm+0x94>
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106d53:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106d58:	0f 22 d8             	mov    %eax,%cr3
}
80106d5b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106d5e:	c9                   	leave  
  popcli();
80106d5f:	e9 7c d9 ff ff       	jmp    801046e0 <popcli>
    panic("switchuvm: no pgdir");
80106d64:	83 ec 0c             	sub    $0xc,%esp
80106d67:	68 36 7b 10 80       	push   $0x80107b36
80106d6c:	e8 0f 96 ff ff       	call   80100380 <panic>
80106d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d7f:	90                   	nop

80106d80 <inituvm>:
{
80106d80:	f3 0f 1e fb          	endbr32 
80106d84:	55                   	push   %ebp
80106d85:	89 e5                	mov    %esp,%ebp
80106d87:	57                   	push   %edi
80106d88:	56                   	push   %esi
80106d89:	53                   	push   %ebx
80106d8a:	83 ec 1c             	sub    $0x1c,%esp
80106d8d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106d90:	8b 75 10             	mov    0x10(%ebp),%esi
80106d93:	8b 7d 08             	mov    0x8(%ebp),%edi
80106d96:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106d99:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106d9f:	77 4b                	ja     80106dec <inituvm+0x6c>
  mem = kalloc();
80106da1:	e8 9a b8 ff ff       	call   80102640 <kalloc>
  memset(mem, 0, PGSIZE);
80106da6:	83 ec 04             	sub    $0x4,%esp
80106da9:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80106dae:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106db0:	6a 00                	push   $0x0
80106db2:	50                   	push   %eax
80106db3:	e8 c8 d9 ff ff       	call   80104780 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106db8:	58                   	pop    %eax
80106db9:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106dbf:	5a                   	pop    %edx
80106dc0:	6a 06                	push   $0x6
80106dc2:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106dc7:	31 d2                	xor    %edx,%edx
80106dc9:	50                   	push   %eax
80106dca:	89 f8                	mov    %edi,%eax
80106dcc:	e8 3f fc ff ff       	call   80106a10 <mappages>
  memmove(mem, init, sz);
80106dd1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106dd4:	89 75 10             	mov    %esi,0x10(%ebp)
80106dd7:	83 c4 10             	add    $0x10,%esp
80106dda:	89 5d 08             	mov    %ebx,0x8(%ebp)
80106ddd:	89 45 0c             	mov    %eax,0xc(%ebp)
}
80106de0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106de3:	5b                   	pop    %ebx
80106de4:	5e                   	pop    %esi
80106de5:	5f                   	pop    %edi
80106de6:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106de7:	e9 34 da ff ff       	jmp    80104820 <memmove>
    panic("inituvm: more than a page");
80106dec:	83 ec 0c             	sub    $0xc,%esp
80106def:	68 4a 7b 10 80       	push   $0x80107b4a
80106df4:	e8 87 95 ff ff       	call   80100380 <panic>
80106df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106e00 <loaduvm>:
{
80106e00:	f3 0f 1e fb          	endbr32 
80106e04:	55                   	push   %ebp
80106e05:	89 e5                	mov    %esp,%ebp
80106e07:	57                   	push   %edi
80106e08:	56                   	push   %esi
80106e09:	53                   	push   %ebx
80106e0a:	83 ec 1c             	sub    $0x1c,%esp
80106e0d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e10:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
80106e13:	a9 ff 0f 00 00       	test   $0xfff,%eax
80106e18:	0f 85 99 00 00 00    	jne    80106eb7 <loaduvm+0xb7>
  for(i = 0; i < sz; i += PGSIZE){
80106e1e:	01 f0                	add    %esi,%eax
80106e20:	89 f3                	mov    %esi,%ebx
80106e22:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106e25:	8b 45 14             	mov    0x14(%ebp),%eax
80106e28:	01 f0                	add    %esi,%eax
80106e2a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80106e2d:	85 f6                	test   %esi,%esi
80106e2f:	75 15                	jne    80106e46 <loaduvm+0x46>
80106e31:	eb 6d                	jmp    80106ea0 <loaduvm+0xa0>
80106e33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106e37:	90                   	nop
80106e38:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80106e3e:	89 f0                	mov    %esi,%eax
80106e40:	29 d8                	sub    %ebx,%eax
80106e42:	39 c6                	cmp    %eax,%esi
80106e44:	76 5a                	jbe    80106ea0 <loaduvm+0xa0>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106e46:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106e49:	8b 45 08             	mov    0x8(%ebp),%eax
80106e4c:	31 c9                	xor    %ecx,%ecx
80106e4e:	29 da                	sub    %ebx,%edx
80106e50:	e8 3b fb ff ff       	call   80106990 <walkpgdir>
80106e55:	85 c0                	test   %eax,%eax
80106e57:	74 51                	je     80106eaa <loaduvm+0xaa>
    pa = PTE_ADDR(*pte);
80106e59:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106e5b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
80106e5e:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106e63:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106e68:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80106e6e:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106e71:	29 d9                	sub    %ebx,%ecx
80106e73:	05 00 00 00 80       	add    $0x80000000,%eax
80106e78:	57                   	push   %edi
80106e79:	51                   	push   %ecx
80106e7a:	50                   	push   %eax
80106e7b:	ff 75 10             	pushl  0x10(%ebp)
80106e7e:	e8 cd ab ff ff       	call   80101a50 <readi>
80106e83:	83 c4 10             	add    $0x10,%esp
80106e86:	39 f8                	cmp    %edi,%eax
80106e88:	74 ae                	je     80106e38 <loaduvm+0x38>
}
80106e8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106e8d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e92:	5b                   	pop    %ebx
80106e93:	5e                   	pop    %esi
80106e94:	5f                   	pop    %edi
80106e95:	5d                   	pop    %ebp
80106e96:	c3                   	ret    
80106e97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e9e:	66 90                	xchg   %ax,%ax
80106ea0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106ea3:	31 c0                	xor    %eax,%eax
}
80106ea5:	5b                   	pop    %ebx
80106ea6:	5e                   	pop    %esi
80106ea7:	5f                   	pop    %edi
80106ea8:	5d                   	pop    %ebp
80106ea9:	c3                   	ret    
      panic("loaduvm: address should exist");
80106eaa:	83 ec 0c             	sub    $0xc,%esp
80106ead:	68 64 7b 10 80       	push   $0x80107b64
80106eb2:	e8 c9 94 ff ff       	call   80100380 <panic>
    panic("loaduvm: addr must be page aligned");
80106eb7:	83 ec 0c             	sub    $0xc,%esp
80106eba:	68 08 7c 10 80       	push   $0x80107c08
80106ebf:	e8 bc 94 ff ff       	call   80100380 <panic>
80106ec4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ecb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106ecf:	90                   	nop

80106ed0 <allocuvm>:
{
80106ed0:	f3 0f 1e fb          	endbr32 
80106ed4:	55                   	push   %ebp
80106ed5:	89 e5                	mov    %esp,%ebp
80106ed7:	57                   	push   %edi
80106ed8:	56                   	push   %esi
80106ed9:	53                   	push   %ebx
80106eda:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106edd:	8b 45 10             	mov    0x10(%ebp),%eax
{
80106ee0:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
80106ee3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106ee6:	85 c0                	test   %eax,%eax
80106ee8:	0f 88 b2 00 00 00    	js     80106fa0 <allocuvm+0xd0>
  if(newsz < oldsz)
80106eee:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
80106ef1:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80106ef4:	0f 82 96 00 00 00    	jb     80106f90 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80106efa:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80106f00:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80106f06:	39 75 10             	cmp    %esi,0x10(%ebp)
80106f09:	77 40                	ja     80106f4b <allocuvm+0x7b>
80106f0b:	e9 83 00 00 00       	jmp    80106f93 <allocuvm+0xc3>
    memset(mem, 0, PGSIZE);
80106f10:	83 ec 04             	sub    $0x4,%esp
80106f13:	68 00 10 00 00       	push   $0x1000
80106f18:	6a 00                	push   $0x0
80106f1a:	50                   	push   %eax
80106f1b:	e8 60 d8 ff ff       	call   80104780 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106f20:	58                   	pop    %eax
80106f21:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106f27:	5a                   	pop    %edx
80106f28:	6a 06                	push   $0x6
80106f2a:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106f2f:	89 f2                	mov    %esi,%edx
80106f31:	50                   	push   %eax
80106f32:	89 f8                	mov    %edi,%eax
80106f34:	e8 d7 fa ff ff       	call   80106a10 <mappages>
80106f39:	83 c4 10             	add    $0x10,%esp
80106f3c:	85 c0                	test   %eax,%eax
80106f3e:	78 78                	js     80106fb8 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80106f40:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106f46:	39 75 10             	cmp    %esi,0x10(%ebp)
80106f49:	76 48                	jbe    80106f93 <allocuvm+0xc3>
    mem = kalloc();
80106f4b:	e8 f0 b6 ff ff       	call   80102640 <kalloc>
80106f50:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80106f52:	85 c0                	test   %eax,%eax
80106f54:	75 ba                	jne    80106f10 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106f56:	83 ec 0c             	sub    $0xc,%esp
80106f59:	68 82 7b 10 80       	push   $0x80107b82
80106f5e:	e8 3d 97 ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
80106f63:	8b 45 0c             	mov    0xc(%ebp),%eax
80106f66:	83 c4 10             	add    $0x10,%esp
80106f69:	39 45 10             	cmp    %eax,0x10(%ebp)
80106f6c:	74 32                	je     80106fa0 <allocuvm+0xd0>
80106f6e:	8b 55 10             	mov    0x10(%ebp),%edx
80106f71:	89 c1                	mov    %eax,%ecx
80106f73:	89 f8                	mov    %edi,%eax
80106f75:	e8 26 fb ff ff       	call   80106aa0 <deallocuvm.part.0>
      return 0;
80106f7a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80106f81:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106f84:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f87:	5b                   	pop    %ebx
80106f88:	5e                   	pop    %esi
80106f89:	5f                   	pop    %edi
80106f8a:	5d                   	pop    %ebp
80106f8b:	c3                   	ret    
80106f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80106f90:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80106f93:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106f96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f99:	5b                   	pop    %ebx
80106f9a:	5e                   	pop    %esi
80106f9b:	5f                   	pop    %edi
80106f9c:	5d                   	pop    %ebp
80106f9d:	c3                   	ret    
80106f9e:	66 90                	xchg   %ax,%ax
    return 0;
80106fa0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80106fa7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106faa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fad:	5b                   	pop    %ebx
80106fae:	5e                   	pop    %esi
80106faf:	5f                   	pop    %edi
80106fb0:	5d                   	pop    %ebp
80106fb1:	c3                   	ret    
80106fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106fb8:	83 ec 0c             	sub    $0xc,%esp
80106fbb:	68 9a 7b 10 80       	push   $0x80107b9a
80106fc0:	e8 db 96 ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
80106fc5:	8b 45 0c             	mov    0xc(%ebp),%eax
80106fc8:	83 c4 10             	add    $0x10,%esp
80106fcb:	39 45 10             	cmp    %eax,0x10(%ebp)
80106fce:	74 0c                	je     80106fdc <allocuvm+0x10c>
80106fd0:	8b 55 10             	mov    0x10(%ebp),%edx
80106fd3:	89 c1                	mov    %eax,%ecx
80106fd5:	89 f8                	mov    %edi,%eax
80106fd7:	e8 c4 fa ff ff       	call   80106aa0 <deallocuvm.part.0>
      kfree(mem);
80106fdc:	83 ec 0c             	sub    $0xc,%esp
80106fdf:	53                   	push   %ebx
80106fe0:	e8 9b b4 ff ff       	call   80102480 <kfree>
      return 0;
80106fe5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80106fec:	83 c4 10             	add    $0x10,%esp
}
80106fef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ff2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ff5:	5b                   	pop    %ebx
80106ff6:	5e                   	pop    %esi
80106ff7:	5f                   	pop    %edi
80106ff8:	5d                   	pop    %ebp
80106ff9:	c3                   	ret    
80106ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107000 <deallocuvm>:
{
80107000:	f3 0f 1e fb          	endbr32 
80107004:	55                   	push   %ebp
80107005:	89 e5                	mov    %esp,%ebp
80107007:	8b 55 0c             	mov    0xc(%ebp),%edx
8010700a:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010700d:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80107010:	39 d1                	cmp    %edx,%ecx
80107012:	73 0c                	jae    80107020 <deallocuvm+0x20>
}
80107014:	5d                   	pop    %ebp
80107015:	e9 86 fa ff ff       	jmp    80106aa0 <deallocuvm.part.0>
8010701a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107020:	89 d0                	mov    %edx,%eax
80107022:	5d                   	pop    %ebp
80107023:	c3                   	ret    
80107024:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010702b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010702f:	90                   	nop

80107030 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107030:	f3 0f 1e fb          	endbr32 
80107034:	55                   	push   %ebp
80107035:	89 e5                	mov    %esp,%ebp
80107037:	57                   	push   %edi
80107038:	56                   	push   %esi
80107039:	53                   	push   %ebx
8010703a:	83 ec 0c             	sub    $0xc,%esp
8010703d:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80107040:	85 f6                	test   %esi,%esi
80107042:	74 55                	je     80107099 <freevm+0x69>
  if(newsz >= oldsz)
80107044:	31 c9                	xor    %ecx,%ecx
80107046:	ba 00 00 00 80       	mov    $0x80000000,%edx
8010704b:	89 f0                	mov    %esi,%eax
8010704d:	89 f3                	mov    %esi,%ebx
8010704f:	e8 4c fa ff ff       	call   80106aa0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107054:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
8010705a:	eb 0b                	jmp    80107067 <freevm+0x37>
8010705c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107060:	83 c3 04             	add    $0x4,%ebx
80107063:	39 df                	cmp    %ebx,%edi
80107065:	74 23                	je     8010708a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107067:	8b 03                	mov    (%ebx),%eax
80107069:	a8 01                	test   $0x1,%al
8010706b:	74 f3                	je     80107060 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010706d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107072:	83 ec 0c             	sub    $0xc,%esp
80107075:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107078:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010707d:	50                   	push   %eax
8010707e:	e8 fd b3 ff ff       	call   80102480 <kfree>
80107083:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107086:	39 df                	cmp    %ebx,%edi
80107088:	75 dd                	jne    80107067 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010708a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010708d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107090:	5b                   	pop    %ebx
80107091:	5e                   	pop    %esi
80107092:	5f                   	pop    %edi
80107093:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107094:	e9 e7 b3 ff ff       	jmp    80102480 <kfree>
    panic("freevm: no pgdir");
80107099:	83 ec 0c             	sub    $0xc,%esp
8010709c:	68 b6 7b 10 80       	push   $0x80107bb6
801070a1:	e8 da 92 ff ff       	call   80100380 <panic>
801070a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070ad:	8d 76 00             	lea    0x0(%esi),%esi

801070b0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801070b0:	f3 0f 1e fb          	endbr32 
801070b4:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801070b5:	31 c9                	xor    %ecx,%ecx
{
801070b7:	89 e5                	mov    %esp,%ebp
801070b9:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801070bc:	8b 55 0c             	mov    0xc(%ebp),%edx
801070bf:	8b 45 08             	mov    0x8(%ebp),%eax
801070c2:	e8 c9 f8 ff ff       	call   80106990 <walkpgdir>
  if(pte == 0)
801070c7:	85 c0                	test   %eax,%eax
801070c9:	74 05                	je     801070d0 <clearpteu+0x20>
    panic("clearpteu");
  *pte &= ~PTE_U;
801070cb:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801070ce:	c9                   	leave  
801070cf:	c3                   	ret    
    panic("clearpteu");
801070d0:	83 ec 0c             	sub    $0xc,%esp
801070d3:	68 c7 7b 10 80       	push   $0x80107bc7
801070d8:	e8 a3 92 ff ff       	call   80100380 <panic>
801070dd:	8d 76 00             	lea    0x0(%esi),%esi

801070e0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801070e0:	f3 0f 1e fb          	endbr32 
801070e4:	55                   	push   %ebp
801070e5:	89 e5                	mov    %esp,%ebp
801070e7:	57                   	push   %edi
801070e8:	56                   	push   %esi
801070e9:	53                   	push   %ebx
801070ea:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801070ed:	e8 2e fb ff ff       	call   80106c20 <setupkvm>
801070f2:	89 45 e0             	mov    %eax,-0x20(%ebp)
801070f5:	85 c0                	test   %eax,%eax
801070f7:	0f 84 9c 00 00 00    	je     80107199 <copyuvm+0xb9>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801070fd:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107100:	85 c9                	test   %ecx,%ecx
80107102:	0f 84 91 00 00 00    	je     80107199 <copyuvm+0xb9>
80107108:	31 f6                	xor    %esi,%esi
8010710a:	eb 4a                	jmp    80107156 <copyuvm+0x76>
8010710c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107110:	83 ec 04             	sub    $0x4,%esp
80107113:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107119:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010711c:	68 00 10 00 00       	push   $0x1000
80107121:	57                   	push   %edi
80107122:	50                   	push   %eax
80107123:	e8 f8 d6 ff ff       	call   80104820 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80107128:	58                   	pop    %eax
80107129:	5a                   	pop    %edx
8010712a:	53                   	push   %ebx
8010712b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010712e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107131:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107136:	81 c2 00 00 00 80    	add    $0x80000000,%edx
8010713c:	52                   	push   %edx
8010713d:	89 f2                	mov    %esi,%edx
8010713f:	e8 cc f8 ff ff       	call   80106a10 <mappages>
80107144:	83 c4 10             	add    $0x10,%esp
80107147:	85 c0                	test   %eax,%eax
80107149:	78 39                	js     80107184 <copyuvm+0xa4>
  for(i = 0; i < sz; i += PGSIZE){
8010714b:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107151:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107154:	76 43                	jbe    80107199 <copyuvm+0xb9>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107156:	8b 45 08             	mov    0x8(%ebp),%eax
80107159:	31 c9                	xor    %ecx,%ecx
8010715b:	89 f2                	mov    %esi,%edx
8010715d:	e8 2e f8 ff ff       	call   80106990 <walkpgdir>
80107162:	85 c0                	test   %eax,%eax
80107164:	74 3e                	je     801071a4 <copyuvm+0xc4>
    if(!(*pte & PTE_P))
80107166:	8b 18                	mov    (%eax),%ebx
80107168:	f6 c3 01             	test   $0x1,%bl
8010716b:	74 44                	je     801071b1 <copyuvm+0xd1>
    pa = PTE_ADDR(*pte);
8010716d:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
8010716f:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
80107175:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
8010717b:	e8 c0 b4 ff ff       	call   80102640 <kalloc>
80107180:	85 c0                	test   %eax,%eax
80107182:	75 8c                	jne    80107110 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
80107184:	83 ec 0c             	sub    $0xc,%esp
80107187:	ff 75 e0             	pushl  -0x20(%ebp)
8010718a:	e8 a1 fe ff ff       	call   80107030 <freevm>
  return 0;
8010718f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107196:	83 c4 10             	add    $0x10,%esp
}
80107199:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010719c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010719f:	5b                   	pop    %ebx
801071a0:	5e                   	pop    %esi
801071a1:	5f                   	pop    %edi
801071a2:	5d                   	pop    %ebp
801071a3:	c3                   	ret    
      panic("copyuvm: pte should exist");
801071a4:	83 ec 0c             	sub    $0xc,%esp
801071a7:	68 d1 7b 10 80       	push   $0x80107bd1
801071ac:	e8 cf 91 ff ff       	call   80100380 <panic>
      panic("copyuvm: page not present");
801071b1:	83 ec 0c             	sub    $0xc,%esp
801071b4:	68 eb 7b 10 80       	push   $0x80107beb
801071b9:	e8 c2 91 ff ff       	call   80100380 <panic>
801071be:	66 90                	xchg   %ax,%ax

801071c0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801071c0:	f3 0f 1e fb          	endbr32 
801071c4:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801071c5:	31 c9                	xor    %ecx,%ecx
{
801071c7:	89 e5                	mov    %esp,%ebp
801071c9:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801071cc:	8b 55 0c             	mov    0xc(%ebp),%edx
801071cf:	8b 45 08             	mov    0x8(%ebp),%eax
801071d2:	e8 b9 f7 ff ff       	call   80106990 <walkpgdir>
  if((*pte & PTE_P) == 0)
801071d7:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801071d9:	c9                   	leave  
  if((*pte & PTE_U) == 0)
801071da:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801071dc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
801071e1:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801071e4:	05 00 00 00 80       	add    $0x80000000,%eax
801071e9:	83 fa 05             	cmp    $0x5,%edx
801071ec:	ba 00 00 00 00       	mov    $0x0,%edx
801071f1:	0f 45 c2             	cmovne %edx,%eax
}
801071f4:	c3                   	ret    
801071f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107200 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107200:	f3 0f 1e fb          	endbr32 
80107204:	55                   	push   %ebp
80107205:	89 e5                	mov    %esp,%ebp
80107207:	57                   	push   %edi
80107208:	56                   	push   %esi
80107209:	53                   	push   %ebx
8010720a:	83 ec 0c             	sub    $0xc,%esp
8010720d:	8b 75 14             	mov    0x14(%ebp),%esi
80107210:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107213:	85 f6                	test   %esi,%esi
80107215:	75 3c                	jne    80107253 <copyout+0x53>
80107217:	eb 67                	jmp    80107280 <copyout+0x80>
80107219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107220:	8b 55 0c             	mov    0xc(%ebp),%edx
80107223:	89 fb                	mov    %edi,%ebx
80107225:	29 d3                	sub    %edx,%ebx
80107227:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
8010722d:	39 f3                	cmp    %esi,%ebx
8010722f:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107232:	29 fa                	sub    %edi,%edx
80107234:	83 ec 04             	sub    $0x4,%esp
80107237:	01 c2                	add    %eax,%edx
80107239:	53                   	push   %ebx
8010723a:	ff 75 10             	pushl  0x10(%ebp)
8010723d:	52                   	push   %edx
8010723e:	e8 dd d5 ff ff       	call   80104820 <memmove>
    len -= n;
    buf += n;
80107243:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
80107246:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
  while(len > 0){
8010724c:	83 c4 10             	add    $0x10,%esp
8010724f:	29 de                	sub    %ebx,%esi
80107251:	74 2d                	je     80107280 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
80107253:	89 d7                	mov    %edx,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80107255:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80107258:	89 55 0c             	mov    %edx,0xc(%ebp)
8010725b:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80107261:	57                   	push   %edi
80107262:	ff 75 08             	pushl  0x8(%ebp)
80107265:	e8 56 ff ff ff       	call   801071c0 <uva2ka>
    if(pa0 == 0)
8010726a:	83 c4 10             	add    $0x10,%esp
8010726d:	85 c0                	test   %eax,%eax
8010726f:	75 af                	jne    80107220 <copyout+0x20>
  }
  return 0;
}
80107271:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107274:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107279:	5b                   	pop    %ebx
8010727a:	5e                   	pop    %esi
8010727b:	5f                   	pop    %edi
8010727c:	5d                   	pop    %ebp
8010727d:	c3                   	ret    
8010727e:	66 90                	xchg   %ax,%ax
80107280:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107283:	31 c0                	xor    %eax,%eax
}
80107285:	5b                   	pop    %ebx
80107286:	5e                   	pop    %esi
80107287:	5f                   	pop    %edi
80107288:	5d                   	pop    %ebp
80107289:	c3                   	ret    

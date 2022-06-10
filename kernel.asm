
kernel：     文件格式 elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc d0 b5 10 80       	mov    $0x8010b5d0,%esp
8010002d:	b8 d0 30 10 80       	mov    $0x801030d0,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
80100040:	f3 0f 1e fb          	endbr32 
80100044:	55                   	push   %ebp
80100045:	89 e5                	mov    %esp,%ebp
80100047:	83 ec 10             	sub    $0x10,%esp
8010004a:	68 20 73 10 80       	push   $0x80107320
8010004f:	68 e0 b5 10 80       	push   $0x8010b5e0
80100054:	e8 57 45 00 00       	call   801045b0 <initlock>
80100059:	83 c4 10             	add    $0x10,%esp
8010005c:	ba e4 f4 10 80       	mov    $0x8010f4e4,%edx
80100061:	c7 05 f0 f4 10 80 e4 	movl   $0x8010f4e4,0x8010f4f0
80100068:	f4 10 80 
8010006b:	c7 05 f4 f4 10 80 e4 	movl   $0x8010f4e4,0x8010f4f4
80100072:	f4 10 80 
80100075:	b8 14 b6 10 80       	mov    $0x8010b614,%eax
8010007a:	eb 06                	jmp    80100082 <binit+0x42>
8010007c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c8                	mov    %ecx,%eax
80100082:	89 50 10             	mov    %edx,0x10(%eax)
80100085:	8d 88 18 02 00 00    	lea    0x218(%eax),%ecx
8010008b:	c7 40 0c e4 f4 10 80 	movl   $0x8010f4e4,0xc(%eax)
80100092:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
80100099:	8b 15 f4 f4 10 80    	mov    0x8010f4f4,%edx
8010009f:	89 42 0c             	mov    %eax,0xc(%edx)
801000a2:	89 c2                	mov    %eax,%edx
801000a4:	a3 f4 f4 10 80       	mov    %eax,0x8010f4f4
801000a9:	3d cc f2 10 80       	cmp    $0x8010f2cc,%eax
801000ae:	75 d0                	jne    80100080 <binit+0x40>
801000b0:	c9                   	leave  
801000b1:	c3                   	ret    
801000b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801000c0 <bread>:
801000c0:	f3 0f 1e fb          	endbr32 
801000c4:	55                   	push   %ebp
801000c5:	89 e5                	mov    %esp,%ebp
801000c7:	57                   	push   %edi
801000c8:	56                   	push   %esi
801000c9:	53                   	push   %ebx
801000ca:	83 ec 18             	sub    $0x18,%esp
801000cd:	8b 7d 08             	mov    0x8(%ebp),%edi
801000d0:	8b 75 0c             	mov    0xc(%ebp),%esi
801000d3:	68 e0 b5 10 80       	push   $0x8010b5e0
801000d8:	e8 f3 44 00 00       	call   801045d0 <acquire>
801000dd:	83 c4 10             	add    $0x10,%esp
801000e0:	8b 1d f4 f4 10 80    	mov    0x8010f4f4,%ebx
801000e6:	81 fb e4 f4 10 80    	cmp    $0x8010f4e4,%ebx
801000ec:	75 0d                	jne    801000fb <bread+0x3b>
801000ee:	eb 38                	jmp    80100128 <bread+0x68>
801000f0:	8b 5b 10             	mov    0x10(%ebx),%ebx
801000f3:	81 fb e4 f4 10 80    	cmp    $0x8010f4e4,%ebx
801000f9:	74 2d                	je     80100128 <bread+0x68>
801000fb:	3b 7b 04             	cmp    0x4(%ebx),%edi
801000fe:	75 f0                	jne    801000f0 <bread+0x30>
80100100:	3b 73 08             	cmp    0x8(%ebx),%esi
80100103:	75 eb                	jne    801000f0 <bread+0x30>
80100105:	8b 03                	mov    (%ebx),%eax
80100107:	a8 01                	test   $0x1,%al
80100109:	0f 84 91 00 00 00    	je     801001a0 <bread+0xe0>
8010010f:	83 ec 08             	sub    $0x8,%esp
80100112:	68 e0 b5 10 80       	push   $0x8010b5e0
80100117:	53                   	push   %ebx
80100118:	e8 13 3f 00 00       	call   80104030 <sleep>
8010011d:	83 c4 10             	add    $0x10,%esp
80100120:	eb be                	jmp    801000e0 <bread+0x20>
80100122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100128:	8b 1d f0 f4 10 80    	mov    0x8010f4f0,%ebx
8010012e:	81 fb e4 f4 10 80    	cmp    $0x8010f4e4,%ebx
80100134:	75 15                	jne    8010014b <bread+0x8b>
80100136:	eb 7f                	jmp    801001b7 <bread+0xf7>
80100138:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010013f:	90                   	nop
80100140:	8b 5b 0c             	mov    0xc(%ebx),%ebx
80100143:	81 fb e4 f4 10 80    	cmp    $0x8010f4e4,%ebx
80100149:	74 6c                	je     801001b7 <bread+0xf7>
8010014b:	f6 03 05             	testb  $0x5,(%ebx)
8010014e:	75 f0                	jne    80100140 <bread+0x80>
80100150:	83 ec 0c             	sub    $0xc,%esp
80100153:	89 7b 04             	mov    %edi,0x4(%ebx)
80100156:	89 73 08             	mov    %esi,0x8(%ebx)
80100159:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
8010015f:	68 e0 b5 10 80       	push   $0x8010b5e0
80100164:	e8 47 46 00 00       	call   801047b0 <release>
80100169:	83 c4 10             	add    $0x10,%esp
8010016c:	f6 03 02             	testb  $0x2,(%ebx)
8010016f:	74 0f                	je     80100180 <bread+0xc0>
80100171:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100174:	89 d8                	mov    %ebx,%eax
80100176:	5b                   	pop    %ebx
80100177:	5e                   	pop    %esi
80100178:	5f                   	pop    %edi
80100179:	5d                   	pop    %ebp
8010017a:	c3                   	ret    
8010017b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010017f:	90                   	nop
80100180:	83 ec 0c             	sub    $0xc,%esp
80100183:	53                   	push   %ebx
80100184:	e8 e7 20 00 00       	call   80102270 <iderw>
80100189:	83 c4 10             	add    $0x10,%esp
8010018c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010018f:	89 d8                	mov    %ebx,%eax
80100191:	5b                   	pop    %ebx
80100192:	5e                   	pop    %esi
80100193:	5f                   	pop    %edi
80100194:	5d                   	pop    %ebp
80100195:	c3                   	ret    
80100196:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010019d:	8d 76 00             	lea    0x0(%esi),%esi
801001a0:	83 ec 0c             	sub    $0xc,%esp
801001a3:	83 c8 01             	or     $0x1,%eax
801001a6:	89 03                	mov    %eax,(%ebx)
801001a8:	68 e0 b5 10 80       	push   $0x8010b5e0
801001ad:	e8 fe 45 00 00       	call   801047b0 <release>
801001b2:	83 c4 10             	add    $0x10,%esp
801001b5:	eb b5                	jmp    8010016c <bread+0xac>
801001b7:	83 ec 0c             	sub    $0xc,%esp
801001ba:	68 27 73 10 80       	push   $0x80107327
801001bf:	e8 bc 01 00 00       	call   80100380 <panic>
801001c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001cf:	90                   	nop

801001d0 <bwrite>:
801001d0:	f3 0f 1e fb          	endbr32 
801001d4:	55                   	push   %ebp
801001d5:	89 e5                	mov    %esp,%ebp
801001d7:	83 ec 08             	sub    $0x8,%esp
801001da:	8b 55 08             	mov    0x8(%ebp),%edx
801001dd:	8b 02                	mov    (%edx),%eax
801001df:	a8 01                	test   $0x1,%al
801001e1:	74 0b                	je     801001ee <bwrite+0x1e>
801001e3:	83 c8 04             	or     $0x4,%eax
801001e6:	89 02                	mov    %eax,(%edx)
801001e8:	c9                   	leave  
801001e9:	e9 82 20 00 00       	jmp    80102270 <iderw>
801001ee:	83 ec 0c             	sub    $0xc,%esp
801001f1:	68 38 73 10 80       	push   $0x80107338
801001f6:	e8 85 01 00 00       	call   80100380 <panic>
801001fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001ff:	90                   	nop

80100200 <brelse>:
80100200:	f3 0f 1e fb          	endbr32 
80100204:	55                   	push   %ebp
80100205:	89 e5                	mov    %esp,%ebp
80100207:	53                   	push   %ebx
80100208:	83 ec 04             	sub    $0x4,%esp
8010020b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010020e:	f6 03 01             	testb  $0x1,(%ebx)
80100211:	74 57                	je     8010026a <brelse+0x6a>
80100213:	83 ec 0c             	sub    $0xc,%esp
80100216:	68 e0 b5 10 80       	push   $0x8010b5e0
8010021b:	e8 b0 43 00 00       	call   801045d0 <acquire>
80100220:	8b 53 10             	mov    0x10(%ebx),%edx
80100223:	8b 43 0c             	mov    0xc(%ebx),%eax
80100226:	89 42 0c             	mov    %eax,0xc(%edx)
80100229:	8b 53 10             	mov    0x10(%ebx),%edx
8010022c:	89 50 10             	mov    %edx,0x10(%eax)
8010022f:	a1 f4 f4 10 80       	mov    0x8010f4f4,%eax
80100234:	c7 43 0c e4 f4 10 80 	movl   $0x8010f4e4,0xc(%ebx)
8010023b:	89 43 10             	mov    %eax,0x10(%ebx)
8010023e:	a1 f4 f4 10 80       	mov    0x8010f4f4,%eax
80100243:	89 58 0c             	mov    %ebx,0xc(%eax)
80100246:	89 1d f4 f4 10 80    	mov    %ebx,0x8010f4f4
8010024c:	83 23 fe             	andl   $0xfffffffe,(%ebx)
8010024f:	89 1c 24             	mov    %ebx,(%esp)
80100252:	e8 99 3f 00 00       	call   801041f0 <wakeup>
80100257:	c7 45 08 e0 b5 10 80 	movl   $0x8010b5e0,0x8(%ebp)
8010025e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100261:	83 c4 10             	add    $0x10,%esp
80100264:	c9                   	leave  
80100265:	e9 46 45 00 00       	jmp    801047b0 <release>
8010026a:	83 ec 0c             	sub    $0xc,%esp
8010026d:	68 3f 73 10 80       	push   $0x8010733f
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
801002a1:	e8 2a 43 00 00       	call   801045d0 <acquire>
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
801002d5:	e8 56 3d 00 00       	call   80104030 <sleep>
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
801002ff:	e8 ac 44 00 00       	call   801047b0 <release>
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
80100355:	e8 56 44 00 00       	call   801047b0 <release>
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
801003a7:	68 46 73 10 80       	push   $0x80107346
801003ac:	e8 ef 02 00 00       	call   801006a0 <cprintf>
  cprintf(s);
801003b1:	58                   	pop    %eax
801003b2:	ff 75 08             	pushl  0x8(%ebp)
801003b5:	e8 e6 02 00 00       	call   801006a0 <cprintf>
  cprintf("\n");
801003ba:	c7 04 24 66 78 10 80 	movl   $0x80107866,(%esp)
801003c1:	e8 da 02 00 00       	call   801006a0 <cprintf>
  getcallerpcs(&s, pcs);
801003c6:	8d 45 08             	lea    0x8(%ebp),%eax
801003c9:	5a                   	pop    %edx
801003ca:	59                   	pop    %ecx
801003cb:	53                   	push   %ebx
801003cc:	50                   	push   %eax
801003cd:	e8 ce 42 00 00       	call   801046a0 <getcallerpcs>
  for(i=0; i<10; i++)
801003d2:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d5:	83 ec 08             	sub    $0x8,%esp
801003d8:	ff 33                	pushl  (%ebx)
801003da:	83 c3 04             	add    $0x4,%ebx
801003dd:	68 62 73 10 80       	push   $0x80107362
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
8010041a:	e8 31 5b 00 00       	call   80105f50 <uartputc>
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
80100505:	e8 46 5a 00 00       	call   80105f50 <uartputc>
8010050a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100511:	e8 3a 5a 00 00       	call   80105f50 <uartputc>
80100516:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010051d:	e8 2e 5a 00 00       	call   80105f50 <uartputc>
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
80100551:	e8 4a 43 00 00       	call   801048a0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100556:	b8 80 07 00 00       	mov    $0x780,%eax
8010055b:	83 c4 0c             	add    $0xc,%esp
8010055e:	29 d8                	sub    %ebx,%eax
80100560:	01 c0                	add    %eax,%eax
80100562:	50                   	push   %eax
80100563:	6a 00                	push   $0x0
80100565:	56                   	push   %esi
80100566:	e8 95 42 00 00       	call   80104800 <memset>
8010056b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010056e:	83 c4 10             	add    $0x10,%esp
80100571:	e9 22 ff ff ff       	jmp    80100498 <consputc.part.0+0x98>
    panic("pos under/overflow");
80100576:	83 ec 0c             	sub    $0xc,%esp
80100579:	68 66 73 10 80       	push   $0x80107366
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
801005b9:	0f b6 92 94 73 10 80 	movzbl -0x7fef8c6c(%edx),%edx
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
8010064f:	e8 7c 3f 00 00       	call   801045d0 <acquire>
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
80100687:	e8 24 41 00 00       	call   801047b0 <release>
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
8010076d:	bb 79 73 10 80       	mov    $0x80107379,%ebx
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
801007ad:	e8 1e 3e 00 00       	call   801045d0 <acquire>
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
80100818:	e8 93 3f 00 00       	call   801047b0 <release>
8010081d:	83 c4 10             	add    $0x10,%esp
}
80100820:	e9 ee fe ff ff       	jmp    80100713 <cprintf+0x73>
    panic("null fmt");
80100825:	83 ec 0c             	sub    $0xc,%esp
80100828:	68 80 73 10 80       	push   $0x80107380
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
80100867:	e8 64 3d 00 00       	call   801045d0 <acquire>
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
801009bf:	e8 ec 3d 00 00       	call   801047b0 <release>
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
801009ef:	e9 fc 38 00 00       	jmp    801042f0 <procdump>
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
80100a10:	e8 db 37 00 00       	call   801041f0 <wakeup>
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
80100a2a:	68 89 73 10 80       	push   $0x80107389
80100a2f:	68 20 a5 10 80       	push   $0x8010a520
80100a34:	e8 77 3b 00 00       	call   801045b0 <initlock>

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
80100b00:	e8 9b 61 00 00       	call   80106ca0 <setupkvm>
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
80100b6b:	e8 e0 63 00 00       	call   80106f50 <allocuvm>
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
80100ba1:	e8 da 62 00 00       	call   80106e80 <loaduvm>
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
80100be3:	e8 c8 64 00 00       	call   801070b0 <freevm>
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
80100c22:	e8 29 63 00 00       	call   80106f50 <allocuvm>
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
80100c43:	e8 e8 64 00 00       	call   80107130 <clearpteu>
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
80100c93:	e8 68 3d 00 00       	call   80104a00 <strlen>
80100c98:	f7 d0                	not    %eax
80100c9a:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c9c:	58                   	pop    %eax
80100c9d:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ca0:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ca3:	ff 34 b8             	pushl  (%eax,%edi,4)
80100ca6:	e8 55 3d 00 00       	call   80104a00 <strlen>
80100cab:	83 c0 01             	add    $0x1,%eax
80100cae:	50                   	push   %eax
80100caf:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cb2:	ff 34 b8             	pushl  (%eax,%edi,4)
80100cb5:	53                   	push   %ebx
80100cb6:	56                   	push   %esi
80100cb7:	e8 c4 65 00 00       	call   80107280 <copyout>
80100cbc:	83 c4 20             	add    $0x20,%esp
80100cbf:	85 c0                	test   %eax,%eax
80100cc1:	79 ad                	jns    80100c70 <exec+0x1f0>
80100cc3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100cc7:	90                   	nop
    freevm(pgdir);
80100cc8:	83 ec 0c             	sub    $0xc,%esp
80100ccb:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100cd1:	e8 da 63 00 00       	call   801070b0 <freevm>
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
80100d23:	e8 58 65 00 00       	call   80107280 <copyout>
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
80100d5f:	e8 5c 3c 00 00       	call   801049c0 <safestrcpy>
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
80100d93:	e8 b8 5f 00 00       	call   80106d50 <switchuvm>
  freevm(oldpgdir);
80100d98:	89 3c 24             	mov    %edi,(%esp)
80100d9b:	e8 10 63 00 00       	call   801070b0 <freevm>
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
80100dd0:	f3 0f 1e fb          	endbr32 
80100dd4:	55                   	push   %ebp
80100dd5:	89 e5                	mov    %esp,%ebp
80100dd7:	83 ec 10             	sub    $0x10,%esp
80100dda:	68 a5 73 10 80       	push   $0x801073a5
80100ddf:	68 a0 f7 10 80       	push   $0x8010f7a0
80100de4:	e8 c7 37 00 00       	call   801045b0 <initlock>
80100de9:	83 c4 10             	add    $0x10,%esp
80100dec:	c9                   	leave  
80100ded:	c3                   	ret    
80100dee:	66 90                	xchg   %ax,%ax

80100df0 <filealloc>:
80100df0:	f3 0f 1e fb          	endbr32 
80100df4:	55                   	push   %ebp
80100df5:	89 e5                	mov    %esp,%ebp
80100df7:	53                   	push   %ebx
80100df8:	bb d4 f7 10 80       	mov    $0x8010f7d4,%ebx
80100dfd:	83 ec 10             	sub    $0x10,%esp
80100e00:	68 a0 f7 10 80       	push   $0x8010f7a0
80100e05:	e8 c6 37 00 00       	call   801045d0 <acquire>
80100e0a:	83 c4 10             	add    $0x10,%esp
80100e0d:	eb 0c                	jmp    80100e1b <filealloc+0x2b>
80100e0f:	90                   	nop
80100e10:	83 c3 18             	add    $0x18,%ebx
80100e13:	81 fb 34 01 11 80    	cmp    $0x80110134,%ebx
80100e19:	74 25                	je     80100e40 <filealloc+0x50>
80100e1b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e1e:	85 c0                	test   %eax,%eax
80100e20:	75 ee                	jne    80100e10 <filealloc+0x20>
80100e22:	83 ec 0c             	sub    $0xc,%esp
80100e25:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
80100e2c:	68 a0 f7 10 80       	push   $0x8010f7a0
80100e31:	e8 7a 39 00 00       	call   801047b0 <release>
80100e36:	89 d8                	mov    %ebx,%eax
80100e38:	83 c4 10             	add    $0x10,%esp
80100e3b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e3e:	c9                   	leave  
80100e3f:	c3                   	ret    
80100e40:	83 ec 0c             	sub    $0xc,%esp
80100e43:	31 db                	xor    %ebx,%ebx
80100e45:	68 a0 f7 10 80       	push   $0x8010f7a0
80100e4a:	e8 61 39 00 00       	call   801047b0 <release>
80100e4f:	89 d8                	mov    %ebx,%eax
80100e51:	83 c4 10             	add    $0x10,%esp
80100e54:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e57:	c9                   	leave  
80100e58:	c3                   	ret    
80100e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100e60 <filedup>:
80100e60:	f3 0f 1e fb          	endbr32 
80100e64:	55                   	push   %ebp
80100e65:	89 e5                	mov    %esp,%ebp
80100e67:	53                   	push   %ebx
80100e68:	83 ec 10             	sub    $0x10,%esp
80100e6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100e6e:	68 a0 f7 10 80       	push   $0x8010f7a0
80100e73:	e8 58 37 00 00       	call   801045d0 <acquire>
80100e78:	8b 43 04             	mov    0x4(%ebx),%eax
80100e7b:	83 c4 10             	add    $0x10,%esp
80100e7e:	85 c0                	test   %eax,%eax
80100e80:	7e 1a                	jle    80100e9c <filedup+0x3c>
80100e82:	83 c0 01             	add    $0x1,%eax
80100e85:	83 ec 0c             	sub    $0xc,%esp
80100e88:	89 43 04             	mov    %eax,0x4(%ebx)
80100e8b:	68 a0 f7 10 80       	push   $0x8010f7a0
80100e90:	e8 1b 39 00 00       	call   801047b0 <release>
80100e95:	89 d8                	mov    %ebx,%eax
80100e97:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e9a:	c9                   	leave  
80100e9b:	c3                   	ret    
80100e9c:	83 ec 0c             	sub    $0xc,%esp
80100e9f:	68 ac 73 10 80       	push   $0x801073ac
80100ea4:	e8 d7 f4 ff ff       	call   80100380 <panic>
80100ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100eb0 <fileclose>:
80100eb0:	f3 0f 1e fb          	endbr32 
80100eb4:	55                   	push   %ebp
80100eb5:	89 e5                	mov    %esp,%ebp
80100eb7:	57                   	push   %edi
80100eb8:	56                   	push   %esi
80100eb9:	53                   	push   %ebx
80100eba:	83 ec 28             	sub    $0x28,%esp
80100ebd:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100ec0:	68 a0 f7 10 80       	push   $0x8010f7a0
80100ec5:	e8 06 37 00 00       	call   801045d0 <acquire>
80100eca:	8b 53 04             	mov    0x4(%ebx),%edx
80100ecd:	83 c4 10             	add    $0x10,%esp
80100ed0:	85 d2                	test   %edx,%edx
80100ed2:	0f 8e a1 00 00 00    	jle    80100f79 <fileclose+0xc9>
80100ed8:	83 ea 01             	sub    $0x1,%edx
80100edb:	89 53 04             	mov    %edx,0x4(%ebx)
80100ede:	75 40                	jne    80100f20 <fileclose+0x70>
80100ee0:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100ee4:	83 ec 0c             	sub    $0xc,%esp
80100ee7:	8b 3b                	mov    (%ebx),%edi
80100ee9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80100eef:	8b 73 0c             	mov    0xc(%ebx),%esi
80100ef2:	88 45 e7             	mov    %al,-0x19(%ebp)
80100ef5:	8b 43 10             	mov    0x10(%ebx),%eax
80100ef8:	68 a0 f7 10 80       	push   $0x8010f7a0
80100efd:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100f00:	e8 ab 38 00 00       	call   801047b0 <release>
80100f05:	83 c4 10             	add    $0x10,%esp
80100f08:	83 ff 01             	cmp    $0x1,%edi
80100f0b:	74 53                	je     80100f60 <fileclose+0xb0>
80100f0d:	83 ff 02             	cmp    $0x2,%edi
80100f10:	74 26                	je     80100f38 <fileclose+0x88>
80100f12:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f15:	5b                   	pop    %ebx
80100f16:	5e                   	pop    %esi
80100f17:	5f                   	pop    %edi
80100f18:	5d                   	pop    %ebp
80100f19:	c3                   	ret    
80100f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100f20:	c7 45 08 a0 f7 10 80 	movl   $0x8010f7a0,0x8(%ebp)
80100f27:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f2a:	5b                   	pop    %ebx
80100f2b:	5e                   	pop    %esi
80100f2c:	5f                   	pop    %edi
80100f2d:	5d                   	pop    %ebp
80100f2e:	e9 7d 38 00 00       	jmp    801047b0 <release>
80100f33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f37:	90                   	nop
80100f38:	e8 83 1e 00 00       	call   80102dc0 <begin_op>
80100f3d:	83 ec 0c             	sub    $0xc,%esp
80100f40:	ff 75 e0             	pushl  -0x20(%ebp)
80100f43:	e8 38 09 00 00       	call   80101880 <iput>
80100f48:	83 c4 10             	add    $0x10,%esp
80100f4b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f4e:	5b                   	pop    %ebx
80100f4f:	5e                   	pop    %esi
80100f50:	5f                   	pop    %edi
80100f51:	5d                   	pop    %ebp
80100f52:	e9 d9 1e 00 00       	jmp    80102e30 <end_op>
80100f57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f5e:	66 90                	xchg   %ax,%ax
80100f60:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100f64:	83 ec 08             	sub    $0x8,%esp
80100f67:	53                   	push   %ebx
80100f68:	56                   	push   %esi
80100f69:	e8 02 27 00 00       	call   80103670 <pipeclose>
80100f6e:	83 c4 10             	add    $0x10,%esp
80100f71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f74:	5b                   	pop    %ebx
80100f75:	5e                   	pop    %esi
80100f76:	5f                   	pop    %edi
80100f77:	5d                   	pop    %ebp
80100f78:	c3                   	ret    
80100f79:	83 ec 0c             	sub    $0xc,%esp
80100f7c:	68 b4 73 10 80       	push   $0x801073b4
80100f81:	e8 fa f3 ff ff       	call   80100380 <panic>
80100f86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f8d:	8d 76 00             	lea    0x0(%esi),%esi

80100f90 <filestat>:
80100f90:	f3 0f 1e fb          	endbr32 
80100f94:	55                   	push   %ebp
80100f95:	89 e5                	mov    %esp,%ebp
80100f97:	53                   	push   %ebx
80100f98:	83 ec 04             	sub    $0x4,%esp
80100f9b:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f9e:	83 3b 02             	cmpl   $0x2,(%ebx)
80100fa1:	75 2d                	jne    80100fd0 <filestat+0x40>
80100fa3:	83 ec 0c             	sub    $0xc,%esp
80100fa6:	ff 73 10             	pushl  0x10(%ebx)
80100fa9:	e8 62 07 00 00       	call   80101710 <ilock>
80100fae:	58                   	pop    %eax
80100faf:	5a                   	pop    %edx
80100fb0:	ff 75 0c             	pushl  0xc(%ebp)
80100fb3:	ff 73 10             	pushl  0x10(%ebx)
80100fb6:	e8 65 0a 00 00       	call   80101a20 <stati>
80100fbb:	59                   	pop    %ecx
80100fbc:	ff 73 10             	pushl  0x10(%ebx)
80100fbf:	e8 5c 08 00 00       	call   80101820 <iunlock>
80100fc4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fc7:	83 c4 10             	add    $0x10,%esp
80100fca:	31 c0                	xor    %eax,%eax
80100fcc:	c9                   	leave  
80100fcd:	c3                   	ret    
80100fce:	66 90                	xchg   %ax,%ax
80100fd0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100fd8:	c9                   	leave  
80100fd9:	c3                   	ret    
80100fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100fe0 <fileread>:
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
80100ff6:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100ffa:	74 64                	je     80101060 <fileread+0x80>
80100ffc:	8b 03                	mov    (%ebx),%eax
80100ffe:	83 f8 01             	cmp    $0x1,%eax
80101001:	74 45                	je     80101048 <fileread+0x68>
80101003:	83 f8 02             	cmp    $0x2,%eax
80101006:	75 5f                	jne    80101067 <fileread+0x87>
80101008:	83 ec 0c             	sub    $0xc,%esp
8010100b:	ff 73 10             	pushl  0x10(%ebx)
8010100e:	e8 fd 06 00 00       	call   80101710 <ilock>
80101013:	57                   	push   %edi
80101014:	ff 73 14             	pushl  0x14(%ebx)
80101017:	56                   	push   %esi
80101018:	ff 73 10             	pushl  0x10(%ebx)
8010101b:	e8 30 0a 00 00       	call   80101a50 <readi>
80101020:	83 c4 20             	add    $0x20,%esp
80101023:	89 c6                	mov    %eax,%esi
80101025:	85 c0                	test   %eax,%eax
80101027:	7e 03                	jle    8010102c <fileread+0x4c>
80101029:	01 43 14             	add    %eax,0x14(%ebx)
8010102c:	83 ec 0c             	sub    $0xc,%esp
8010102f:	ff 73 10             	pushl  0x10(%ebx)
80101032:	e8 e9 07 00 00       	call   80101820 <iunlock>
80101037:	83 c4 10             	add    $0x10,%esp
8010103a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010103d:	89 f0                	mov    %esi,%eax
8010103f:	5b                   	pop    %ebx
80101040:	5e                   	pop    %esi
80101041:	5f                   	pop    %edi
80101042:	5d                   	pop    %ebp
80101043:	c3                   	ret    
80101044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101048:	8b 43 0c             	mov    0xc(%ebx),%eax
8010104b:	89 45 08             	mov    %eax,0x8(%ebp)
8010104e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101051:	5b                   	pop    %ebx
80101052:	5e                   	pop    %esi
80101053:	5f                   	pop    %edi
80101054:	5d                   	pop    %ebp
80101055:	e9 b6 27 00 00       	jmp    80103810 <piperead>
8010105a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101060:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101065:	eb d3                	jmp    8010103a <fileread+0x5a>
80101067:	83 ec 0c             	sub    $0xc,%esp
8010106a:	68 be 73 10 80       	push   $0x801073be
8010106f:	e8 0c f3 ff ff       	call   80100380 <panic>
80101074:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010107b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010107f:	90                   	nop

80101080 <filewrite>:
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
80101099:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
8010109d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801010a0:	0f 84 c1 00 00 00    	je     80101167 <filewrite+0xe7>
801010a6:	8b 06                	mov    (%esi),%eax
801010a8:	83 f8 01             	cmp    $0x1,%eax
801010ab:	0f 84 c3 00 00 00    	je     80101174 <filewrite+0xf4>
801010b1:	83 f8 02             	cmp    $0x2,%eax
801010b4:	0f 85 cc 00 00 00    	jne    80101186 <filewrite+0x106>
801010ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801010bd:	31 ff                	xor    %edi,%edi
801010bf:	85 c0                	test   %eax,%eax
801010c1:	7f 34                	jg     801010f7 <filewrite+0x77>
801010c3:	e9 98 00 00 00       	jmp    80101160 <filewrite+0xe0>
801010c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801010cf:	90                   	nop
801010d0:	01 46 14             	add    %eax,0x14(%esi)
801010d3:	83 ec 0c             	sub    $0xc,%esp
801010d6:	ff 76 10             	pushl  0x10(%esi)
801010d9:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010dc:	e8 3f 07 00 00       	call   80101820 <iunlock>
801010e1:	e8 4a 1d 00 00       	call   80102e30 <end_op>
801010e6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010e9:	83 c4 10             	add    $0x10,%esp
801010ec:	39 c3                	cmp    %eax,%ebx
801010ee:	75 60                	jne    80101150 <filewrite+0xd0>
801010f0:	01 df                	add    %ebx,%edi
801010f2:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010f5:	7e 69                	jle    80101160 <filewrite+0xe0>
801010f7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801010fa:	b8 00 1a 00 00       	mov    $0x1a00,%eax
801010ff:	29 fb                	sub    %edi,%ebx
80101101:	81 fb 00 1a 00 00    	cmp    $0x1a00,%ebx
80101107:	0f 4f d8             	cmovg  %eax,%ebx
8010110a:	e8 b1 1c 00 00       	call   80102dc0 <begin_op>
8010110f:	83 ec 0c             	sub    $0xc,%esp
80101112:	ff 76 10             	pushl  0x10(%esi)
80101115:	e8 f6 05 00 00       	call   80101710 <ilock>
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
80101133:	83 ec 0c             	sub    $0xc,%esp
80101136:	ff 76 10             	pushl  0x10(%esi)
80101139:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010113c:	e8 df 06 00 00       	call   80101820 <iunlock>
80101141:	e8 ea 1c 00 00       	call   80102e30 <end_op>
80101146:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101149:	83 c4 10             	add    $0x10,%esp
8010114c:	85 c0                	test   %eax,%eax
8010114e:	75 17                	jne    80101167 <filewrite+0xe7>
80101150:	83 ec 0c             	sub    $0xc,%esp
80101153:	68 c7 73 10 80       	push   $0x801073c7
80101158:	e8 23 f2 ff ff       	call   80100380 <panic>
8010115d:	8d 76 00             	lea    0x0(%esi),%esi
80101160:	89 f8                	mov    %edi,%eax
80101162:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80101165:	74 05                	je     8010116c <filewrite+0xec>
80101167:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010116c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010116f:	5b                   	pop    %ebx
80101170:	5e                   	pop    %esi
80101171:	5f                   	pop    %edi
80101172:	5d                   	pop    %ebp
80101173:	c3                   	ret    
80101174:	8b 46 0c             	mov    0xc(%esi),%eax
80101177:	89 45 08             	mov    %eax,0x8(%ebp)
8010117a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010117d:	5b                   	pop    %ebx
8010117e:	5e                   	pop    %esi
8010117f:	5f                   	pop    %edi
80101180:	5d                   	pop    %ebp
80101181:	e9 8a 25 00 00       	jmp    80103710 <pipewrite>
80101186:	83 ec 0c             	sub    $0xc,%esp
80101189:	68 cd 73 10 80       	push   $0x801073cd
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
80101244:	68 d7 73 10 80       	push   $0x801073d7
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
80101285:	e8 76 35 00 00       	call   80104800 <memset>
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
801012ca:	e8 01 33 00 00       	call   801045d0 <acquire>
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
8010132f:	e8 7c 34 00 00       	call   801047b0 <release>

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
8010135d:	e8 4e 34 00 00       	call   801047b0 <release>
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
8010138a:	68 ed 73 10 80       	push   $0x801073ed
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
80101453:	68 fd 73 10 80       	push   $0x801073fd
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
80101485:	e8 16 34 00 00       	call   801048a0 <memmove>
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
80101514:	68 10 74 10 80       	push   $0x80107410
80101519:	e8 62 ee ff ff       	call   80100380 <panic>
8010151e:	66 90                	xchg   %ax,%ax

80101520 <iinit>:
{
80101520:	f3 0f 1e fb          	endbr32 
80101524:	55                   	push   %ebp
80101525:	89 e5                	mov    %esp,%ebp
80101527:	83 ec 10             	sub    $0x10,%esp
  initlock(&icache.lock, "icache");
8010152a:	68 23 74 10 80       	push   $0x80107423
8010152f:	68 c0 01 11 80       	push   $0x801101c0
80101534:	e8 77 30 00 00       	call   801045b0 <initlock>
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
80101572:	68 84 74 10 80       	push   $0x80107484
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
8010160e:	e8 ed 31 00 00       	call   80104800 <memset>
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
80101643:	68 2a 74 10 80       	push   $0x8010742a
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
801016b5:	e8 e6 31 00 00       	call   801048a0 <memmove>
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
801016f3:	e8 d8 2e 00 00       	call   801045d0 <acquire>
  ip->ref++;
801016f8:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801016fc:	c7 04 24 c0 01 11 80 	movl   $0x801101c0,(%esp)
80101703:	e8 a8 30 00 00       	call   801047b0 <release>
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
80101737:	e8 94 2e 00 00       	call   801045d0 <acquire>
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
80101759:	e8 d2 28 00 00       	call   80104030 <sleep>
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
80101776:	e8 35 30 00 00       	call   801047b0 <release>
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
801017e8:	e8 b3 30 00 00       	call   801048a0 <memmove>
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
80101806:	68 42 74 10 80       	push   $0x80107442
8010180b:	e8 70 eb ff ff       	call   80100380 <panic>
    panic("ilock");
80101810:	83 ec 0c             	sub    $0xc,%esp
80101813:	68 3c 74 10 80       	push   $0x8010743c
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
80101847:	e8 84 2d 00 00       	call   801045d0 <acquire>
  ip->flags &= ~I_BUSY;
8010184c:	83 63 0c fe          	andl   $0xfffffffe,0xc(%ebx)
  wakeup(ip);
80101850:	89 1c 24             	mov    %ebx,(%esp)
80101853:	e8 98 29 00 00       	call   801041f0 <wakeup>
  release(&icache.lock);
80101858:	c7 45 08 c0 01 11 80 	movl   $0x801101c0,0x8(%ebp)
}
8010185f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&icache.lock);
80101862:	83 c4 10             	add    $0x10,%esp
}
80101865:	c9                   	leave  
  release(&icache.lock);
80101866:	e9 45 2f 00 00       	jmp    801047b0 <release>
    panic("iunlock");
8010186b:	83 ec 0c             	sub    $0xc,%esp
8010186e:	68 51 74 10 80       	push   $0x80107451
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
80101895:	e8 36 2d 00 00       	call   801045d0 <acquire>
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
801018dd:	e8 ce 2e 00 00       	call   801047b0 <release>
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
8010193e:	e8 8d 2c 00 00       	call   801045d0 <acquire>
    ip->flags = 0;
80101943:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    wakeup(ip);
8010194a:	89 1c 24             	mov    %ebx,(%esp)
8010194d:	e8 9e 28 00 00       	call   801041f0 <wakeup>
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
8010196c:	e9 3f 2e 00 00       	jmp    801047b0 <release>
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
801019d7:	68 59 74 10 80       	push   $0x80107459
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
80101af7:	e8 a4 2d 00 00       	call   801048a0 <memmove>
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
80101bf3:	e8 a8 2c 00 00       	call   801048a0 <memmove>
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
80101c92:	e8 79 2c 00 00       	call   80104910 <strncmp>
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
80101cf5:	e8 16 2c 00 00       	call   80104910 <strncmp>
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
80101d3a:	68 75 74 10 80       	push   $0x80107475
80101d3f:	e8 3c e6 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
80101d44:	83 ec 0c             	sub    $0xc,%esp
80101d47:	68 63 74 10 80       	push   $0x80107463
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
80101d8d:	e8 3e 28 00 00       	call   801045d0 <acquire>
  ip->ref++;
80101d92:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101d96:	c7 04 24 c0 01 11 80 	movl   $0x801101c0,(%esp)
80101d9d:	e8 0e 2a 00 00       	call   801047b0 <release>
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
80101e07:	e8 94 2a 00 00       	call   801048a0 <memmove>
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
80101e93:	e8 08 2a 00 00       	call   801048a0 <memmove>
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
80101fc5:	e8 96 29 00 00       	call   80104960 <strncpy>
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
80102003:	68 75 74 10 80       	push   $0x80107475
80102008:	e8 73 e3 ff ff       	call   80100380 <panic>
    panic("dirlink");
8010200d:	83 ec 0c             	sub    $0xc,%esp
80102010:	68 46 7a 10 80       	push   $0x80107a46
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
8010211b:	68 e9 74 10 80       	push   $0x801074e9
80102120:	e8 5b e2 ff ff       	call   80100380 <panic>
    panic("idestart");
80102125:	83 ec 0c             	sub    $0xc,%esp
80102128:	68 e0 74 10 80       	push   $0x801074e0
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
8010214a:	68 fb 74 10 80       	push   $0x801074fb
8010214f:	68 80 a5 10 80       	push   $0x8010a580
80102154:	e8 57 24 00 00       	call   801045b0 <initlock>
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
801021e2:	e8 e9 23 00 00       	call   801045d0 <acquire>
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
8010223d:	e8 ae 1f 00 00       	call   801041f0 <wakeup>

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
8010225b:	e8 50 25 00 00       	call   801047b0 <release>

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
801022b0:	e8 1b 23 00 00       	call   801045d0 <acquire>

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
801022f9:	e8 32 1d 00 00       	call   80104030 <sleep>
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
80102316:	e9 95 24 00 00       	jmp    801047b0 <release>
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
8010233a:	68 28 75 10 80       	push   $0x80107528
8010233f:	e8 3c e0 ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
80102344:	83 ec 0c             	sub    $0xc,%esp
80102347:	68 13 75 10 80       	push   $0x80107513
8010234c:	e8 2f e0 ff ff       	call   80100380 <panic>
    panic("iderw: buf not busy");
80102351:	83 ec 0c             	sub    $0xc,%esp
80102354:	68 ff 74 10 80       	push   $0x801074ff
80102359:	e8 22 e0 ff ff       	call   80100380 <panic>
8010235e:	66 90                	xchg   %ax,%ax

80102360 <ioapicinit>:
80102360:	f3 0f 1e fb          	endbr32 
80102364:	a1 c4 12 11 80       	mov    0x801112c4,%eax
80102369:	85 c0                	test   %eax,%eax
8010236b:	0f 84 af 00 00 00    	je     80102420 <ioapicinit+0xc0>
80102371:	55                   	push   %ebp
80102372:	c7 05 94 11 11 80 00 	movl   $0xfec00000,0x80111194
80102379:	00 c0 fe 
8010237c:	89 e5                	mov    %esp,%ebp
8010237e:	56                   	push   %esi
8010237f:	53                   	push   %ebx
80102380:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102387:	00 00 00 
8010238a:	8b 15 94 11 11 80    	mov    0x80111194,%edx
80102390:	8b 72 10             	mov    0x10(%edx),%esi
80102393:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
80102399:	8b 0d 94 11 11 80    	mov    0x80111194,%ecx
8010239f:	0f b6 15 c0 12 11 80 	movzbl 0x801112c0,%edx
801023a6:	c1 ee 10             	shr    $0x10,%esi
801023a9:	89 f0                	mov    %esi,%eax
801023ab:	0f b6 f0             	movzbl %al,%esi
801023ae:	8b 41 10             	mov    0x10(%ecx),%eax
801023b1:	c1 e8 18             	shr    $0x18,%eax
801023b4:	39 c2                	cmp    %eax,%edx
801023b6:	75 48                	jne    80102400 <ioapicinit+0xa0>
801023b8:	83 c6 21             	add    $0x21,%esi
801023bb:	ba 10 00 00 00       	mov    $0x10,%edx
801023c0:	b8 20 00 00 00       	mov    $0x20,%eax
801023c5:	8d 76 00             	lea    0x0(%esi),%esi
801023c8:	89 11                	mov    %edx,(%ecx)
801023ca:	89 c3                	mov    %eax,%ebx
801023cc:	8b 0d 94 11 11 80    	mov    0x80111194,%ecx
801023d2:	83 c0 01             	add    $0x1,%eax
801023d5:	81 cb 00 00 01 00    	or     $0x10000,%ebx
801023db:	89 59 10             	mov    %ebx,0x10(%ecx)
801023de:	8d 5a 01             	lea    0x1(%edx),%ebx
801023e1:	83 c2 02             	add    $0x2,%edx
801023e4:	89 19                	mov    %ebx,(%ecx)
801023e6:	8b 0d 94 11 11 80    	mov    0x80111194,%ecx
801023ec:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
801023f3:	39 f0                	cmp    %esi,%eax
801023f5:	75 d1                	jne    801023c8 <ioapicinit+0x68>
801023f7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023fa:	5b                   	pop    %ebx
801023fb:	5e                   	pop    %esi
801023fc:	5d                   	pop    %ebp
801023fd:	c3                   	ret    
801023fe:	66 90                	xchg   %ax,%ax
80102400:	83 ec 0c             	sub    $0xc,%esp
80102403:	68 48 75 10 80       	push   $0x80107548
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
80102430:	f3 0f 1e fb          	endbr32 
80102434:	55                   	push   %ebp
80102435:	8b 15 c4 12 11 80    	mov    0x801112c4,%edx
8010243b:	89 e5                	mov    %esp,%ebp
8010243d:	8b 45 08             	mov    0x8(%ebp),%eax
80102440:	85 d2                	test   %edx,%edx
80102442:	74 2b                	je     8010246f <ioapicenable+0x3f>
80102444:	8b 0d 94 11 11 80    	mov    0x80111194,%ecx
8010244a:	8d 50 20             	lea    0x20(%eax),%edx
8010244d:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
80102451:	89 01                	mov    %eax,(%ecx)
80102453:	8b 0d 94 11 11 80    	mov    0x80111194,%ecx
80102459:	83 c0 01             	add    $0x1,%eax
8010245c:	89 51 10             	mov    %edx,0x10(%ecx)
8010245f:	8b 55 0c             	mov    0xc(%ebp),%edx
80102462:	89 01                	mov    %eax,(%ecx)
80102464:	a1 94 11 11 80       	mov    0x80111194,%eax
80102469:	c1 e2 18             	shl    $0x18,%edx
8010246c:	89 50 10             	mov    %edx,0x10(%eax)
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
80102480:	f3 0f 1e fb          	endbr32 
80102484:	55                   	push   %ebp
80102485:	89 e5                	mov    %esp,%ebp
80102487:	53                   	push   %ebx
80102488:	83 ec 04             	sub    $0x4,%esp
8010248b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010248e:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102494:	75 7a                	jne    80102510 <kfree+0x90>
80102496:	81 fb 68 42 11 80    	cmp    $0x80114268,%ebx
8010249c:	72 72                	jb     80102510 <kfree+0x90>
8010249e:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801024a4:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801024a9:	77 65                	ja     80102510 <kfree+0x90>
801024ab:	83 ec 04             	sub    $0x4,%esp
801024ae:	68 00 10 00 00       	push   $0x1000
801024b3:	6a 01                	push   $0x1
801024b5:	53                   	push   %ebx
801024b6:	e8 45 23 00 00       	call   80104800 <memset>
801024bb:	8b 15 d4 11 11 80    	mov    0x801111d4,%edx
801024c1:	83 c4 10             	add    $0x10,%esp
801024c4:	85 d2                	test   %edx,%edx
801024c6:	75 20                	jne    801024e8 <kfree+0x68>
801024c8:	a1 d8 11 11 80       	mov    0x801111d8,%eax
801024cd:	89 03                	mov    %eax,(%ebx)
801024cf:	a1 d4 11 11 80       	mov    0x801111d4,%eax
801024d4:	89 1d d8 11 11 80    	mov    %ebx,0x801111d8
801024da:	85 c0                	test   %eax,%eax
801024dc:	75 22                	jne    80102500 <kfree+0x80>
801024de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024e1:	c9                   	leave  
801024e2:	c3                   	ret    
801024e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024e7:	90                   	nop
801024e8:	83 ec 0c             	sub    $0xc,%esp
801024eb:	68 a0 11 11 80       	push   $0x801111a0
801024f0:	e8 db 20 00 00       	call   801045d0 <acquire>
801024f5:	83 c4 10             	add    $0x10,%esp
801024f8:	eb ce                	jmp    801024c8 <kfree+0x48>
801024fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102500:	c7 45 08 a0 11 11 80 	movl   $0x801111a0,0x8(%ebp)
80102507:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010250a:	c9                   	leave  
8010250b:	e9 a0 22 00 00       	jmp    801047b0 <release>
80102510:	83 ec 0c             	sub    $0xc,%esp
80102513:	68 7a 75 10 80       	push   $0x8010757a
80102518:	e8 63 de ff ff       	call   80100380 <panic>
8010251d:	8d 76 00             	lea    0x0(%esi),%esi

80102520 <freerange>:
80102520:	f3 0f 1e fb          	endbr32 
80102524:	55                   	push   %ebp
80102525:	89 e5                	mov    %esp,%ebp
80102527:	56                   	push   %esi
80102528:	8b 45 08             	mov    0x8(%ebp),%eax
8010252b:	8b 75 0c             	mov    0xc(%ebp),%esi
8010252e:	53                   	push   %ebx
8010252f:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102535:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
8010253b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102541:	39 de                	cmp    %ebx,%esi
80102543:	72 1f                	jb     80102564 <freerange+0x44>
80102545:	8d 76 00             	lea    0x0(%esi),%esi
80102548:	83 ec 0c             	sub    $0xc,%esp
8010254b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102551:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102557:	50                   	push   %eax
80102558:	e8 23 ff ff ff       	call   80102480 <kfree>
8010255d:	83 c4 10             	add    $0x10,%esp
80102560:	39 f3                	cmp    %esi,%ebx
80102562:	76 e4                	jbe    80102548 <freerange+0x28>
80102564:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102567:	5b                   	pop    %ebx
80102568:	5e                   	pop    %esi
80102569:	5d                   	pop    %ebp
8010256a:	c3                   	ret    
8010256b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010256f:	90                   	nop

80102570 <kinit1>:
80102570:	f3 0f 1e fb          	endbr32 
80102574:	55                   	push   %ebp
80102575:	89 e5                	mov    %esp,%ebp
80102577:	56                   	push   %esi
80102578:	53                   	push   %ebx
80102579:	8b 75 0c             	mov    0xc(%ebp),%esi
8010257c:	83 ec 08             	sub    $0x8,%esp
8010257f:	68 80 75 10 80       	push   $0x80107580
80102584:	68 a0 11 11 80       	push   $0x801111a0
80102589:	e8 22 20 00 00       	call   801045b0 <initlock>
8010258e:	8b 45 08             	mov    0x8(%ebp),%eax
80102591:	83 c4 10             	add    $0x10,%esp
80102594:	c7 05 d4 11 11 80 00 	movl   $0x0,0x801111d4
8010259b:	00 00 00 
8010259e:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025a4:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801025aa:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025b0:	39 de                	cmp    %ebx,%esi
801025b2:	72 20                	jb     801025d4 <kinit1+0x64>
801025b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801025b8:	83 ec 0c             	sub    $0xc,%esp
801025bb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801025c1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025c7:	50                   	push   %eax
801025c8:	e8 b3 fe ff ff       	call   80102480 <kfree>
801025cd:	83 c4 10             	add    $0x10,%esp
801025d0:	39 de                	cmp    %ebx,%esi
801025d2:	73 e4                	jae    801025b8 <kinit1+0x48>
801025d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025d7:	5b                   	pop    %ebx
801025d8:	5e                   	pop    %esi
801025d9:	5d                   	pop    %ebp
801025da:	c3                   	ret    
801025db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801025df:	90                   	nop

801025e0 <kinit2>:
801025e0:	f3 0f 1e fb          	endbr32 
801025e4:	55                   	push   %ebp
801025e5:	89 e5                	mov    %esp,%ebp
801025e7:	56                   	push   %esi
801025e8:	8b 45 08             	mov    0x8(%ebp),%eax
801025eb:	8b 75 0c             	mov    0xc(%ebp),%esi
801025ee:	53                   	push   %ebx
801025ef:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025f5:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801025fb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102601:	39 de                	cmp    %ebx,%esi
80102603:	72 1f                	jb     80102624 <kinit2+0x44>
80102605:	8d 76 00             	lea    0x0(%esi),%esi
80102608:	83 ec 0c             	sub    $0xc,%esp
8010260b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102611:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102617:	50                   	push   %eax
80102618:	e8 63 fe ff ff       	call   80102480 <kfree>
8010261d:	83 c4 10             	add    $0x10,%esp
80102620:	39 de                	cmp    %ebx,%esi
80102622:	73 e4                	jae    80102608 <kinit2+0x28>
80102624:	c7 05 d4 11 11 80 01 	movl   $0x1,0x801111d4
8010262b:	00 00 00 
8010262e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102631:	5b                   	pop    %ebx
80102632:	5e                   	pop    %esi
80102633:	5d                   	pop    %ebp
80102634:	c3                   	ret    
80102635:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010263c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102640 <kalloc>:
80102640:	f3 0f 1e fb          	endbr32 
80102644:	a1 d4 11 11 80       	mov    0x801111d4,%eax
80102649:	85 c0                	test   %eax,%eax
8010264b:	75 1b                	jne    80102668 <kalloc+0x28>
8010264d:	a1 d8 11 11 80       	mov    0x801111d8,%eax
80102652:	85 c0                	test   %eax,%eax
80102654:	74 0a                	je     80102660 <kalloc+0x20>
80102656:	8b 10                	mov    (%eax),%edx
80102658:	89 15 d8 11 11 80    	mov    %edx,0x801111d8
8010265e:	c3                   	ret    
8010265f:	90                   	nop
80102660:	c3                   	ret    
80102661:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102668:	55                   	push   %ebp
80102669:	89 e5                	mov    %esp,%ebp
8010266b:	83 ec 24             	sub    $0x24,%esp
8010266e:	68 a0 11 11 80       	push   $0x801111a0
80102673:	e8 58 1f 00 00       	call   801045d0 <acquire>
80102678:	a1 d8 11 11 80       	mov    0x801111d8,%eax
8010267d:	8b 15 d4 11 11 80    	mov    0x801111d4,%edx
80102683:	83 c4 10             	add    $0x10,%esp
80102686:	85 c0                	test   %eax,%eax
80102688:	74 08                	je     80102692 <kalloc+0x52>
8010268a:	8b 08                	mov    (%eax),%ecx
8010268c:	89 0d d8 11 11 80    	mov    %ecx,0x801111d8
80102692:	85 d2                	test   %edx,%edx
80102694:	74 16                	je     801026ac <kalloc+0x6c>
80102696:	83 ec 0c             	sub    $0xc,%esp
80102699:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010269c:	68 a0 11 11 80       	push   $0x801111a0
801026a1:	e8 0a 21 00 00       	call   801047b0 <release>
801026a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801026a9:	83 c4 10             	add    $0x10,%esp
801026ac:	c9                   	leave  
801026ad:	c3                   	ret    
801026ae:	66 90                	xchg   %ax,%ax

801026b0 <kbdgetc>:
801026b0:	f3 0f 1e fb          	endbr32 
801026b4:	ba 64 00 00 00       	mov    $0x64,%edx
801026b9:	ec                   	in     (%dx),%al
801026ba:	a8 01                	test   $0x1,%al
801026bc:	0f 84 be 00 00 00    	je     80102780 <kbdgetc+0xd0>
801026c2:	55                   	push   %ebp
801026c3:	ba 60 00 00 00       	mov    $0x60,%edx
801026c8:	89 e5                	mov    %esp,%ebp
801026ca:	53                   	push   %ebx
801026cb:	ec                   	in     (%dx),%al
801026cc:	8b 1d b4 a5 10 80    	mov    0x8010a5b4,%ebx
801026d2:	0f b6 d0             	movzbl %al,%edx
801026d5:	3c e0                	cmp    $0xe0,%al
801026d7:	74 57                	je     80102730 <kbdgetc+0x80>
801026d9:	89 d9                	mov    %ebx,%ecx
801026db:	83 e1 40             	and    $0x40,%ecx
801026de:	84 c0                	test   %al,%al
801026e0:	78 5e                	js     80102740 <kbdgetc+0x90>
801026e2:	85 c9                	test   %ecx,%ecx
801026e4:	74 09                	je     801026ef <kbdgetc+0x3f>
801026e6:	83 c8 80             	or     $0xffffff80,%eax
801026e9:	83 e3 bf             	and    $0xffffffbf,%ebx
801026ec:	0f b6 d0             	movzbl %al,%edx
801026ef:	0f b6 8a c0 76 10 80 	movzbl -0x7fef8940(%edx),%ecx
801026f6:	0f b6 82 c0 75 10 80 	movzbl -0x7fef8a40(%edx),%eax
801026fd:	09 d9                	or     %ebx,%ecx
801026ff:	31 c1                	xor    %eax,%ecx
80102701:	89 c8                	mov    %ecx,%eax
80102703:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
80102709:	83 e0 03             	and    $0x3,%eax
8010270c:	83 e1 08             	and    $0x8,%ecx
8010270f:	8b 04 85 a0 75 10 80 	mov    -0x7fef8a60(,%eax,4),%eax
80102716:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
8010271a:	74 0b                	je     80102727 <kbdgetc+0x77>
8010271c:	8d 50 9f             	lea    -0x61(%eax),%edx
8010271f:	83 fa 19             	cmp    $0x19,%edx
80102722:	77 44                	ja     80102768 <kbdgetc+0xb8>
80102724:	83 e8 20             	sub    $0x20,%eax
80102727:	5b                   	pop    %ebx
80102728:	5d                   	pop    %ebp
80102729:	c3                   	ret    
8010272a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102730:	83 cb 40             	or     $0x40,%ebx
80102733:	31 c0                	xor    %eax,%eax
80102735:	89 1d b4 a5 10 80    	mov    %ebx,0x8010a5b4
8010273b:	5b                   	pop    %ebx
8010273c:	5d                   	pop    %ebp
8010273d:	c3                   	ret    
8010273e:	66 90                	xchg   %ax,%ax
80102740:	83 e0 7f             	and    $0x7f,%eax
80102743:	85 c9                	test   %ecx,%ecx
80102745:	0f 44 d0             	cmove  %eax,%edx
80102748:	31 c0                	xor    %eax,%eax
8010274a:	0f b6 8a c0 76 10 80 	movzbl -0x7fef8940(%edx),%ecx
80102751:	83 c9 40             	or     $0x40,%ecx
80102754:	0f b6 c9             	movzbl %cl,%ecx
80102757:	f7 d1                	not    %ecx
80102759:	21 d9                	and    %ebx,%ecx
8010275b:	5b                   	pop    %ebx
8010275c:	5d                   	pop    %ebp
8010275d:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
80102763:	c3                   	ret    
80102764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102768:	8d 48 bf             	lea    -0x41(%eax),%ecx
8010276b:	8d 50 20             	lea    0x20(%eax),%edx
8010276e:	5b                   	pop    %ebx
8010276f:	5d                   	pop    %ebp
80102770:	83 f9 1a             	cmp    $0x1a,%ecx
80102773:	0f 42 c2             	cmovb  %edx,%eax
80102776:	c3                   	ret    
80102777:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010277e:	66 90                	xchg   %ax,%ax
80102780:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102785:	c3                   	ret    
80102786:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010278d:	8d 76 00             	lea    0x0(%esi),%esi

80102790 <kbdintr>:
80102790:	f3 0f 1e fb          	endbr32 
80102794:	55                   	push   %ebp
80102795:	89 e5                	mov    %esp,%ebp
80102797:	83 ec 14             	sub    $0x14,%esp
8010279a:	68 b0 26 10 80       	push   $0x801026b0
8010279f:	e8 ac e0 ff ff       	call   80100850 <consoleintr>
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
8010291e:	68 c0 77 10 80       	push   $0x801077c0
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
8010293e:	68 ec 77 10 80       	push   $0x801077ec
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
80102b4f:	e8 fc 1c 00 00       	call   80104850 <memcmp>
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
80102c20:	8b 0d 28 12 11 80    	mov    0x80111228,%ecx
80102c26:	85 c9                	test   %ecx,%ecx
80102c28:	0f 8e 8a 00 00 00    	jle    80102cb8 <install_trans+0x98>
80102c2e:	55                   	push   %ebp
80102c2f:	89 e5                	mov    %esp,%ebp
80102c31:	57                   	push   %edi
80102c32:	31 ff                	xor    %edi,%edi
80102c34:	56                   	push   %esi
80102c35:	53                   	push   %ebx
80102c36:	83 ec 0c             	sub    $0xc,%esp
80102c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c40:	a1 14 12 11 80       	mov    0x80111214,%eax
80102c45:	83 ec 08             	sub    $0x8,%esp
80102c48:	01 f8                	add    %edi,%eax
80102c4a:	83 c0 01             	add    $0x1,%eax
80102c4d:	50                   	push   %eax
80102c4e:	ff 35 24 12 11 80    	pushl  0x80111224
80102c54:	e8 67 d4 ff ff       	call   801000c0 <bread>
80102c59:	89 c6                	mov    %eax,%esi
80102c5b:	58                   	pop    %eax
80102c5c:	5a                   	pop    %edx
80102c5d:	ff 34 bd 2c 12 11 80 	pushl  -0x7feeedd4(,%edi,4)
80102c64:	ff 35 24 12 11 80    	pushl  0x80111224
80102c6a:	83 c7 01             	add    $0x1,%edi
80102c6d:	e8 4e d4 ff ff       	call   801000c0 <bread>
80102c72:	83 c4 0c             	add    $0xc,%esp
80102c75:	89 c3                	mov    %eax,%ebx
80102c77:	8d 46 18             	lea    0x18(%esi),%eax
80102c7a:	68 00 02 00 00       	push   $0x200
80102c7f:	50                   	push   %eax
80102c80:	8d 43 18             	lea    0x18(%ebx),%eax
80102c83:	50                   	push   %eax
80102c84:	e8 17 1c 00 00       	call   801048a0 <memmove>
80102c89:	89 1c 24             	mov    %ebx,(%esp)
80102c8c:	e8 3f d5 ff ff       	call   801001d0 <bwrite>
80102c91:	89 34 24             	mov    %esi,(%esp)
80102c94:	e8 67 d5 ff ff       	call   80100200 <brelse>
80102c99:	89 1c 24             	mov    %ebx,(%esp)
80102c9c:	e8 5f d5 ff ff       	call   80100200 <brelse>
80102ca1:	83 c4 10             	add    $0x10,%esp
80102ca4:	39 3d 28 12 11 80    	cmp    %edi,0x80111228
80102caa:	7f 94                	jg     80102c40 <install_trans+0x20>
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
80102cc0:	55                   	push   %ebp
80102cc1:	89 e5                	mov    %esp,%ebp
80102cc3:	53                   	push   %ebx
80102cc4:	83 ec 0c             	sub    $0xc,%esp
80102cc7:	ff 35 14 12 11 80    	pushl  0x80111214
80102ccd:	ff 35 24 12 11 80    	pushl  0x80111224
80102cd3:	e8 e8 d3 ff ff       	call   801000c0 <bread>
80102cd8:	83 c4 10             	add    $0x10,%esp
80102cdb:	89 c3                	mov    %eax,%ebx
80102cdd:	a1 28 12 11 80       	mov    0x80111228,%eax
80102ce2:	89 43 18             	mov    %eax,0x18(%ebx)
80102ce5:	a1 28 12 11 80       	mov    0x80111228,%eax
80102cea:	85 c0                	test   %eax,%eax
80102cec:	7e 18                	jle    80102d06 <write_head+0x46>
80102cee:	31 d2                	xor    %edx,%edx
80102cf0:	8b 0c 95 2c 12 11 80 	mov    -0x7feeedd4(,%edx,4),%ecx
80102cf7:	89 4c 93 1c          	mov    %ecx,0x1c(%ebx,%edx,4)
80102cfb:	83 c2 01             	add    $0x1,%edx
80102cfe:	39 15 28 12 11 80    	cmp    %edx,0x80111228
80102d04:	7f ea                	jg     80102cf0 <write_head+0x30>
80102d06:	83 ec 0c             	sub    $0xc,%esp
80102d09:	53                   	push   %ebx
80102d0a:	e8 c1 d4 ff ff       	call   801001d0 <bwrite>
80102d0f:	89 1c 24             	mov    %ebx,(%esp)
80102d12:	e8 e9 d4 ff ff       	call   80100200 <brelse>
80102d17:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d1a:	83 c4 10             	add    $0x10,%esp
80102d1d:	c9                   	leave  
80102d1e:	c3                   	ret    
80102d1f:	90                   	nop

80102d20 <initlog>:
80102d20:	f3 0f 1e fb          	endbr32 
80102d24:	55                   	push   %ebp
80102d25:	89 e5                	mov    %esp,%ebp
80102d27:	53                   	push   %ebx
80102d28:	83 ec 2c             	sub    $0x2c,%esp
80102d2b:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102d2e:	68 fc 77 10 80       	push   $0x801077fc
80102d33:	68 e0 11 11 80       	push   $0x801111e0
80102d38:	e8 73 18 00 00       	call   801045b0 <initlock>
80102d3d:	58                   	pop    %eax
80102d3e:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102d41:	5a                   	pop    %edx
80102d42:	50                   	push   %eax
80102d43:	53                   	push   %ebx
80102d44:	e8 17 e7 ff ff       	call   80101460 <readsb>
80102d49:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102d4c:	59                   	pop    %ecx
80102d4d:	89 1d 24 12 11 80    	mov    %ebx,0x80111224
80102d53:	8b 55 e8             	mov    -0x18(%ebp),%edx
80102d56:	a3 14 12 11 80       	mov    %eax,0x80111214
80102d5b:	89 15 18 12 11 80    	mov    %edx,0x80111218
80102d61:	5a                   	pop    %edx
80102d62:	50                   	push   %eax
80102d63:	53                   	push   %ebx
80102d64:	e8 57 d3 ff ff       	call   801000c0 <bread>
80102d69:	83 c4 10             	add    $0x10,%esp
80102d6c:	8b 48 18             	mov    0x18(%eax),%ecx
80102d6f:	89 0d 28 12 11 80    	mov    %ecx,0x80111228
80102d75:	85 c9                	test   %ecx,%ecx
80102d77:	7e 19                	jle    80102d92 <initlog+0x72>
80102d79:	31 d2                	xor    %edx,%edx
80102d7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d7f:	90                   	nop
80102d80:	8b 5c 90 1c          	mov    0x1c(%eax,%edx,4),%ebx
80102d84:	89 1c 95 2c 12 11 80 	mov    %ebx,-0x7feeedd4(,%edx,4)
80102d8b:	83 c2 01             	add    $0x1,%edx
80102d8e:	39 d1                	cmp    %edx,%ecx
80102d90:	75 ee                	jne    80102d80 <initlog+0x60>
80102d92:	83 ec 0c             	sub    $0xc,%esp
80102d95:	50                   	push   %eax
80102d96:	e8 65 d4 ff ff       	call   80100200 <brelse>
80102d9b:	e8 80 fe ff ff       	call   80102c20 <install_trans>
80102da0:	c7 05 28 12 11 80 00 	movl   $0x0,0x80111228
80102da7:	00 00 00 
80102daa:	e8 11 ff ff ff       	call   80102cc0 <write_head>
80102daf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102db2:	83 c4 10             	add    $0x10,%esp
80102db5:	c9                   	leave  
80102db6:	c3                   	ret    
80102db7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102dbe:	66 90                	xchg   %ax,%ax

80102dc0 <begin_op>:
80102dc0:	f3 0f 1e fb          	endbr32 
80102dc4:	55                   	push   %ebp
80102dc5:	89 e5                	mov    %esp,%ebp
80102dc7:	83 ec 14             	sub    $0x14,%esp
80102dca:	68 e0 11 11 80       	push   $0x801111e0
80102dcf:	e8 fc 17 00 00       	call   801045d0 <acquire>
80102dd4:	83 c4 10             	add    $0x10,%esp
80102dd7:	eb 1c                	jmp    80102df5 <begin_op+0x35>
80102dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102de0:	83 ec 08             	sub    $0x8,%esp
80102de3:	68 e0 11 11 80       	push   $0x801111e0
80102de8:	68 e0 11 11 80       	push   $0x801111e0
80102ded:	e8 3e 12 00 00       	call   80104030 <sleep>
80102df2:	83 c4 10             	add    $0x10,%esp
80102df5:	a1 20 12 11 80       	mov    0x80111220,%eax
80102dfa:	85 c0                	test   %eax,%eax
80102dfc:	75 e2                	jne    80102de0 <begin_op+0x20>
80102dfe:	a1 1c 12 11 80       	mov    0x8011121c,%eax
80102e03:	8b 15 28 12 11 80    	mov    0x80111228,%edx
80102e09:	83 c0 01             	add    $0x1,%eax
80102e0c:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102e0f:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102e12:	83 fa 1e             	cmp    $0x1e,%edx
80102e15:	7f c9                	jg     80102de0 <begin_op+0x20>
80102e17:	83 ec 0c             	sub    $0xc,%esp
80102e1a:	a3 1c 12 11 80       	mov    %eax,0x8011121c
80102e1f:	68 e0 11 11 80       	push   $0x801111e0
80102e24:	e8 87 19 00 00       	call   801047b0 <release>
80102e29:	83 c4 10             	add    $0x10,%esp
80102e2c:	c9                   	leave  
80102e2d:	c3                   	ret    
80102e2e:	66 90                	xchg   %ax,%ax

80102e30 <end_op>:
80102e30:	f3 0f 1e fb          	endbr32 
80102e34:	55                   	push   %ebp
80102e35:	89 e5                	mov    %esp,%ebp
80102e37:	57                   	push   %edi
80102e38:	56                   	push   %esi
80102e39:	53                   	push   %ebx
80102e3a:	83 ec 18             	sub    $0x18,%esp
80102e3d:	68 e0 11 11 80       	push   $0x801111e0
80102e42:	e8 89 17 00 00       	call   801045d0 <acquire>
80102e47:	a1 1c 12 11 80       	mov    0x8011121c,%eax
80102e4c:	8b 35 20 12 11 80    	mov    0x80111220,%esi
80102e52:	83 c4 10             	add    $0x10,%esp
80102e55:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102e58:	89 1d 1c 12 11 80    	mov    %ebx,0x8011121c
80102e5e:	85 f6                	test   %esi,%esi
80102e60:	0f 85 1e 01 00 00    	jne    80102f84 <end_op+0x154>
80102e66:	85 db                	test   %ebx,%ebx
80102e68:	0f 85 f2 00 00 00    	jne    80102f60 <end_op+0x130>
80102e6e:	c7 05 20 12 11 80 01 	movl   $0x1,0x80111220
80102e75:	00 00 00 
80102e78:	83 ec 0c             	sub    $0xc,%esp
80102e7b:	68 e0 11 11 80       	push   $0x801111e0
80102e80:	e8 2b 19 00 00       	call   801047b0 <release>
80102e85:	8b 0d 28 12 11 80    	mov    0x80111228,%ecx
80102e8b:	83 c4 10             	add    $0x10,%esp
80102e8e:	85 c9                	test   %ecx,%ecx
80102e90:	7f 3e                	jg     80102ed0 <end_op+0xa0>
80102e92:	83 ec 0c             	sub    $0xc,%esp
80102e95:	68 e0 11 11 80       	push   $0x801111e0
80102e9a:	e8 31 17 00 00       	call   801045d0 <acquire>
80102e9f:	c7 04 24 e0 11 11 80 	movl   $0x801111e0,(%esp)
80102ea6:	c7 05 20 12 11 80 00 	movl   $0x0,0x80111220
80102ead:	00 00 00 
80102eb0:	e8 3b 13 00 00       	call   801041f0 <wakeup>
80102eb5:	c7 04 24 e0 11 11 80 	movl   $0x801111e0,(%esp)
80102ebc:	e8 ef 18 00 00       	call   801047b0 <release>
80102ec1:	83 c4 10             	add    $0x10,%esp
80102ec4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ec7:	5b                   	pop    %ebx
80102ec8:	5e                   	pop    %esi
80102ec9:	5f                   	pop    %edi
80102eca:	5d                   	pop    %ebp
80102ecb:	c3                   	ret    
80102ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ed0:	a1 14 12 11 80       	mov    0x80111214,%eax
80102ed5:	83 ec 08             	sub    $0x8,%esp
80102ed8:	01 d8                	add    %ebx,%eax
80102eda:	83 c0 01             	add    $0x1,%eax
80102edd:	50                   	push   %eax
80102ede:	ff 35 24 12 11 80    	pushl  0x80111224
80102ee4:	e8 d7 d1 ff ff       	call   801000c0 <bread>
80102ee9:	89 c6                	mov    %eax,%esi
80102eeb:	58                   	pop    %eax
80102eec:	5a                   	pop    %edx
80102eed:	ff 34 9d 2c 12 11 80 	pushl  -0x7feeedd4(,%ebx,4)
80102ef4:	ff 35 24 12 11 80    	pushl  0x80111224
80102efa:	83 c3 01             	add    $0x1,%ebx
80102efd:	e8 be d1 ff ff       	call   801000c0 <bread>
80102f02:	83 c4 0c             	add    $0xc,%esp
80102f05:	89 c7                	mov    %eax,%edi
80102f07:	8d 40 18             	lea    0x18(%eax),%eax
80102f0a:	68 00 02 00 00       	push   $0x200
80102f0f:	50                   	push   %eax
80102f10:	8d 46 18             	lea    0x18(%esi),%eax
80102f13:	50                   	push   %eax
80102f14:	e8 87 19 00 00       	call   801048a0 <memmove>
80102f19:	89 34 24             	mov    %esi,(%esp)
80102f1c:	e8 af d2 ff ff       	call   801001d0 <bwrite>
80102f21:	89 3c 24             	mov    %edi,(%esp)
80102f24:	e8 d7 d2 ff ff       	call   80100200 <brelse>
80102f29:	89 34 24             	mov    %esi,(%esp)
80102f2c:	e8 cf d2 ff ff       	call   80100200 <brelse>
80102f31:	83 c4 10             	add    $0x10,%esp
80102f34:	3b 1d 28 12 11 80    	cmp    0x80111228,%ebx
80102f3a:	7c 94                	jl     80102ed0 <end_op+0xa0>
80102f3c:	e8 7f fd ff ff       	call   80102cc0 <write_head>
80102f41:	e8 da fc ff ff       	call   80102c20 <install_trans>
80102f46:	c7 05 28 12 11 80 00 	movl   $0x0,0x80111228
80102f4d:	00 00 00 
80102f50:	e8 6b fd ff ff       	call   80102cc0 <write_head>
80102f55:	e9 38 ff ff ff       	jmp    80102e92 <end_op+0x62>
80102f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102f60:	83 ec 0c             	sub    $0xc,%esp
80102f63:	68 e0 11 11 80       	push   $0x801111e0
80102f68:	e8 83 12 00 00       	call   801041f0 <wakeup>
80102f6d:	c7 04 24 e0 11 11 80 	movl   $0x801111e0,(%esp)
80102f74:	e8 37 18 00 00       	call   801047b0 <release>
80102f79:	83 c4 10             	add    $0x10,%esp
80102f7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f7f:	5b                   	pop    %ebx
80102f80:	5e                   	pop    %esi
80102f81:	5f                   	pop    %edi
80102f82:	5d                   	pop    %ebp
80102f83:	c3                   	ret    
80102f84:	83 ec 0c             	sub    $0xc,%esp
80102f87:	68 00 78 10 80       	push   $0x80107800
80102f8c:	e8 ef d3 ff ff       	call   80100380 <panic>
80102f91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f9f:	90                   	nop

80102fa0 <log_write>:
80102fa0:	f3 0f 1e fb          	endbr32 
80102fa4:	55                   	push   %ebp
80102fa5:	89 e5                	mov    %esp,%ebp
80102fa7:	53                   	push   %ebx
80102fa8:	83 ec 04             	sub    $0x4,%esp
80102fab:	8b 15 28 12 11 80    	mov    0x80111228,%edx
80102fb1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102fb4:	83 fa 1d             	cmp    $0x1d,%edx
80102fb7:	0f 8f 91 00 00 00    	jg     8010304e <log_write+0xae>
80102fbd:	a1 18 12 11 80       	mov    0x80111218,%eax
80102fc2:	83 e8 01             	sub    $0x1,%eax
80102fc5:	39 c2                	cmp    %eax,%edx
80102fc7:	0f 8d 81 00 00 00    	jge    8010304e <log_write+0xae>
80102fcd:	a1 1c 12 11 80       	mov    0x8011121c,%eax
80102fd2:	85 c0                	test   %eax,%eax
80102fd4:	0f 8e 81 00 00 00    	jle    8010305b <log_write+0xbb>
80102fda:	83 ec 0c             	sub    $0xc,%esp
80102fdd:	68 e0 11 11 80       	push   $0x801111e0
80102fe2:	e8 e9 15 00 00       	call   801045d0 <acquire>
80102fe7:	8b 15 28 12 11 80    	mov    0x80111228,%edx
80102fed:	83 c4 10             	add    $0x10,%esp
80102ff0:	85 d2                	test   %edx,%edx
80102ff2:	7e 4e                	jle    80103042 <log_write+0xa2>
80102ff4:	8b 4b 08             	mov    0x8(%ebx),%ecx
80102ff7:	31 c0                	xor    %eax,%eax
80102ff9:	eb 0c                	jmp    80103007 <log_write+0x67>
80102ffb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102fff:	90                   	nop
80103000:	83 c0 01             	add    $0x1,%eax
80103003:	39 c2                	cmp    %eax,%edx
80103005:	74 29                	je     80103030 <log_write+0x90>
80103007:	39 0c 85 2c 12 11 80 	cmp    %ecx,-0x7feeedd4(,%eax,4)
8010300e:	75 f0                	jne    80103000 <log_write+0x60>
80103010:	89 0c 85 2c 12 11 80 	mov    %ecx,-0x7feeedd4(,%eax,4)
80103017:	83 0b 04             	orl    $0x4,(%ebx)
8010301a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010301d:	c7 45 08 e0 11 11 80 	movl   $0x801111e0,0x8(%ebp)
80103024:	c9                   	leave  
80103025:	e9 86 17 00 00       	jmp    801047b0 <release>
8010302a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103030:	89 0c 95 2c 12 11 80 	mov    %ecx,-0x7feeedd4(,%edx,4)
80103037:	83 c2 01             	add    $0x1,%edx
8010303a:	89 15 28 12 11 80    	mov    %edx,0x80111228
80103040:	eb d5                	jmp    80103017 <log_write+0x77>
80103042:	8b 43 08             	mov    0x8(%ebx),%eax
80103045:	a3 2c 12 11 80       	mov    %eax,0x8011122c
8010304a:	75 cb                	jne    80103017 <log_write+0x77>
8010304c:	eb e9                	jmp    80103037 <log_write+0x97>
8010304e:	83 ec 0c             	sub    $0xc,%esp
80103051:	68 0f 78 10 80       	push   $0x8010780f
80103056:	e8 25 d3 ff ff       	call   80100380 <panic>
8010305b:	83 ec 0c             	sub    $0xc,%esp
8010305e:	68 25 78 10 80       	push   $0x80107825
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
8010307f:	68 40 78 10 80       	push   $0x80107840
80103084:	e8 17 d6 ff ff       	call   801006a0 <cprintf>
  idtinit();       // load idt register
80103089:	e8 f2 2a 00 00       	call   80105b80 <idtinit>
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
801030ba:	e8 71 3c 00 00       	call   80106d30 <switchkvm>
  seginit();
801030bf:	e8 fc 3a 00 00       	call   80106bc0 <seginit>
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
801030f5:	e8 16 3c 00 00       	call   80106d10 <kvmalloc>
  mpinit();        // detect other processors
801030fa:	e8 b1 01 00 00       	call   801032b0 <mpinit>
  lapicinit();     // interrupt controller
801030ff:	e8 ac f6 ff ff       	call   801027b0 <lapicinit>
  seginit();       // segment descriptors
80103104:	e8 b7 3a 00 00       	call   80106bc0 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpunum());
80103109:	e8 a2 f7 ff ff       	call   801028b0 <cpunum>
8010310e:	5a                   	pop    %edx
8010310f:	59                   	pop    %ecx
80103110:	50                   	push   %eax
80103111:	68 51 78 10 80       	push   $0x80107851
80103116:	e8 85 d5 ff ff       	call   801006a0 <cprintf>
  picinit();       // another interrupt controller
8010311b:	e8 a0 03 00 00       	call   801034c0 <picinit>
  ioapicinit();    // another interrupt controller
80103120:	e8 3b f2 ff ff       	call   80102360 <ioapicinit>
  consoleinit();   // console hardware
80103125:	e8 f6 d8 ff ff       	call   80100a20 <consoleinit>
  uartinit();      // serial port
8010312a:	e8 51 2d 00 00       	call   80105e80 <uartinit>
  pinit();         // process table
8010312f:	e8 cc 08 00 00       	call   80103a00 <pinit>
  tvinit();        // trap vectors
80103134:	e8 c7 29 00 00       	call   80105b00 <tvinit>
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
8010316b:	e8 30 17 00 00       	call   801048a0 <memmove>

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
80103224:	e8 77 28 00 00       	call   80105aa0 <timerinit>
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
8010325e:	68 68 78 10 80       	push   $0x80107868
80103263:	56                   	push   %esi
80103264:	e8 e7 15 00 00       	call   80104850 <memcmp>
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
8010331a:	68 6d 78 10 80       	push   $0x8010786d
8010331f:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103320:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103323:	e8 28 15 00 00       	call   80104850 <memcmp>
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
80103490:	f3 0f 1e fb          	endbr32 
80103494:	55                   	push   %ebp
80103495:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
8010349a:	ba 21 00 00 00       	mov    $0x21,%edx
8010349f:	89 e5                	mov    %esp,%ebp
801034a1:	8b 4d 08             	mov    0x8(%ebp),%ecx
801034a4:	d3 c0                	rol    %cl,%eax
801034a6:	66 23 05 00 a0 10 80 	and    0x8010a000,%ax
801034ad:	66 a3 00 a0 10 80    	mov    %ax,0x8010a000
801034b3:	ee                   	out    %al,(%dx)
801034b4:	ba a1 00 00 00       	mov    $0xa1,%edx
801034b9:	66 c1 e8 08          	shr    $0x8,%ax
801034bd:	ee                   	out    %al,(%dx)
801034be:	5d                   	pop    %ebp
801034bf:	c3                   	ret    

801034c0 <picinit>:
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
8010353b:	0f b7 05 00 a0 10 80 	movzwl 0x8010a000,%eax
80103542:	66 83 f8 ff          	cmp    $0xffff,%ax
80103546:	74 0a                	je     80103552 <picinit+0x92>
80103548:	89 da                	mov    %ebx,%edx
8010354a:	ee                   	out    %al,(%dx)
8010354b:	66 c1 e8 08          	shr    $0x8,%ax
8010354f:	89 ca                	mov    %ecx,%edx
80103551:	ee                   	out    %al,(%dx)
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
801035d7:	68 72 78 10 80       	push   $0x80107872
801035dc:	50                   	push   %eax
801035dd:	e8 ce 0f 00 00       	call   801045b0 <initlock>
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
80103683:	e8 48 0f 00 00       	call   801045d0 <acquire>
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
801036a3:	e8 48 0b 00 00       	call   801041f0 <wakeup>
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
801036c8:	e9 e3 10 00 00       	jmp    801047b0 <release>
801036cd:	8d 76 00             	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
801036d0:	83 ec 0c             	sub    $0xc,%esp
801036d3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801036d9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801036e0:	00 00 00 
    wakeup(&p->nwrite);
801036e3:	50                   	push   %eax
801036e4:	e8 07 0b 00 00       	call   801041f0 <wakeup>
801036e9:	83 c4 10             	add    $0x10,%esp
801036ec:	eb bd                	jmp    801036ab <pipeclose+0x3b>
801036ee:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801036f0:	83 ec 0c             	sub    $0xc,%esp
801036f3:	53                   	push   %ebx
801036f4:	e8 b7 10 00 00       	call   801047b0 <release>
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
80103721:	e8 aa 0e 00 00       	call   801045d0 <acquire>
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
80103779:	e8 72 0a 00 00       	call   801041f0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010377e:	58                   	pop    %eax
8010377f:	5a                   	pop    %edx
80103780:	57                   	push   %edi
80103781:	53                   	push   %ebx
80103782:	e8 a9 08 00 00       	call   80104030 <sleep>
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
801037ad:	e8 fe 0f 00 00       	call   801047b0 <release>
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
801037fa:	e8 f1 09 00 00       	call   801041f0 <wakeup>
  release(&p->lock);
801037ff:	89 3c 24             	mov    %edi,(%esp)
80103802:	e8 a9 0f 00 00       	call   801047b0 <release>
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
8010382a:	e8 a1 0d 00 00       	call   801045d0 <acquire>
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
8010385f:	e8 cc 07 00 00       	call   80104030 <sleep>
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
801038c7:	e8 24 09 00 00       	call   801041f0 <wakeup>
  release(&p->lock);
801038cc:	89 34 24             	mov    %esi,(%esp)
801038cf:	e8 dc 0e 00 00       	call   801047b0 <release>
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
801038f1:	e8 ba 0e 00 00       	call   801047b0 <release>
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
8010396a:	c7 40 14 f2 5a 10 80 	movl   $0x80105af2,0x14(%eax)
  p->context = (struct context*)sp;
80103971:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103974:	6a 14                	push   $0x14
80103976:	6a 00                	push   $0x0
80103978:	50                   	push   %eax
80103979:	e8 82 0e 00 00       	call   80104800 <memset>
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
801039bf:	e8 ec 0d 00 00       	call   801047b0 <release>

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
80103a0a:	68 77 78 10 80       	push   $0x80107877
80103a0f:	68 e0 18 11 80       	push   $0x801118e0
80103a14:	e8 97 0b 00 00       	call   801045b0 <initlock>
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
80103a30:	e8 9b 0b 00 00       	call   801045d0 <acquire>
  p = allocproc();
80103a35:	e8 d6 fe ff ff       	call   80103910 <allocproc>
80103a3a:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103a3c:	a3 bc a5 10 80       	mov    %eax,0x8010a5bc
  if((p->pgdir = setupkvm()) == 0)
80103a41:	e8 5a 32 00 00       	call   80106ca0 <setupkvm>
80103a46:	83 c4 10             	add    $0x10,%esp
80103a49:	89 43 04             	mov    %eax,0x4(%ebx)
80103a4c:	85 c0                	test   %eax,%eax
80103a4e:	0f 84 b1 00 00 00    	je     80103b05 <userinit+0xe5>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103a54:	83 ec 04             	sub    $0x4,%esp
80103a57:	68 2c 00 00 00       	push   $0x2c
80103a5c:	68 60 a4 10 80       	push   $0x8010a460
80103a61:	50                   	push   %eax
80103a62:	e8 99 33 00 00       	call   80106e00 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103a67:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103a6a:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103a70:	6a 4c                	push   $0x4c
80103a72:	6a 00                	push   $0x0
80103a74:	ff 73 18             	pushl  0x18(%ebx)
80103a77:	e8 84 0d 00 00       	call   80104800 <memset>
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
80103ad0:	68 97 78 10 80       	push   $0x80107897
80103ad5:	50                   	push   %eax
80103ad6:	e8 e5 0e 00 00       	call   801049c0 <safestrcpy>
  p->cwd = namei("/");
80103adb:	c7 04 24 a0 78 10 80 	movl   $0x801078a0,(%esp)
80103ae2:	e8 39 e5 ff ff       	call   80102020 <namei>
  p->state = RUNNABLE;
80103ae7:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  p->cwd = namei("/");
80103aee:	89 43 68             	mov    %eax,0x68(%ebx)
  release(&ptable.lock);
80103af1:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
80103af8:	e8 b3 0c 00 00       	call   801047b0 <release>
}
80103afd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b00:	83 c4 10             	add    $0x10,%esp
80103b03:	c9                   	leave  
80103b04:	c3                   	ret    
    panic("userinit: out of memory?");
80103b05:	83 ec 0c             	sub    $0xc,%esp
80103b08:	68 7e 78 10 80       	push   $0x8010787e
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
80103b48:	e8 03 32 00 00       	call   80106d50 <switchuvm>
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
80103b62:	e8 e9 33 00 00       	call   80106f50 <allocuvm>
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
80103b8a:	e8 f1 34 00 00       	call   80107080 <deallocuvm>
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
80103bb2:	e8 19 0a 00 00       	call   801045d0 <acquire>
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
80103bd7:	e8 84 35 00 00       	call   80107160 <copyuvm>
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
80103c68:	e8 53 0d 00 00       	call   801049c0 <safestrcpy>
  np->state = RUNNABLE;
80103c6d:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  pid = np->pid;
80103c74:	8b 73 10             	mov    0x10(%ebx),%esi
  release(&ptable.lock);
80103c77:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
80103c7e:	e8 2d 0b 00 00       	call   801047b0 <release>
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
80103c9d:	e8 0e 0b 00 00       	call   801047b0 <release>
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
80103ccc:	e8 df 0a 00 00       	call   801047b0 <release>
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
80103cfe:	e8 cd 08 00 00       	call   801045d0 <acquire>
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
80103d21:	e8 2a 30 00 00       	call   80106d50 <switchuvm>
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
80103d3c:	e8 e2 0c 00 00       	call   80104a23 <swtch>
      switchkvm();
80103d41:	e8 ea 2f 00 00       	call   80106d30 <switchkvm>
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
80103d6a:	e8 41 0a 00 00       	call   801047b0 <release>
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
80103d90:	e8 6b 09 00 00       	call   80104700 <holding>
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
80103dcf:	e8 4f 0c 00 00       	call   80104a23 <swtch>
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
80103deb:	68 a2 78 10 80       	push   $0x801078a2
80103df0:	e8 8b c5 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
80103df5:	83 ec 0c             	sub    $0xc,%esp
80103df8:	68 ce 78 10 80       	push   $0x801078ce
80103dfd:	e8 7e c5 ff ff       	call   80100380 <panic>
    panic("sched running");
80103e02:	83 ec 0c             	sub    $0xc,%esp
80103e05:	68 c0 78 10 80       	push   $0x801078c0
80103e0a:	e8 71 c5 ff ff       	call   80100380 <panic>
    panic("sched locks");
80103e0f:	83 ec 0c             	sub    $0xc,%esp
80103e12:	68 b4 78 10 80       	push   $0x801078b4
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
80103e38:	0f 84 9a 01 00 00    	je     80103fd8 <exit+0x1b8>
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
80103e9d:	e8 2e 07 00 00       	call   801045d0 <acquire>
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
  if(proc->parent==0 && proc->pthread!=0)
80103eea:	8b 53 14             	mov    0x14(%ebx),%edx
80103eed:	b8 14 19 11 80       	mov    $0x80111914,%eax
80103ef2:	85 d2                	test   %edx,%edx
80103ef4:	75 16                	jne    80103f0c <exit+0xec>
80103ef6:	e9 a6 00 00 00       	jmp    80103fa1 <exit+0x181>
80103efb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103eff:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f00:	05 84 00 00 00       	add    $0x84,%eax
80103f05:	3d 14 3a 11 80       	cmp    $0x80113a14,%eax
80103f0a:	74 1e                	je     80103f2a <exit+0x10a>
    if(p->state == SLEEPING && p->chan == chan)
80103f0c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f10:	75 ee                	jne    80103f00 <exit+0xe0>
80103f12:	3b 50 20             	cmp    0x20(%eax),%edx
80103f15:	75 e9                	jne    80103f00 <exit+0xe0>
      p->state = RUNNABLE;
80103f17:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f1e:	05 84 00 00 00       	add    $0x84,%eax
80103f23:	3d 14 3a 11 80       	cmp    $0x80113a14,%eax
80103f28:	75 e2                	jne    80103f0c <exit+0xec>
      p->parent = initproc;
80103f2a:	8b 0d bc a5 10 80    	mov    0x8010a5bc,%ecx
80103f30:	ba 14 19 11 80       	mov    $0x80111914,%edx
80103f35:	eb 17                	jmp    80103f4e <exit+0x12e>
80103f37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f3e:	66 90                	xchg   %ax,%ax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f40:	81 c2 84 00 00 00    	add    $0x84,%edx
80103f46:	81 fa 14 3a 11 80    	cmp    $0x80113a14,%edx
80103f4c:	74 3a                	je     80103f88 <exit+0x168>
    if(p->parent == proc){
80103f4e:	3b 5a 14             	cmp    0x14(%edx),%ebx
80103f51:	75 ed                	jne    80103f40 <exit+0x120>
      if(p->state == ZOMBIE)
80103f53:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103f57:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103f5a:	75 e4                	jne    80103f40 <exit+0x120>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f5c:	b8 14 19 11 80       	mov    $0x80111914,%eax
80103f61:	eb 11                	jmp    80103f74 <exit+0x154>
80103f63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f67:	90                   	nop
80103f68:	05 84 00 00 00       	add    $0x84,%eax
80103f6d:	3d 14 3a 11 80       	cmp    $0x80113a14,%eax
80103f72:	74 cc                	je     80103f40 <exit+0x120>
    if(p->state == SLEEPING && p->chan == chan)
80103f74:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f78:	75 ee                	jne    80103f68 <exit+0x148>
80103f7a:	3b 48 20             	cmp    0x20(%eax),%ecx
80103f7d:	75 e9                	jne    80103f68 <exit+0x148>
      p->state = RUNNABLE;
80103f7f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103f86:	eb e0                	jmp    80103f68 <exit+0x148>
  proc->state = ZOMBIE;
80103f88:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103f8f:	e8 ec fd ff ff       	call   80103d80 <sched>
  panic("zombie exit");
80103f94:	83 ec 0c             	sub    $0xc,%esp
80103f97:	68 ef 78 10 80       	push   $0x801078ef
80103f9c:	e8 df c3 ff ff       	call   80100380 <panic>
  if(proc->parent==0 && proc->pthread!=0)
80103fa1:	8b 4b 7c             	mov    0x7c(%ebx),%ecx
80103fa4:	85 c9                	test   %ecx,%ecx
80103fa6:	75 28                	jne    80103fd0 <exit+0x1b0>
80103fa8:	e9 5f ff ff ff       	jmp    80103f0c <exit+0xec>
80103fad:	8d 76 00             	lea    0x0(%esi),%esi
    if(p->state == SLEEPING && p->chan == chan)
80103fb0:	3b 48 20             	cmp    0x20(%eax),%ecx
80103fb3:	75 0b                	jne    80103fc0 <exit+0x1a0>
      p->state = RUNNABLE;
80103fb5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fc0:	05 84 00 00 00       	add    $0x84,%eax
80103fc5:	3d 14 3a 11 80       	cmp    $0x80113a14,%eax
80103fca:	0f 84 5a ff ff ff    	je     80103f2a <exit+0x10a>
    if(p->state == SLEEPING && p->chan == chan)
80103fd0:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103fd4:	75 ea                	jne    80103fc0 <exit+0x1a0>
80103fd6:	eb d8                	jmp    80103fb0 <exit+0x190>
    panic("init exiting");
80103fd8:	83 ec 0c             	sub    $0xc,%esp
80103fdb:	68 e2 78 10 80       	push   $0x801078e2
80103fe0:	e8 9b c3 ff ff       	call   80100380 <panic>
80103fe5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103ff0 <yield>:
{
80103ff0:	f3 0f 1e fb          	endbr32 
80103ff4:	55                   	push   %ebp
80103ff5:	89 e5                	mov    %esp,%ebp
80103ff7:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103ffa:	68 e0 18 11 80       	push   $0x801118e0
80103fff:	e8 cc 05 00 00       	call   801045d0 <acquire>
  proc->state = RUNNABLE;
80104004:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010400a:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80104011:	e8 6a fd ff ff       	call   80103d80 <sched>
  release(&ptable.lock);
80104016:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
8010401d:	e8 8e 07 00 00       	call   801047b0 <release>
}
80104022:	83 c4 10             	add    $0x10,%esp
80104025:	c9                   	leave  
80104026:	c3                   	ret    
80104027:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010402e:	66 90                	xchg   %ax,%ax

80104030 <sleep>:
{
80104030:	f3 0f 1e fb          	endbr32 
80104034:	55                   	push   %ebp
  if(proc == 0)
80104035:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
8010403b:	89 e5                	mov    %esp,%ebp
8010403d:	56                   	push   %esi
8010403e:	8b 75 08             	mov    0x8(%ebp),%esi
80104041:	53                   	push   %ebx
80104042:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(proc == 0)
80104045:	85 c0                	test   %eax,%eax
80104047:	0f 84 9b 00 00 00    	je     801040e8 <sleep+0xb8>
  if(lk == 0)
8010404d:	85 db                	test   %ebx,%ebx
8010404f:	0f 84 86 00 00 00    	je     801040db <sleep+0xab>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104055:	81 fb e0 18 11 80    	cmp    $0x801118e0,%ebx
8010405b:	74 5b                	je     801040b8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
8010405d:	83 ec 0c             	sub    $0xc,%esp
80104060:	68 e0 18 11 80       	push   $0x801118e0
80104065:	e8 66 05 00 00       	call   801045d0 <acquire>
    release(lk);
8010406a:	89 1c 24             	mov    %ebx,(%esp)
8010406d:	e8 3e 07 00 00       	call   801047b0 <release>
  proc->chan = chan;
80104072:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104078:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
8010407b:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80104082:	e8 f9 fc ff ff       	call   80103d80 <sched>
  proc->chan = 0;
80104087:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010408d:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
    release(&ptable.lock);
80104094:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
8010409b:	e8 10 07 00 00       	call   801047b0 <release>
    acquire(lk);
801040a0:	89 5d 08             	mov    %ebx,0x8(%ebp)
801040a3:	83 c4 10             	add    $0x10,%esp
}
801040a6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801040a9:	5b                   	pop    %ebx
801040aa:	5e                   	pop    %esi
801040ab:	5d                   	pop    %ebp
    acquire(lk);
801040ac:	e9 1f 05 00 00       	jmp    801045d0 <acquire>
801040b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  proc->chan = chan;
801040b8:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
801040bb:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
801040c2:	e8 b9 fc ff ff       	call   80103d80 <sched>
  proc->chan = 0;
801040c7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801040cd:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
}
801040d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801040d7:	5b                   	pop    %ebx
801040d8:	5e                   	pop    %esi
801040d9:	5d                   	pop    %ebp
801040da:	c3                   	ret    
    panic("sleep without lk");
801040db:	83 ec 0c             	sub    $0xc,%esp
801040de:	68 01 79 10 80       	push   $0x80107901
801040e3:	e8 98 c2 ff ff       	call   80100380 <panic>
    panic("sleep");
801040e8:	83 ec 0c             	sub    $0xc,%esp
801040eb:	68 fb 78 10 80       	push   $0x801078fb
801040f0:	e8 8b c2 ff ff       	call   80100380 <panic>
801040f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104100 <wait>:
{
80104100:	f3 0f 1e fb          	endbr32 
80104104:	55                   	push   %ebp
80104105:	89 e5                	mov    %esp,%ebp
80104107:	56                   	push   %esi
80104108:	53                   	push   %ebx
  acquire(&ptable.lock);
80104109:	83 ec 0c             	sub    $0xc,%esp
8010410c:	68 e0 18 11 80       	push   $0x801118e0
80104111:	e8 ba 04 00 00       	call   801045d0 <acquire>
80104116:	83 c4 10             	add    $0x10,%esp
      if(p->parent != proc)
80104119:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    havekids = 0;
8010411f:	31 d2                	xor    %edx,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104121:	bb 14 19 11 80       	mov    $0x80111914,%ebx
80104126:	eb 16                	jmp    8010413e <wait+0x3e>
80104128:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010412f:	90                   	nop
80104130:	81 c3 84 00 00 00    	add    $0x84,%ebx
80104136:	81 fb 14 3a 11 80    	cmp    $0x80113a14,%ebx
8010413c:	74 1e                	je     8010415c <wait+0x5c>
      if(p->parent != proc)
8010413e:	39 43 14             	cmp    %eax,0x14(%ebx)
80104141:	75 ed                	jne    80104130 <wait+0x30>
      if(p->state == ZOMBIE){
80104143:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104147:	74 37                	je     80104180 <wait+0x80>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104149:	81 c3 84 00 00 00    	add    $0x84,%ebx
      havekids = 1;
8010414f:	ba 01 00 00 00       	mov    $0x1,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104154:	81 fb 14 3a 11 80    	cmp    $0x80113a14,%ebx
8010415a:	75 e2                	jne    8010413e <wait+0x3e>
    if(!havekids || proc->killed){
8010415c:	85 d2                	test   %edx,%edx
8010415e:	74 76                	je     801041d6 <wait+0xd6>
80104160:	8b 50 24             	mov    0x24(%eax),%edx
80104163:	85 d2                	test   %edx,%edx
80104165:	75 6f                	jne    801041d6 <wait+0xd6>
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80104167:	83 ec 08             	sub    $0x8,%esp
8010416a:	68 e0 18 11 80       	push   $0x801118e0
8010416f:	50                   	push   %eax
80104170:	e8 bb fe ff ff       	call   80104030 <sleep>
    havekids = 0;
80104175:	83 c4 10             	add    $0x10,%esp
80104178:	eb 9f                	jmp    80104119 <wait+0x19>
8010417a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104180:	83 ec 0c             	sub    $0xc,%esp
80104183:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80104186:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104189:	e8 f2 e2 ff ff       	call   80102480 <kfree>
        freevm(p->pgdir);
8010418e:	59                   	pop    %ecx
8010418f:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80104192:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104199:	e8 12 2f 00 00       	call   801070b0 <freevm>
        release(&ptable.lock);
8010419e:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
        p->pid = 0;
801041a5:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801041ac:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801041b3:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801041b7:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801041be:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801041c5:	e8 e6 05 00 00       	call   801047b0 <release>
        return pid;
801041ca:	83 c4 10             	add    $0x10,%esp
}
801041cd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801041d0:	89 f0                	mov    %esi,%eax
801041d2:	5b                   	pop    %ebx
801041d3:	5e                   	pop    %esi
801041d4:	5d                   	pop    %ebp
801041d5:	c3                   	ret    
      release(&ptable.lock);
801041d6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801041d9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801041de:	68 e0 18 11 80       	push   $0x801118e0
801041e3:	e8 c8 05 00 00       	call   801047b0 <release>
      return -1;
801041e8:	83 c4 10             	add    $0x10,%esp
801041eb:	eb e0                	jmp    801041cd <wait+0xcd>
801041ed:	8d 76 00             	lea    0x0(%esi),%esi

801041f0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801041f0:	f3 0f 1e fb          	endbr32 
801041f4:	55                   	push   %ebp
801041f5:	89 e5                	mov    %esp,%ebp
801041f7:	53                   	push   %ebx
801041f8:	83 ec 10             	sub    $0x10,%esp
801041fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801041fe:	68 e0 18 11 80       	push   $0x801118e0
80104203:	e8 c8 03 00 00       	call   801045d0 <acquire>
80104208:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010420b:	b8 14 19 11 80       	mov    $0x80111914,%eax
80104210:	eb 12                	jmp    80104224 <wakeup+0x34>
80104212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104218:	05 84 00 00 00       	add    $0x84,%eax
8010421d:	3d 14 3a 11 80       	cmp    $0x80113a14,%eax
80104222:	74 1e                	je     80104242 <wakeup+0x52>
    if(p->state == SLEEPING && p->chan == chan)
80104224:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104228:	75 ee                	jne    80104218 <wakeup+0x28>
8010422a:	3b 58 20             	cmp    0x20(%eax),%ebx
8010422d:	75 e9                	jne    80104218 <wakeup+0x28>
      p->state = RUNNABLE;
8010422f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104236:	05 84 00 00 00       	add    $0x84,%eax
8010423b:	3d 14 3a 11 80       	cmp    $0x80113a14,%eax
80104240:	75 e2                	jne    80104224 <wakeup+0x34>
  wakeup1(chan);
  release(&ptable.lock);
80104242:	c7 45 08 e0 18 11 80 	movl   $0x801118e0,0x8(%ebp)
}
80104249:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010424c:	c9                   	leave  
  release(&ptable.lock);
8010424d:	e9 5e 05 00 00       	jmp    801047b0 <release>
80104252:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104260 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104260:	f3 0f 1e fb          	endbr32 
80104264:	55                   	push   %ebp
80104265:	89 e5                	mov    %esp,%ebp
80104267:	53                   	push   %ebx
80104268:	83 ec 10             	sub    $0x10,%esp
8010426b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010426e:	68 e0 18 11 80       	push   $0x801118e0
80104273:	e8 58 03 00 00       	call   801045d0 <acquire>
80104278:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010427b:	b8 14 19 11 80       	mov    $0x80111914,%eax
80104280:	eb 12                	jmp    80104294 <kill+0x34>
80104282:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104288:	05 84 00 00 00       	add    $0x84,%eax
8010428d:	3d 14 3a 11 80       	cmp    $0x80113a14,%eax
80104292:	74 34                	je     801042c8 <kill+0x68>
    if(p->pid == pid){
80104294:	39 58 10             	cmp    %ebx,0x10(%eax)
80104297:	75 ef                	jne    80104288 <kill+0x28>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104299:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
8010429d:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801042a4:	75 07                	jne    801042ad <kill+0x4d>
        p->state = RUNNABLE;
801042a6:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801042ad:	83 ec 0c             	sub    $0xc,%esp
801042b0:	68 e0 18 11 80       	push   $0x801118e0
801042b5:	e8 f6 04 00 00       	call   801047b0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801042ba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
801042bd:	83 c4 10             	add    $0x10,%esp
801042c0:	31 c0                	xor    %eax,%eax
}
801042c2:	c9                   	leave  
801042c3:	c3                   	ret    
801042c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801042c8:	83 ec 0c             	sub    $0xc,%esp
801042cb:	68 e0 18 11 80       	push   $0x801118e0
801042d0:	e8 db 04 00 00       	call   801047b0 <release>
}
801042d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801042d8:	83 c4 10             	add    $0x10,%esp
801042db:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801042e0:	c9                   	leave  
801042e1:	c3                   	ret    
801042e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801042f0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801042f0:	f3 0f 1e fb          	endbr32 
801042f4:	55                   	push   %ebp
801042f5:	89 e5                	mov    %esp,%ebp
801042f7:	57                   	push   %edi
801042f8:	56                   	push   %esi
801042f9:	8d 75 e8             	lea    -0x18(%ebp),%esi
801042fc:	53                   	push   %ebx
801042fd:	bb 80 19 11 80       	mov    $0x80111980,%ebx
80104302:	83 ec 3c             	sub    $0x3c,%esp
80104305:	eb 2b                	jmp    80104332 <procdump+0x42>
80104307:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010430e:	66 90                	xchg   %ax,%ax
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104310:	83 ec 0c             	sub    $0xc,%esp
80104313:	68 66 78 10 80       	push   $0x80107866
80104318:	e8 83 c3 ff ff       	call   801006a0 <cprintf>
8010431d:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104320:	81 c3 84 00 00 00    	add    $0x84,%ebx
80104326:	81 fb 80 3a 11 80    	cmp    $0x80113a80,%ebx
8010432c:	0f 84 8e 00 00 00    	je     801043c0 <procdump+0xd0>
    if(p->state == UNUSED)
80104332:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104335:	85 c0                	test   %eax,%eax
80104337:	74 e7                	je     80104320 <procdump+0x30>
      state = "???";
80104339:	ba 12 79 10 80       	mov    $0x80107912,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010433e:	83 f8 05             	cmp    $0x5,%eax
80104341:	77 11                	ja     80104354 <procdump+0x64>
80104343:	8b 14 85 4c 79 10 80 	mov    -0x7fef86b4(,%eax,4),%edx
      state = "???";
8010434a:	b8 12 79 10 80       	mov    $0x80107912,%eax
8010434f:	85 d2                	test   %edx,%edx
80104351:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104354:	53                   	push   %ebx
80104355:	52                   	push   %edx
80104356:	ff 73 a4             	pushl  -0x5c(%ebx)
80104359:	68 16 79 10 80       	push   $0x80107916
8010435e:	e8 3d c3 ff ff       	call   801006a0 <cprintf>
    if(p->state == SLEEPING){
80104363:	83 c4 10             	add    $0x10,%esp
80104366:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010436a:	75 a4                	jne    80104310 <procdump+0x20>
      getcallerpcs((uint*)p->context->ebp+2, pc);
8010436c:	83 ec 08             	sub    $0x8,%esp
8010436f:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104372:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104375:	50                   	push   %eax
80104376:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104379:	8b 40 0c             	mov    0xc(%eax),%eax
8010437c:	83 c0 08             	add    $0x8,%eax
8010437f:	50                   	push   %eax
80104380:	e8 1b 03 00 00       	call   801046a0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104385:	83 c4 10             	add    $0x10,%esp
80104388:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010438f:	90                   	nop
80104390:	8b 17                	mov    (%edi),%edx
80104392:	85 d2                	test   %edx,%edx
80104394:	0f 84 76 ff ff ff    	je     80104310 <procdump+0x20>
        cprintf(" %p", pc[i]);
8010439a:	83 ec 08             	sub    $0x8,%esp
8010439d:	83 c7 04             	add    $0x4,%edi
801043a0:	52                   	push   %edx
801043a1:	68 62 73 10 80       	push   $0x80107362
801043a6:	e8 f5 c2 ff ff       	call   801006a0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801043ab:	83 c4 10             	add    $0x10,%esp
801043ae:	39 fe                	cmp    %edi,%esi
801043b0:	75 de                	jne    80104390 <procdump+0xa0>
801043b2:	e9 59 ff ff ff       	jmp    80104310 <procdump+0x20>
801043b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043be:	66 90                	xchg   %ax,%ax
  }
}
801043c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043c3:	5b                   	pop    %ebx
801043c4:	5e                   	pop    %esi
801043c5:	5f                   	pop    %edi
801043c6:	5d                   	pop    %ebp
801043c7:	c3                   	ret    
801043c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043cf:	90                   	nop

801043d0 <clone>:


int clone(void(*func)(void *), void *arg, void *stack)
{
801043d0:	f3 0f 1e fb          	endbr32 
801043d4:	55                   	push   %ebp
801043d5:	89 e5                	mov    %esp,%ebp
801043d7:	57                   	push   %edi
801043d8:	56                   	push   %esi
801043d9:	53                   	push   %ebx
801043da:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *curproc = proc; // 记录发出 clone 的进程（np->pthread 记录的父线程）
801043dd:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801043e4:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct proc *np;

  if ((np = allocproc()) == 0) //为新线程分配 PCB/TCB
801043e7:	e8 24 f5 ff ff       	call   80103910 <allocproc>
801043ec:	85 c0                	test   %eax,%eax
801043ee:	0f 84 e9 00 00 00    	je     801044dd <clone+0x10d>
    return -1;
  //由于共享进程映像，只需使用同一个页表即可，无需拷贝内容
  np->pgdir = curproc->pgdir; // 线程间共用同一个页表
801043f4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801043f7:	89 c3                	mov    %eax,%ebx
  np->sz = curproc->sz;
  np->pthread = curproc; // exit 时用于找到父进程并唤醒
  np->ustack = stack;    //设置自己的线程栈
  np->parent = 0;
  *np->tf = *curproc->tf; // 继承 trapframe
801043f9:	b9 13 00 00 00       	mov    $0x13,%ecx
801043fe:	8b 7b 18             	mov    0x18(%ebx),%edi
  np->pgdir = curproc->pgdir; // 线程间共用同一个页表
80104401:	8b 42 04             	mov    0x4(%edx),%eax
80104404:	89 43 04             	mov    %eax,0x4(%ebx)
  np->sz = curproc->sz;
80104407:	8b 02                	mov    (%edx),%eax
  np->pthread = curproc; // exit 时用于找到父进程并唤醒
80104409:	89 53 7c             	mov    %edx,0x7c(%ebx)
  np->sz = curproc->sz;
8010440c:	89 03                	mov    %eax,(%ebx)
  np->ustack = stack;    //设置自己的线程栈
8010440e:	8b 45 10             	mov    0x10(%ebp),%eax
  np->parent = 0;
80104411:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  np->ustack = stack;    //设置自己的线程栈
80104418:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)

  int *sp = stack + 4096 - 8; //下面将在线程栈填写8字节内容
  // 在用户态栈“伪造”现场，将参数和返回地址（无用的）保存在里面
  *(sp + 1) = (int)arg; // *(np->tf->esp+4) = (int)arg
8010441e:	8b 45 0c             	mov    0xc(%ebp),%eax
  *np->tf = *curproc->tf; // 继承 trapframe
80104421:	8b 72 18             	mov    0x18(%edx),%esi
80104424:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  *(sp + 1) = (int)arg; // *(np->tf->esp+4) = (int)arg
80104426:	8b 4d 10             	mov    0x10(%ebp),%ecx
  np->tf->eip = (int)func;
  np->tf->esp = (int)sp; // top of stack
  np->tf->ebp = (int)sp; // 栈帧指针
  np->tf->eax = 0;

  for (int i = 0; i < NOFILE; i++) // 复制文件描述符
80104429:	31 f6                	xor    %esi,%esi
8010442b:	89 d7                	mov    %edx,%edi
  *(sp + 1) = (int)arg; // *(np->tf->esp+4) = (int)arg
8010442d:	89 81 fc 0f 00 00    	mov    %eax,0xffc(%ecx)
  *sp = 0xffffffff;     // 返回地址（没有用到）
80104433:	c7 81 f8 0f 00 00 ff 	movl   $0xffffffff,0xff8(%ecx)
8010443a:	ff ff ff 
  np->tf->eip = (int)func;
8010443d:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104440:	8b 43 18             	mov    0x18(%ebx),%eax
80104443:	89 48 38             	mov    %ecx,0x38(%eax)
  int *sp = stack + 4096 - 8; //下面将在线程栈填写8字节内容
80104446:	8b 45 10             	mov    0x10(%ebp),%eax
  np->tf->esp = (int)sp; // top of stack
80104449:	8b 4b 18             	mov    0x18(%ebx),%ecx
  int *sp = stack + 4096 - 8; //下面将在线程栈填写8字节内容
8010444c:	05 f8 0f 00 00       	add    $0xff8,%eax
  np->tf->esp = (int)sp; // top of stack
80104451:	89 41 44             	mov    %eax,0x44(%ecx)
  np->tf->ebp = (int)sp; // 栈帧指针
80104454:	8b 4b 18             	mov    0x18(%ebx),%ecx
80104457:	89 41 08             	mov    %eax,0x8(%ecx)
  np->tf->eax = 0;
8010445a:	8b 43 18             	mov    0x18(%ebx),%eax
8010445d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for (int i = 0; i < NOFILE; i++) // 复制文件描述符
80104464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (curproc->ofile[i])
80104468:	8b 44 b7 28          	mov    0x28(%edi,%esi,4),%eax
8010446c:	85 c0                	test   %eax,%eax
8010446e:	74 10                	je     80104480 <clone+0xb0>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104470:	83 ec 0c             	sub    $0xc,%esp
80104473:	50                   	push   %eax
80104474:	e8 e7 c9 ff ff       	call   80100e60 <filedup>
80104479:	83 c4 10             	add    $0x10,%esp
8010447c:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
  for (int i = 0; i < NOFILE; i++) // 复制文件描述符
80104480:	83 c6 01             	add    $0x1,%esi
80104483:	83 fe 10             	cmp    $0x10,%esi
80104486:	75 e0                	jne    80104468 <clone+0x98>
  np->cwd = idup(curproc->cwd);
80104488:	83 ec 0c             	sub    $0xc,%esp
8010448b:	ff 77 68             	pushl  0x68(%edi)
8010448e:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80104491:	e8 4a d2 ff ff       	call   801016e0 <idup>

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104496:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104499:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
8010449c:	89 43 68             	mov    %eax,0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010449f:	8d 43 6c             	lea    0x6c(%ebx),%eax
801044a2:	83 c2 6c             	add    $0x6c,%edx
801044a5:	6a 10                	push   $0x10
801044a7:	52                   	push   %edx
801044a8:	50                   	push   %eax
801044a9:	e8 12 05 00 00       	call   801049c0 <safestrcpy>
  int pid = np->pid;
801044ae:	8b 73 10             	mov    0x10(%ebx),%esi

  acquire(&ptable.lock);
801044b1:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
801044b8:	e8 13 01 00 00       	call   801045d0 <acquire>
  np->state = RUNNABLE;
801044bd:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
801044c4:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
801044cb:	e8 e0 02 00 00       	call   801047b0 <release>
  // 返回新线程的 pid
  return pid;
801044d0:	83 c4 10             	add    $0x10,%esp
}
801044d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044d6:	89 f0                	mov    %esi,%eax
801044d8:	5b                   	pop    %ebx
801044d9:	5e                   	pop    %esi
801044da:	5f                   	pop    %edi
801044db:	5d                   	pop    %ebp
801044dc:	c3                   	ret    
    return -1;
801044dd:	be ff ff ff ff       	mov    $0xffffffff,%esi
801044e2:	eb ef                	jmp    801044d3 <clone+0x103>
801044e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044ef:	90                   	nop

801044f0 <join>:

int 
join(int tid)
{
801044f0:	f3 0f 1e fb          	endbr32 
801044f4:	55                   	push   %ebp
801044f5:	89 e5                	mov    %esp,%ebp
801044f7:	57                   	push   %edi
801044f8:	56                   	push   %esi
801044f9:	53                   	push   %ebx
801044fa:	83 ec 18             	sub    $0x18,%esp
801044fd:	8b 75 08             	mov    0x8(%ebp),%esi
  // cprintf("in join, stack pointer = %p\n", *stack);
  struct proc *curproc = proc;
80104500:	65 8b 3d 04 00 00 00 	mov    %gs:0x4,%edi
  
  acquire(&ptable.lock);
80104507:	68 e0 18 11 80       	push   $0x801118e0
8010450c:	e8 bf 00 00 00       	call   801045d0 <acquire>
80104511:	83 c4 10             	add    $0x10,%esp
  struct proc *p;
  int havekids;
  while (1)
  {
    // scan through table looking for zombie children
    havekids = 0;
80104514:	31 c0                	xor    %eax,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104516:	bb 14 19 11 80       	mov    $0x80111914,%ebx
8010451b:	eb 16                	jmp    80104533 <join+0x43>
8010451d:	8d 76 00             	lea    0x0(%esi),%esi
    {
      if (p->pid != tid) //判定是否自己的子线程
        continue;

      havekids = 1;
80104520:	b8 01 00 00 00       	mov    $0x1,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104525:	81 c3 84 00 00 00    	add    $0x84,%ebx
8010452b:	81 fb 14 3a 11 80    	cmp    $0x80113a14,%ebx
80104531:	74 3d                	je     80104570 <join+0x80>
      if (p->pid != tid) //判定是否自己的子线程
80104533:	39 73 10             	cmp    %esi,0x10(%ebx)
80104536:	75 ed                	jne    80104525 <join+0x35>
      if (p->state == ZOMBIE)
80104538:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010453c:	75 e2                	jne    80104520 <join+0x30>
      {
        kfree(p->kstack); //释放内核栈
8010453e:	83 ec 0c             	sub    $0xc,%esp
80104541:	ff 73 08             	pushl  0x8(%ebx)
80104544:	e8 37 df ff ff       	call   80102480 <kfree>
        p->state = UNUSED;
        release(&ptable.lock);
80104549:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
        p->state = UNUSED;
80104550:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104557:	e8 54 02 00 00       	call   801047b0 <release>
        return tid;
8010455c:	83 c4 10             	add    $0x10,%esp
8010455f:	89 f0                	mov    %esi,%eax
    }
    // Wait for children to exit
    sleep(curproc, &ptable.lock);
  }
  return 0;
}
80104561:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104564:	5b                   	pop    %ebx
80104565:	5e                   	pop    %esi
80104566:	5f                   	pop    %edi
80104567:	5d                   	pop    %ebp
80104568:	c3                   	ret    
80104569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (!havekids || curproc->killed)
80104570:	85 c0                	test   %eax,%eax
80104572:	74 1a                	je     8010458e <join+0x9e>
80104574:	8b 47 24             	mov    0x24(%edi),%eax
80104577:	85 c0                	test   %eax,%eax
80104579:	75 13                	jne    8010458e <join+0x9e>
    sleep(curproc, &ptable.lock);
8010457b:	83 ec 08             	sub    $0x8,%esp
8010457e:	68 e0 18 11 80       	push   $0x801118e0
80104583:	57                   	push   %edi
80104584:	e8 a7 fa ff ff       	call   80104030 <sleep>
    havekids = 0;
80104589:	83 c4 10             	add    $0x10,%esp
8010458c:	eb 86                	jmp    80104514 <join+0x24>
      release(&ptable.lock);
8010458e:	83 ec 0c             	sub    $0xc,%esp
80104591:	68 e0 18 11 80       	push   $0x801118e0
80104596:	e8 15 02 00 00       	call   801047b0 <release>
      return -1;
8010459b:	83 c4 10             	add    $0x10,%esp
8010459e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801045a3:	eb bc                	jmp    80104561 <join+0x71>
801045a5:	66 90                	xchg   %ax,%ax
801045a7:	66 90                	xchg   %ax,%ax
801045a9:	66 90                	xchg   %ax,%ax
801045ab:	66 90                	xchg   %ax,%ax
801045ad:	66 90                	xchg   %ax,%ax
801045af:	90                   	nop

801045b0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801045b0:	f3 0f 1e fb          	endbr32 
801045b4:	55                   	push   %ebp
801045b5:	89 e5                	mov    %esp,%ebp
801045b7:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801045ba:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801045bd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801045c3:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801045c6:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801045cd:	5d                   	pop    %ebp
801045ce:	c3                   	ret    
801045cf:	90                   	nop

801045d0 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
801045d0:	f3 0f 1e fb          	endbr32 
801045d4:	55                   	push   %ebp
801045d5:	89 e5                	mov    %esp,%ebp
801045d7:	53                   	push   %ebx
801045d8:	83 ec 04             	sub    $0x4,%esp
801045db:	9c                   	pushf  
801045dc:	5a                   	pop    %edx
  asm volatile("cli");
801045dd:	fa                   	cli    
{
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
801045de:	65 8b 0d 00 00 00 00 	mov    %gs:0x0,%ecx
801045e5:	8b 81 ac 00 00 00    	mov    0xac(%ecx),%eax
801045eb:	85 c0                	test   %eax,%eax
801045ed:	75 0c                	jne    801045fb <acquire+0x2b>
    cpu->intena = eflags & FL_IF;
801045ef:	81 e2 00 02 00 00    	and    $0x200,%edx
801045f5:	89 91 b0 00 00 00    	mov    %edx,0xb0(%ecx)
  if(holding(lk))
801045fb:	8b 55 08             	mov    0x8(%ebp),%edx
  cpu->ncli += 1;
801045fe:	83 c0 01             	add    $0x1,%eax
80104601:	89 81 ac 00 00 00    	mov    %eax,0xac(%ecx)
  return lock->locked && lock->cpu == cpu;
80104607:	8b 02                	mov    (%edx),%eax
80104609:	85 c0                	test   %eax,%eax
8010460b:	74 05                	je     80104612 <acquire+0x42>
8010460d:	39 4a 08             	cmp    %ecx,0x8(%edx)
80104610:	74 76                	je     80104688 <acquire+0xb8>
  asm volatile("lock; xchgl %0, %1" :
80104612:	b9 01 00 00 00       	mov    $0x1,%ecx
80104617:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010461e:	66 90                	xchg   %ax,%ax
80104620:	89 c8                	mov    %ecx,%eax
80104622:	f0 87 02             	lock xchg %eax,(%edx)
  while(xchg(&lk->locked, 1) != 0)
80104625:	85 c0                	test   %eax,%eax
80104627:	75 f7                	jne    80104620 <acquire+0x50>
  __sync_synchronize();
80104629:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  ebp = (uint*)v - 2;
8010462e:	89 ea                	mov    %ebp,%edx
  lk->cpu = cpu;
80104630:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104636:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104639:	89 41 08             	mov    %eax,0x8(%ecx)
  for(i = 0; i < 10; i++){
8010463c:	31 c0                	xor    %eax,%eax
8010463e:	66 90                	xchg   %ax,%ax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104640:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104646:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010464c:	77 1a                	ja     80104668 <acquire+0x98>
    pcs[i] = ebp[1];     // saved %eip
8010464e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104651:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104655:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104658:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
8010465a:	83 f8 0a             	cmp    $0xa,%eax
8010465d:	75 e1                	jne    80104640 <acquire+0x70>
}
8010465f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104662:	c9                   	leave  
80104663:	c3                   	ret    
80104664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104668:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
8010466c:	83 c1 34             	add    $0x34,%ecx
8010466f:	90                   	nop
    pcs[i] = 0;
80104670:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104676:	83 c0 04             	add    $0x4,%eax
80104679:	39 c8                	cmp    %ecx,%eax
8010467b:	75 f3                	jne    80104670 <acquire+0xa0>
}
8010467d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104680:	c9                   	leave  
80104681:	c3                   	ret    
80104682:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("acquire");
80104688:	83 ec 0c             	sub    $0xc,%esp
8010468b:	68 64 79 10 80       	push   $0x80107964
80104690:	e8 eb bc ff ff       	call   80100380 <panic>
80104695:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010469c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046a0 <getcallerpcs>:
{
801046a0:	f3 0f 1e fb          	endbr32 
801046a4:	55                   	push   %ebp
  for(i = 0; i < 10; i++){
801046a5:	31 d2                	xor    %edx,%edx
{
801046a7:	89 e5                	mov    %esp,%ebp
801046a9:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801046aa:	8b 45 08             	mov    0x8(%ebp),%eax
{
801046ad:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801046b0:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
801046b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046b7:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801046b8:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801046be:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801046c4:	77 1a                	ja     801046e0 <getcallerpcs+0x40>
    pcs[i] = ebp[1];     // saved %eip
801046c6:	8b 58 04             	mov    0x4(%eax),%ebx
801046c9:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801046cc:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801046cf:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801046d1:	83 fa 0a             	cmp    $0xa,%edx
801046d4:	75 e2                	jne    801046b8 <getcallerpcs+0x18>
}
801046d6:	5b                   	pop    %ebx
801046d7:	5d                   	pop    %ebp
801046d8:	c3                   	ret    
801046d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
801046e0:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801046e3:	8d 51 28             	lea    0x28(%ecx),%edx
801046e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046ed:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
801046f0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801046f6:	83 c0 04             	add    $0x4,%eax
801046f9:	39 d0                	cmp    %edx,%eax
801046fb:	75 f3                	jne    801046f0 <getcallerpcs+0x50>
}
801046fd:	5b                   	pop    %ebx
801046fe:	5d                   	pop    %ebp
801046ff:	c3                   	ret    

80104700 <holding>:
{
80104700:	f3 0f 1e fb          	endbr32 
80104704:	55                   	push   %ebp
80104705:	89 e5                	mov    %esp,%ebp
80104707:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu;
8010470a:	8b 02                	mov    (%edx),%eax
8010470c:	85 c0                	test   %eax,%eax
8010470e:	74 18                	je     80104728 <holding+0x28>
80104710:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104716:	39 42 08             	cmp    %eax,0x8(%edx)
80104719:	0f 94 c0             	sete   %al
}
8010471c:	5d                   	pop    %ebp
  return lock->locked && lock->cpu == cpu;
8010471d:	0f b6 c0             	movzbl %al,%eax
}
80104720:	c3                   	ret    
80104721:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104728:	31 c0                	xor    %eax,%eax
8010472a:	5d                   	pop    %ebp
8010472b:	c3                   	ret    
8010472c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104730 <pushcli>:
{
80104730:	f3 0f 1e fb          	endbr32 
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104734:	9c                   	pushf  
80104735:	59                   	pop    %ecx
  asm volatile("cli");
80104736:	fa                   	cli    
  if(cpu->ncli == 0)
80104737:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010473e:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
80104744:	85 c0                	test   %eax,%eax
80104746:	75 0c                	jne    80104754 <pushcli+0x24>
    cpu->intena = eflags & FL_IF;
80104748:	81 e1 00 02 00 00    	and    $0x200,%ecx
8010474e:	89 8a b0 00 00 00    	mov    %ecx,0xb0(%edx)
  cpu->ncli += 1;
80104754:	83 c0 01             	add    $0x1,%eax
80104757:	89 82 ac 00 00 00    	mov    %eax,0xac(%edx)
}
8010475d:	c3                   	ret    
8010475e:	66 90                	xchg   %ax,%ax

80104760 <popcli>:

void
popcli(void)
{
80104760:	f3 0f 1e fb          	endbr32 
80104764:	55                   	push   %ebp
80104765:	89 e5                	mov    %esp,%ebp
80104767:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
8010476a:	9c                   	pushf  
8010476b:	58                   	pop    %eax
  if(readeflags()&FL_IF)
8010476c:	f6 c4 02             	test   $0x2,%ah
8010476f:	75 2c                	jne    8010479d <popcli+0x3d>
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
80104771:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104778:	83 aa ac 00 00 00 01 	subl   $0x1,0xac(%edx)
8010477f:	78 0f                	js     80104790 <popcli+0x30>
    panic("popcli");
  if(cpu->ncli == 0 && cpu->intena)
80104781:	75 0b                	jne    8010478e <popcli+0x2e>
80104783:	8b 82 b0 00 00 00    	mov    0xb0(%edx),%eax
80104789:	85 c0                	test   %eax,%eax
8010478b:	74 01                	je     8010478e <popcli+0x2e>
  asm volatile("sti");
8010478d:	fb                   	sti    
    sti();
}
8010478e:	c9                   	leave  
8010478f:	c3                   	ret    
    panic("popcli");
80104790:	83 ec 0c             	sub    $0xc,%esp
80104793:	68 83 79 10 80       	push   $0x80107983
80104798:	e8 e3 bb ff ff       	call   80100380 <panic>
    panic("popcli - interruptible");
8010479d:	83 ec 0c             	sub    $0xc,%esp
801047a0:	68 6c 79 10 80       	push   $0x8010796c
801047a5:	e8 d6 bb ff ff       	call   80100380 <panic>
801047aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801047b0 <release>:
{
801047b0:	f3 0f 1e fb          	endbr32 
801047b4:	55                   	push   %ebp
801047b5:	89 e5                	mov    %esp,%ebp
801047b7:	83 ec 08             	sub    $0x8,%esp
801047ba:	8b 45 08             	mov    0x8(%ebp),%eax
  return lock->locked && lock->cpu == cpu;
801047bd:	8b 10                	mov    (%eax),%edx
801047bf:	85 d2                	test   %edx,%edx
801047c1:	74 0c                	je     801047cf <release+0x1f>
801047c3:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801047ca:	39 50 08             	cmp    %edx,0x8(%eax)
801047cd:	74 11                	je     801047e0 <release+0x30>
    panic("release");
801047cf:	83 ec 0c             	sub    $0xc,%esp
801047d2:	68 8a 79 10 80       	push   $0x8010798a
801047d7:	e8 a4 bb ff ff       	call   80100380 <panic>
801047dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  lk->pcs[0] = 0;
801047e0:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
801047e7:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  __sync_synchronize();
801047ee:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->locked = 0;
801047f3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
801047f9:	c9                   	leave  
  popcli();
801047fa:	e9 61 ff ff ff       	jmp    80104760 <popcli>
801047ff:	90                   	nop

80104800 <memset>:
80104800:	f3 0f 1e fb          	endbr32 
80104804:	55                   	push   %ebp
80104805:	89 e5                	mov    %esp,%ebp
80104807:	57                   	push   %edi
80104808:	8b 55 08             	mov    0x8(%ebp),%edx
8010480b:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010480e:	53                   	push   %ebx
8010480f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104812:	89 d7                	mov    %edx,%edi
80104814:	09 cf                	or     %ecx,%edi
80104816:	83 e7 03             	and    $0x3,%edi
80104819:	75 25                	jne    80104840 <memset+0x40>
8010481b:	0f b6 f8             	movzbl %al,%edi
8010481e:	c1 e0 18             	shl    $0x18,%eax
80104821:	89 fb                	mov    %edi,%ebx
80104823:	c1 e9 02             	shr    $0x2,%ecx
80104826:	c1 e3 10             	shl    $0x10,%ebx
80104829:	09 d8                	or     %ebx,%eax
8010482b:	09 f8                	or     %edi,%eax
8010482d:	c1 e7 08             	shl    $0x8,%edi
80104830:	09 f8                	or     %edi,%eax
80104832:	89 d7                	mov    %edx,%edi
80104834:	fc                   	cld    
80104835:	f3 ab                	rep stos %eax,%es:(%edi)
80104837:	5b                   	pop    %ebx
80104838:	89 d0                	mov    %edx,%eax
8010483a:	5f                   	pop    %edi
8010483b:	5d                   	pop    %ebp
8010483c:	c3                   	ret    
8010483d:	8d 76 00             	lea    0x0(%esi),%esi
80104840:	89 d7                	mov    %edx,%edi
80104842:	fc                   	cld    
80104843:	f3 aa                	rep stos %al,%es:(%edi)
80104845:	5b                   	pop    %ebx
80104846:	89 d0                	mov    %edx,%eax
80104848:	5f                   	pop    %edi
80104849:	5d                   	pop    %ebp
8010484a:	c3                   	ret    
8010484b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010484f:	90                   	nop

80104850 <memcmp>:
80104850:	f3 0f 1e fb          	endbr32 
80104854:	55                   	push   %ebp
80104855:	89 e5                	mov    %esp,%ebp
80104857:	56                   	push   %esi
80104858:	8b 75 10             	mov    0x10(%ebp),%esi
8010485b:	8b 55 08             	mov    0x8(%ebp),%edx
8010485e:	53                   	push   %ebx
8010485f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104862:	85 f6                	test   %esi,%esi
80104864:	74 2a                	je     80104890 <memcmp+0x40>
80104866:	01 c6                	add    %eax,%esi
80104868:	eb 10                	jmp    8010487a <memcmp+0x2a>
8010486a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104870:	83 c0 01             	add    $0x1,%eax
80104873:	83 c2 01             	add    $0x1,%edx
80104876:	39 f0                	cmp    %esi,%eax
80104878:	74 16                	je     80104890 <memcmp+0x40>
8010487a:	0f b6 0a             	movzbl (%edx),%ecx
8010487d:	0f b6 18             	movzbl (%eax),%ebx
80104880:	38 d9                	cmp    %bl,%cl
80104882:	74 ec                	je     80104870 <memcmp+0x20>
80104884:	0f b6 c1             	movzbl %cl,%eax
80104887:	29 d8                	sub    %ebx,%eax
80104889:	5b                   	pop    %ebx
8010488a:	5e                   	pop    %esi
8010488b:	5d                   	pop    %ebp
8010488c:	c3                   	ret    
8010488d:	8d 76 00             	lea    0x0(%esi),%esi
80104890:	5b                   	pop    %ebx
80104891:	31 c0                	xor    %eax,%eax
80104893:	5e                   	pop    %esi
80104894:	5d                   	pop    %ebp
80104895:	c3                   	ret    
80104896:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010489d:	8d 76 00             	lea    0x0(%esi),%esi

801048a0 <memmove>:
801048a0:	f3 0f 1e fb          	endbr32 
801048a4:	55                   	push   %ebp
801048a5:	89 e5                	mov    %esp,%ebp
801048a7:	57                   	push   %edi
801048a8:	8b 55 08             	mov    0x8(%ebp),%edx
801048ab:	8b 4d 10             	mov    0x10(%ebp),%ecx
801048ae:	56                   	push   %esi
801048af:	8b 75 0c             	mov    0xc(%ebp),%esi
801048b2:	39 d6                	cmp    %edx,%esi
801048b4:	73 2a                	jae    801048e0 <memmove+0x40>
801048b6:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
801048b9:	39 fa                	cmp    %edi,%edx
801048bb:	73 23                	jae    801048e0 <memmove+0x40>
801048bd:	8d 41 ff             	lea    -0x1(%ecx),%eax
801048c0:	85 c9                	test   %ecx,%ecx
801048c2:	74 13                	je     801048d7 <memmove+0x37>
801048c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048c8:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
801048cc:	88 0c 02             	mov    %cl,(%edx,%eax,1)
801048cf:	83 e8 01             	sub    $0x1,%eax
801048d2:	83 f8 ff             	cmp    $0xffffffff,%eax
801048d5:	75 f1                	jne    801048c8 <memmove+0x28>
801048d7:	5e                   	pop    %esi
801048d8:	89 d0                	mov    %edx,%eax
801048da:	5f                   	pop    %edi
801048db:	5d                   	pop    %ebp
801048dc:	c3                   	ret    
801048dd:	8d 76 00             	lea    0x0(%esi),%esi
801048e0:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
801048e3:	89 d7                	mov    %edx,%edi
801048e5:	85 c9                	test   %ecx,%ecx
801048e7:	74 ee                	je     801048d7 <memmove+0x37>
801048e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048f0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
801048f1:	39 f0                	cmp    %esi,%eax
801048f3:	75 fb                	jne    801048f0 <memmove+0x50>
801048f5:	5e                   	pop    %esi
801048f6:	89 d0                	mov    %edx,%eax
801048f8:	5f                   	pop    %edi
801048f9:	5d                   	pop    %ebp
801048fa:	c3                   	ret    
801048fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048ff:	90                   	nop

80104900 <memcpy>:
80104900:	f3 0f 1e fb          	endbr32 
80104904:	eb 9a                	jmp    801048a0 <memmove>
80104906:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010490d:	8d 76 00             	lea    0x0(%esi),%esi

80104910 <strncmp>:
80104910:	f3 0f 1e fb          	endbr32 
80104914:	55                   	push   %ebp
80104915:	89 e5                	mov    %esp,%ebp
80104917:	56                   	push   %esi
80104918:	8b 75 10             	mov    0x10(%ebp),%esi
8010491b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010491e:	53                   	push   %ebx
8010491f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104922:	85 f6                	test   %esi,%esi
80104924:	74 32                	je     80104958 <strncmp+0x48>
80104926:	01 c6                	add    %eax,%esi
80104928:	eb 14                	jmp    8010493e <strncmp+0x2e>
8010492a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104930:	38 da                	cmp    %bl,%dl
80104932:	75 14                	jne    80104948 <strncmp+0x38>
80104934:	83 c0 01             	add    $0x1,%eax
80104937:	83 c1 01             	add    $0x1,%ecx
8010493a:	39 f0                	cmp    %esi,%eax
8010493c:	74 1a                	je     80104958 <strncmp+0x48>
8010493e:	0f b6 11             	movzbl (%ecx),%edx
80104941:	0f b6 18             	movzbl (%eax),%ebx
80104944:	84 d2                	test   %dl,%dl
80104946:	75 e8                	jne    80104930 <strncmp+0x20>
80104948:	0f b6 c2             	movzbl %dl,%eax
8010494b:	29 d8                	sub    %ebx,%eax
8010494d:	5b                   	pop    %ebx
8010494e:	5e                   	pop    %esi
8010494f:	5d                   	pop    %ebp
80104950:	c3                   	ret    
80104951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104958:	5b                   	pop    %ebx
80104959:	31 c0                	xor    %eax,%eax
8010495b:	5e                   	pop    %esi
8010495c:	5d                   	pop    %ebp
8010495d:	c3                   	ret    
8010495e:	66 90                	xchg   %ax,%ax

80104960 <strncpy>:
80104960:	f3 0f 1e fb          	endbr32 
80104964:	55                   	push   %ebp
80104965:	89 e5                	mov    %esp,%ebp
80104967:	57                   	push   %edi
80104968:	56                   	push   %esi
80104969:	8b 75 08             	mov    0x8(%ebp),%esi
8010496c:	53                   	push   %ebx
8010496d:	8b 45 10             	mov    0x10(%ebp),%eax
80104970:	89 f2                	mov    %esi,%edx
80104972:	eb 1b                	jmp    8010498f <strncpy+0x2f>
80104974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104978:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
8010497c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010497f:	83 c2 01             	add    $0x1,%edx
80104982:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80104986:	89 f9                	mov    %edi,%ecx
80104988:	88 4a ff             	mov    %cl,-0x1(%edx)
8010498b:	84 c9                	test   %cl,%cl
8010498d:	74 09                	je     80104998 <strncpy+0x38>
8010498f:	89 c3                	mov    %eax,%ebx
80104991:	83 e8 01             	sub    $0x1,%eax
80104994:	85 db                	test   %ebx,%ebx
80104996:	7f e0                	jg     80104978 <strncpy+0x18>
80104998:	89 d1                	mov    %edx,%ecx
8010499a:	85 c0                	test   %eax,%eax
8010499c:	7e 15                	jle    801049b3 <strncpy+0x53>
8010499e:	66 90                	xchg   %ax,%ax
801049a0:	83 c1 01             	add    $0x1,%ecx
801049a3:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
801049a7:	89 c8                	mov    %ecx,%eax
801049a9:	f7 d0                	not    %eax
801049ab:	01 d0                	add    %edx,%eax
801049ad:	01 d8                	add    %ebx,%eax
801049af:	85 c0                	test   %eax,%eax
801049b1:	7f ed                	jg     801049a0 <strncpy+0x40>
801049b3:	5b                   	pop    %ebx
801049b4:	89 f0                	mov    %esi,%eax
801049b6:	5e                   	pop    %esi
801049b7:	5f                   	pop    %edi
801049b8:	5d                   	pop    %ebp
801049b9:	c3                   	ret    
801049ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801049c0 <safestrcpy>:
801049c0:	f3 0f 1e fb          	endbr32 
801049c4:	55                   	push   %ebp
801049c5:	89 e5                	mov    %esp,%ebp
801049c7:	56                   	push   %esi
801049c8:	8b 55 10             	mov    0x10(%ebp),%edx
801049cb:	8b 75 08             	mov    0x8(%ebp),%esi
801049ce:	53                   	push   %ebx
801049cf:	8b 45 0c             	mov    0xc(%ebp),%eax
801049d2:	85 d2                	test   %edx,%edx
801049d4:	7e 21                	jle    801049f7 <safestrcpy+0x37>
801049d6:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
801049da:	89 f2                	mov    %esi,%edx
801049dc:	eb 12                	jmp    801049f0 <safestrcpy+0x30>
801049de:	66 90                	xchg   %ax,%ax
801049e0:	0f b6 08             	movzbl (%eax),%ecx
801049e3:	83 c0 01             	add    $0x1,%eax
801049e6:	83 c2 01             	add    $0x1,%edx
801049e9:	88 4a ff             	mov    %cl,-0x1(%edx)
801049ec:	84 c9                	test   %cl,%cl
801049ee:	74 04                	je     801049f4 <safestrcpy+0x34>
801049f0:	39 d8                	cmp    %ebx,%eax
801049f2:	75 ec                	jne    801049e0 <safestrcpy+0x20>
801049f4:	c6 02 00             	movb   $0x0,(%edx)
801049f7:	89 f0                	mov    %esi,%eax
801049f9:	5b                   	pop    %ebx
801049fa:	5e                   	pop    %esi
801049fb:	5d                   	pop    %ebp
801049fc:	c3                   	ret    
801049fd:	8d 76 00             	lea    0x0(%esi),%esi

80104a00 <strlen>:
80104a00:	f3 0f 1e fb          	endbr32 
80104a04:	55                   	push   %ebp
80104a05:	31 c0                	xor    %eax,%eax
80104a07:	89 e5                	mov    %esp,%ebp
80104a09:	8b 55 08             	mov    0x8(%ebp),%edx
80104a0c:	80 3a 00             	cmpb   $0x0,(%edx)
80104a0f:	74 10                	je     80104a21 <strlen+0x21>
80104a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a18:	83 c0 01             	add    $0x1,%eax
80104a1b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104a1f:	75 f7                	jne    80104a18 <strlen+0x18>
80104a21:	5d                   	pop    %ebp
80104a22:	c3                   	ret    

80104a23 <swtch>:
80104a23:	8b 44 24 04          	mov    0x4(%esp),%eax
80104a27:	8b 54 24 08          	mov    0x8(%esp),%edx
80104a2b:	55                   	push   %ebp
80104a2c:	53                   	push   %ebx
80104a2d:	56                   	push   %esi
80104a2e:	57                   	push   %edi
80104a2f:	89 20                	mov    %esp,(%eax)
80104a31:	89 d4                	mov    %edx,%esp
80104a33:	5f                   	pop    %edi
80104a34:	5e                   	pop    %esi
80104a35:	5b                   	pop    %ebx
80104a36:	5d                   	pop    %ebp
80104a37:	c3                   	ret    
80104a38:	66 90                	xchg   %ax,%ax
80104a3a:	66 90                	xchg   %ax,%ax
80104a3c:	66 90                	xchg   %ax,%ax
80104a3e:	66 90                	xchg   %ax,%ax

80104a40 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104a40:	f3 0f 1e fb          	endbr32 
80104a44:	55                   	push   %ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80104a45:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104a4c:	8b 12                	mov    (%edx),%edx
{
80104a4e:	89 e5                	mov    %esp,%ebp
80104a50:	8b 45 08             	mov    0x8(%ebp),%eax
  if(addr >= proc->sz || addr+4 > proc->sz)
80104a53:	39 c2                	cmp    %eax,%edx
80104a55:	76 19                	jbe    80104a70 <fetchint+0x30>
80104a57:	8d 48 04             	lea    0x4(%eax),%ecx
80104a5a:	39 ca                	cmp    %ecx,%edx
80104a5c:	72 12                	jb     80104a70 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104a5e:	8b 10                	mov    (%eax),%edx
80104a60:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a63:	89 10                	mov    %edx,(%eax)
  return 0;
80104a65:	31 c0                	xor    %eax,%eax
}
80104a67:	5d                   	pop    %ebp
80104a68:	c3                   	ret    
80104a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104a70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a75:	5d                   	pop    %ebp
80104a76:	c3                   	ret    
80104a77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a7e:	66 90                	xchg   %ax,%ax

80104a80 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104a80:	f3 0f 1e fb          	endbr32 
80104a84:	55                   	push   %ebp
  char *s, *ep;

  if(addr >= proc->sz)
80104a85:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
80104a8b:	89 e5                	mov    %esp,%ebp
80104a8d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(addr >= proc->sz)
80104a90:	39 08                	cmp    %ecx,(%eax)
80104a92:	76 2c                	jbe    80104ac0 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80104a94:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a97:	89 08                	mov    %ecx,(%eax)
  ep = (char*)proc->sz;
80104a99:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a9f:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++)
80104aa1:	39 d1                	cmp    %edx,%ecx
80104aa3:	73 1b                	jae    80104ac0 <fetchstr+0x40>
80104aa5:	89 c8                	mov    %ecx,%eax
80104aa7:	eb 0e                	jmp    80104ab7 <fetchstr+0x37>
80104aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ab0:	83 c0 01             	add    $0x1,%eax
80104ab3:	39 c2                	cmp    %eax,%edx
80104ab5:	76 09                	jbe    80104ac0 <fetchstr+0x40>
    if(*s == 0)
80104ab7:	80 38 00             	cmpb   $0x0,(%eax)
80104aba:	75 f4                	jne    80104ab0 <fetchstr+0x30>
      return s - *pp;
80104abc:	29 c8                	sub    %ecx,%eax
  return -1;
}
80104abe:	5d                   	pop    %ebp
80104abf:	c3                   	ret    
    return -1;
80104ac0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ac5:	5d                   	pop    %ebp
80104ac6:	c3                   	ret    
80104ac7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ace:	66 90                	xchg   %ax,%ax

80104ad0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104ad0:	f3 0f 1e fb          	endbr32 
80104ad4:	55                   	push   %ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104ad5:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104adc:	8b 42 18             	mov    0x18(%edx),%eax
  if(addr >= proc->sz || addr+4 > proc->sz)
80104adf:	8b 12                	mov    (%edx),%edx
{
80104ae1:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104ae3:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104ae6:	8b 40 44             	mov    0x44(%eax),%eax
80104ae9:	8d 04 88             	lea    (%eax,%ecx,4),%eax
80104aec:	8d 48 04             	lea    0x4(%eax),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104aef:	39 d1                	cmp    %edx,%ecx
80104af1:	73 1d                	jae    80104b10 <argint+0x40>
80104af3:	8d 48 08             	lea    0x8(%eax),%ecx
80104af6:	39 ca                	cmp    %ecx,%edx
80104af8:	72 16                	jb     80104b10 <argint+0x40>
  *ip = *(int*)(addr);
80104afa:	8b 50 04             	mov    0x4(%eax),%edx
80104afd:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b00:	89 10                	mov    %edx,(%eax)
  return 0;
80104b02:	31 c0                	xor    %eax,%eax
}
80104b04:	5d                   	pop    %ebp
80104b05:	c3                   	ret    
80104b06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b0d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104b10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b15:	5d                   	pop    %ebp
80104b16:	c3                   	ret    
80104b17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b1e:	66 90                	xchg   %ax,%ax

80104b20 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104b20:	f3 0f 1e fb          	endbr32 
80104b24:	55                   	push   %ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104b25:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b2b:	8b 50 18             	mov    0x18(%eax),%edx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104b2e:	8b 00                	mov    (%eax),%eax
{
80104b30:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104b32:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104b35:	8b 52 44             	mov    0x44(%edx),%edx
80104b38:	8d 14 8a             	lea    (%edx,%ecx,4),%edx
80104b3b:	8d 4a 04             	lea    0x4(%edx),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104b3e:	39 c1                	cmp    %eax,%ecx
80104b40:	73 26                	jae    80104b68 <argptr+0x48>
80104b42:	8d 4a 08             	lea    0x8(%edx),%ecx
80104b45:	39 c8                	cmp    %ecx,%eax
80104b47:	72 1f                	jb     80104b68 <argptr+0x48>
  *ip = *(int*)(addr);
80104b49:	8b 52 04             	mov    0x4(%edx),%edx
  int i;

  if(argint(n, &i) < 0)
    return -1;
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
80104b4c:	39 c2                	cmp    %eax,%edx
80104b4e:	73 18                	jae    80104b68 <argptr+0x48>
80104b50:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104b53:	01 d1                	add    %edx,%ecx
80104b55:	39 c1                	cmp    %eax,%ecx
80104b57:	77 0f                	ja     80104b68 <argptr+0x48>
    return -1;
  *pp = (char*)i;
80104b59:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b5c:	89 10                	mov    %edx,(%eax)
  return 0;
80104b5e:	31 c0                	xor    %eax,%eax
}
80104b60:	5d                   	pop    %ebp
80104b61:	c3                   	ret    
80104b62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104b68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b6d:	5d                   	pop    %ebp
80104b6e:	c3                   	ret    
80104b6f:	90                   	nop

80104b70 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104b70:	f3 0f 1e fb          	endbr32 
80104b74:	55                   	push   %ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104b75:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b7b:	8b 50 18             	mov    0x18(%eax),%edx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104b7e:	8b 00                	mov    (%eax),%eax
{
80104b80:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104b82:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104b85:	8b 52 44             	mov    0x44(%edx),%edx
80104b88:	8d 14 8a             	lea    (%edx,%ecx,4),%edx
80104b8b:	8d 4a 04             	lea    0x4(%edx),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104b8e:	39 c1                	cmp    %eax,%ecx
80104b90:	73 3e                	jae    80104bd0 <argstr+0x60>
80104b92:	8d 4a 08             	lea    0x8(%edx),%ecx
80104b95:	39 c8                	cmp    %ecx,%eax
80104b97:	72 37                	jb     80104bd0 <argstr+0x60>
  *ip = *(int*)(addr);
80104b99:	8b 4a 04             	mov    0x4(%edx),%ecx
  if(addr >= proc->sz)
80104b9c:	39 c1                	cmp    %eax,%ecx
80104b9e:	73 30                	jae    80104bd0 <argstr+0x60>
  *pp = (char*)addr;
80104ba0:	8b 45 0c             	mov    0xc(%ebp),%eax
80104ba3:	89 08                	mov    %ecx,(%eax)
  ep = (char*)proc->sz;
80104ba5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bab:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++)
80104bad:	39 d1                	cmp    %edx,%ecx
80104baf:	73 1f                	jae    80104bd0 <argstr+0x60>
80104bb1:	89 c8                	mov    %ecx,%eax
80104bb3:	eb 0a                	jmp    80104bbf <argstr+0x4f>
80104bb5:	8d 76 00             	lea    0x0(%esi),%esi
80104bb8:	83 c0 01             	add    $0x1,%eax
80104bbb:	39 c2                	cmp    %eax,%edx
80104bbd:	76 11                	jbe    80104bd0 <argstr+0x60>
    if(*s == 0)
80104bbf:	80 38 00             	cmpb   $0x0,(%eax)
80104bc2:	75 f4                	jne    80104bb8 <argstr+0x48>
      return s - *pp;
80104bc4:	29 c8                	sub    %ecx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104bc6:	5d                   	pop    %ebp
80104bc7:	c3                   	ret    
80104bc8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bcf:	90                   	nop
    return -1;
80104bd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104bd5:	5d                   	pop    %ebp
80104bd6:	c3                   	ret    
80104bd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bde:	66 90                	xchg   %ax,%ax

80104be0 <syscall>:
[SYS_join]    sys_join,
};

void
syscall(void)
{
80104be0:	f3 0f 1e fb          	endbr32 
80104be4:	55                   	push   %ebp
80104be5:	89 e5                	mov    %esp,%ebp
80104be7:	83 ec 08             	sub    $0x8,%esp
  int num;

  num = proc->tf->eax;
80104bea:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104bf1:	8b 42 18             	mov    0x18(%edx),%eax
80104bf4:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104bf7:	8d 48 ff             	lea    -0x1(%eax),%ecx
80104bfa:	83 f9 16             	cmp    $0x16,%ecx
80104bfd:	77 21                	ja     80104c20 <syscall+0x40>
80104bff:	8b 0c 85 c0 79 10 80 	mov    -0x7fef8640(,%eax,4),%ecx
80104c06:	85 c9                	test   %ecx,%ecx
80104c08:	74 16                	je     80104c20 <syscall+0x40>
    proc->tf->eax = syscalls[num]();
80104c0a:	ff d1                	call   *%ecx
80104c0c:	89 c2                	mov    %eax,%edx
80104c0e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c14:	8b 40 18             	mov    0x18(%eax),%eax
80104c17:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  }
}
80104c1a:	c9                   	leave  
80104c1b:	c3                   	ret    
80104c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104c20:	50                   	push   %eax
            proc->pid, proc->name, num);
80104c21:	8d 42 6c             	lea    0x6c(%edx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104c24:	50                   	push   %eax
80104c25:	ff 72 10             	pushl  0x10(%edx)
80104c28:	68 92 79 10 80       	push   $0x80107992
80104c2d:	e8 6e ba ff ff       	call   801006a0 <cprintf>
    proc->tf->eax = -1;
80104c32:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c38:	83 c4 10             	add    $0x10,%esp
80104c3b:	8b 40 18             	mov    0x18(%eax),%eax
80104c3e:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104c45:	c9                   	leave  
80104c46:	c3                   	ret    
80104c47:	66 90                	xchg   %ax,%ax
80104c49:	66 90                	xchg   %ax,%ax
80104c4b:	66 90                	xchg   %ax,%ax
80104c4d:	66 90                	xchg   %ax,%ax
80104c4f:	90                   	nop

80104c50 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104c50:	55                   	push   %ebp
80104c51:	89 e5                	mov    %esp,%ebp
80104c53:	57                   	push   %edi
80104c54:	56                   	push   %esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104c55:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104c58:	53                   	push   %ebx
80104c59:	83 ec 44             	sub    $0x44,%esp
80104c5c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104c5f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104c62:	57                   	push   %edi
80104c63:	50                   	push   %eax
{
80104c64:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104c67:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104c6a:	e8 d1 d3 ff ff       	call   80102040 <nameiparent>
80104c6f:	83 c4 10             	add    $0x10,%esp
80104c72:	85 c0                	test   %eax,%eax
80104c74:	0f 84 46 01 00 00    	je     80104dc0 <create+0x170>
    return 0;
  ilock(dp);
80104c7a:	83 ec 0c             	sub    $0xc,%esp
80104c7d:	89 c3                	mov    %eax,%ebx
80104c7f:	50                   	push   %eax
80104c80:	e8 8b ca ff ff       	call   80101710 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104c85:	83 c4 0c             	add    $0xc,%esp
80104c88:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104c8b:	50                   	push   %eax
80104c8c:	57                   	push   %edi
80104c8d:	53                   	push   %ebx
80104c8e:	e8 0d d0 ff ff       	call   80101ca0 <dirlookup>
80104c93:	83 c4 10             	add    $0x10,%esp
80104c96:	89 c6                	mov    %eax,%esi
80104c98:	85 c0                	test   %eax,%eax
80104c9a:	74 54                	je     80104cf0 <create+0xa0>
    iunlockput(dp);
80104c9c:	83 ec 0c             	sub    $0xc,%esp
80104c9f:	53                   	push   %ebx
80104ca0:	e8 4b cd ff ff       	call   801019f0 <iunlockput>
    ilock(ip);
80104ca5:	89 34 24             	mov    %esi,(%esp)
80104ca8:	e8 63 ca ff ff       	call   80101710 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104cad:	83 c4 10             	add    $0x10,%esp
80104cb0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104cb5:	75 19                	jne    80104cd0 <create+0x80>
80104cb7:	66 83 7e 10 02       	cmpw   $0x2,0x10(%esi)
80104cbc:	75 12                	jne    80104cd0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104cbe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104cc1:	89 f0                	mov    %esi,%eax
80104cc3:	5b                   	pop    %ebx
80104cc4:	5e                   	pop    %esi
80104cc5:	5f                   	pop    %edi
80104cc6:	5d                   	pop    %ebp
80104cc7:	c3                   	ret    
80104cc8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ccf:	90                   	nop
    iunlockput(ip);
80104cd0:	83 ec 0c             	sub    $0xc,%esp
80104cd3:	56                   	push   %esi
    return 0;
80104cd4:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80104cd6:	e8 15 cd ff ff       	call   801019f0 <iunlockput>
    return 0;
80104cdb:	83 c4 10             	add    $0x10,%esp
}
80104cde:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ce1:	89 f0                	mov    %esi,%eax
80104ce3:	5b                   	pop    %ebx
80104ce4:	5e                   	pop    %esi
80104ce5:	5f                   	pop    %edi
80104ce6:	5d                   	pop    %ebp
80104ce7:	c3                   	ret    
80104ce8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cef:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80104cf0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104cf4:	83 ec 08             	sub    $0x8,%esp
80104cf7:	50                   	push   %eax
80104cf8:	ff 33                	pushl  (%ebx)
80104cfa:	e8 91 c8 ff ff       	call   80101590 <ialloc>
80104cff:	83 c4 10             	add    $0x10,%esp
80104d02:	89 c6                	mov    %eax,%esi
80104d04:	85 c0                	test   %eax,%eax
80104d06:	0f 84 cd 00 00 00    	je     80104dd9 <create+0x189>
  ilock(ip);
80104d0c:	83 ec 0c             	sub    $0xc,%esp
80104d0f:	50                   	push   %eax
80104d10:	e8 fb c9 ff ff       	call   80101710 <ilock>
  ip->major = major;
80104d15:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104d19:	66 89 46 12          	mov    %ax,0x12(%esi)
  ip->minor = minor;
80104d1d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104d21:	66 89 46 14          	mov    %ax,0x14(%esi)
  ip->nlink = 1;
80104d25:	b8 01 00 00 00       	mov    $0x1,%eax
80104d2a:	66 89 46 16          	mov    %ax,0x16(%esi)
  iupdate(ip);
80104d2e:	89 34 24             	mov    %esi,(%esp)
80104d31:	e8 1a c9 ff ff       	call   80101650 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104d36:	83 c4 10             	add    $0x10,%esp
80104d39:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104d3e:	74 30                	je     80104d70 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104d40:	83 ec 04             	sub    $0x4,%esp
80104d43:	ff 76 04             	pushl  0x4(%esi)
80104d46:	57                   	push   %edi
80104d47:	53                   	push   %ebx
80104d48:	e8 13 d2 ff ff       	call   80101f60 <dirlink>
80104d4d:	83 c4 10             	add    $0x10,%esp
80104d50:	85 c0                	test   %eax,%eax
80104d52:	78 78                	js     80104dcc <create+0x17c>
  iunlockput(dp);
80104d54:	83 ec 0c             	sub    $0xc,%esp
80104d57:	53                   	push   %ebx
80104d58:	e8 93 cc ff ff       	call   801019f0 <iunlockput>
  return ip;
80104d5d:	83 c4 10             	add    $0x10,%esp
}
80104d60:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d63:	89 f0                	mov    %esi,%eax
80104d65:	5b                   	pop    %ebx
80104d66:	5e                   	pop    %esi
80104d67:	5f                   	pop    %edi
80104d68:	5d                   	pop    %ebp
80104d69:	c3                   	ret    
80104d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104d70:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104d73:	66 83 43 16 01       	addw   $0x1,0x16(%ebx)
    iupdate(dp);
80104d78:	53                   	push   %ebx
80104d79:	e8 d2 c8 ff ff       	call   80101650 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104d7e:	83 c4 0c             	add    $0xc,%esp
80104d81:	ff 76 04             	pushl  0x4(%esi)
80104d84:	68 3c 7a 10 80       	push   $0x80107a3c
80104d89:	56                   	push   %esi
80104d8a:	e8 d1 d1 ff ff       	call   80101f60 <dirlink>
80104d8f:	83 c4 10             	add    $0x10,%esp
80104d92:	85 c0                	test   %eax,%eax
80104d94:	78 18                	js     80104dae <create+0x15e>
80104d96:	83 ec 04             	sub    $0x4,%esp
80104d99:	ff 73 04             	pushl  0x4(%ebx)
80104d9c:	68 3b 7a 10 80       	push   $0x80107a3b
80104da1:	56                   	push   %esi
80104da2:	e8 b9 d1 ff ff       	call   80101f60 <dirlink>
80104da7:	83 c4 10             	add    $0x10,%esp
80104daa:	85 c0                	test   %eax,%eax
80104dac:	79 92                	jns    80104d40 <create+0xf0>
      panic("create dots");
80104dae:	83 ec 0c             	sub    $0xc,%esp
80104db1:	68 2f 7a 10 80       	push   $0x80107a2f
80104db6:	e8 c5 b5 ff ff       	call   80100380 <panic>
80104dbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104dbf:	90                   	nop
}
80104dc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104dc3:	31 f6                	xor    %esi,%esi
}
80104dc5:	5b                   	pop    %ebx
80104dc6:	89 f0                	mov    %esi,%eax
80104dc8:	5e                   	pop    %esi
80104dc9:	5f                   	pop    %edi
80104dca:	5d                   	pop    %ebp
80104dcb:	c3                   	ret    
    panic("create: dirlink");
80104dcc:	83 ec 0c             	sub    $0xc,%esp
80104dcf:	68 3e 7a 10 80       	push   $0x80107a3e
80104dd4:	e8 a7 b5 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80104dd9:	83 ec 0c             	sub    $0xc,%esp
80104ddc:	68 20 7a 10 80       	push   $0x80107a20
80104de1:	e8 9a b5 ff ff       	call   80100380 <panic>
80104de6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ded:	8d 76 00             	lea    0x0(%esi),%esi

80104df0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104df0:	55                   	push   %ebp
80104df1:	89 e5                	mov    %esp,%ebp
80104df3:	56                   	push   %esi
80104df4:	89 d6                	mov    %edx,%esi
80104df6:	53                   	push   %ebx
80104df7:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104df9:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104dfc:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104dff:	50                   	push   %eax
80104e00:	6a 00                	push   $0x0
80104e02:	e8 c9 fc ff ff       	call   80104ad0 <argint>
80104e07:	83 c4 10             	add    $0x10,%esp
80104e0a:	85 c0                	test   %eax,%eax
80104e0c:	78 32                	js     80104e40 <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80104e0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e11:	83 f8 0f             	cmp    $0xf,%eax
80104e14:	77 2a                	ja     80104e40 <argfd.constprop.0+0x50>
80104e16:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104e1d:	8b 54 82 28          	mov    0x28(%edx,%eax,4),%edx
80104e21:	85 d2                	test   %edx,%edx
80104e23:	74 1b                	je     80104e40 <argfd.constprop.0+0x50>
  if(pfd)
80104e25:	85 db                	test   %ebx,%ebx
80104e27:	74 02                	je     80104e2b <argfd.constprop.0+0x3b>
    *pfd = fd;
80104e29:	89 03                	mov    %eax,(%ebx)
    *pf = f;
80104e2b:	89 16                	mov    %edx,(%esi)
  return 0;
80104e2d:	31 c0                	xor    %eax,%eax
}
80104e2f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e32:	5b                   	pop    %ebx
80104e33:	5e                   	pop    %esi
80104e34:	5d                   	pop    %ebp
80104e35:	c3                   	ret    
80104e36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e3d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104e40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e45:	eb e8                	jmp    80104e2f <argfd.constprop.0+0x3f>
80104e47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e4e:	66 90                	xchg   %ax,%ax

80104e50 <sys_dup>:
{
80104e50:	f3 0f 1e fb          	endbr32 
80104e54:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104e55:	31 c0                	xor    %eax,%eax
{
80104e57:	89 e5                	mov    %esp,%ebp
80104e59:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104e5a:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104e5d:	83 ec 14             	sub    $0x14,%esp
  if(argfd(0, 0, &f) < 0)
80104e60:	e8 8b ff ff ff       	call   80104df0 <argfd.constprop.0>
80104e65:	85 c0                	test   %eax,%eax
80104e67:	78 1f                	js     80104e88 <sys_dup+0x38>
  if((fd=fdalloc(f)) < 0)
80104e69:	8b 55 f4             	mov    -0xc(%ebp),%edx
    if(proc->ofile[fd] == 0){
80104e6c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  for(fd = 0; fd < NOFILE; fd++){
80104e72:	31 db                	xor    %ebx,%ebx
80104e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->ofile[fd] == 0){
80104e78:	8b 4c 98 28          	mov    0x28(%eax,%ebx,4),%ecx
80104e7c:	85 c9                	test   %ecx,%ecx
80104e7e:	74 18                	je     80104e98 <sys_dup+0x48>
  for(fd = 0; fd < NOFILE; fd++){
80104e80:	83 c3 01             	add    $0x1,%ebx
80104e83:	83 fb 10             	cmp    $0x10,%ebx
80104e86:	75 f0                	jne    80104e78 <sys_dup+0x28>
    return -1;
80104e88:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104e8d:	89 d8                	mov    %ebx,%eax
80104e8f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e92:	c9                   	leave  
80104e93:	c3                   	ret    
80104e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  filedup(f);
80104e98:	83 ec 0c             	sub    $0xc,%esp
      proc->ofile[fd] = f;
80104e9b:	89 54 98 28          	mov    %edx,0x28(%eax,%ebx,4)
  filedup(f);
80104e9f:	52                   	push   %edx
80104ea0:	e8 bb bf ff ff       	call   80100e60 <filedup>
}
80104ea5:	89 d8                	mov    %ebx,%eax
  return fd;
80104ea7:	83 c4 10             	add    $0x10,%esp
}
80104eaa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ead:	c9                   	leave  
80104eae:	c3                   	ret    
80104eaf:	90                   	nop

80104eb0 <sys_read>:
{
80104eb0:	f3 0f 1e fb          	endbr32 
80104eb4:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104eb5:	31 c0                	xor    %eax,%eax
{
80104eb7:	89 e5                	mov    %esp,%ebp
80104eb9:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ebc:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104ebf:	e8 2c ff ff ff       	call   80104df0 <argfd.constprop.0>
80104ec4:	85 c0                	test   %eax,%eax
80104ec6:	78 48                	js     80104f10 <sys_read+0x60>
80104ec8:	83 ec 08             	sub    $0x8,%esp
80104ecb:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104ece:	50                   	push   %eax
80104ecf:	6a 02                	push   $0x2
80104ed1:	e8 fa fb ff ff       	call   80104ad0 <argint>
80104ed6:	83 c4 10             	add    $0x10,%esp
80104ed9:	85 c0                	test   %eax,%eax
80104edb:	78 33                	js     80104f10 <sys_read+0x60>
80104edd:	83 ec 04             	sub    $0x4,%esp
80104ee0:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ee3:	ff 75 f0             	pushl  -0x10(%ebp)
80104ee6:	50                   	push   %eax
80104ee7:	6a 01                	push   $0x1
80104ee9:	e8 32 fc ff ff       	call   80104b20 <argptr>
80104eee:	83 c4 10             	add    $0x10,%esp
80104ef1:	85 c0                	test   %eax,%eax
80104ef3:	78 1b                	js     80104f10 <sys_read+0x60>
  return fileread(f, p, n);
80104ef5:	83 ec 04             	sub    $0x4,%esp
80104ef8:	ff 75 f0             	pushl  -0x10(%ebp)
80104efb:	ff 75 f4             	pushl  -0xc(%ebp)
80104efe:	ff 75 ec             	pushl  -0x14(%ebp)
80104f01:	e8 da c0 ff ff       	call   80100fe0 <fileread>
80104f06:	83 c4 10             	add    $0x10,%esp
}
80104f09:	c9                   	leave  
80104f0a:	c3                   	ret    
80104f0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f0f:	90                   	nop
80104f10:	c9                   	leave  
    return -1;
80104f11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f16:	c3                   	ret    
80104f17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f1e:	66 90                	xchg   %ax,%ax

80104f20 <sys_write>:
{
80104f20:	f3 0f 1e fb          	endbr32 
80104f24:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f25:	31 c0                	xor    %eax,%eax
{
80104f27:	89 e5                	mov    %esp,%ebp
80104f29:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f2c:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104f2f:	e8 bc fe ff ff       	call   80104df0 <argfd.constprop.0>
80104f34:	85 c0                	test   %eax,%eax
80104f36:	78 48                	js     80104f80 <sys_write+0x60>
80104f38:	83 ec 08             	sub    $0x8,%esp
80104f3b:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f3e:	50                   	push   %eax
80104f3f:	6a 02                	push   $0x2
80104f41:	e8 8a fb ff ff       	call   80104ad0 <argint>
80104f46:	83 c4 10             	add    $0x10,%esp
80104f49:	85 c0                	test   %eax,%eax
80104f4b:	78 33                	js     80104f80 <sys_write+0x60>
80104f4d:	83 ec 04             	sub    $0x4,%esp
80104f50:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f53:	ff 75 f0             	pushl  -0x10(%ebp)
80104f56:	50                   	push   %eax
80104f57:	6a 01                	push   $0x1
80104f59:	e8 c2 fb ff ff       	call   80104b20 <argptr>
80104f5e:	83 c4 10             	add    $0x10,%esp
80104f61:	85 c0                	test   %eax,%eax
80104f63:	78 1b                	js     80104f80 <sys_write+0x60>
  return filewrite(f, p, n);
80104f65:	83 ec 04             	sub    $0x4,%esp
80104f68:	ff 75 f0             	pushl  -0x10(%ebp)
80104f6b:	ff 75 f4             	pushl  -0xc(%ebp)
80104f6e:	ff 75 ec             	pushl  -0x14(%ebp)
80104f71:	e8 0a c1 ff ff       	call   80101080 <filewrite>
80104f76:	83 c4 10             	add    $0x10,%esp
}
80104f79:	c9                   	leave  
80104f7a:	c3                   	ret    
80104f7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f7f:	90                   	nop
80104f80:	c9                   	leave  
    return -1;
80104f81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f86:	c3                   	ret    
80104f87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f8e:	66 90                	xchg   %ax,%ax

80104f90 <sys_close>:
{
80104f90:	f3 0f 1e fb          	endbr32 
80104f94:	55                   	push   %ebp
80104f95:	89 e5                	mov    %esp,%ebp
80104f97:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104f9a:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104f9d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104fa0:	e8 4b fe ff ff       	call   80104df0 <argfd.constprop.0>
80104fa5:	85 c0                	test   %eax,%eax
80104fa7:	78 27                	js     80104fd0 <sys_close+0x40>
  proc->ofile[fd] = 0;
80104fa9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104faf:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104fb2:	83 ec 0c             	sub    $0xc,%esp
  proc->ofile[fd] = 0;
80104fb5:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104fbc:	00 
  fileclose(f);
80104fbd:	ff 75 f4             	pushl  -0xc(%ebp)
80104fc0:	e8 eb be ff ff       	call   80100eb0 <fileclose>
  return 0;
80104fc5:	83 c4 10             	add    $0x10,%esp
80104fc8:	31 c0                	xor    %eax,%eax
}
80104fca:	c9                   	leave  
80104fcb:	c3                   	ret    
80104fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fd0:	c9                   	leave  
    return -1;
80104fd1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fd6:	c3                   	ret    
80104fd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fde:	66 90                	xchg   %ax,%ax

80104fe0 <sys_fstat>:
{
80104fe0:	f3 0f 1e fb          	endbr32 
80104fe4:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104fe5:	31 c0                	xor    %eax,%eax
{
80104fe7:	89 e5                	mov    %esp,%ebp
80104fe9:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104fec:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104fef:	e8 fc fd ff ff       	call   80104df0 <argfd.constprop.0>
80104ff4:	85 c0                	test   %eax,%eax
80104ff6:	78 30                	js     80105028 <sys_fstat+0x48>
80104ff8:	83 ec 04             	sub    $0x4,%esp
80104ffb:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ffe:	6a 14                	push   $0x14
80105000:	50                   	push   %eax
80105001:	6a 01                	push   $0x1
80105003:	e8 18 fb ff ff       	call   80104b20 <argptr>
80105008:	83 c4 10             	add    $0x10,%esp
8010500b:	85 c0                	test   %eax,%eax
8010500d:	78 19                	js     80105028 <sys_fstat+0x48>
  return filestat(f, st);
8010500f:	83 ec 08             	sub    $0x8,%esp
80105012:	ff 75 f4             	pushl  -0xc(%ebp)
80105015:	ff 75 f0             	pushl  -0x10(%ebp)
80105018:	e8 73 bf ff ff       	call   80100f90 <filestat>
8010501d:	83 c4 10             	add    $0x10,%esp
}
80105020:	c9                   	leave  
80105021:	c3                   	ret    
80105022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105028:	c9                   	leave  
    return -1;
80105029:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010502e:	c3                   	ret    
8010502f:	90                   	nop

80105030 <sys_link>:
{
80105030:	f3 0f 1e fb          	endbr32 
80105034:	55                   	push   %ebp
80105035:	89 e5                	mov    %esp,%ebp
80105037:	57                   	push   %edi
80105038:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105039:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
8010503c:	53                   	push   %ebx
8010503d:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105040:	50                   	push   %eax
80105041:	6a 00                	push   $0x0
80105043:	e8 28 fb ff ff       	call   80104b70 <argstr>
80105048:	83 c4 10             	add    $0x10,%esp
8010504b:	85 c0                	test   %eax,%eax
8010504d:	0f 88 ff 00 00 00    	js     80105152 <sys_link+0x122>
80105053:	83 ec 08             	sub    $0x8,%esp
80105056:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105059:	50                   	push   %eax
8010505a:	6a 01                	push   $0x1
8010505c:	e8 0f fb ff ff       	call   80104b70 <argstr>
80105061:	83 c4 10             	add    $0x10,%esp
80105064:	85 c0                	test   %eax,%eax
80105066:	0f 88 e6 00 00 00    	js     80105152 <sys_link+0x122>
  begin_op();
8010506c:	e8 4f dd ff ff       	call   80102dc0 <begin_op>
  if((ip = namei(old)) == 0){
80105071:	83 ec 0c             	sub    $0xc,%esp
80105074:	ff 75 d4             	pushl  -0x2c(%ebp)
80105077:	e8 a4 cf ff ff       	call   80102020 <namei>
8010507c:	83 c4 10             	add    $0x10,%esp
8010507f:	89 c3                	mov    %eax,%ebx
80105081:	85 c0                	test   %eax,%eax
80105083:	0f 84 e8 00 00 00    	je     80105171 <sys_link+0x141>
  ilock(ip);
80105089:	83 ec 0c             	sub    $0xc,%esp
8010508c:	50                   	push   %eax
8010508d:	e8 7e c6 ff ff       	call   80101710 <ilock>
  if(ip->type == T_DIR){
80105092:	83 c4 10             	add    $0x10,%esp
80105095:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
8010509a:	0f 84 b9 00 00 00    	je     80105159 <sys_link+0x129>
  iupdate(ip);
801050a0:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
801050a3:	66 83 43 16 01       	addw   $0x1,0x16(%ebx)
  if((dp = nameiparent(new, name)) == 0)
801050a8:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801050ab:	53                   	push   %ebx
801050ac:	e8 9f c5 ff ff       	call   80101650 <iupdate>
  iunlock(ip);
801050b1:	89 1c 24             	mov    %ebx,(%esp)
801050b4:	e8 67 c7 ff ff       	call   80101820 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801050b9:	58                   	pop    %eax
801050ba:	5a                   	pop    %edx
801050bb:	57                   	push   %edi
801050bc:	ff 75 d0             	pushl  -0x30(%ebp)
801050bf:	e8 7c cf ff ff       	call   80102040 <nameiparent>
801050c4:	83 c4 10             	add    $0x10,%esp
801050c7:	89 c6                	mov    %eax,%esi
801050c9:	85 c0                	test   %eax,%eax
801050cb:	74 5f                	je     8010512c <sys_link+0xfc>
  ilock(dp);
801050cd:	83 ec 0c             	sub    $0xc,%esp
801050d0:	50                   	push   %eax
801050d1:	e8 3a c6 ff ff       	call   80101710 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801050d6:	8b 03                	mov    (%ebx),%eax
801050d8:	83 c4 10             	add    $0x10,%esp
801050db:	39 06                	cmp    %eax,(%esi)
801050dd:	75 41                	jne    80105120 <sys_link+0xf0>
801050df:	83 ec 04             	sub    $0x4,%esp
801050e2:	ff 73 04             	pushl  0x4(%ebx)
801050e5:	57                   	push   %edi
801050e6:	56                   	push   %esi
801050e7:	e8 74 ce ff ff       	call   80101f60 <dirlink>
801050ec:	83 c4 10             	add    $0x10,%esp
801050ef:	85 c0                	test   %eax,%eax
801050f1:	78 2d                	js     80105120 <sys_link+0xf0>
  iunlockput(dp);
801050f3:	83 ec 0c             	sub    $0xc,%esp
801050f6:	56                   	push   %esi
801050f7:	e8 f4 c8 ff ff       	call   801019f0 <iunlockput>
  iput(ip);
801050fc:	89 1c 24             	mov    %ebx,(%esp)
801050ff:	e8 7c c7 ff ff       	call   80101880 <iput>
  end_op();
80105104:	e8 27 dd ff ff       	call   80102e30 <end_op>
  return 0;
80105109:	83 c4 10             	add    $0x10,%esp
8010510c:	31 c0                	xor    %eax,%eax
}
8010510e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105111:	5b                   	pop    %ebx
80105112:	5e                   	pop    %esi
80105113:	5f                   	pop    %edi
80105114:	5d                   	pop    %ebp
80105115:	c3                   	ret    
80105116:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010511d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
80105120:	83 ec 0c             	sub    $0xc,%esp
80105123:	56                   	push   %esi
80105124:	e8 c7 c8 ff ff       	call   801019f0 <iunlockput>
    goto bad;
80105129:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
8010512c:	83 ec 0c             	sub    $0xc,%esp
8010512f:	53                   	push   %ebx
80105130:	e8 db c5 ff ff       	call   80101710 <ilock>
  ip->nlink--;
80105135:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
8010513a:	89 1c 24             	mov    %ebx,(%esp)
8010513d:	e8 0e c5 ff ff       	call   80101650 <iupdate>
  iunlockput(ip);
80105142:	89 1c 24             	mov    %ebx,(%esp)
80105145:	e8 a6 c8 ff ff       	call   801019f0 <iunlockput>
  end_op();
8010514a:	e8 e1 dc ff ff       	call   80102e30 <end_op>
  return -1;
8010514f:	83 c4 10             	add    $0x10,%esp
80105152:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105157:	eb b5                	jmp    8010510e <sys_link+0xde>
    iunlockput(ip);
80105159:	83 ec 0c             	sub    $0xc,%esp
8010515c:	53                   	push   %ebx
8010515d:	e8 8e c8 ff ff       	call   801019f0 <iunlockput>
    end_op();
80105162:	e8 c9 dc ff ff       	call   80102e30 <end_op>
    return -1;
80105167:	83 c4 10             	add    $0x10,%esp
8010516a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010516f:	eb 9d                	jmp    8010510e <sys_link+0xde>
    end_op();
80105171:	e8 ba dc ff ff       	call   80102e30 <end_op>
    return -1;
80105176:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010517b:	eb 91                	jmp    8010510e <sys_link+0xde>
8010517d:	8d 76 00             	lea    0x0(%esi),%esi

80105180 <sys_unlink>:
{
80105180:	f3 0f 1e fb          	endbr32 
80105184:	55                   	push   %ebp
80105185:	89 e5                	mov    %esp,%ebp
80105187:	57                   	push   %edi
80105188:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105189:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
8010518c:	53                   	push   %ebx
8010518d:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80105190:	50                   	push   %eax
80105191:	6a 00                	push   $0x0
80105193:	e8 d8 f9 ff ff       	call   80104b70 <argstr>
80105198:	83 c4 10             	add    $0x10,%esp
8010519b:	85 c0                	test   %eax,%eax
8010519d:	0f 88 7d 01 00 00    	js     80105320 <sys_unlink+0x1a0>
  begin_op();
801051a3:	e8 18 dc ff ff       	call   80102dc0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801051a8:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801051ab:	83 ec 08             	sub    $0x8,%esp
801051ae:	53                   	push   %ebx
801051af:	ff 75 c0             	pushl  -0x40(%ebp)
801051b2:	e8 89 ce ff ff       	call   80102040 <nameiparent>
801051b7:	83 c4 10             	add    $0x10,%esp
801051ba:	89 c6                	mov    %eax,%esi
801051bc:	85 c0                	test   %eax,%eax
801051be:	0f 84 66 01 00 00    	je     8010532a <sys_unlink+0x1aa>
  ilock(dp);
801051c4:	83 ec 0c             	sub    $0xc,%esp
801051c7:	50                   	push   %eax
801051c8:	e8 43 c5 ff ff       	call   80101710 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801051cd:	58                   	pop    %eax
801051ce:	5a                   	pop    %edx
801051cf:	68 3c 7a 10 80       	push   $0x80107a3c
801051d4:	53                   	push   %ebx
801051d5:	e8 a6 ca ff ff       	call   80101c80 <namecmp>
801051da:	83 c4 10             	add    $0x10,%esp
801051dd:	85 c0                	test   %eax,%eax
801051df:	0f 84 03 01 00 00    	je     801052e8 <sys_unlink+0x168>
801051e5:	83 ec 08             	sub    $0x8,%esp
801051e8:	68 3b 7a 10 80       	push   $0x80107a3b
801051ed:	53                   	push   %ebx
801051ee:	e8 8d ca ff ff       	call   80101c80 <namecmp>
801051f3:	83 c4 10             	add    $0x10,%esp
801051f6:	85 c0                	test   %eax,%eax
801051f8:	0f 84 ea 00 00 00    	je     801052e8 <sys_unlink+0x168>
  if((ip = dirlookup(dp, name, &off)) == 0)
801051fe:	83 ec 04             	sub    $0x4,%esp
80105201:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105204:	50                   	push   %eax
80105205:	53                   	push   %ebx
80105206:	56                   	push   %esi
80105207:	e8 94 ca ff ff       	call   80101ca0 <dirlookup>
8010520c:	83 c4 10             	add    $0x10,%esp
8010520f:	89 c3                	mov    %eax,%ebx
80105211:	85 c0                	test   %eax,%eax
80105213:	0f 84 cf 00 00 00    	je     801052e8 <sys_unlink+0x168>
  ilock(ip);
80105219:	83 ec 0c             	sub    $0xc,%esp
8010521c:	50                   	push   %eax
8010521d:	e8 ee c4 ff ff       	call   80101710 <ilock>
  if(ip->nlink < 1)
80105222:	83 c4 10             	add    $0x10,%esp
80105225:	66 83 7b 16 00       	cmpw   $0x0,0x16(%ebx)
8010522a:	0f 8e 23 01 00 00    	jle    80105353 <sys_unlink+0x1d3>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105230:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
80105235:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105238:	74 66                	je     801052a0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010523a:	83 ec 04             	sub    $0x4,%esp
8010523d:	6a 10                	push   $0x10
8010523f:	6a 00                	push   $0x0
80105241:	57                   	push   %edi
80105242:	e8 b9 f5 ff ff       	call   80104800 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105247:	6a 10                	push   $0x10
80105249:	ff 75 c4             	pushl  -0x3c(%ebp)
8010524c:	57                   	push   %edi
8010524d:	56                   	push   %esi
8010524e:	e8 fd c8 ff ff       	call   80101b50 <writei>
80105253:	83 c4 20             	add    $0x20,%esp
80105256:	83 f8 10             	cmp    $0x10,%eax
80105259:	0f 85 e7 00 00 00    	jne    80105346 <sys_unlink+0x1c6>
  if(ip->type == T_DIR){
8010525f:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
80105264:	0f 84 96 00 00 00    	je     80105300 <sys_unlink+0x180>
  iunlockput(dp);
8010526a:	83 ec 0c             	sub    $0xc,%esp
8010526d:	56                   	push   %esi
8010526e:	e8 7d c7 ff ff       	call   801019f0 <iunlockput>
  ip->nlink--;
80105273:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
80105278:	89 1c 24             	mov    %ebx,(%esp)
8010527b:	e8 d0 c3 ff ff       	call   80101650 <iupdate>
  iunlockput(ip);
80105280:	89 1c 24             	mov    %ebx,(%esp)
80105283:	e8 68 c7 ff ff       	call   801019f0 <iunlockput>
  end_op();
80105288:	e8 a3 db ff ff       	call   80102e30 <end_op>
  return 0;
8010528d:	83 c4 10             	add    $0x10,%esp
80105290:	31 c0                	xor    %eax,%eax
}
80105292:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105295:	5b                   	pop    %ebx
80105296:	5e                   	pop    %esi
80105297:	5f                   	pop    %edi
80105298:	5d                   	pop    %ebp
80105299:	c3                   	ret    
8010529a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801052a0:	83 7b 18 20          	cmpl   $0x20,0x18(%ebx)
801052a4:	76 94                	jbe    8010523a <sys_unlink+0xba>
801052a6:	ba 20 00 00 00       	mov    $0x20,%edx
801052ab:	eb 0b                	jmp    801052b8 <sys_unlink+0x138>
801052ad:	8d 76 00             	lea    0x0(%esi),%esi
801052b0:	83 c2 10             	add    $0x10,%edx
801052b3:	39 53 18             	cmp    %edx,0x18(%ebx)
801052b6:	76 82                	jbe    8010523a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801052b8:	6a 10                	push   $0x10
801052ba:	52                   	push   %edx
801052bb:	57                   	push   %edi
801052bc:	53                   	push   %ebx
801052bd:	89 55 b4             	mov    %edx,-0x4c(%ebp)
801052c0:	e8 8b c7 ff ff       	call   80101a50 <readi>
801052c5:	83 c4 10             	add    $0x10,%esp
801052c8:	8b 55 b4             	mov    -0x4c(%ebp),%edx
801052cb:	83 f8 10             	cmp    $0x10,%eax
801052ce:	75 69                	jne    80105339 <sys_unlink+0x1b9>
    if(de.inum != 0)
801052d0:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801052d5:	74 d9                	je     801052b0 <sys_unlink+0x130>
    iunlockput(ip);
801052d7:	83 ec 0c             	sub    $0xc,%esp
801052da:	53                   	push   %ebx
801052db:	e8 10 c7 ff ff       	call   801019f0 <iunlockput>
    goto bad;
801052e0:	83 c4 10             	add    $0x10,%esp
801052e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801052e7:	90                   	nop
  iunlockput(dp);
801052e8:	83 ec 0c             	sub    $0xc,%esp
801052eb:	56                   	push   %esi
801052ec:	e8 ff c6 ff ff       	call   801019f0 <iunlockput>
  end_op();
801052f1:	e8 3a db ff ff       	call   80102e30 <end_op>
  return -1;
801052f6:	83 c4 10             	add    $0x10,%esp
801052f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052fe:	eb 92                	jmp    80105292 <sys_unlink+0x112>
    iupdate(dp);
80105300:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105303:	66 83 6e 16 01       	subw   $0x1,0x16(%esi)
    iupdate(dp);
80105308:	56                   	push   %esi
80105309:	e8 42 c3 ff ff       	call   80101650 <iupdate>
8010530e:	83 c4 10             	add    $0x10,%esp
80105311:	e9 54 ff ff ff       	jmp    8010526a <sys_unlink+0xea>
80105316:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010531d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105320:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105325:	e9 68 ff ff ff       	jmp    80105292 <sys_unlink+0x112>
    end_op();
8010532a:	e8 01 db ff ff       	call   80102e30 <end_op>
    return -1;
8010532f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105334:	e9 59 ff ff ff       	jmp    80105292 <sys_unlink+0x112>
      panic("isdirempty: readi");
80105339:	83 ec 0c             	sub    $0xc,%esp
8010533c:	68 60 7a 10 80       	push   $0x80107a60
80105341:	e8 3a b0 ff ff       	call   80100380 <panic>
    panic("unlink: writei");
80105346:	83 ec 0c             	sub    $0xc,%esp
80105349:	68 72 7a 10 80       	push   $0x80107a72
8010534e:	e8 2d b0 ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
80105353:	83 ec 0c             	sub    $0xc,%esp
80105356:	68 4e 7a 10 80       	push   $0x80107a4e
8010535b:	e8 20 b0 ff ff       	call   80100380 <panic>

80105360 <sys_open>:

int
sys_open(void)
{
80105360:	f3 0f 1e fb          	endbr32 
80105364:	55                   	push   %ebp
80105365:	89 e5                	mov    %esp,%ebp
80105367:	57                   	push   %edi
80105368:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105369:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
8010536c:	53                   	push   %ebx
8010536d:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105370:	50                   	push   %eax
80105371:	6a 00                	push   $0x0
80105373:	e8 f8 f7 ff ff       	call   80104b70 <argstr>
80105378:	83 c4 10             	add    $0x10,%esp
8010537b:	85 c0                	test   %eax,%eax
8010537d:	0f 88 9a 00 00 00    	js     8010541d <sys_open+0xbd>
80105383:	83 ec 08             	sub    $0x8,%esp
80105386:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105389:	50                   	push   %eax
8010538a:	6a 01                	push   $0x1
8010538c:	e8 3f f7 ff ff       	call   80104ad0 <argint>
80105391:	83 c4 10             	add    $0x10,%esp
80105394:	85 c0                	test   %eax,%eax
80105396:	0f 88 81 00 00 00    	js     8010541d <sys_open+0xbd>
    return -1;

  begin_op();
8010539c:	e8 1f da ff ff       	call   80102dc0 <begin_op>

  if(omode & O_CREATE){
801053a1:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801053a5:	0f 85 7d 00 00 00    	jne    80105428 <sys_open+0xc8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801053ab:	83 ec 0c             	sub    $0xc,%esp
801053ae:	ff 75 e0             	pushl  -0x20(%ebp)
801053b1:	e8 6a cc ff ff       	call   80102020 <namei>
801053b6:	83 c4 10             	add    $0x10,%esp
801053b9:	89 c6                	mov    %eax,%esi
801053bb:	85 c0                	test   %eax,%eax
801053bd:	0f 84 82 00 00 00    	je     80105445 <sys_open+0xe5>
      end_op();
      return -1;
    }
    ilock(ip);
801053c3:	83 ec 0c             	sub    $0xc,%esp
801053c6:	50                   	push   %eax
801053c7:	e8 44 c3 ff ff       	call   80101710 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801053cc:	83 c4 10             	add    $0x10,%esp
801053cf:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
801053d4:	0f 84 c6 00 00 00    	je     801054a0 <sys_open+0x140>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801053da:	e8 11 ba ff ff       	call   80100df0 <filealloc>
801053df:	89 c7                	mov    %eax,%edi
801053e1:	85 c0                	test   %eax,%eax
801053e3:	74 27                	je     8010540c <sys_open+0xac>
    if(proc->ofile[fd] == 0){
801053e5:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  for(fd = 0; fd < NOFILE; fd++){
801053ec:	31 db                	xor    %ebx,%ebx
801053ee:	66 90                	xchg   %ax,%ax
    if(proc->ofile[fd] == 0){
801053f0:	8b 44 9a 28          	mov    0x28(%edx,%ebx,4),%eax
801053f4:	85 c0                	test   %eax,%eax
801053f6:	74 60                	je     80105458 <sys_open+0xf8>
  for(fd = 0; fd < NOFILE; fd++){
801053f8:	83 c3 01             	add    $0x1,%ebx
801053fb:	83 fb 10             	cmp    $0x10,%ebx
801053fe:	75 f0                	jne    801053f0 <sys_open+0x90>
    if(f)
      fileclose(f);
80105400:	83 ec 0c             	sub    $0xc,%esp
80105403:	57                   	push   %edi
80105404:	e8 a7 ba ff ff       	call   80100eb0 <fileclose>
80105409:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010540c:	83 ec 0c             	sub    $0xc,%esp
8010540f:	56                   	push   %esi
80105410:	e8 db c5 ff ff       	call   801019f0 <iunlockput>
    end_op();
80105415:	e8 16 da ff ff       	call   80102e30 <end_op>
    return -1;
8010541a:	83 c4 10             	add    $0x10,%esp
8010541d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105422:	eb 6d                	jmp    80105491 <sys_open+0x131>
80105424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105428:	83 ec 0c             	sub    $0xc,%esp
8010542b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010542e:	31 c9                	xor    %ecx,%ecx
80105430:	ba 02 00 00 00       	mov    $0x2,%edx
80105435:	6a 00                	push   $0x0
80105437:	e8 14 f8 ff ff       	call   80104c50 <create>
    if(ip == 0){
8010543c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
8010543f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105441:	85 c0                	test   %eax,%eax
80105443:	75 95                	jne    801053da <sys_open+0x7a>
      end_op();
80105445:	e8 e6 d9 ff ff       	call   80102e30 <end_op>
      return -1;
8010544a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010544f:	eb 40                	jmp    80105491 <sys_open+0x131>
80105451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105458:	83 ec 0c             	sub    $0xc,%esp
      proc->ofile[fd] = f;
8010545b:	89 7c 9a 28          	mov    %edi,0x28(%edx,%ebx,4)
  iunlock(ip);
8010545f:	56                   	push   %esi
80105460:	e8 bb c3 ff ff       	call   80101820 <iunlock>
  end_op();
80105465:	e8 c6 d9 ff ff       	call   80102e30 <end_op>

  f->type = FD_INODE;
8010546a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105470:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105473:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105476:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105479:	89 d0                	mov    %edx,%eax
  f->off = 0;
8010547b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105482:	f7 d0                	not    %eax
80105484:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105487:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
8010548a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010548d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105491:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105494:	89 d8                	mov    %ebx,%eax
80105496:	5b                   	pop    %ebx
80105497:	5e                   	pop    %esi
80105498:	5f                   	pop    %edi
80105499:	5d                   	pop    %ebp
8010549a:	c3                   	ret    
8010549b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010549f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
801054a0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801054a3:	85 d2                	test   %edx,%edx
801054a5:	0f 84 2f ff ff ff    	je     801053da <sys_open+0x7a>
801054ab:	e9 5c ff ff ff       	jmp    8010540c <sys_open+0xac>

801054b0 <sys_mkdir>:

int
sys_mkdir(void)
{
801054b0:	f3 0f 1e fb          	endbr32 
801054b4:	55                   	push   %ebp
801054b5:	89 e5                	mov    %esp,%ebp
801054b7:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801054ba:	e8 01 d9 ff ff       	call   80102dc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801054bf:	83 ec 08             	sub    $0x8,%esp
801054c2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054c5:	50                   	push   %eax
801054c6:	6a 00                	push   $0x0
801054c8:	e8 a3 f6 ff ff       	call   80104b70 <argstr>
801054cd:	83 c4 10             	add    $0x10,%esp
801054d0:	85 c0                	test   %eax,%eax
801054d2:	78 34                	js     80105508 <sys_mkdir+0x58>
801054d4:	83 ec 0c             	sub    $0xc,%esp
801054d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054da:	31 c9                	xor    %ecx,%ecx
801054dc:	ba 01 00 00 00       	mov    $0x1,%edx
801054e1:	6a 00                	push   $0x0
801054e3:	e8 68 f7 ff ff       	call   80104c50 <create>
801054e8:	83 c4 10             	add    $0x10,%esp
801054eb:	85 c0                	test   %eax,%eax
801054ed:	74 19                	je     80105508 <sys_mkdir+0x58>
    end_op();
    return -1;
  }
  iunlockput(ip);
801054ef:	83 ec 0c             	sub    $0xc,%esp
801054f2:	50                   	push   %eax
801054f3:	e8 f8 c4 ff ff       	call   801019f0 <iunlockput>
  end_op();
801054f8:	e8 33 d9 ff ff       	call   80102e30 <end_op>
  return 0;
801054fd:	83 c4 10             	add    $0x10,%esp
80105500:	31 c0                	xor    %eax,%eax
}
80105502:	c9                   	leave  
80105503:	c3                   	ret    
80105504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105508:	e8 23 d9 ff ff       	call   80102e30 <end_op>
    return -1;
8010550d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105512:	c9                   	leave  
80105513:	c3                   	ret    
80105514:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010551b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010551f:	90                   	nop

80105520 <sys_mknod>:

int
sys_mknod(void)
{
80105520:	f3 0f 1e fb          	endbr32 
80105524:	55                   	push   %ebp
80105525:	89 e5                	mov    %esp,%ebp
80105527:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
8010552a:	e8 91 d8 ff ff       	call   80102dc0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010552f:	83 ec 08             	sub    $0x8,%esp
80105532:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105535:	50                   	push   %eax
80105536:	6a 00                	push   $0x0
80105538:	e8 33 f6 ff ff       	call   80104b70 <argstr>
8010553d:	83 c4 10             	add    $0x10,%esp
80105540:	85 c0                	test   %eax,%eax
80105542:	78 64                	js     801055a8 <sys_mknod+0x88>
     argint(1, &major) < 0 ||
80105544:	83 ec 08             	sub    $0x8,%esp
80105547:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010554a:	50                   	push   %eax
8010554b:	6a 01                	push   $0x1
8010554d:	e8 7e f5 ff ff       	call   80104ad0 <argint>
  if((argstr(0, &path)) < 0 ||
80105552:	83 c4 10             	add    $0x10,%esp
80105555:	85 c0                	test   %eax,%eax
80105557:	78 4f                	js     801055a8 <sys_mknod+0x88>
     argint(2, &minor) < 0 ||
80105559:	83 ec 08             	sub    $0x8,%esp
8010555c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010555f:	50                   	push   %eax
80105560:	6a 02                	push   $0x2
80105562:	e8 69 f5 ff ff       	call   80104ad0 <argint>
     argint(1, &major) < 0 ||
80105567:	83 c4 10             	add    $0x10,%esp
8010556a:	85 c0                	test   %eax,%eax
8010556c:	78 3a                	js     801055a8 <sys_mknod+0x88>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010556e:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105572:	83 ec 0c             	sub    $0xc,%esp
80105575:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105579:	ba 03 00 00 00       	mov    $0x3,%edx
8010557e:	50                   	push   %eax
8010557f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105582:	e8 c9 f6 ff ff       	call   80104c50 <create>
     argint(2, &minor) < 0 ||
80105587:	83 c4 10             	add    $0x10,%esp
8010558a:	85 c0                	test   %eax,%eax
8010558c:	74 1a                	je     801055a8 <sys_mknod+0x88>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010558e:	83 ec 0c             	sub    $0xc,%esp
80105591:	50                   	push   %eax
80105592:	e8 59 c4 ff ff       	call   801019f0 <iunlockput>
  end_op();
80105597:	e8 94 d8 ff ff       	call   80102e30 <end_op>
  return 0;
8010559c:	83 c4 10             	add    $0x10,%esp
8010559f:	31 c0                	xor    %eax,%eax
}
801055a1:	c9                   	leave  
801055a2:	c3                   	ret    
801055a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801055a7:	90                   	nop
    end_op();
801055a8:	e8 83 d8 ff ff       	call   80102e30 <end_op>
    return -1;
801055ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055b2:	c9                   	leave  
801055b3:	c3                   	ret    
801055b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801055bf:	90                   	nop

801055c0 <sys_chdir>:

int
sys_chdir(void)
{
801055c0:	f3 0f 1e fb          	endbr32 
801055c4:	55                   	push   %ebp
801055c5:	89 e5                	mov    %esp,%ebp
801055c7:	53                   	push   %ebx
801055c8:	83 ec 14             	sub    $0x14,%esp
  char *path;
  struct inode *ip;

  begin_op();
801055cb:	e8 f0 d7 ff ff       	call   80102dc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801055d0:	83 ec 08             	sub    $0x8,%esp
801055d3:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055d6:	50                   	push   %eax
801055d7:	6a 00                	push   $0x0
801055d9:	e8 92 f5 ff ff       	call   80104b70 <argstr>
801055de:	83 c4 10             	add    $0x10,%esp
801055e1:	85 c0                	test   %eax,%eax
801055e3:	78 7b                	js     80105660 <sys_chdir+0xa0>
801055e5:	83 ec 0c             	sub    $0xc,%esp
801055e8:	ff 75 f4             	pushl  -0xc(%ebp)
801055eb:	e8 30 ca ff ff       	call   80102020 <namei>
801055f0:	83 c4 10             	add    $0x10,%esp
801055f3:	89 c3                	mov    %eax,%ebx
801055f5:	85 c0                	test   %eax,%eax
801055f7:	74 67                	je     80105660 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801055f9:	83 ec 0c             	sub    $0xc,%esp
801055fc:	50                   	push   %eax
801055fd:	e8 0e c1 ff ff       	call   80101710 <ilock>
  if(ip->type != T_DIR){
80105602:	83 c4 10             	add    $0x10,%esp
80105605:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
8010560a:	75 34                	jne    80105640 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
8010560c:	83 ec 0c             	sub    $0xc,%esp
8010560f:	53                   	push   %ebx
80105610:	e8 0b c2 ff ff       	call   80101820 <iunlock>
  iput(proc->cwd);
80105615:	58                   	pop    %eax
80105616:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010561c:	ff 70 68             	pushl  0x68(%eax)
8010561f:	e8 5c c2 ff ff       	call   80101880 <iput>
  end_op();
80105624:	e8 07 d8 ff ff       	call   80102e30 <end_op>
  proc->cwd = ip;
80105629:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return 0;
8010562f:	83 c4 10             	add    $0x10,%esp
  proc->cwd = ip;
80105632:	89 58 68             	mov    %ebx,0x68(%eax)
  return 0;
80105635:	31 c0                	xor    %eax,%eax
}
80105637:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010563a:	c9                   	leave  
8010563b:	c3                   	ret    
8010563c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80105640:	83 ec 0c             	sub    $0xc,%esp
80105643:	53                   	push   %ebx
80105644:	e8 a7 c3 ff ff       	call   801019f0 <iunlockput>
    end_op();
80105649:	e8 e2 d7 ff ff       	call   80102e30 <end_op>
    return -1;
8010564e:	83 c4 10             	add    $0x10,%esp
80105651:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105656:	eb df                	jmp    80105637 <sys_chdir+0x77>
80105658:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010565f:	90                   	nop
    end_op();
80105660:	e8 cb d7 ff ff       	call   80102e30 <end_op>
    return -1;
80105665:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010566a:	eb cb                	jmp    80105637 <sys_chdir+0x77>
8010566c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105670 <sys_exec>:

int
sys_exec(void)
{
80105670:	f3 0f 1e fb          	endbr32 
80105674:	55                   	push   %ebp
80105675:	89 e5                	mov    %esp,%ebp
80105677:	57                   	push   %edi
80105678:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105679:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010567f:	53                   	push   %ebx
80105680:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105686:	50                   	push   %eax
80105687:	6a 00                	push   $0x0
80105689:	e8 e2 f4 ff ff       	call   80104b70 <argstr>
8010568e:	83 c4 10             	add    $0x10,%esp
80105691:	85 c0                	test   %eax,%eax
80105693:	0f 88 8b 00 00 00    	js     80105724 <sys_exec+0xb4>
80105699:	83 ec 08             	sub    $0x8,%esp
8010569c:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801056a2:	50                   	push   %eax
801056a3:	6a 01                	push   $0x1
801056a5:	e8 26 f4 ff ff       	call   80104ad0 <argint>
801056aa:	83 c4 10             	add    $0x10,%esp
801056ad:	85 c0                	test   %eax,%eax
801056af:	78 73                	js     80105724 <sys_exec+0xb4>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801056b1:	83 ec 04             	sub    $0x4,%esp
801056b4:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
801056ba:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801056bc:	68 80 00 00 00       	push   $0x80
801056c1:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801056c7:	6a 00                	push   $0x0
801056c9:	50                   	push   %eax
801056ca:	e8 31 f1 ff ff       	call   80104800 <memset>
801056cf:	83 c4 10             	add    $0x10,%esp
801056d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801056d8:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801056de:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
801056e5:	83 ec 08             	sub    $0x8,%esp
801056e8:	57                   	push   %edi
801056e9:	01 f0                	add    %esi,%eax
801056eb:	50                   	push   %eax
801056ec:	e8 4f f3 ff ff       	call   80104a40 <fetchint>
801056f1:	83 c4 10             	add    $0x10,%esp
801056f4:	85 c0                	test   %eax,%eax
801056f6:	78 2c                	js     80105724 <sys_exec+0xb4>
      return -1;
    if(uarg == 0){
801056f8:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801056fe:	85 c0                	test   %eax,%eax
80105700:	74 36                	je     80105738 <sys_exec+0xc8>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105702:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105708:	83 ec 08             	sub    $0x8,%esp
8010570b:	8d 14 31             	lea    (%ecx,%esi,1),%edx
8010570e:	52                   	push   %edx
8010570f:	50                   	push   %eax
80105710:	e8 6b f3 ff ff       	call   80104a80 <fetchstr>
80105715:	83 c4 10             	add    $0x10,%esp
80105718:	85 c0                	test   %eax,%eax
8010571a:	78 08                	js     80105724 <sys_exec+0xb4>
  for(i=0;; i++){
8010571c:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
8010571f:	83 fb 20             	cmp    $0x20,%ebx
80105722:	75 b4                	jne    801056d8 <sys_exec+0x68>
      return -1;
  }
  return exec(path, argv);
}
80105724:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105727:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010572c:	5b                   	pop    %ebx
8010572d:	5e                   	pop    %esi
8010572e:	5f                   	pop    %edi
8010572f:	5d                   	pop    %ebp
80105730:	c3                   	ret    
80105731:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105738:	83 ec 08             	sub    $0x8,%esp
8010573b:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
      argv[i] = 0;
80105741:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105748:	00 00 00 00 
  return exec(path, argv);
8010574c:	50                   	push   %eax
8010574d:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105753:	e8 28 b3 ff ff       	call   80100a80 <exec>
80105758:	83 c4 10             	add    $0x10,%esp
}
8010575b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010575e:	5b                   	pop    %ebx
8010575f:	5e                   	pop    %esi
80105760:	5f                   	pop    %edi
80105761:	5d                   	pop    %ebp
80105762:	c3                   	ret    
80105763:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010576a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105770 <sys_pipe>:

int
sys_pipe(void)
{
80105770:	f3 0f 1e fb          	endbr32 
80105774:	55                   	push   %ebp
80105775:	89 e5                	mov    %esp,%ebp
80105777:	57                   	push   %edi
80105778:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105779:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
8010577c:	53                   	push   %ebx
8010577d:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105780:	6a 08                	push   $0x8
80105782:	50                   	push   %eax
80105783:	6a 00                	push   $0x0
80105785:	e8 96 f3 ff ff       	call   80104b20 <argptr>
8010578a:	83 c4 10             	add    $0x10,%esp
8010578d:	85 c0                	test   %eax,%eax
8010578f:	78 4c                	js     801057dd <sys_pipe+0x6d>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105791:	83 ec 08             	sub    $0x8,%esp
80105794:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105797:	50                   	push   %eax
80105798:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010579b:	50                   	push   %eax
8010579c:	e8 bf dd ff ff       	call   80103560 <pipealloc>
801057a1:	83 c4 10             	add    $0x10,%esp
801057a4:	85 c0                	test   %eax,%eax
801057a6:	78 35                	js     801057dd <sys_pipe+0x6d>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801057a8:	8b 75 e0             	mov    -0x20(%ebp),%esi
    if(proc->ofile[fd] == 0){
801057ab:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
  for(fd = 0; fd < NOFILE; fd++){
801057b2:	31 c0                	xor    %eax,%eax
801057b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->ofile[fd] == 0){
801057b8:	8b 54 81 28          	mov    0x28(%ecx,%eax,4),%edx
801057bc:	85 d2                	test   %edx,%edx
801057be:	74 28                	je     801057e8 <sys_pipe+0x78>
  for(fd = 0; fd < NOFILE; fd++){
801057c0:	83 c0 01             	add    $0x1,%eax
801057c3:	83 f8 10             	cmp    $0x10,%eax
801057c6:	75 f0                	jne    801057b8 <sys_pipe+0x48>
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
    fileclose(rf);
801057c8:	83 ec 0c             	sub    $0xc,%esp
801057cb:	56                   	push   %esi
801057cc:	e8 df b6 ff ff       	call   80100eb0 <fileclose>
    fileclose(wf);
801057d1:	58                   	pop    %eax
801057d2:	ff 75 e4             	pushl  -0x1c(%ebp)
801057d5:	e8 d6 b6 ff ff       	call   80100eb0 <fileclose>
    return -1;
801057da:	83 c4 10             	add    $0x10,%esp
801057dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057e2:	eb 3d                	jmp    80105821 <sys_pipe+0xb1>
801057e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      proc->ofile[fd] = f;
801057e8:	8d 1c 81             	lea    (%ecx,%eax,4),%ebx
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801057eb:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801057ee:	31 d2                	xor    %edx,%edx
      proc->ofile[fd] = f;
801057f0:	89 73 28             	mov    %esi,0x28(%ebx)
  for(fd = 0; fd < NOFILE; fd++){
801057f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801057f7:	90                   	nop
    if(proc->ofile[fd] == 0){
801057f8:	83 7c 91 28 00       	cmpl   $0x0,0x28(%ecx,%edx,4)
801057fd:	74 11                	je     80105810 <sys_pipe+0xa0>
  for(fd = 0; fd < NOFILE; fd++){
801057ff:	83 c2 01             	add    $0x1,%edx
80105802:	83 fa 10             	cmp    $0x10,%edx
80105805:	75 f1                	jne    801057f8 <sys_pipe+0x88>
      proc->ofile[fd0] = 0;
80105807:	c7 43 28 00 00 00 00 	movl   $0x0,0x28(%ebx)
8010580e:	eb b8                	jmp    801057c8 <sys_pipe+0x58>
      proc->ofile[fd] = f;
80105810:	89 7c 91 28          	mov    %edi,0x28(%ecx,%edx,4)
  }
  fd[0] = fd0;
80105814:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80105817:	89 01                	mov    %eax,(%ecx)
  fd[1] = fd1;
80105819:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010581c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
8010581f:	31 c0                	xor    %eax,%eax
}
80105821:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105824:	5b                   	pop    %ebx
80105825:	5e                   	pop    %esi
80105826:	5f                   	pop    %edi
80105827:	5d                   	pop    %ebp
80105828:	c3                   	ret    
80105829:	66 90                	xchg   %ax,%ax
8010582b:	66 90                	xchg   %ax,%ax
8010582d:	66 90                	xchg   %ax,%ax
8010582f:	90                   	nop

80105830 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105830:	f3 0f 1e fb          	endbr32 
  return fork();
80105834:	e9 67 e3 ff ff       	jmp    80103ba0 <fork>
80105839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105840 <sys_exit>:
}

int
sys_exit(void)
{
80105840:	f3 0f 1e fb          	endbr32 
80105844:	55                   	push   %ebp
80105845:	89 e5                	mov    %esp,%ebp
80105847:	83 ec 08             	sub    $0x8,%esp
  exit();
8010584a:	e8 d1 e5 ff ff       	call   80103e20 <exit>
  return 0;  // not reached
}
8010584f:	31 c0                	xor    %eax,%eax
80105851:	c9                   	leave  
80105852:	c3                   	ret    
80105853:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010585a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105860 <sys_wait>:

int
sys_wait(void)
{
80105860:	f3 0f 1e fb          	endbr32 
  return wait();
80105864:	e9 97 e8 ff ff       	jmp    80104100 <wait>
80105869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105870 <sys_kill>:
}

int
sys_kill(void)
{
80105870:	f3 0f 1e fb          	endbr32 
80105874:	55                   	push   %ebp
80105875:	89 e5                	mov    %esp,%ebp
80105877:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
8010587a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010587d:	50                   	push   %eax
8010587e:	6a 00                	push   $0x0
80105880:	e8 4b f2 ff ff       	call   80104ad0 <argint>
80105885:	83 c4 10             	add    $0x10,%esp
80105888:	85 c0                	test   %eax,%eax
8010588a:	78 14                	js     801058a0 <sys_kill+0x30>
    return -1;
  return kill(pid);
8010588c:	83 ec 0c             	sub    $0xc,%esp
8010588f:	ff 75 f4             	pushl  -0xc(%ebp)
80105892:	e8 c9 e9 ff ff       	call   80104260 <kill>
80105897:	83 c4 10             	add    $0x10,%esp
}
8010589a:	c9                   	leave  
8010589b:	c3                   	ret    
8010589c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801058a0:	c9                   	leave  
    return -1;
801058a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058a6:	c3                   	ret    
801058a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058ae:	66 90                	xchg   %ax,%ax

801058b0 <sys_getpid>:

int
sys_getpid(void)
{
801058b0:	f3 0f 1e fb          	endbr32 
  return proc->pid;
801058b4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801058ba:	8b 40 10             	mov    0x10(%eax),%eax
}
801058bd:	c3                   	ret    
801058be:	66 90                	xchg   %ax,%ax

801058c0 <sys_sbrk>:

int
sys_sbrk(void)
{
801058c0:	f3 0f 1e fb          	endbr32 
801058c4:	55                   	push   %ebp
801058c5:	89 e5                	mov    %esp,%ebp
801058c7:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801058c8:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801058cb:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801058ce:	50                   	push   %eax
801058cf:	6a 00                	push   $0x0
801058d1:	e8 fa f1 ff ff       	call   80104ad0 <argint>
801058d6:	83 c4 10             	add    $0x10,%esp
801058d9:	85 c0                	test   %eax,%eax
801058db:	78 23                	js     80105900 <sys_sbrk+0x40>
    return -1;
  addr = proc->sz;
801058dd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(growproc(n) < 0)
801058e3:	83 ec 0c             	sub    $0xc,%esp
  addr = proc->sz;
801058e6:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801058e8:	ff 75 f4             	pushl  -0xc(%ebp)
801058eb:	e8 30 e2 ff ff       	call   80103b20 <growproc>
801058f0:	83 c4 10             	add    $0x10,%esp
801058f3:	85 c0                	test   %eax,%eax
801058f5:	78 09                	js     80105900 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801058f7:	89 d8                	mov    %ebx,%eax
801058f9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801058fc:	c9                   	leave  
801058fd:	c3                   	ret    
801058fe:	66 90                	xchg   %ax,%ax
    return -1;
80105900:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105905:	eb f0                	jmp    801058f7 <sys_sbrk+0x37>
80105907:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010590e:	66 90                	xchg   %ax,%ax

80105910 <sys_sleep>:

int
sys_sleep(void)
{
80105910:	f3 0f 1e fb          	endbr32 
80105914:	55                   	push   %ebp
80105915:	89 e5                	mov    %esp,%ebp
80105917:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105918:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
8010591b:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010591e:	50                   	push   %eax
8010591f:	6a 00                	push   $0x0
80105921:	e8 aa f1 ff ff       	call   80104ad0 <argint>
80105926:	83 c4 10             	add    $0x10,%esp
80105929:	85 c0                	test   %eax,%eax
8010592b:	0f 88 86 00 00 00    	js     801059b7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105931:	83 ec 0c             	sub    $0xc,%esp
80105934:	68 20 3a 11 80       	push   $0x80113a20
80105939:	e8 92 ec ff ff       	call   801045d0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010593e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105941:	8b 1d 60 42 11 80    	mov    0x80114260,%ebx
  while(ticks - ticks0 < n){
80105947:	83 c4 10             	add    $0x10,%esp
8010594a:	85 d2                	test   %edx,%edx
8010594c:	75 23                	jne    80105971 <sys_sleep+0x61>
8010594e:	eb 50                	jmp    801059a0 <sys_sleep+0x90>
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105950:	83 ec 08             	sub    $0x8,%esp
80105953:	68 20 3a 11 80       	push   $0x80113a20
80105958:	68 60 42 11 80       	push   $0x80114260
8010595d:	e8 ce e6 ff ff       	call   80104030 <sleep>
  while(ticks - ticks0 < n){
80105962:	a1 60 42 11 80       	mov    0x80114260,%eax
80105967:	83 c4 10             	add    $0x10,%esp
8010596a:	29 d8                	sub    %ebx,%eax
8010596c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010596f:	73 2f                	jae    801059a0 <sys_sleep+0x90>
    if(proc->killed){
80105971:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105977:	8b 40 24             	mov    0x24(%eax),%eax
8010597a:	85 c0                	test   %eax,%eax
8010597c:	74 d2                	je     80105950 <sys_sleep+0x40>
      release(&tickslock);
8010597e:	83 ec 0c             	sub    $0xc,%esp
80105981:	68 20 3a 11 80       	push   $0x80113a20
80105986:	e8 25 ee ff ff       	call   801047b0 <release>
  }
  release(&tickslock);
  return 0;
}
8010598b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
8010598e:	83 c4 10             	add    $0x10,%esp
80105991:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105996:	c9                   	leave  
80105997:	c3                   	ret    
80105998:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010599f:	90                   	nop
  release(&tickslock);
801059a0:	83 ec 0c             	sub    $0xc,%esp
801059a3:	68 20 3a 11 80       	push   $0x80113a20
801059a8:	e8 03 ee ff ff       	call   801047b0 <release>
  return 0;
801059ad:	83 c4 10             	add    $0x10,%esp
801059b0:	31 c0                	xor    %eax,%eax
}
801059b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059b5:	c9                   	leave  
801059b6:	c3                   	ret    
    return -1;
801059b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059bc:	eb f4                	jmp    801059b2 <sys_sleep+0xa2>
801059be:	66 90                	xchg   %ax,%ax

801059c0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801059c0:	f3 0f 1e fb          	endbr32 
801059c4:	55                   	push   %ebp
801059c5:	89 e5                	mov    %esp,%ebp
801059c7:	53                   	push   %ebx
801059c8:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801059cb:	68 20 3a 11 80       	push   $0x80113a20
801059d0:	e8 fb eb ff ff       	call   801045d0 <acquire>
  xticks = ticks;
801059d5:	8b 1d 60 42 11 80    	mov    0x80114260,%ebx
  release(&tickslock);
801059db:	c7 04 24 20 3a 11 80 	movl   $0x80113a20,(%esp)
801059e2:	e8 c9 ed ff ff       	call   801047b0 <release>
  return xticks;
}
801059e7:	89 d8                	mov    %ebx,%eax
801059e9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059ec:	c9                   	leave  
801059ed:	c3                   	ret    
801059ee:	66 90                	xchg   %ax,%ax

801059f0 <sys_clone>:

int sys_clone(void)
{
801059f0:	f3 0f 1e fb          	endbr32 
801059f4:	55                   	push   %ebp
801059f5:	89 e5                	mov    %esp,%ebp
801059f7:	83 ec 20             	sub    $0x20,%esp
  int func, arg, stack;
  if(argint(0, &func) < 0) return -1;
801059fa:	8d 45 ec             	lea    -0x14(%ebp),%eax
801059fd:	50                   	push   %eax
801059fe:	6a 00                	push   $0x0
80105a00:	e8 cb f0 ff ff       	call   80104ad0 <argint>
80105a05:	83 c4 10             	add    $0x10,%esp
80105a08:	85 c0                	test   %eax,%eax
80105a0a:	78 44                	js     80105a50 <sys_clone+0x60>
  if(argint(1, &arg) < 0) return -1;
80105a0c:	83 ec 08             	sub    $0x8,%esp
80105a0f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a12:	50                   	push   %eax
80105a13:	6a 01                	push   $0x1
80105a15:	e8 b6 f0 ff ff       	call   80104ad0 <argint>
80105a1a:	83 c4 10             	add    $0x10,%esp
80105a1d:	85 c0                	test   %eax,%eax
80105a1f:	78 2f                	js     80105a50 <sys_clone+0x60>
  if(argint(2, &stack) < 0) return -1;
80105a21:	83 ec 08             	sub    $0x8,%esp
80105a24:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a27:	50                   	push   %eax
80105a28:	6a 02                	push   $0x2
80105a2a:	e8 a1 f0 ff ff       	call   80104ad0 <argint>
80105a2f:	83 c4 10             	add    $0x10,%esp
80105a32:	85 c0                	test   %eax,%eax
80105a34:	78 1a                	js     80105a50 <sys_clone+0x60>
  return clone((void *)func, (void*)arg, (void*)stack);
80105a36:	83 ec 04             	sub    $0x4,%esp
80105a39:	ff 75 f4             	pushl  -0xc(%ebp)
80105a3c:	ff 75 f0             	pushl  -0x10(%ebp)
80105a3f:	ff 75 ec             	pushl  -0x14(%ebp)
80105a42:	e8 89 e9 ff ff       	call   801043d0 <clone>
80105a47:	83 c4 10             	add    $0x10,%esp
}
80105a4a:	c9                   	leave  
80105a4b:	c3                   	ret    
80105a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a50:	c9                   	leave  
  if(argint(0, &func) < 0) return -1;
80105a51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a56:	c3                   	ret    
80105a57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a5e:	66 90                	xchg   %ax,%ax

80105a60 <sys_join>:

int sys_join(void) 
{
80105a60:	f3 0f 1e fb          	endbr32 
80105a64:	55                   	push   %ebp
80105a65:	89 e5                	mov    %esp,%ebp
80105a67:	83 ec 20             	sub    $0x20,%esp
  int n;
  if(argint(0, &n) < 0) return -1;
80105a6a:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a6d:	50                   	push   %eax
80105a6e:	6a 00                	push   $0x0
80105a70:	e8 5b f0 ff ff       	call   80104ad0 <argint>
80105a75:	83 c4 10             	add    $0x10,%esp
80105a78:	85 c0                	test   %eax,%eax
80105a7a:	78 14                	js     80105a90 <sys_join+0x30>
  return join(n);
80105a7c:	83 ec 0c             	sub    $0xc,%esp
80105a7f:	ff 75 f4             	pushl  -0xc(%ebp)
80105a82:	e8 69 ea ff ff       	call   801044f0 <join>
80105a87:	83 c4 10             	add    $0x10,%esp
}
80105a8a:	c9                   	leave  
80105a8b:	c3                   	ret    
80105a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a90:	c9                   	leave  
  if(argint(0, &n) < 0) return -1;
80105a91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a96:	c3                   	ret    
80105a97:	66 90                	xchg   %ax,%ax
80105a99:	66 90                	xchg   %ax,%ax
80105a9b:	66 90                	xchg   %ax,%ax
80105a9d:	66 90                	xchg   %ax,%ax
80105a9f:	90                   	nop

80105aa0 <timerinit>:
80105aa0:	f3 0f 1e fb          	endbr32 
80105aa4:	55                   	push   %ebp
80105aa5:	b8 34 00 00 00       	mov    $0x34,%eax
80105aaa:	ba 43 00 00 00       	mov    $0x43,%edx
80105aaf:	89 e5                	mov    %esp,%ebp
80105ab1:	83 ec 14             	sub    $0x14,%esp
80105ab4:	ee                   	out    %al,(%dx)
80105ab5:	ba 40 00 00 00       	mov    $0x40,%edx
80105aba:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
80105abf:	ee                   	out    %al,(%dx)
80105ac0:	b8 2e 00 00 00       	mov    $0x2e,%eax
80105ac5:	ee                   	out    %al,(%dx)
80105ac6:	6a 00                	push   $0x0
80105ac8:	e8 c3 d9 ff ff       	call   80103490 <picenable>
80105acd:	83 c4 10             	add    $0x10,%esp
80105ad0:	c9                   	leave  
80105ad1:	c3                   	ret    

80105ad2 <alltraps>:
80105ad2:	1e                   	push   %ds
80105ad3:	06                   	push   %es
80105ad4:	0f a0                	push   %fs
80105ad6:	0f a8                	push   %gs
80105ad8:	60                   	pusha  
80105ad9:	66 b8 10 00          	mov    $0x10,%ax
80105add:	8e d8                	mov    %eax,%ds
80105adf:	8e c0                	mov    %eax,%es
80105ae1:	66 b8 18 00          	mov    $0x18,%ax
80105ae5:	8e e0                	mov    %eax,%fs
80105ae7:	8e e8                	mov    %eax,%gs
80105ae9:	54                   	push   %esp
80105aea:	e8 c1 00 00 00       	call   80105bb0 <trap>
80105aef:	83 c4 04             	add    $0x4,%esp

80105af2 <trapret>:
80105af2:	61                   	popa   
80105af3:	0f a9                	pop    %gs
80105af5:	0f a1                	pop    %fs
80105af7:	07                   	pop    %es
80105af8:	1f                   	pop    %ds
80105af9:	83 c4 08             	add    $0x8,%esp
80105afc:	cf                   	iret   
80105afd:	66 90                	xchg   %ax,%ax
80105aff:	90                   	nop

80105b00 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105b00:	f3 0f 1e fb          	endbr32 
80105b04:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105b05:	31 c0                	xor    %eax,%eax
{
80105b07:	89 e5                	mov    %esp,%ebp
80105b09:	83 ec 08             	sub    $0x8,%esp
80105b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105b10:	8b 14 85 0c a0 10 80 	mov    -0x7fef5ff4(,%eax,4),%edx
80105b17:	c7 04 c5 62 3a 11 80 	movl   $0x8e000008,-0x7feec59e(,%eax,8)
80105b1e:	08 00 00 8e 
80105b22:	66 89 14 c5 60 3a 11 	mov    %dx,-0x7feec5a0(,%eax,8)
80105b29:	80 
80105b2a:	c1 ea 10             	shr    $0x10,%edx
80105b2d:	66 89 14 c5 66 3a 11 	mov    %dx,-0x7feec59a(,%eax,8)
80105b34:	80 
  for(i = 0; i < 256; i++)
80105b35:	83 c0 01             	add    $0x1,%eax
80105b38:	3d 00 01 00 00       	cmp    $0x100,%eax
80105b3d:	75 d1                	jne    80105b10 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80105b3f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105b42:	a1 0c a1 10 80       	mov    0x8010a10c,%eax
80105b47:	c7 05 62 3c 11 80 08 	movl   $0xef000008,0x80113c62
80105b4e:	00 00 ef 
  initlock(&tickslock, "time");
80105b51:	68 81 7a 10 80       	push   $0x80107a81
80105b56:	68 20 3a 11 80       	push   $0x80113a20
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105b5b:	66 a3 60 3c 11 80    	mov    %ax,0x80113c60
80105b61:	c1 e8 10             	shr    $0x10,%eax
80105b64:	66 a3 66 3c 11 80    	mov    %ax,0x80113c66
  initlock(&tickslock, "time");
80105b6a:	e8 41 ea ff ff       	call   801045b0 <initlock>
}
80105b6f:	83 c4 10             	add    $0x10,%esp
80105b72:	c9                   	leave  
80105b73:	c3                   	ret    
80105b74:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b7f:	90                   	nop

80105b80 <idtinit>:

void
idtinit(void)
{
80105b80:	f3 0f 1e fb          	endbr32 
80105b84:	55                   	push   %ebp
  pd[0] = size-1;
80105b85:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105b8a:	89 e5                	mov    %esp,%ebp
80105b8c:	83 ec 10             	sub    $0x10,%esp
80105b8f:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105b93:	b8 60 3a 11 80       	mov    $0x80113a60,%eax
80105b98:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105b9c:	c1 e8 10             	shr    $0x10,%eax
80105b9f:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105ba3:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105ba6:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105ba9:	c9                   	leave  
80105baa:	c3                   	ret    
80105bab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105baf:	90                   	nop

80105bb0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105bb0:	f3 0f 1e fb          	endbr32 
80105bb4:	55                   	push   %ebp
80105bb5:	89 e5                	mov    %esp,%ebp
80105bb7:	57                   	push   %edi
80105bb8:	56                   	push   %esi
80105bb9:	53                   	push   %ebx
80105bba:	83 ec 0c             	sub    $0xc,%esp
80105bbd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105bc0:	8b 43 30             	mov    0x30(%ebx),%eax
80105bc3:	83 f8 40             	cmp    $0x40,%eax
80105bc6:	0f 84 e4 00 00 00    	je     80105cb0 <trap+0x100>
    if(proc->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105bcc:	83 e8 20             	sub    $0x20,%eax
80105bcf:	83 f8 1f             	cmp    $0x1f,%eax
80105bd2:	77 59                	ja     80105c2d <trap+0x7d>
80105bd4:	3e ff 24 85 28 7b 10 	notrack jmp *-0x7fef84d8(,%eax,4)
80105bdb:	80 
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
80105bdc:	e8 cf cc ff ff       	call   801028b0 <cpunum>
80105be1:	85 c0                	test   %eax,%eax
80105be3:	0f 84 af 01 00 00    	je     80105d98 <trap+0x1e8>
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
    lapiceoi();
80105be9:	e8 62 cd ff ff       	call   80102950 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105bee:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105bf4:	85 c0                	test   %eax,%eax
80105bf6:	74 2d                	je     80105c25 <trap+0x75>
80105bf8:	8b 50 24             	mov    0x24(%eax),%edx
80105bfb:	85 d2                	test   %edx,%edx
80105bfd:	0f 85 80 00 00 00    	jne    80105c83 <trap+0xd3>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105c03:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105c07:	0f 84 63 01 00 00    	je     80105d70 <trap+0x1c0>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105c0d:	8b 40 24             	mov    0x24(%eax),%eax
80105c10:	85 c0                	test   %eax,%eax
80105c12:	74 11                	je     80105c25 <trap+0x75>
80105c14:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105c18:	83 e0 03             	and    $0x3,%eax
80105c1b:	66 83 f8 03          	cmp    $0x3,%ax
80105c1f:	0f 84 b5 00 00 00    	je     80105cda <trap+0x12a>
    exit();
}
80105c25:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c28:	5b                   	pop    %ebx
80105c29:	5e                   	pop    %esi
80105c2a:	5f                   	pop    %edi
80105c2b:	5d                   	pop    %ebp
80105c2c:	c3                   	ret    
    if(proc == 0 || (tf->cs&3) == 0){
80105c2d:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
80105c34:	8b 73 38             	mov    0x38(%ebx),%esi
80105c37:	85 c9                	test   %ecx,%ecx
80105c39:	0f 84 8d 01 00 00    	je     80105dcc <trap+0x21c>
80105c3f:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105c43:	0f 84 83 01 00 00    	je     80105dcc <trap+0x21c>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105c49:	0f 20 d7             	mov    %cr2,%edi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105c4c:	e8 5f cc ff ff       	call   801028b0 <cpunum>
80105c51:	57                   	push   %edi
80105c52:	89 c2                	mov    %eax,%edx
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80105c54:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105c5a:	56                   	push   %esi
80105c5b:	52                   	push   %edx
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80105c5c:	8d 50 6c             	lea    0x6c(%eax),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105c5f:	ff 73 34             	pushl  0x34(%ebx)
80105c62:	ff 73 30             	pushl  0x30(%ebx)
80105c65:	52                   	push   %edx
80105c66:	ff 70 10             	pushl  0x10(%eax)
80105c69:	68 e4 7a 10 80       	push   $0x80107ae4
80105c6e:	e8 2d aa ff ff       	call   801006a0 <cprintf>
    proc->killed = 1;
80105c73:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105c79:	83 c4 20             	add    $0x20,%esp
80105c7c:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105c83:	0f b7 53 3c          	movzwl 0x3c(%ebx),%edx
80105c87:	83 e2 03             	and    $0x3,%edx
80105c8a:	66 83 fa 03          	cmp    $0x3,%dx
80105c8e:	0f 85 6f ff ff ff    	jne    80105c03 <trap+0x53>
    exit();
80105c94:	e8 87 e1 ff ff       	call   80103e20 <exit>
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105c99:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105c9f:	85 c0                	test   %eax,%eax
80105ca1:	0f 85 5c ff ff ff    	jne    80105c03 <trap+0x53>
80105ca7:	e9 79 ff ff ff       	jmp    80105c25 <trap+0x75>
80105cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed)
80105cb0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105cb6:	8b 70 24             	mov    0x24(%eax),%esi
80105cb9:	85 f6                	test   %esi,%esi
80105cbb:	0f 85 9f 00 00 00    	jne    80105d60 <trap+0x1b0>
    proc->tf = tf;
80105cc1:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105cc4:	e8 17 ef ff ff       	call   80104be0 <syscall>
    if(proc->killed)
80105cc9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105ccf:	8b 58 24             	mov    0x24(%eax),%ebx
80105cd2:	85 db                	test   %ebx,%ebx
80105cd4:	0f 84 4b ff ff ff    	je     80105c25 <trap+0x75>
}
80105cda:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cdd:	5b                   	pop    %ebx
80105cde:	5e                   	pop    %esi
80105cdf:	5f                   	pop    %edi
80105ce0:	5d                   	pop    %ebp
      exit();
80105ce1:	e9 3a e1 ff ff       	jmp    80103e20 <exit>
    ideintr();
80105ce6:	e8 e5 c4 ff ff       	call   801021d0 <ideintr>
    lapiceoi();
80105ceb:	e8 60 cc ff ff       	call   80102950 <lapiceoi>
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105cf0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105cf6:	85 c0                	test   %eax,%eax
80105cf8:	0f 85 fa fe ff ff    	jne    80105bf8 <trap+0x48>
80105cfe:	e9 22 ff ff ff       	jmp    80105c25 <trap+0x75>
    kbdintr();
80105d03:	e8 88 ca ff ff       	call   80102790 <kbdintr>
    lapiceoi();
80105d08:	e8 43 cc ff ff       	call   80102950 <lapiceoi>
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105d0d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105d13:	85 c0                	test   %eax,%eax
80105d15:	0f 85 dd fe ff ff    	jne    80105bf8 <trap+0x48>
80105d1b:	e9 05 ff ff ff       	jmp    80105c25 <trap+0x75>
    uartintr();
80105d20:	e8 5b 02 00 00       	call   80105f80 <uartintr>
80105d25:	e9 bf fe ff ff       	jmp    80105be9 <trap+0x39>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105d2a:	8b 7b 38             	mov    0x38(%ebx),%edi
80105d2d:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105d31:	e8 7a cb ff ff       	call   801028b0 <cpunum>
80105d36:	57                   	push   %edi
80105d37:	56                   	push   %esi
80105d38:	50                   	push   %eax
80105d39:	68 8c 7a 10 80       	push   $0x80107a8c
80105d3e:	e8 5d a9 ff ff       	call   801006a0 <cprintf>
    lapiceoi();
80105d43:	e8 08 cc ff ff       	call   80102950 <lapiceoi>
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105d48:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    break;
80105d4e:	83 c4 10             	add    $0x10,%esp
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105d51:	85 c0                	test   %eax,%eax
80105d53:	0f 85 9f fe ff ff    	jne    80105bf8 <trap+0x48>
80105d59:	e9 c7 fe ff ff       	jmp    80105c25 <trap+0x75>
80105d5e:	66 90                	xchg   %ax,%ax
      exit();
80105d60:	e8 bb e0 ff ff       	call   80103e20 <exit>
80105d65:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105d6b:	e9 51 ff ff ff       	jmp    80105cc1 <trap+0x111>
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105d70:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105d74:	0f 85 93 fe ff ff    	jne    80105c0d <trap+0x5d>
    yield();
80105d7a:	e8 71 e2 ff ff       	call   80103ff0 <yield>
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105d7f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105d85:	85 c0                	test   %eax,%eax
80105d87:	0f 85 80 fe ff ff    	jne    80105c0d <trap+0x5d>
80105d8d:	e9 93 fe ff ff       	jmp    80105c25 <trap+0x75>
80105d92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105d98:	83 ec 0c             	sub    $0xc,%esp
80105d9b:	68 20 3a 11 80       	push   $0x80113a20
80105da0:	e8 2b e8 ff ff       	call   801045d0 <acquire>
      wakeup(&ticks);
80105da5:	c7 04 24 60 42 11 80 	movl   $0x80114260,(%esp)
      ticks++;
80105dac:	83 05 60 42 11 80 01 	addl   $0x1,0x80114260
      wakeup(&ticks);
80105db3:	e8 38 e4 ff ff       	call   801041f0 <wakeup>
      release(&tickslock);
80105db8:	c7 04 24 20 3a 11 80 	movl   $0x80113a20,(%esp)
80105dbf:	e8 ec e9 ff ff       	call   801047b0 <release>
80105dc4:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80105dc7:	e9 1d fe ff ff       	jmp    80105be9 <trap+0x39>
80105dcc:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105dcf:	e8 dc ca ff ff       	call   801028b0 <cpunum>
80105dd4:	83 ec 0c             	sub    $0xc,%esp
80105dd7:	57                   	push   %edi
80105dd8:	56                   	push   %esi
80105dd9:	50                   	push   %eax
80105dda:	ff 73 30             	pushl  0x30(%ebx)
80105ddd:	68 b0 7a 10 80       	push   $0x80107ab0
80105de2:	e8 b9 a8 ff ff       	call   801006a0 <cprintf>
      panic("trap");
80105de7:	83 c4 14             	add    $0x14,%esp
80105dea:	68 86 7a 10 80       	push   $0x80107a86
80105def:	e8 8c a5 ff ff       	call   80100380 <panic>
80105df4:	66 90                	xchg   %ax,%ax
80105df6:	66 90                	xchg   %ax,%ax
80105df8:	66 90                	xchg   %ax,%ax
80105dfa:	66 90                	xchg   %ax,%ax
80105dfc:	66 90                	xchg   %ax,%ax
80105dfe:	66 90                	xchg   %ax,%ax

80105e00 <uartgetc>:
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105e00:	f3 0f 1e fb          	endbr32 
  if(!uart)
80105e04:	a1 c0 a5 10 80       	mov    0x8010a5c0,%eax
80105e09:	85 c0                	test   %eax,%eax
80105e0b:	74 1b                	je     80105e28 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105e0d:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105e12:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105e13:	a8 01                	test   $0x1,%al
80105e15:	74 11                	je     80105e28 <uartgetc+0x28>
80105e17:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e1c:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105e1d:	0f b6 c0             	movzbl %al,%eax
80105e20:	c3                   	ret    
80105e21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105e28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e2d:	c3                   	ret    
80105e2e:	66 90                	xchg   %ax,%ax

80105e30 <uartputc.part.0>:
uartputc(int c)
80105e30:	55                   	push   %ebp
80105e31:	89 e5                	mov    %esp,%ebp
80105e33:	57                   	push   %edi
80105e34:	89 c7                	mov    %eax,%edi
80105e36:	56                   	push   %esi
80105e37:	be fd 03 00 00       	mov    $0x3fd,%esi
80105e3c:	53                   	push   %ebx
80105e3d:	bb 80 00 00 00       	mov    $0x80,%ebx
80105e42:	83 ec 0c             	sub    $0xc,%esp
80105e45:	eb 1b                	jmp    80105e62 <uartputc.part.0+0x32>
80105e47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e4e:	66 90                	xchg   %ax,%ax
    microdelay(10);
80105e50:	83 ec 0c             	sub    $0xc,%esp
80105e53:	6a 0a                	push   $0xa
80105e55:	e8 16 cb ff ff       	call   80102970 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105e5a:	83 c4 10             	add    $0x10,%esp
80105e5d:	83 eb 01             	sub    $0x1,%ebx
80105e60:	74 07                	je     80105e69 <uartputc.part.0+0x39>
80105e62:	89 f2                	mov    %esi,%edx
80105e64:	ec                   	in     (%dx),%al
80105e65:	a8 20                	test   $0x20,%al
80105e67:	74 e7                	je     80105e50 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105e69:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e6e:	89 f8                	mov    %edi,%eax
80105e70:	ee                   	out    %al,(%dx)
}
80105e71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e74:	5b                   	pop    %ebx
80105e75:	5e                   	pop    %esi
80105e76:	5f                   	pop    %edi
80105e77:	5d                   	pop    %ebp
80105e78:	c3                   	ret    
80105e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e80 <uartinit>:
{
80105e80:	f3 0f 1e fb          	endbr32 
80105e84:	55                   	push   %ebp
80105e85:	31 c9                	xor    %ecx,%ecx
80105e87:	89 c8                	mov    %ecx,%eax
80105e89:	89 e5                	mov    %esp,%ebp
80105e8b:	57                   	push   %edi
80105e8c:	56                   	push   %esi
80105e8d:	53                   	push   %ebx
80105e8e:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105e93:	89 da                	mov    %ebx,%edx
80105e95:	83 ec 0c             	sub    $0xc,%esp
80105e98:	ee                   	out    %al,(%dx)
80105e99:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105e9e:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105ea3:	89 fa                	mov    %edi,%edx
80105ea5:	ee                   	out    %al,(%dx)
80105ea6:	b8 0c 00 00 00       	mov    $0xc,%eax
80105eab:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105eb0:	ee                   	out    %al,(%dx)
80105eb1:	be f9 03 00 00       	mov    $0x3f9,%esi
80105eb6:	89 c8                	mov    %ecx,%eax
80105eb8:	89 f2                	mov    %esi,%edx
80105eba:	ee                   	out    %al,(%dx)
80105ebb:	b8 03 00 00 00       	mov    $0x3,%eax
80105ec0:	89 fa                	mov    %edi,%edx
80105ec2:	ee                   	out    %al,(%dx)
80105ec3:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105ec8:	89 c8                	mov    %ecx,%eax
80105eca:	ee                   	out    %al,(%dx)
80105ecb:	b8 01 00 00 00       	mov    $0x1,%eax
80105ed0:	89 f2                	mov    %esi,%edx
80105ed2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105ed3:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105ed8:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105ed9:	3c ff                	cmp    $0xff,%al
80105edb:	74 62                	je     80105f3f <uartinit+0xbf>
  uart = 1;
80105edd:	c7 05 c0 a5 10 80 01 	movl   $0x1,0x8010a5c0
80105ee4:	00 00 00 
80105ee7:	89 da                	mov    %ebx,%edx
80105ee9:	ec                   	in     (%dx),%al
80105eea:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105eef:	ec                   	in     (%dx),%al
  picenable(IRQ_COM1);
80105ef0:	83 ec 0c             	sub    $0xc,%esp
  ioapicenable(IRQ_COM1, 0);
80105ef3:	be 76 00 00 00       	mov    $0x76,%esi
  picenable(IRQ_COM1);
80105ef8:	6a 04                	push   $0x4
80105efa:	e8 91 d5 ff ff       	call   80103490 <picenable>
  ioapicenable(IRQ_COM1, 0);
80105eff:	59                   	pop    %ecx
80105f00:	5b                   	pop    %ebx
80105f01:	6a 00                	push   $0x0
80105f03:	6a 04                	push   $0x4
  for(p="xv6...\n"; *p; p++)
80105f05:	bb a8 7b 10 80       	mov    $0x80107ba8,%ebx
  ioapicenable(IRQ_COM1, 0);
80105f0a:	e8 21 c5 ff ff       	call   80102430 <ioapicenable>
80105f0f:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105f12:	b8 78 00 00 00       	mov    $0x78,%eax
80105f17:	eb 0b                	jmp    80105f24 <uartinit+0xa4>
80105f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f20:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
  if(!uart)
80105f24:	8b 15 c0 a5 10 80    	mov    0x8010a5c0,%edx
80105f2a:	85 d2                	test   %edx,%edx
80105f2c:	74 08                	je     80105f36 <uartinit+0xb6>
    uartputc(*p);
80105f2e:	0f be c0             	movsbl %al,%eax
80105f31:	e8 fa fe ff ff       	call   80105e30 <uartputc.part.0>
  for(p="xv6...\n"; *p; p++)
80105f36:	89 f0                	mov    %esi,%eax
80105f38:	83 c3 01             	add    $0x1,%ebx
80105f3b:	84 c0                	test   %al,%al
80105f3d:	75 e1                	jne    80105f20 <uartinit+0xa0>
}
80105f3f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f42:	5b                   	pop    %ebx
80105f43:	5e                   	pop    %esi
80105f44:	5f                   	pop    %edi
80105f45:	5d                   	pop    %ebp
80105f46:	c3                   	ret    
80105f47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f4e:	66 90                	xchg   %ax,%ax

80105f50 <uartputc>:
{
80105f50:	f3 0f 1e fb          	endbr32 
80105f54:	55                   	push   %ebp
  if(!uart)
80105f55:	8b 15 c0 a5 10 80    	mov    0x8010a5c0,%edx
{
80105f5b:	89 e5                	mov    %esp,%ebp
80105f5d:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105f60:	85 d2                	test   %edx,%edx
80105f62:	74 0c                	je     80105f70 <uartputc+0x20>
}
80105f64:	5d                   	pop    %ebp
80105f65:	e9 c6 fe ff ff       	jmp    80105e30 <uartputc.part.0>
80105f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105f70:	5d                   	pop    %ebp
80105f71:	c3                   	ret    
80105f72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105f80 <uartintr>:

void
uartintr(void)
{
80105f80:	f3 0f 1e fb          	endbr32 
80105f84:	55                   	push   %ebp
80105f85:	89 e5                	mov    %esp,%ebp
80105f87:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105f8a:	68 00 5e 10 80       	push   $0x80105e00
80105f8f:	e8 bc a8 ff ff       	call   80100850 <consoleintr>
}
80105f94:	83 c4 10             	add    $0x10,%esp
80105f97:	c9                   	leave  
80105f98:	c3                   	ret    

80105f99 <vector0>:
80105f99:	6a 00                	push   $0x0
80105f9b:	6a 00                	push   $0x0
80105f9d:	e9 30 fb ff ff       	jmp    80105ad2 <alltraps>

80105fa2 <vector1>:
80105fa2:	6a 00                	push   $0x0
80105fa4:	6a 01                	push   $0x1
80105fa6:	e9 27 fb ff ff       	jmp    80105ad2 <alltraps>

80105fab <vector2>:
80105fab:	6a 00                	push   $0x0
80105fad:	6a 02                	push   $0x2
80105faf:	e9 1e fb ff ff       	jmp    80105ad2 <alltraps>

80105fb4 <vector3>:
80105fb4:	6a 00                	push   $0x0
80105fb6:	6a 03                	push   $0x3
80105fb8:	e9 15 fb ff ff       	jmp    80105ad2 <alltraps>

80105fbd <vector4>:
80105fbd:	6a 00                	push   $0x0
80105fbf:	6a 04                	push   $0x4
80105fc1:	e9 0c fb ff ff       	jmp    80105ad2 <alltraps>

80105fc6 <vector5>:
80105fc6:	6a 00                	push   $0x0
80105fc8:	6a 05                	push   $0x5
80105fca:	e9 03 fb ff ff       	jmp    80105ad2 <alltraps>

80105fcf <vector6>:
80105fcf:	6a 00                	push   $0x0
80105fd1:	6a 06                	push   $0x6
80105fd3:	e9 fa fa ff ff       	jmp    80105ad2 <alltraps>

80105fd8 <vector7>:
80105fd8:	6a 00                	push   $0x0
80105fda:	6a 07                	push   $0x7
80105fdc:	e9 f1 fa ff ff       	jmp    80105ad2 <alltraps>

80105fe1 <vector8>:
80105fe1:	6a 08                	push   $0x8
80105fe3:	e9 ea fa ff ff       	jmp    80105ad2 <alltraps>

80105fe8 <vector9>:
80105fe8:	6a 00                	push   $0x0
80105fea:	6a 09                	push   $0x9
80105fec:	e9 e1 fa ff ff       	jmp    80105ad2 <alltraps>

80105ff1 <vector10>:
80105ff1:	6a 0a                	push   $0xa
80105ff3:	e9 da fa ff ff       	jmp    80105ad2 <alltraps>

80105ff8 <vector11>:
80105ff8:	6a 0b                	push   $0xb
80105ffa:	e9 d3 fa ff ff       	jmp    80105ad2 <alltraps>

80105fff <vector12>:
80105fff:	6a 0c                	push   $0xc
80106001:	e9 cc fa ff ff       	jmp    80105ad2 <alltraps>

80106006 <vector13>:
80106006:	6a 0d                	push   $0xd
80106008:	e9 c5 fa ff ff       	jmp    80105ad2 <alltraps>

8010600d <vector14>:
8010600d:	6a 0e                	push   $0xe
8010600f:	e9 be fa ff ff       	jmp    80105ad2 <alltraps>

80106014 <vector15>:
80106014:	6a 00                	push   $0x0
80106016:	6a 0f                	push   $0xf
80106018:	e9 b5 fa ff ff       	jmp    80105ad2 <alltraps>

8010601d <vector16>:
8010601d:	6a 00                	push   $0x0
8010601f:	6a 10                	push   $0x10
80106021:	e9 ac fa ff ff       	jmp    80105ad2 <alltraps>

80106026 <vector17>:
80106026:	6a 11                	push   $0x11
80106028:	e9 a5 fa ff ff       	jmp    80105ad2 <alltraps>

8010602d <vector18>:
8010602d:	6a 00                	push   $0x0
8010602f:	6a 12                	push   $0x12
80106031:	e9 9c fa ff ff       	jmp    80105ad2 <alltraps>

80106036 <vector19>:
80106036:	6a 00                	push   $0x0
80106038:	6a 13                	push   $0x13
8010603a:	e9 93 fa ff ff       	jmp    80105ad2 <alltraps>

8010603f <vector20>:
8010603f:	6a 00                	push   $0x0
80106041:	6a 14                	push   $0x14
80106043:	e9 8a fa ff ff       	jmp    80105ad2 <alltraps>

80106048 <vector21>:
80106048:	6a 00                	push   $0x0
8010604a:	6a 15                	push   $0x15
8010604c:	e9 81 fa ff ff       	jmp    80105ad2 <alltraps>

80106051 <vector22>:
80106051:	6a 00                	push   $0x0
80106053:	6a 16                	push   $0x16
80106055:	e9 78 fa ff ff       	jmp    80105ad2 <alltraps>

8010605a <vector23>:
8010605a:	6a 00                	push   $0x0
8010605c:	6a 17                	push   $0x17
8010605e:	e9 6f fa ff ff       	jmp    80105ad2 <alltraps>

80106063 <vector24>:
80106063:	6a 00                	push   $0x0
80106065:	6a 18                	push   $0x18
80106067:	e9 66 fa ff ff       	jmp    80105ad2 <alltraps>

8010606c <vector25>:
8010606c:	6a 00                	push   $0x0
8010606e:	6a 19                	push   $0x19
80106070:	e9 5d fa ff ff       	jmp    80105ad2 <alltraps>

80106075 <vector26>:
80106075:	6a 00                	push   $0x0
80106077:	6a 1a                	push   $0x1a
80106079:	e9 54 fa ff ff       	jmp    80105ad2 <alltraps>

8010607e <vector27>:
8010607e:	6a 00                	push   $0x0
80106080:	6a 1b                	push   $0x1b
80106082:	e9 4b fa ff ff       	jmp    80105ad2 <alltraps>

80106087 <vector28>:
80106087:	6a 00                	push   $0x0
80106089:	6a 1c                	push   $0x1c
8010608b:	e9 42 fa ff ff       	jmp    80105ad2 <alltraps>

80106090 <vector29>:
80106090:	6a 00                	push   $0x0
80106092:	6a 1d                	push   $0x1d
80106094:	e9 39 fa ff ff       	jmp    80105ad2 <alltraps>

80106099 <vector30>:
80106099:	6a 00                	push   $0x0
8010609b:	6a 1e                	push   $0x1e
8010609d:	e9 30 fa ff ff       	jmp    80105ad2 <alltraps>

801060a2 <vector31>:
801060a2:	6a 00                	push   $0x0
801060a4:	6a 1f                	push   $0x1f
801060a6:	e9 27 fa ff ff       	jmp    80105ad2 <alltraps>

801060ab <vector32>:
801060ab:	6a 00                	push   $0x0
801060ad:	6a 20                	push   $0x20
801060af:	e9 1e fa ff ff       	jmp    80105ad2 <alltraps>

801060b4 <vector33>:
801060b4:	6a 00                	push   $0x0
801060b6:	6a 21                	push   $0x21
801060b8:	e9 15 fa ff ff       	jmp    80105ad2 <alltraps>

801060bd <vector34>:
801060bd:	6a 00                	push   $0x0
801060bf:	6a 22                	push   $0x22
801060c1:	e9 0c fa ff ff       	jmp    80105ad2 <alltraps>

801060c6 <vector35>:
801060c6:	6a 00                	push   $0x0
801060c8:	6a 23                	push   $0x23
801060ca:	e9 03 fa ff ff       	jmp    80105ad2 <alltraps>

801060cf <vector36>:
801060cf:	6a 00                	push   $0x0
801060d1:	6a 24                	push   $0x24
801060d3:	e9 fa f9 ff ff       	jmp    80105ad2 <alltraps>

801060d8 <vector37>:
801060d8:	6a 00                	push   $0x0
801060da:	6a 25                	push   $0x25
801060dc:	e9 f1 f9 ff ff       	jmp    80105ad2 <alltraps>

801060e1 <vector38>:
801060e1:	6a 00                	push   $0x0
801060e3:	6a 26                	push   $0x26
801060e5:	e9 e8 f9 ff ff       	jmp    80105ad2 <alltraps>

801060ea <vector39>:
801060ea:	6a 00                	push   $0x0
801060ec:	6a 27                	push   $0x27
801060ee:	e9 df f9 ff ff       	jmp    80105ad2 <alltraps>

801060f3 <vector40>:
801060f3:	6a 00                	push   $0x0
801060f5:	6a 28                	push   $0x28
801060f7:	e9 d6 f9 ff ff       	jmp    80105ad2 <alltraps>

801060fc <vector41>:
801060fc:	6a 00                	push   $0x0
801060fe:	6a 29                	push   $0x29
80106100:	e9 cd f9 ff ff       	jmp    80105ad2 <alltraps>

80106105 <vector42>:
80106105:	6a 00                	push   $0x0
80106107:	6a 2a                	push   $0x2a
80106109:	e9 c4 f9 ff ff       	jmp    80105ad2 <alltraps>

8010610e <vector43>:
8010610e:	6a 00                	push   $0x0
80106110:	6a 2b                	push   $0x2b
80106112:	e9 bb f9 ff ff       	jmp    80105ad2 <alltraps>

80106117 <vector44>:
80106117:	6a 00                	push   $0x0
80106119:	6a 2c                	push   $0x2c
8010611b:	e9 b2 f9 ff ff       	jmp    80105ad2 <alltraps>

80106120 <vector45>:
80106120:	6a 00                	push   $0x0
80106122:	6a 2d                	push   $0x2d
80106124:	e9 a9 f9 ff ff       	jmp    80105ad2 <alltraps>

80106129 <vector46>:
80106129:	6a 00                	push   $0x0
8010612b:	6a 2e                	push   $0x2e
8010612d:	e9 a0 f9 ff ff       	jmp    80105ad2 <alltraps>

80106132 <vector47>:
80106132:	6a 00                	push   $0x0
80106134:	6a 2f                	push   $0x2f
80106136:	e9 97 f9 ff ff       	jmp    80105ad2 <alltraps>

8010613b <vector48>:
8010613b:	6a 00                	push   $0x0
8010613d:	6a 30                	push   $0x30
8010613f:	e9 8e f9 ff ff       	jmp    80105ad2 <alltraps>

80106144 <vector49>:
80106144:	6a 00                	push   $0x0
80106146:	6a 31                	push   $0x31
80106148:	e9 85 f9 ff ff       	jmp    80105ad2 <alltraps>

8010614d <vector50>:
8010614d:	6a 00                	push   $0x0
8010614f:	6a 32                	push   $0x32
80106151:	e9 7c f9 ff ff       	jmp    80105ad2 <alltraps>

80106156 <vector51>:
80106156:	6a 00                	push   $0x0
80106158:	6a 33                	push   $0x33
8010615a:	e9 73 f9 ff ff       	jmp    80105ad2 <alltraps>

8010615f <vector52>:
8010615f:	6a 00                	push   $0x0
80106161:	6a 34                	push   $0x34
80106163:	e9 6a f9 ff ff       	jmp    80105ad2 <alltraps>

80106168 <vector53>:
80106168:	6a 00                	push   $0x0
8010616a:	6a 35                	push   $0x35
8010616c:	e9 61 f9 ff ff       	jmp    80105ad2 <alltraps>

80106171 <vector54>:
80106171:	6a 00                	push   $0x0
80106173:	6a 36                	push   $0x36
80106175:	e9 58 f9 ff ff       	jmp    80105ad2 <alltraps>

8010617a <vector55>:
8010617a:	6a 00                	push   $0x0
8010617c:	6a 37                	push   $0x37
8010617e:	e9 4f f9 ff ff       	jmp    80105ad2 <alltraps>

80106183 <vector56>:
80106183:	6a 00                	push   $0x0
80106185:	6a 38                	push   $0x38
80106187:	e9 46 f9 ff ff       	jmp    80105ad2 <alltraps>

8010618c <vector57>:
8010618c:	6a 00                	push   $0x0
8010618e:	6a 39                	push   $0x39
80106190:	e9 3d f9 ff ff       	jmp    80105ad2 <alltraps>

80106195 <vector58>:
80106195:	6a 00                	push   $0x0
80106197:	6a 3a                	push   $0x3a
80106199:	e9 34 f9 ff ff       	jmp    80105ad2 <alltraps>

8010619e <vector59>:
8010619e:	6a 00                	push   $0x0
801061a0:	6a 3b                	push   $0x3b
801061a2:	e9 2b f9 ff ff       	jmp    80105ad2 <alltraps>

801061a7 <vector60>:
801061a7:	6a 00                	push   $0x0
801061a9:	6a 3c                	push   $0x3c
801061ab:	e9 22 f9 ff ff       	jmp    80105ad2 <alltraps>

801061b0 <vector61>:
801061b0:	6a 00                	push   $0x0
801061b2:	6a 3d                	push   $0x3d
801061b4:	e9 19 f9 ff ff       	jmp    80105ad2 <alltraps>

801061b9 <vector62>:
801061b9:	6a 00                	push   $0x0
801061bb:	6a 3e                	push   $0x3e
801061bd:	e9 10 f9 ff ff       	jmp    80105ad2 <alltraps>

801061c2 <vector63>:
801061c2:	6a 00                	push   $0x0
801061c4:	6a 3f                	push   $0x3f
801061c6:	e9 07 f9 ff ff       	jmp    80105ad2 <alltraps>

801061cb <vector64>:
801061cb:	6a 00                	push   $0x0
801061cd:	6a 40                	push   $0x40
801061cf:	e9 fe f8 ff ff       	jmp    80105ad2 <alltraps>

801061d4 <vector65>:
801061d4:	6a 00                	push   $0x0
801061d6:	6a 41                	push   $0x41
801061d8:	e9 f5 f8 ff ff       	jmp    80105ad2 <alltraps>

801061dd <vector66>:
801061dd:	6a 00                	push   $0x0
801061df:	6a 42                	push   $0x42
801061e1:	e9 ec f8 ff ff       	jmp    80105ad2 <alltraps>

801061e6 <vector67>:
801061e6:	6a 00                	push   $0x0
801061e8:	6a 43                	push   $0x43
801061ea:	e9 e3 f8 ff ff       	jmp    80105ad2 <alltraps>

801061ef <vector68>:
801061ef:	6a 00                	push   $0x0
801061f1:	6a 44                	push   $0x44
801061f3:	e9 da f8 ff ff       	jmp    80105ad2 <alltraps>

801061f8 <vector69>:
801061f8:	6a 00                	push   $0x0
801061fa:	6a 45                	push   $0x45
801061fc:	e9 d1 f8 ff ff       	jmp    80105ad2 <alltraps>

80106201 <vector70>:
80106201:	6a 00                	push   $0x0
80106203:	6a 46                	push   $0x46
80106205:	e9 c8 f8 ff ff       	jmp    80105ad2 <alltraps>

8010620a <vector71>:
8010620a:	6a 00                	push   $0x0
8010620c:	6a 47                	push   $0x47
8010620e:	e9 bf f8 ff ff       	jmp    80105ad2 <alltraps>

80106213 <vector72>:
80106213:	6a 00                	push   $0x0
80106215:	6a 48                	push   $0x48
80106217:	e9 b6 f8 ff ff       	jmp    80105ad2 <alltraps>

8010621c <vector73>:
8010621c:	6a 00                	push   $0x0
8010621e:	6a 49                	push   $0x49
80106220:	e9 ad f8 ff ff       	jmp    80105ad2 <alltraps>

80106225 <vector74>:
80106225:	6a 00                	push   $0x0
80106227:	6a 4a                	push   $0x4a
80106229:	e9 a4 f8 ff ff       	jmp    80105ad2 <alltraps>

8010622e <vector75>:
8010622e:	6a 00                	push   $0x0
80106230:	6a 4b                	push   $0x4b
80106232:	e9 9b f8 ff ff       	jmp    80105ad2 <alltraps>

80106237 <vector76>:
80106237:	6a 00                	push   $0x0
80106239:	6a 4c                	push   $0x4c
8010623b:	e9 92 f8 ff ff       	jmp    80105ad2 <alltraps>

80106240 <vector77>:
80106240:	6a 00                	push   $0x0
80106242:	6a 4d                	push   $0x4d
80106244:	e9 89 f8 ff ff       	jmp    80105ad2 <alltraps>

80106249 <vector78>:
80106249:	6a 00                	push   $0x0
8010624b:	6a 4e                	push   $0x4e
8010624d:	e9 80 f8 ff ff       	jmp    80105ad2 <alltraps>

80106252 <vector79>:
80106252:	6a 00                	push   $0x0
80106254:	6a 4f                	push   $0x4f
80106256:	e9 77 f8 ff ff       	jmp    80105ad2 <alltraps>

8010625b <vector80>:
8010625b:	6a 00                	push   $0x0
8010625d:	6a 50                	push   $0x50
8010625f:	e9 6e f8 ff ff       	jmp    80105ad2 <alltraps>

80106264 <vector81>:
80106264:	6a 00                	push   $0x0
80106266:	6a 51                	push   $0x51
80106268:	e9 65 f8 ff ff       	jmp    80105ad2 <alltraps>

8010626d <vector82>:
8010626d:	6a 00                	push   $0x0
8010626f:	6a 52                	push   $0x52
80106271:	e9 5c f8 ff ff       	jmp    80105ad2 <alltraps>

80106276 <vector83>:
80106276:	6a 00                	push   $0x0
80106278:	6a 53                	push   $0x53
8010627a:	e9 53 f8 ff ff       	jmp    80105ad2 <alltraps>

8010627f <vector84>:
8010627f:	6a 00                	push   $0x0
80106281:	6a 54                	push   $0x54
80106283:	e9 4a f8 ff ff       	jmp    80105ad2 <alltraps>

80106288 <vector85>:
80106288:	6a 00                	push   $0x0
8010628a:	6a 55                	push   $0x55
8010628c:	e9 41 f8 ff ff       	jmp    80105ad2 <alltraps>

80106291 <vector86>:
80106291:	6a 00                	push   $0x0
80106293:	6a 56                	push   $0x56
80106295:	e9 38 f8 ff ff       	jmp    80105ad2 <alltraps>

8010629a <vector87>:
8010629a:	6a 00                	push   $0x0
8010629c:	6a 57                	push   $0x57
8010629e:	e9 2f f8 ff ff       	jmp    80105ad2 <alltraps>

801062a3 <vector88>:
801062a3:	6a 00                	push   $0x0
801062a5:	6a 58                	push   $0x58
801062a7:	e9 26 f8 ff ff       	jmp    80105ad2 <alltraps>

801062ac <vector89>:
801062ac:	6a 00                	push   $0x0
801062ae:	6a 59                	push   $0x59
801062b0:	e9 1d f8 ff ff       	jmp    80105ad2 <alltraps>

801062b5 <vector90>:
801062b5:	6a 00                	push   $0x0
801062b7:	6a 5a                	push   $0x5a
801062b9:	e9 14 f8 ff ff       	jmp    80105ad2 <alltraps>

801062be <vector91>:
801062be:	6a 00                	push   $0x0
801062c0:	6a 5b                	push   $0x5b
801062c2:	e9 0b f8 ff ff       	jmp    80105ad2 <alltraps>

801062c7 <vector92>:
801062c7:	6a 00                	push   $0x0
801062c9:	6a 5c                	push   $0x5c
801062cb:	e9 02 f8 ff ff       	jmp    80105ad2 <alltraps>

801062d0 <vector93>:
801062d0:	6a 00                	push   $0x0
801062d2:	6a 5d                	push   $0x5d
801062d4:	e9 f9 f7 ff ff       	jmp    80105ad2 <alltraps>

801062d9 <vector94>:
801062d9:	6a 00                	push   $0x0
801062db:	6a 5e                	push   $0x5e
801062dd:	e9 f0 f7 ff ff       	jmp    80105ad2 <alltraps>

801062e2 <vector95>:
801062e2:	6a 00                	push   $0x0
801062e4:	6a 5f                	push   $0x5f
801062e6:	e9 e7 f7 ff ff       	jmp    80105ad2 <alltraps>

801062eb <vector96>:
801062eb:	6a 00                	push   $0x0
801062ed:	6a 60                	push   $0x60
801062ef:	e9 de f7 ff ff       	jmp    80105ad2 <alltraps>

801062f4 <vector97>:
801062f4:	6a 00                	push   $0x0
801062f6:	6a 61                	push   $0x61
801062f8:	e9 d5 f7 ff ff       	jmp    80105ad2 <alltraps>

801062fd <vector98>:
801062fd:	6a 00                	push   $0x0
801062ff:	6a 62                	push   $0x62
80106301:	e9 cc f7 ff ff       	jmp    80105ad2 <alltraps>

80106306 <vector99>:
80106306:	6a 00                	push   $0x0
80106308:	6a 63                	push   $0x63
8010630a:	e9 c3 f7 ff ff       	jmp    80105ad2 <alltraps>

8010630f <vector100>:
8010630f:	6a 00                	push   $0x0
80106311:	6a 64                	push   $0x64
80106313:	e9 ba f7 ff ff       	jmp    80105ad2 <alltraps>

80106318 <vector101>:
80106318:	6a 00                	push   $0x0
8010631a:	6a 65                	push   $0x65
8010631c:	e9 b1 f7 ff ff       	jmp    80105ad2 <alltraps>

80106321 <vector102>:
80106321:	6a 00                	push   $0x0
80106323:	6a 66                	push   $0x66
80106325:	e9 a8 f7 ff ff       	jmp    80105ad2 <alltraps>

8010632a <vector103>:
8010632a:	6a 00                	push   $0x0
8010632c:	6a 67                	push   $0x67
8010632e:	e9 9f f7 ff ff       	jmp    80105ad2 <alltraps>

80106333 <vector104>:
80106333:	6a 00                	push   $0x0
80106335:	6a 68                	push   $0x68
80106337:	e9 96 f7 ff ff       	jmp    80105ad2 <alltraps>

8010633c <vector105>:
8010633c:	6a 00                	push   $0x0
8010633e:	6a 69                	push   $0x69
80106340:	e9 8d f7 ff ff       	jmp    80105ad2 <alltraps>

80106345 <vector106>:
80106345:	6a 00                	push   $0x0
80106347:	6a 6a                	push   $0x6a
80106349:	e9 84 f7 ff ff       	jmp    80105ad2 <alltraps>

8010634e <vector107>:
8010634e:	6a 00                	push   $0x0
80106350:	6a 6b                	push   $0x6b
80106352:	e9 7b f7 ff ff       	jmp    80105ad2 <alltraps>

80106357 <vector108>:
80106357:	6a 00                	push   $0x0
80106359:	6a 6c                	push   $0x6c
8010635b:	e9 72 f7 ff ff       	jmp    80105ad2 <alltraps>

80106360 <vector109>:
80106360:	6a 00                	push   $0x0
80106362:	6a 6d                	push   $0x6d
80106364:	e9 69 f7 ff ff       	jmp    80105ad2 <alltraps>

80106369 <vector110>:
80106369:	6a 00                	push   $0x0
8010636b:	6a 6e                	push   $0x6e
8010636d:	e9 60 f7 ff ff       	jmp    80105ad2 <alltraps>

80106372 <vector111>:
80106372:	6a 00                	push   $0x0
80106374:	6a 6f                	push   $0x6f
80106376:	e9 57 f7 ff ff       	jmp    80105ad2 <alltraps>

8010637b <vector112>:
8010637b:	6a 00                	push   $0x0
8010637d:	6a 70                	push   $0x70
8010637f:	e9 4e f7 ff ff       	jmp    80105ad2 <alltraps>

80106384 <vector113>:
80106384:	6a 00                	push   $0x0
80106386:	6a 71                	push   $0x71
80106388:	e9 45 f7 ff ff       	jmp    80105ad2 <alltraps>

8010638d <vector114>:
8010638d:	6a 00                	push   $0x0
8010638f:	6a 72                	push   $0x72
80106391:	e9 3c f7 ff ff       	jmp    80105ad2 <alltraps>

80106396 <vector115>:
80106396:	6a 00                	push   $0x0
80106398:	6a 73                	push   $0x73
8010639a:	e9 33 f7 ff ff       	jmp    80105ad2 <alltraps>

8010639f <vector116>:
8010639f:	6a 00                	push   $0x0
801063a1:	6a 74                	push   $0x74
801063a3:	e9 2a f7 ff ff       	jmp    80105ad2 <alltraps>

801063a8 <vector117>:
801063a8:	6a 00                	push   $0x0
801063aa:	6a 75                	push   $0x75
801063ac:	e9 21 f7 ff ff       	jmp    80105ad2 <alltraps>

801063b1 <vector118>:
801063b1:	6a 00                	push   $0x0
801063b3:	6a 76                	push   $0x76
801063b5:	e9 18 f7 ff ff       	jmp    80105ad2 <alltraps>

801063ba <vector119>:
801063ba:	6a 00                	push   $0x0
801063bc:	6a 77                	push   $0x77
801063be:	e9 0f f7 ff ff       	jmp    80105ad2 <alltraps>

801063c3 <vector120>:
801063c3:	6a 00                	push   $0x0
801063c5:	6a 78                	push   $0x78
801063c7:	e9 06 f7 ff ff       	jmp    80105ad2 <alltraps>

801063cc <vector121>:
801063cc:	6a 00                	push   $0x0
801063ce:	6a 79                	push   $0x79
801063d0:	e9 fd f6 ff ff       	jmp    80105ad2 <alltraps>

801063d5 <vector122>:
801063d5:	6a 00                	push   $0x0
801063d7:	6a 7a                	push   $0x7a
801063d9:	e9 f4 f6 ff ff       	jmp    80105ad2 <alltraps>

801063de <vector123>:
801063de:	6a 00                	push   $0x0
801063e0:	6a 7b                	push   $0x7b
801063e2:	e9 eb f6 ff ff       	jmp    80105ad2 <alltraps>

801063e7 <vector124>:
801063e7:	6a 00                	push   $0x0
801063e9:	6a 7c                	push   $0x7c
801063eb:	e9 e2 f6 ff ff       	jmp    80105ad2 <alltraps>

801063f0 <vector125>:
801063f0:	6a 00                	push   $0x0
801063f2:	6a 7d                	push   $0x7d
801063f4:	e9 d9 f6 ff ff       	jmp    80105ad2 <alltraps>

801063f9 <vector126>:
801063f9:	6a 00                	push   $0x0
801063fb:	6a 7e                	push   $0x7e
801063fd:	e9 d0 f6 ff ff       	jmp    80105ad2 <alltraps>

80106402 <vector127>:
80106402:	6a 00                	push   $0x0
80106404:	6a 7f                	push   $0x7f
80106406:	e9 c7 f6 ff ff       	jmp    80105ad2 <alltraps>

8010640b <vector128>:
8010640b:	6a 00                	push   $0x0
8010640d:	68 80 00 00 00       	push   $0x80
80106412:	e9 bb f6 ff ff       	jmp    80105ad2 <alltraps>

80106417 <vector129>:
80106417:	6a 00                	push   $0x0
80106419:	68 81 00 00 00       	push   $0x81
8010641e:	e9 af f6 ff ff       	jmp    80105ad2 <alltraps>

80106423 <vector130>:
80106423:	6a 00                	push   $0x0
80106425:	68 82 00 00 00       	push   $0x82
8010642a:	e9 a3 f6 ff ff       	jmp    80105ad2 <alltraps>

8010642f <vector131>:
8010642f:	6a 00                	push   $0x0
80106431:	68 83 00 00 00       	push   $0x83
80106436:	e9 97 f6 ff ff       	jmp    80105ad2 <alltraps>

8010643b <vector132>:
8010643b:	6a 00                	push   $0x0
8010643d:	68 84 00 00 00       	push   $0x84
80106442:	e9 8b f6 ff ff       	jmp    80105ad2 <alltraps>

80106447 <vector133>:
80106447:	6a 00                	push   $0x0
80106449:	68 85 00 00 00       	push   $0x85
8010644e:	e9 7f f6 ff ff       	jmp    80105ad2 <alltraps>

80106453 <vector134>:
80106453:	6a 00                	push   $0x0
80106455:	68 86 00 00 00       	push   $0x86
8010645a:	e9 73 f6 ff ff       	jmp    80105ad2 <alltraps>

8010645f <vector135>:
8010645f:	6a 00                	push   $0x0
80106461:	68 87 00 00 00       	push   $0x87
80106466:	e9 67 f6 ff ff       	jmp    80105ad2 <alltraps>

8010646b <vector136>:
8010646b:	6a 00                	push   $0x0
8010646d:	68 88 00 00 00       	push   $0x88
80106472:	e9 5b f6 ff ff       	jmp    80105ad2 <alltraps>

80106477 <vector137>:
80106477:	6a 00                	push   $0x0
80106479:	68 89 00 00 00       	push   $0x89
8010647e:	e9 4f f6 ff ff       	jmp    80105ad2 <alltraps>

80106483 <vector138>:
80106483:	6a 00                	push   $0x0
80106485:	68 8a 00 00 00       	push   $0x8a
8010648a:	e9 43 f6 ff ff       	jmp    80105ad2 <alltraps>

8010648f <vector139>:
8010648f:	6a 00                	push   $0x0
80106491:	68 8b 00 00 00       	push   $0x8b
80106496:	e9 37 f6 ff ff       	jmp    80105ad2 <alltraps>

8010649b <vector140>:
8010649b:	6a 00                	push   $0x0
8010649d:	68 8c 00 00 00       	push   $0x8c
801064a2:	e9 2b f6 ff ff       	jmp    80105ad2 <alltraps>

801064a7 <vector141>:
801064a7:	6a 00                	push   $0x0
801064a9:	68 8d 00 00 00       	push   $0x8d
801064ae:	e9 1f f6 ff ff       	jmp    80105ad2 <alltraps>

801064b3 <vector142>:
801064b3:	6a 00                	push   $0x0
801064b5:	68 8e 00 00 00       	push   $0x8e
801064ba:	e9 13 f6 ff ff       	jmp    80105ad2 <alltraps>

801064bf <vector143>:
801064bf:	6a 00                	push   $0x0
801064c1:	68 8f 00 00 00       	push   $0x8f
801064c6:	e9 07 f6 ff ff       	jmp    80105ad2 <alltraps>

801064cb <vector144>:
801064cb:	6a 00                	push   $0x0
801064cd:	68 90 00 00 00       	push   $0x90
801064d2:	e9 fb f5 ff ff       	jmp    80105ad2 <alltraps>

801064d7 <vector145>:
801064d7:	6a 00                	push   $0x0
801064d9:	68 91 00 00 00       	push   $0x91
801064de:	e9 ef f5 ff ff       	jmp    80105ad2 <alltraps>

801064e3 <vector146>:
801064e3:	6a 00                	push   $0x0
801064e5:	68 92 00 00 00       	push   $0x92
801064ea:	e9 e3 f5 ff ff       	jmp    80105ad2 <alltraps>

801064ef <vector147>:
801064ef:	6a 00                	push   $0x0
801064f1:	68 93 00 00 00       	push   $0x93
801064f6:	e9 d7 f5 ff ff       	jmp    80105ad2 <alltraps>

801064fb <vector148>:
801064fb:	6a 00                	push   $0x0
801064fd:	68 94 00 00 00       	push   $0x94
80106502:	e9 cb f5 ff ff       	jmp    80105ad2 <alltraps>

80106507 <vector149>:
80106507:	6a 00                	push   $0x0
80106509:	68 95 00 00 00       	push   $0x95
8010650e:	e9 bf f5 ff ff       	jmp    80105ad2 <alltraps>

80106513 <vector150>:
80106513:	6a 00                	push   $0x0
80106515:	68 96 00 00 00       	push   $0x96
8010651a:	e9 b3 f5 ff ff       	jmp    80105ad2 <alltraps>

8010651f <vector151>:
8010651f:	6a 00                	push   $0x0
80106521:	68 97 00 00 00       	push   $0x97
80106526:	e9 a7 f5 ff ff       	jmp    80105ad2 <alltraps>

8010652b <vector152>:
8010652b:	6a 00                	push   $0x0
8010652d:	68 98 00 00 00       	push   $0x98
80106532:	e9 9b f5 ff ff       	jmp    80105ad2 <alltraps>

80106537 <vector153>:
80106537:	6a 00                	push   $0x0
80106539:	68 99 00 00 00       	push   $0x99
8010653e:	e9 8f f5 ff ff       	jmp    80105ad2 <alltraps>

80106543 <vector154>:
80106543:	6a 00                	push   $0x0
80106545:	68 9a 00 00 00       	push   $0x9a
8010654a:	e9 83 f5 ff ff       	jmp    80105ad2 <alltraps>

8010654f <vector155>:
8010654f:	6a 00                	push   $0x0
80106551:	68 9b 00 00 00       	push   $0x9b
80106556:	e9 77 f5 ff ff       	jmp    80105ad2 <alltraps>

8010655b <vector156>:
8010655b:	6a 00                	push   $0x0
8010655d:	68 9c 00 00 00       	push   $0x9c
80106562:	e9 6b f5 ff ff       	jmp    80105ad2 <alltraps>

80106567 <vector157>:
80106567:	6a 00                	push   $0x0
80106569:	68 9d 00 00 00       	push   $0x9d
8010656e:	e9 5f f5 ff ff       	jmp    80105ad2 <alltraps>

80106573 <vector158>:
80106573:	6a 00                	push   $0x0
80106575:	68 9e 00 00 00       	push   $0x9e
8010657a:	e9 53 f5 ff ff       	jmp    80105ad2 <alltraps>

8010657f <vector159>:
8010657f:	6a 00                	push   $0x0
80106581:	68 9f 00 00 00       	push   $0x9f
80106586:	e9 47 f5 ff ff       	jmp    80105ad2 <alltraps>

8010658b <vector160>:
8010658b:	6a 00                	push   $0x0
8010658d:	68 a0 00 00 00       	push   $0xa0
80106592:	e9 3b f5 ff ff       	jmp    80105ad2 <alltraps>

80106597 <vector161>:
80106597:	6a 00                	push   $0x0
80106599:	68 a1 00 00 00       	push   $0xa1
8010659e:	e9 2f f5 ff ff       	jmp    80105ad2 <alltraps>

801065a3 <vector162>:
801065a3:	6a 00                	push   $0x0
801065a5:	68 a2 00 00 00       	push   $0xa2
801065aa:	e9 23 f5 ff ff       	jmp    80105ad2 <alltraps>

801065af <vector163>:
801065af:	6a 00                	push   $0x0
801065b1:	68 a3 00 00 00       	push   $0xa3
801065b6:	e9 17 f5 ff ff       	jmp    80105ad2 <alltraps>

801065bb <vector164>:
801065bb:	6a 00                	push   $0x0
801065bd:	68 a4 00 00 00       	push   $0xa4
801065c2:	e9 0b f5 ff ff       	jmp    80105ad2 <alltraps>

801065c7 <vector165>:
801065c7:	6a 00                	push   $0x0
801065c9:	68 a5 00 00 00       	push   $0xa5
801065ce:	e9 ff f4 ff ff       	jmp    80105ad2 <alltraps>

801065d3 <vector166>:
801065d3:	6a 00                	push   $0x0
801065d5:	68 a6 00 00 00       	push   $0xa6
801065da:	e9 f3 f4 ff ff       	jmp    80105ad2 <alltraps>

801065df <vector167>:
801065df:	6a 00                	push   $0x0
801065e1:	68 a7 00 00 00       	push   $0xa7
801065e6:	e9 e7 f4 ff ff       	jmp    80105ad2 <alltraps>

801065eb <vector168>:
801065eb:	6a 00                	push   $0x0
801065ed:	68 a8 00 00 00       	push   $0xa8
801065f2:	e9 db f4 ff ff       	jmp    80105ad2 <alltraps>

801065f7 <vector169>:
801065f7:	6a 00                	push   $0x0
801065f9:	68 a9 00 00 00       	push   $0xa9
801065fe:	e9 cf f4 ff ff       	jmp    80105ad2 <alltraps>

80106603 <vector170>:
80106603:	6a 00                	push   $0x0
80106605:	68 aa 00 00 00       	push   $0xaa
8010660a:	e9 c3 f4 ff ff       	jmp    80105ad2 <alltraps>

8010660f <vector171>:
8010660f:	6a 00                	push   $0x0
80106611:	68 ab 00 00 00       	push   $0xab
80106616:	e9 b7 f4 ff ff       	jmp    80105ad2 <alltraps>

8010661b <vector172>:
8010661b:	6a 00                	push   $0x0
8010661d:	68 ac 00 00 00       	push   $0xac
80106622:	e9 ab f4 ff ff       	jmp    80105ad2 <alltraps>

80106627 <vector173>:
80106627:	6a 00                	push   $0x0
80106629:	68 ad 00 00 00       	push   $0xad
8010662e:	e9 9f f4 ff ff       	jmp    80105ad2 <alltraps>

80106633 <vector174>:
80106633:	6a 00                	push   $0x0
80106635:	68 ae 00 00 00       	push   $0xae
8010663a:	e9 93 f4 ff ff       	jmp    80105ad2 <alltraps>

8010663f <vector175>:
8010663f:	6a 00                	push   $0x0
80106641:	68 af 00 00 00       	push   $0xaf
80106646:	e9 87 f4 ff ff       	jmp    80105ad2 <alltraps>

8010664b <vector176>:
8010664b:	6a 00                	push   $0x0
8010664d:	68 b0 00 00 00       	push   $0xb0
80106652:	e9 7b f4 ff ff       	jmp    80105ad2 <alltraps>

80106657 <vector177>:
80106657:	6a 00                	push   $0x0
80106659:	68 b1 00 00 00       	push   $0xb1
8010665e:	e9 6f f4 ff ff       	jmp    80105ad2 <alltraps>

80106663 <vector178>:
80106663:	6a 00                	push   $0x0
80106665:	68 b2 00 00 00       	push   $0xb2
8010666a:	e9 63 f4 ff ff       	jmp    80105ad2 <alltraps>

8010666f <vector179>:
8010666f:	6a 00                	push   $0x0
80106671:	68 b3 00 00 00       	push   $0xb3
80106676:	e9 57 f4 ff ff       	jmp    80105ad2 <alltraps>

8010667b <vector180>:
8010667b:	6a 00                	push   $0x0
8010667d:	68 b4 00 00 00       	push   $0xb4
80106682:	e9 4b f4 ff ff       	jmp    80105ad2 <alltraps>

80106687 <vector181>:
80106687:	6a 00                	push   $0x0
80106689:	68 b5 00 00 00       	push   $0xb5
8010668e:	e9 3f f4 ff ff       	jmp    80105ad2 <alltraps>

80106693 <vector182>:
80106693:	6a 00                	push   $0x0
80106695:	68 b6 00 00 00       	push   $0xb6
8010669a:	e9 33 f4 ff ff       	jmp    80105ad2 <alltraps>

8010669f <vector183>:
8010669f:	6a 00                	push   $0x0
801066a1:	68 b7 00 00 00       	push   $0xb7
801066a6:	e9 27 f4 ff ff       	jmp    80105ad2 <alltraps>

801066ab <vector184>:
801066ab:	6a 00                	push   $0x0
801066ad:	68 b8 00 00 00       	push   $0xb8
801066b2:	e9 1b f4 ff ff       	jmp    80105ad2 <alltraps>

801066b7 <vector185>:
801066b7:	6a 00                	push   $0x0
801066b9:	68 b9 00 00 00       	push   $0xb9
801066be:	e9 0f f4 ff ff       	jmp    80105ad2 <alltraps>

801066c3 <vector186>:
801066c3:	6a 00                	push   $0x0
801066c5:	68 ba 00 00 00       	push   $0xba
801066ca:	e9 03 f4 ff ff       	jmp    80105ad2 <alltraps>

801066cf <vector187>:
801066cf:	6a 00                	push   $0x0
801066d1:	68 bb 00 00 00       	push   $0xbb
801066d6:	e9 f7 f3 ff ff       	jmp    80105ad2 <alltraps>

801066db <vector188>:
801066db:	6a 00                	push   $0x0
801066dd:	68 bc 00 00 00       	push   $0xbc
801066e2:	e9 eb f3 ff ff       	jmp    80105ad2 <alltraps>

801066e7 <vector189>:
801066e7:	6a 00                	push   $0x0
801066e9:	68 bd 00 00 00       	push   $0xbd
801066ee:	e9 df f3 ff ff       	jmp    80105ad2 <alltraps>

801066f3 <vector190>:
801066f3:	6a 00                	push   $0x0
801066f5:	68 be 00 00 00       	push   $0xbe
801066fa:	e9 d3 f3 ff ff       	jmp    80105ad2 <alltraps>

801066ff <vector191>:
801066ff:	6a 00                	push   $0x0
80106701:	68 bf 00 00 00       	push   $0xbf
80106706:	e9 c7 f3 ff ff       	jmp    80105ad2 <alltraps>

8010670b <vector192>:
8010670b:	6a 00                	push   $0x0
8010670d:	68 c0 00 00 00       	push   $0xc0
80106712:	e9 bb f3 ff ff       	jmp    80105ad2 <alltraps>

80106717 <vector193>:
80106717:	6a 00                	push   $0x0
80106719:	68 c1 00 00 00       	push   $0xc1
8010671e:	e9 af f3 ff ff       	jmp    80105ad2 <alltraps>

80106723 <vector194>:
80106723:	6a 00                	push   $0x0
80106725:	68 c2 00 00 00       	push   $0xc2
8010672a:	e9 a3 f3 ff ff       	jmp    80105ad2 <alltraps>

8010672f <vector195>:
8010672f:	6a 00                	push   $0x0
80106731:	68 c3 00 00 00       	push   $0xc3
80106736:	e9 97 f3 ff ff       	jmp    80105ad2 <alltraps>

8010673b <vector196>:
8010673b:	6a 00                	push   $0x0
8010673d:	68 c4 00 00 00       	push   $0xc4
80106742:	e9 8b f3 ff ff       	jmp    80105ad2 <alltraps>

80106747 <vector197>:
80106747:	6a 00                	push   $0x0
80106749:	68 c5 00 00 00       	push   $0xc5
8010674e:	e9 7f f3 ff ff       	jmp    80105ad2 <alltraps>

80106753 <vector198>:
80106753:	6a 00                	push   $0x0
80106755:	68 c6 00 00 00       	push   $0xc6
8010675a:	e9 73 f3 ff ff       	jmp    80105ad2 <alltraps>

8010675f <vector199>:
8010675f:	6a 00                	push   $0x0
80106761:	68 c7 00 00 00       	push   $0xc7
80106766:	e9 67 f3 ff ff       	jmp    80105ad2 <alltraps>

8010676b <vector200>:
8010676b:	6a 00                	push   $0x0
8010676d:	68 c8 00 00 00       	push   $0xc8
80106772:	e9 5b f3 ff ff       	jmp    80105ad2 <alltraps>

80106777 <vector201>:
80106777:	6a 00                	push   $0x0
80106779:	68 c9 00 00 00       	push   $0xc9
8010677e:	e9 4f f3 ff ff       	jmp    80105ad2 <alltraps>

80106783 <vector202>:
80106783:	6a 00                	push   $0x0
80106785:	68 ca 00 00 00       	push   $0xca
8010678a:	e9 43 f3 ff ff       	jmp    80105ad2 <alltraps>

8010678f <vector203>:
8010678f:	6a 00                	push   $0x0
80106791:	68 cb 00 00 00       	push   $0xcb
80106796:	e9 37 f3 ff ff       	jmp    80105ad2 <alltraps>

8010679b <vector204>:
8010679b:	6a 00                	push   $0x0
8010679d:	68 cc 00 00 00       	push   $0xcc
801067a2:	e9 2b f3 ff ff       	jmp    80105ad2 <alltraps>

801067a7 <vector205>:
801067a7:	6a 00                	push   $0x0
801067a9:	68 cd 00 00 00       	push   $0xcd
801067ae:	e9 1f f3 ff ff       	jmp    80105ad2 <alltraps>

801067b3 <vector206>:
801067b3:	6a 00                	push   $0x0
801067b5:	68 ce 00 00 00       	push   $0xce
801067ba:	e9 13 f3 ff ff       	jmp    80105ad2 <alltraps>

801067bf <vector207>:
801067bf:	6a 00                	push   $0x0
801067c1:	68 cf 00 00 00       	push   $0xcf
801067c6:	e9 07 f3 ff ff       	jmp    80105ad2 <alltraps>

801067cb <vector208>:
801067cb:	6a 00                	push   $0x0
801067cd:	68 d0 00 00 00       	push   $0xd0
801067d2:	e9 fb f2 ff ff       	jmp    80105ad2 <alltraps>

801067d7 <vector209>:
801067d7:	6a 00                	push   $0x0
801067d9:	68 d1 00 00 00       	push   $0xd1
801067de:	e9 ef f2 ff ff       	jmp    80105ad2 <alltraps>

801067e3 <vector210>:
801067e3:	6a 00                	push   $0x0
801067e5:	68 d2 00 00 00       	push   $0xd2
801067ea:	e9 e3 f2 ff ff       	jmp    80105ad2 <alltraps>

801067ef <vector211>:
801067ef:	6a 00                	push   $0x0
801067f1:	68 d3 00 00 00       	push   $0xd3
801067f6:	e9 d7 f2 ff ff       	jmp    80105ad2 <alltraps>

801067fb <vector212>:
801067fb:	6a 00                	push   $0x0
801067fd:	68 d4 00 00 00       	push   $0xd4
80106802:	e9 cb f2 ff ff       	jmp    80105ad2 <alltraps>

80106807 <vector213>:
80106807:	6a 00                	push   $0x0
80106809:	68 d5 00 00 00       	push   $0xd5
8010680e:	e9 bf f2 ff ff       	jmp    80105ad2 <alltraps>

80106813 <vector214>:
80106813:	6a 00                	push   $0x0
80106815:	68 d6 00 00 00       	push   $0xd6
8010681a:	e9 b3 f2 ff ff       	jmp    80105ad2 <alltraps>

8010681f <vector215>:
8010681f:	6a 00                	push   $0x0
80106821:	68 d7 00 00 00       	push   $0xd7
80106826:	e9 a7 f2 ff ff       	jmp    80105ad2 <alltraps>

8010682b <vector216>:
8010682b:	6a 00                	push   $0x0
8010682d:	68 d8 00 00 00       	push   $0xd8
80106832:	e9 9b f2 ff ff       	jmp    80105ad2 <alltraps>

80106837 <vector217>:
80106837:	6a 00                	push   $0x0
80106839:	68 d9 00 00 00       	push   $0xd9
8010683e:	e9 8f f2 ff ff       	jmp    80105ad2 <alltraps>

80106843 <vector218>:
80106843:	6a 00                	push   $0x0
80106845:	68 da 00 00 00       	push   $0xda
8010684a:	e9 83 f2 ff ff       	jmp    80105ad2 <alltraps>

8010684f <vector219>:
8010684f:	6a 00                	push   $0x0
80106851:	68 db 00 00 00       	push   $0xdb
80106856:	e9 77 f2 ff ff       	jmp    80105ad2 <alltraps>

8010685b <vector220>:
8010685b:	6a 00                	push   $0x0
8010685d:	68 dc 00 00 00       	push   $0xdc
80106862:	e9 6b f2 ff ff       	jmp    80105ad2 <alltraps>

80106867 <vector221>:
80106867:	6a 00                	push   $0x0
80106869:	68 dd 00 00 00       	push   $0xdd
8010686e:	e9 5f f2 ff ff       	jmp    80105ad2 <alltraps>

80106873 <vector222>:
80106873:	6a 00                	push   $0x0
80106875:	68 de 00 00 00       	push   $0xde
8010687a:	e9 53 f2 ff ff       	jmp    80105ad2 <alltraps>

8010687f <vector223>:
8010687f:	6a 00                	push   $0x0
80106881:	68 df 00 00 00       	push   $0xdf
80106886:	e9 47 f2 ff ff       	jmp    80105ad2 <alltraps>

8010688b <vector224>:
8010688b:	6a 00                	push   $0x0
8010688d:	68 e0 00 00 00       	push   $0xe0
80106892:	e9 3b f2 ff ff       	jmp    80105ad2 <alltraps>

80106897 <vector225>:
80106897:	6a 00                	push   $0x0
80106899:	68 e1 00 00 00       	push   $0xe1
8010689e:	e9 2f f2 ff ff       	jmp    80105ad2 <alltraps>

801068a3 <vector226>:
801068a3:	6a 00                	push   $0x0
801068a5:	68 e2 00 00 00       	push   $0xe2
801068aa:	e9 23 f2 ff ff       	jmp    80105ad2 <alltraps>

801068af <vector227>:
801068af:	6a 00                	push   $0x0
801068b1:	68 e3 00 00 00       	push   $0xe3
801068b6:	e9 17 f2 ff ff       	jmp    80105ad2 <alltraps>

801068bb <vector228>:
801068bb:	6a 00                	push   $0x0
801068bd:	68 e4 00 00 00       	push   $0xe4
801068c2:	e9 0b f2 ff ff       	jmp    80105ad2 <alltraps>

801068c7 <vector229>:
801068c7:	6a 00                	push   $0x0
801068c9:	68 e5 00 00 00       	push   $0xe5
801068ce:	e9 ff f1 ff ff       	jmp    80105ad2 <alltraps>

801068d3 <vector230>:
801068d3:	6a 00                	push   $0x0
801068d5:	68 e6 00 00 00       	push   $0xe6
801068da:	e9 f3 f1 ff ff       	jmp    80105ad2 <alltraps>

801068df <vector231>:
801068df:	6a 00                	push   $0x0
801068e1:	68 e7 00 00 00       	push   $0xe7
801068e6:	e9 e7 f1 ff ff       	jmp    80105ad2 <alltraps>

801068eb <vector232>:
801068eb:	6a 00                	push   $0x0
801068ed:	68 e8 00 00 00       	push   $0xe8
801068f2:	e9 db f1 ff ff       	jmp    80105ad2 <alltraps>

801068f7 <vector233>:
801068f7:	6a 00                	push   $0x0
801068f9:	68 e9 00 00 00       	push   $0xe9
801068fe:	e9 cf f1 ff ff       	jmp    80105ad2 <alltraps>

80106903 <vector234>:
80106903:	6a 00                	push   $0x0
80106905:	68 ea 00 00 00       	push   $0xea
8010690a:	e9 c3 f1 ff ff       	jmp    80105ad2 <alltraps>

8010690f <vector235>:
8010690f:	6a 00                	push   $0x0
80106911:	68 eb 00 00 00       	push   $0xeb
80106916:	e9 b7 f1 ff ff       	jmp    80105ad2 <alltraps>

8010691b <vector236>:
8010691b:	6a 00                	push   $0x0
8010691d:	68 ec 00 00 00       	push   $0xec
80106922:	e9 ab f1 ff ff       	jmp    80105ad2 <alltraps>

80106927 <vector237>:
80106927:	6a 00                	push   $0x0
80106929:	68 ed 00 00 00       	push   $0xed
8010692e:	e9 9f f1 ff ff       	jmp    80105ad2 <alltraps>

80106933 <vector238>:
80106933:	6a 00                	push   $0x0
80106935:	68 ee 00 00 00       	push   $0xee
8010693a:	e9 93 f1 ff ff       	jmp    80105ad2 <alltraps>

8010693f <vector239>:
8010693f:	6a 00                	push   $0x0
80106941:	68 ef 00 00 00       	push   $0xef
80106946:	e9 87 f1 ff ff       	jmp    80105ad2 <alltraps>

8010694b <vector240>:
8010694b:	6a 00                	push   $0x0
8010694d:	68 f0 00 00 00       	push   $0xf0
80106952:	e9 7b f1 ff ff       	jmp    80105ad2 <alltraps>

80106957 <vector241>:
80106957:	6a 00                	push   $0x0
80106959:	68 f1 00 00 00       	push   $0xf1
8010695e:	e9 6f f1 ff ff       	jmp    80105ad2 <alltraps>

80106963 <vector242>:
80106963:	6a 00                	push   $0x0
80106965:	68 f2 00 00 00       	push   $0xf2
8010696a:	e9 63 f1 ff ff       	jmp    80105ad2 <alltraps>

8010696f <vector243>:
8010696f:	6a 00                	push   $0x0
80106971:	68 f3 00 00 00       	push   $0xf3
80106976:	e9 57 f1 ff ff       	jmp    80105ad2 <alltraps>

8010697b <vector244>:
8010697b:	6a 00                	push   $0x0
8010697d:	68 f4 00 00 00       	push   $0xf4
80106982:	e9 4b f1 ff ff       	jmp    80105ad2 <alltraps>

80106987 <vector245>:
80106987:	6a 00                	push   $0x0
80106989:	68 f5 00 00 00       	push   $0xf5
8010698e:	e9 3f f1 ff ff       	jmp    80105ad2 <alltraps>

80106993 <vector246>:
80106993:	6a 00                	push   $0x0
80106995:	68 f6 00 00 00       	push   $0xf6
8010699a:	e9 33 f1 ff ff       	jmp    80105ad2 <alltraps>

8010699f <vector247>:
8010699f:	6a 00                	push   $0x0
801069a1:	68 f7 00 00 00       	push   $0xf7
801069a6:	e9 27 f1 ff ff       	jmp    80105ad2 <alltraps>

801069ab <vector248>:
801069ab:	6a 00                	push   $0x0
801069ad:	68 f8 00 00 00       	push   $0xf8
801069b2:	e9 1b f1 ff ff       	jmp    80105ad2 <alltraps>

801069b7 <vector249>:
801069b7:	6a 00                	push   $0x0
801069b9:	68 f9 00 00 00       	push   $0xf9
801069be:	e9 0f f1 ff ff       	jmp    80105ad2 <alltraps>

801069c3 <vector250>:
801069c3:	6a 00                	push   $0x0
801069c5:	68 fa 00 00 00       	push   $0xfa
801069ca:	e9 03 f1 ff ff       	jmp    80105ad2 <alltraps>

801069cf <vector251>:
801069cf:	6a 00                	push   $0x0
801069d1:	68 fb 00 00 00       	push   $0xfb
801069d6:	e9 f7 f0 ff ff       	jmp    80105ad2 <alltraps>

801069db <vector252>:
801069db:	6a 00                	push   $0x0
801069dd:	68 fc 00 00 00       	push   $0xfc
801069e2:	e9 eb f0 ff ff       	jmp    80105ad2 <alltraps>

801069e7 <vector253>:
801069e7:	6a 00                	push   $0x0
801069e9:	68 fd 00 00 00       	push   $0xfd
801069ee:	e9 df f0 ff ff       	jmp    80105ad2 <alltraps>

801069f3 <vector254>:
801069f3:	6a 00                	push   $0x0
801069f5:	68 fe 00 00 00       	push   $0xfe
801069fa:	e9 d3 f0 ff ff       	jmp    80105ad2 <alltraps>

801069ff <vector255>:
801069ff:	6a 00                	push   $0x0
80106a01:	68 ff 00 00 00       	push   $0xff
80106a06:	e9 c7 f0 ff ff       	jmp    80105ad2 <alltraps>
80106a0b:	66 90                	xchg   %ax,%ax
80106a0d:	66 90                	xchg   %ax,%ax
80106a0f:	90                   	nop

80106a10 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106a10:	55                   	push   %ebp
80106a11:	89 e5                	mov    %esp,%ebp
80106a13:	57                   	push   %edi
80106a14:	56                   	push   %esi
80106a15:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106a17:	c1 ea 16             	shr    $0x16,%edx
{
80106a1a:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
80106a1b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
80106a1e:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106a21:	8b 1f                	mov    (%edi),%ebx
80106a23:	f6 c3 01             	test   $0x1,%bl
80106a26:	74 28                	je     80106a50 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106a28:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106a2e:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106a34:	89 f0                	mov    %esi,%eax
}
80106a36:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106a39:	c1 e8 0a             	shr    $0xa,%eax
80106a3c:	25 fc 0f 00 00       	and    $0xffc,%eax
80106a41:	01 d8                	add    %ebx,%eax
}
80106a43:	5b                   	pop    %ebx
80106a44:	5e                   	pop    %esi
80106a45:	5f                   	pop    %edi
80106a46:	5d                   	pop    %ebp
80106a47:	c3                   	ret    
80106a48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a4f:	90                   	nop
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106a50:	85 c9                	test   %ecx,%ecx
80106a52:	74 2c                	je     80106a80 <walkpgdir+0x70>
80106a54:	e8 e7 bb ff ff       	call   80102640 <kalloc>
80106a59:	89 c3                	mov    %eax,%ebx
80106a5b:	85 c0                	test   %eax,%eax
80106a5d:	74 21                	je     80106a80 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
80106a5f:	83 ec 04             	sub    $0x4,%esp
80106a62:	68 00 10 00 00       	push   $0x1000
80106a67:	6a 00                	push   $0x0
80106a69:	50                   	push   %eax
80106a6a:	e8 91 dd ff ff       	call   80104800 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106a6f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106a75:	83 c4 10             	add    $0x10,%esp
80106a78:	83 c8 07             	or     $0x7,%eax
80106a7b:	89 07                	mov    %eax,(%edi)
80106a7d:	eb b5                	jmp    80106a34 <walkpgdir+0x24>
80106a7f:	90                   	nop
}
80106a80:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106a83:	31 c0                	xor    %eax,%eax
}
80106a85:	5b                   	pop    %ebx
80106a86:	5e                   	pop    %esi
80106a87:	5f                   	pop    %edi
80106a88:	5d                   	pop    %ebp
80106a89:	c3                   	ret    
80106a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106a90 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106a90:	55                   	push   %ebp
80106a91:	89 e5                	mov    %esp,%ebp
80106a93:	57                   	push   %edi
80106a94:	89 c7                	mov    %eax,%edi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106a96:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
{
80106a9a:	56                   	push   %esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106a9b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  a = (char*)PGROUNDDOWN((uint)va);
80106aa0:	89 d6                	mov    %edx,%esi
{
80106aa2:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106aa3:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
{
80106aa9:	83 ec 1c             	sub    $0x1c,%esp
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106aac:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106aaf:	8b 45 08             	mov    0x8(%ebp),%eax
80106ab2:	29 f0                	sub    %esi,%eax
80106ab4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106ab7:	eb 1f                	jmp    80106ad8 <mappages+0x48>
80106ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106ac0:	f6 00 01             	testb  $0x1,(%eax)
80106ac3:	75 45                	jne    80106b0a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106ac5:	0b 5d 0c             	or     0xc(%ebp),%ebx
80106ac8:	83 cb 01             	or     $0x1,%ebx
80106acb:	89 18                	mov    %ebx,(%eax)
    if(a == last)
80106acd:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80106ad0:	74 2e                	je     80106b00 <mappages+0x70>
      break;
    a += PGSIZE;
80106ad2:	81 c6 00 10 00 00    	add    $0x1000,%esi
  for(;;){
80106ad8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106adb:	b9 01 00 00 00       	mov    $0x1,%ecx
80106ae0:	89 f2                	mov    %esi,%edx
80106ae2:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
80106ae5:	89 f8                	mov    %edi,%eax
80106ae7:	e8 24 ff ff ff       	call   80106a10 <walkpgdir>
80106aec:	85 c0                	test   %eax,%eax
80106aee:	75 d0                	jne    80106ac0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80106af0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106af3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106af8:	5b                   	pop    %ebx
80106af9:	5e                   	pop    %esi
80106afa:	5f                   	pop    %edi
80106afb:	5d                   	pop    %ebp
80106afc:	c3                   	ret    
80106afd:	8d 76 00             	lea    0x0(%esi),%esi
80106b00:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106b03:	31 c0                	xor    %eax,%eax
}
80106b05:	5b                   	pop    %ebx
80106b06:	5e                   	pop    %esi
80106b07:	5f                   	pop    %edi
80106b08:	5d                   	pop    %ebp
80106b09:	c3                   	ret    
      panic("remap");
80106b0a:	83 ec 0c             	sub    $0xc,%esp
80106b0d:	68 b0 7b 10 80       	push   $0x80107bb0
80106b12:	e8 69 98 ff ff       	call   80100380 <panic>
80106b17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b1e:	66 90                	xchg   %ax,%ax

80106b20 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106b20:	55                   	push   %ebp
80106b21:	89 e5                	mov    %esp,%ebp
80106b23:	57                   	push   %edi
80106b24:	56                   	push   %esi
80106b25:	89 c6                	mov    %eax,%esi
80106b27:	53                   	push   %ebx
80106b28:	89 d3                	mov    %edx,%ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106b2a:	8d 91 ff 0f 00 00    	lea    0xfff(%ecx),%edx
80106b30:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106b36:	83 ec 1c             	sub    $0x1c,%esp
80106b39:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106b3c:	39 da                	cmp    %ebx,%edx
80106b3e:	73 61                	jae    80106ba1 <deallocuvm.part.0+0x81>
80106b40:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80106b43:	89 d7                	mov    %edx,%edi
80106b45:	eb 38                	jmp    80106b7f <deallocuvm.part.0+0x5f>
80106b47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b4e:	66 90                	xchg   %ax,%ax
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a += (NPTENTRIES - 1) * PGSIZE;
    else if((*pte & PTE_P) != 0){
80106b50:	8b 00                	mov    (%eax),%eax
80106b52:	a8 01                	test   $0x1,%al
80106b54:	74 1e                	je     80106b74 <deallocuvm.part.0+0x54>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106b56:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106b5b:	74 4f                	je     80106bac <deallocuvm.part.0+0x8c>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106b5d:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106b60:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106b65:	50                   	push   %eax
80106b66:	e8 15 b9 ff ff       	call   80102480 <kfree>
      *pte = 0;
80106b6b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80106b71:	83 c4 10             	add    $0x10,%esp
  for(; a  < oldsz; a += PGSIZE){
80106b74:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106b7a:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80106b7d:	73 22                	jae    80106ba1 <deallocuvm.part.0+0x81>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106b7f:	31 c9                	xor    %ecx,%ecx
80106b81:	89 fa                	mov    %edi,%edx
80106b83:	89 f0                	mov    %esi,%eax
80106b85:	e8 86 fe ff ff       	call   80106a10 <walkpgdir>
80106b8a:	89 c3                	mov    %eax,%ebx
    if(!pte)
80106b8c:	85 c0                	test   %eax,%eax
80106b8e:	75 c0                	jne    80106b50 <deallocuvm.part.0+0x30>
      a += (NPTENTRIES - 1) * PGSIZE;
80106b90:	81 c7 00 f0 3f 00    	add    $0x3ff000,%edi
  for(; a  < oldsz; a += PGSIZE){
80106b96:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106b9c:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80106b9f:	72 de                	jb     80106b7f <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80106ba1:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106ba4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ba7:	5b                   	pop    %ebx
80106ba8:	5e                   	pop    %esi
80106ba9:	5f                   	pop    %edi
80106baa:	5d                   	pop    %ebp
80106bab:	c3                   	ret    
        panic("kfree");
80106bac:	83 ec 0c             	sub    $0xc,%esp
80106baf:	68 7a 75 10 80       	push   $0x8010757a
80106bb4:	e8 c7 97 ff ff       	call   80100380 <panic>
80106bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106bc0 <seginit>:
{
80106bc0:	f3 0f 1e fb          	endbr32 
80106bc4:	55                   	push   %ebp
80106bc5:	89 e5                	mov    %esp,%ebp
80106bc7:	53                   	push   %ebx
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106bc8:	31 db                	xor    %ebx,%ebx
{
80106bca:	83 ec 14             	sub    $0x14,%esp
  c = &cpus[cpunum()];
80106bcd:	e8 de bc ff ff       	call   801028b0 <cpunum>
80106bd2:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106bd8:	8d 90 e0 12 11 80    	lea    -0x7feeed20(%eax),%edx
80106bde:	8d 88 94 13 11 80    	lea    -0x7feeec6c(%eax),%ecx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106be4:	c7 80 58 13 11 80 ff 	movl   $0xffff,-0x7feeeca8(%eax)
80106beb:	ff 00 00 
80106bee:	c7 80 5c 13 11 80 00 	movl   $0xcf9a00,-0x7feeeca4(%eax)
80106bf5:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106bf8:	c7 80 60 13 11 80 ff 	movl   $0xffff,-0x7feeeca0(%eax)
80106bff:	ff 00 00 
80106c02:	c7 80 64 13 11 80 00 	movl   $0xcf9200,-0x7feeec9c(%eax)
80106c09:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106c0c:	c7 80 70 13 11 80 ff 	movl   $0xffff,-0x7feeec90(%eax)
80106c13:	ff 00 00 
80106c16:	c7 80 74 13 11 80 00 	movl   $0xcffa00,-0x7feeec8c(%eax)
80106c1d:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106c20:	c7 80 78 13 11 80 ff 	movl   $0xffff,-0x7feeec88(%eax)
80106c27:	ff 00 00 
80106c2a:	c7 80 7c 13 11 80 00 	movl   $0xcff200,-0x7feeec84(%eax)
80106c31:	f2 cf 00 
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106c34:	66 89 9a 88 00 00 00 	mov    %bx,0x88(%edx)
80106c3b:	89 cb                	mov    %ecx,%ebx
80106c3d:	c1 eb 10             	shr    $0x10,%ebx
80106c40:	66 89 8a 8a 00 00 00 	mov    %cx,0x8a(%edx)
80106c47:	c1 e9 18             	shr    $0x18,%ecx
80106c4a:	88 9a 8c 00 00 00    	mov    %bl,0x8c(%edx)
80106c50:	bb 92 c0 ff ff       	mov    $0xffffc092,%ebx
80106c55:	66 89 98 6d 13 11 80 	mov    %bx,-0x7feeec93(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106c5c:	05 50 13 11 80       	add    $0x80111350,%eax
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106c61:	88 8a 8f 00 00 00    	mov    %cl,0x8f(%edx)
  pd[0] = size-1;
80106c67:	b9 37 00 00 00       	mov    $0x37,%ecx
80106c6c:	66 89 4d f2          	mov    %cx,-0xe(%ebp)
  pd[1] = (uint)p;
80106c70:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106c74:	c1 e8 10             	shr    $0x10,%eax
80106c77:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106c7b:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106c7e:	0f 01 10             	lgdtl  (%eax)
  asm volatile("movw %0, %%gs" : : "r" (v));
80106c81:	b8 18 00 00 00       	mov    $0x18,%eax
80106c86:	8e e8                	mov    %eax,%gs
  proc = 0;
80106c88:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80106c8f:	00 00 00 00 
  c = &cpus[cpunum()];
80106c93:	65 89 15 00 00 00 00 	mov    %edx,%gs:0x0
}
80106c9a:	83 c4 14             	add    $0x14,%esp
80106c9d:	5b                   	pop    %ebx
80106c9e:	5d                   	pop    %ebp
80106c9f:	c3                   	ret    

80106ca0 <setupkvm>:
{
80106ca0:	f3 0f 1e fb          	endbr32 
80106ca4:	55                   	push   %ebp
80106ca5:	89 e5                	mov    %esp,%ebp
80106ca7:	56                   	push   %esi
80106ca8:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106ca9:	e8 92 b9 ff ff       	call   80102640 <kalloc>
80106cae:	85 c0                	test   %eax,%eax
80106cb0:	74 4e                	je     80106d00 <setupkvm+0x60>
  memset(pgdir, 0, PGSIZE);
80106cb2:	83 ec 04             	sub    $0x4,%esp
80106cb5:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106cb7:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106cbc:	68 00 10 00 00       	push   $0x1000
80106cc1:	6a 00                	push   $0x0
80106cc3:	50                   	push   %eax
80106cc4:	e8 37 db ff ff       	call   80104800 <memset>
80106cc9:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0)
80106ccc:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106ccf:	83 ec 08             	sub    $0x8,%esp
80106cd2:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106cd5:	ff 73 0c             	pushl  0xc(%ebx)
80106cd8:	8b 13                	mov    (%ebx),%edx
80106cda:	50                   	push   %eax
80106cdb:	29 c1                	sub    %eax,%ecx
80106cdd:	89 f0                	mov    %esi,%eax
80106cdf:	e8 ac fd ff ff       	call   80106a90 <mappages>
80106ce4:	83 c4 10             	add    $0x10,%esp
80106ce7:	85 c0                	test   %eax,%eax
80106ce9:	78 15                	js     80106d00 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106ceb:	83 c3 10             	add    $0x10,%ebx
80106cee:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106cf4:	75 d6                	jne    80106ccc <setupkvm+0x2c>
}
80106cf6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106cf9:	89 f0                	mov    %esi,%eax
80106cfb:	5b                   	pop    %ebx
80106cfc:	5e                   	pop    %esi
80106cfd:	5d                   	pop    %ebp
80106cfe:	c3                   	ret    
80106cff:	90                   	nop
80106d00:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
80106d03:	31 f6                	xor    %esi,%esi
}
80106d05:	89 f0                	mov    %esi,%eax
80106d07:	5b                   	pop    %ebx
80106d08:	5e                   	pop    %esi
80106d09:	5d                   	pop    %ebp
80106d0a:	c3                   	ret    
80106d0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106d0f:	90                   	nop

80106d10 <kvmalloc>:
{
80106d10:	f3 0f 1e fb          	endbr32 
80106d14:	55                   	push   %ebp
80106d15:	89 e5                	mov    %esp,%ebp
80106d17:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106d1a:	e8 81 ff ff ff       	call   80106ca0 <setupkvm>
80106d1f:	a3 64 42 11 80       	mov    %eax,0x80114264
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106d24:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106d29:	0f 22 d8             	mov    %eax,%cr3
}
80106d2c:	c9                   	leave  
80106d2d:	c3                   	ret    
80106d2e:	66 90                	xchg   %ax,%ax

80106d30 <switchkvm>:
{
80106d30:	f3 0f 1e fb          	endbr32 
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106d34:	a1 64 42 11 80       	mov    0x80114264,%eax
80106d39:	05 00 00 00 80       	add    $0x80000000,%eax
80106d3e:	0f 22 d8             	mov    %eax,%cr3
}
80106d41:	c3                   	ret    
80106d42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106d50 <switchuvm>:
{
80106d50:	f3 0f 1e fb          	endbr32 
80106d54:	55                   	push   %ebp
80106d55:	89 e5                	mov    %esp,%ebp
80106d57:	53                   	push   %ebx
80106d58:	83 ec 04             	sub    $0x4,%esp
80106d5b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80106d5e:	e8 cd d9 ff ff       	call   80104730 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106d63:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106d69:	b9 67 00 00 00       	mov    $0x67,%ecx
80106d6e:	8d 50 08             	lea    0x8(%eax),%edx
80106d71:	66 89 88 a0 00 00 00 	mov    %cx,0xa0(%eax)
80106d78:	66 89 90 a2 00 00 00 	mov    %dx,0xa2(%eax)
80106d7f:	89 d1                	mov    %edx,%ecx
80106d81:	c1 ea 18             	shr    $0x18,%edx
80106d84:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
80106d8a:	ba 89 40 00 00       	mov    $0x4089,%edx
80106d8f:	c1 e9 10             	shr    $0x10,%ecx
80106d92:	66 89 90 a5 00 00 00 	mov    %dx,0xa5(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80106d99:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106da0:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80106da6:	b9 10 00 00 00       	mov    $0x10,%ecx
80106dab:	66 89 48 10          	mov    %cx,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80106daf:	8b 52 08             	mov    0x8(%edx),%edx
80106db2:	81 c2 00 10 00 00    	add    $0x1000,%edx
80106db8:	89 50 0c             	mov    %edx,0xc(%eax)
  cpu->ts.iomb = (ushort) 0xFFFF;
80106dbb:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106dc0:	66 89 50 6e          	mov    %dx,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106dc4:	b8 30 00 00 00       	mov    $0x30,%eax
80106dc9:	0f 00 d8             	ltr    %ax
  if(p->pgdir == 0)
80106dcc:	8b 43 04             	mov    0x4(%ebx),%eax
80106dcf:	85 c0                	test   %eax,%eax
80106dd1:	74 11                	je     80106de4 <switchuvm+0x94>
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106dd3:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106dd8:	0f 22 d8             	mov    %eax,%cr3
}
80106ddb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106dde:	c9                   	leave  
  popcli();
80106ddf:	e9 7c d9 ff ff       	jmp    80104760 <popcli>
    panic("switchuvm: no pgdir");
80106de4:	83 ec 0c             	sub    $0xc,%esp
80106de7:	68 b6 7b 10 80       	push   $0x80107bb6
80106dec:	e8 8f 95 ff ff       	call   80100380 <panic>
80106df1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106df8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106dff:	90                   	nop

80106e00 <inituvm>:
{
80106e00:	f3 0f 1e fb          	endbr32 
80106e04:	55                   	push   %ebp
80106e05:	89 e5                	mov    %esp,%ebp
80106e07:	57                   	push   %edi
80106e08:	56                   	push   %esi
80106e09:	53                   	push   %ebx
80106e0a:	83 ec 1c             	sub    $0x1c,%esp
80106e0d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e10:	8b 75 10             	mov    0x10(%ebp),%esi
80106e13:	8b 7d 08             	mov    0x8(%ebp),%edi
80106e16:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106e19:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106e1f:	77 4b                	ja     80106e6c <inituvm+0x6c>
  mem = kalloc();
80106e21:	e8 1a b8 ff ff       	call   80102640 <kalloc>
  memset(mem, 0, PGSIZE);
80106e26:	83 ec 04             	sub    $0x4,%esp
80106e29:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80106e2e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106e30:	6a 00                	push   $0x0
80106e32:	50                   	push   %eax
80106e33:	e8 c8 d9 ff ff       	call   80104800 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106e38:	58                   	pop    %eax
80106e39:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106e3f:	5a                   	pop    %edx
80106e40:	6a 06                	push   $0x6
80106e42:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106e47:	31 d2                	xor    %edx,%edx
80106e49:	50                   	push   %eax
80106e4a:	89 f8                	mov    %edi,%eax
80106e4c:	e8 3f fc ff ff       	call   80106a90 <mappages>
  memmove(mem, init, sz);
80106e51:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106e54:	89 75 10             	mov    %esi,0x10(%ebp)
80106e57:	83 c4 10             	add    $0x10,%esp
80106e5a:	89 5d 08             	mov    %ebx,0x8(%ebp)
80106e5d:	89 45 0c             	mov    %eax,0xc(%ebp)
}
80106e60:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e63:	5b                   	pop    %ebx
80106e64:	5e                   	pop    %esi
80106e65:	5f                   	pop    %edi
80106e66:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106e67:	e9 34 da ff ff       	jmp    801048a0 <memmove>
    panic("inituvm: more than a page");
80106e6c:	83 ec 0c             	sub    $0xc,%esp
80106e6f:	68 ca 7b 10 80       	push   $0x80107bca
80106e74:	e8 07 95 ff ff       	call   80100380 <panic>
80106e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106e80 <loaduvm>:
{
80106e80:	f3 0f 1e fb          	endbr32 
80106e84:	55                   	push   %ebp
80106e85:	89 e5                	mov    %esp,%ebp
80106e87:	57                   	push   %edi
80106e88:	56                   	push   %esi
80106e89:	53                   	push   %ebx
80106e8a:	83 ec 1c             	sub    $0x1c,%esp
80106e8d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e90:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
80106e93:	a9 ff 0f 00 00       	test   $0xfff,%eax
80106e98:	0f 85 99 00 00 00    	jne    80106f37 <loaduvm+0xb7>
  for(i = 0; i < sz; i += PGSIZE){
80106e9e:	01 f0                	add    %esi,%eax
80106ea0:	89 f3                	mov    %esi,%ebx
80106ea2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106ea5:	8b 45 14             	mov    0x14(%ebp),%eax
80106ea8:	01 f0                	add    %esi,%eax
80106eaa:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80106ead:	85 f6                	test   %esi,%esi
80106eaf:	75 15                	jne    80106ec6 <loaduvm+0x46>
80106eb1:	eb 6d                	jmp    80106f20 <loaduvm+0xa0>
80106eb3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106eb7:	90                   	nop
80106eb8:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80106ebe:	89 f0                	mov    %esi,%eax
80106ec0:	29 d8                	sub    %ebx,%eax
80106ec2:	39 c6                	cmp    %eax,%esi
80106ec4:	76 5a                	jbe    80106f20 <loaduvm+0xa0>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106ec6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106ec9:	8b 45 08             	mov    0x8(%ebp),%eax
80106ecc:	31 c9                	xor    %ecx,%ecx
80106ece:	29 da                	sub    %ebx,%edx
80106ed0:	e8 3b fb ff ff       	call   80106a10 <walkpgdir>
80106ed5:	85 c0                	test   %eax,%eax
80106ed7:	74 51                	je     80106f2a <loaduvm+0xaa>
    pa = PTE_ADDR(*pte);
80106ed9:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106edb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
80106ede:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106ee3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106ee8:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80106eee:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106ef1:	29 d9                	sub    %ebx,%ecx
80106ef3:	05 00 00 00 80       	add    $0x80000000,%eax
80106ef8:	57                   	push   %edi
80106ef9:	51                   	push   %ecx
80106efa:	50                   	push   %eax
80106efb:	ff 75 10             	pushl  0x10(%ebp)
80106efe:	e8 4d ab ff ff       	call   80101a50 <readi>
80106f03:	83 c4 10             	add    $0x10,%esp
80106f06:	39 f8                	cmp    %edi,%eax
80106f08:	74 ae                	je     80106eb8 <loaduvm+0x38>
}
80106f0a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106f0d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106f12:	5b                   	pop    %ebx
80106f13:	5e                   	pop    %esi
80106f14:	5f                   	pop    %edi
80106f15:	5d                   	pop    %ebp
80106f16:	c3                   	ret    
80106f17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f1e:	66 90                	xchg   %ax,%ax
80106f20:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106f23:	31 c0                	xor    %eax,%eax
}
80106f25:	5b                   	pop    %ebx
80106f26:	5e                   	pop    %esi
80106f27:	5f                   	pop    %edi
80106f28:	5d                   	pop    %ebp
80106f29:	c3                   	ret    
      panic("loaduvm: address should exist");
80106f2a:	83 ec 0c             	sub    $0xc,%esp
80106f2d:	68 e4 7b 10 80       	push   $0x80107be4
80106f32:	e8 49 94 ff ff       	call   80100380 <panic>
    panic("loaduvm: addr must be page aligned");
80106f37:	83 ec 0c             	sub    $0xc,%esp
80106f3a:	68 88 7c 10 80       	push   $0x80107c88
80106f3f:	e8 3c 94 ff ff       	call   80100380 <panic>
80106f44:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106f4f:	90                   	nop

80106f50 <allocuvm>:
{
80106f50:	f3 0f 1e fb          	endbr32 
80106f54:	55                   	push   %ebp
80106f55:	89 e5                	mov    %esp,%ebp
80106f57:	57                   	push   %edi
80106f58:	56                   	push   %esi
80106f59:	53                   	push   %ebx
80106f5a:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106f5d:	8b 45 10             	mov    0x10(%ebp),%eax
{
80106f60:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
80106f63:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106f66:	85 c0                	test   %eax,%eax
80106f68:	0f 88 b2 00 00 00    	js     80107020 <allocuvm+0xd0>
  if(newsz < oldsz)
80106f6e:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
80106f71:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80106f74:	0f 82 96 00 00 00    	jb     80107010 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80106f7a:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80106f80:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80106f86:	39 75 10             	cmp    %esi,0x10(%ebp)
80106f89:	77 40                	ja     80106fcb <allocuvm+0x7b>
80106f8b:	e9 83 00 00 00       	jmp    80107013 <allocuvm+0xc3>
    memset(mem, 0, PGSIZE);
80106f90:	83 ec 04             	sub    $0x4,%esp
80106f93:	68 00 10 00 00       	push   $0x1000
80106f98:	6a 00                	push   $0x0
80106f9a:	50                   	push   %eax
80106f9b:	e8 60 d8 ff ff       	call   80104800 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106fa0:	58                   	pop    %eax
80106fa1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106fa7:	5a                   	pop    %edx
80106fa8:	6a 06                	push   $0x6
80106faa:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106faf:	89 f2                	mov    %esi,%edx
80106fb1:	50                   	push   %eax
80106fb2:	89 f8                	mov    %edi,%eax
80106fb4:	e8 d7 fa ff ff       	call   80106a90 <mappages>
80106fb9:	83 c4 10             	add    $0x10,%esp
80106fbc:	85 c0                	test   %eax,%eax
80106fbe:	78 78                	js     80107038 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80106fc0:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106fc6:	39 75 10             	cmp    %esi,0x10(%ebp)
80106fc9:	76 48                	jbe    80107013 <allocuvm+0xc3>
    mem = kalloc();
80106fcb:	e8 70 b6 ff ff       	call   80102640 <kalloc>
80106fd0:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80106fd2:	85 c0                	test   %eax,%eax
80106fd4:	75 ba                	jne    80106f90 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106fd6:	83 ec 0c             	sub    $0xc,%esp
80106fd9:	68 02 7c 10 80       	push   $0x80107c02
80106fde:	e8 bd 96 ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
80106fe3:	8b 45 0c             	mov    0xc(%ebp),%eax
80106fe6:	83 c4 10             	add    $0x10,%esp
80106fe9:	39 45 10             	cmp    %eax,0x10(%ebp)
80106fec:	74 32                	je     80107020 <allocuvm+0xd0>
80106fee:	8b 55 10             	mov    0x10(%ebp),%edx
80106ff1:	89 c1                	mov    %eax,%ecx
80106ff3:	89 f8                	mov    %edi,%eax
80106ff5:	e8 26 fb ff ff       	call   80106b20 <deallocuvm.part.0>
      return 0;
80106ffa:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107001:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107004:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107007:	5b                   	pop    %ebx
80107008:	5e                   	pop    %esi
80107009:	5f                   	pop    %edi
8010700a:	5d                   	pop    %ebp
8010700b:	c3                   	ret    
8010700c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107010:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80107013:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107016:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107019:	5b                   	pop    %ebx
8010701a:	5e                   	pop    %esi
8010701b:	5f                   	pop    %edi
8010701c:	5d                   	pop    %ebp
8010701d:	c3                   	ret    
8010701e:	66 90                	xchg   %ax,%ax
    return 0;
80107020:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107027:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010702a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010702d:	5b                   	pop    %ebx
8010702e:	5e                   	pop    %esi
8010702f:	5f                   	pop    %edi
80107030:	5d                   	pop    %ebp
80107031:	c3                   	ret    
80107032:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107038:	83 ec 0c             	sub    $0xc,%esp
8010703b:	68 1a 7c 10 80       	push   $0x80107c1a
80107040:	e8 5b 96 ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
80107045:	8b 45 0c             	mov    0xc(%ebp),%eax
80107048:	83 c4 10             	add    $0x10,%esp
8010704b:	39 45 10             	cmp    %eax,0x10(%ebp)
8010704e:	74 0c                	je     8010705c <allocuvm+0x10c>
80107050:	8b 55 10             	mov    0x10(%ebp),%edx
80107053:	89 c1                	mov    %eax,%ecx
80107055:	89 f8                	mov    %edi,%eax
80107057:	e8 c4 fa ff ff       	call   80106b20 <deallocuvm.part.0>
      kfree(mem);
8010705c:	83 ec 0c             	sub    $0xc,%esp
8010705f:	53                   	push   %ebx
80107060:	e8 1b b4 ff ff       	call   80102480 <kfree>
      return 0;
80107065:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010706c:	83 c4 10             	add    $0x10,%esp
}
8010706f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107072:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107075:	5b                   	pop    %ebx
80107076:	5e                   	pop    %esi
80107077:	5f                   	pop    %edi
80107078:	5d                   	pop    %ebp
80107079:	c3                   	ret    
8010707a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107080 <deallocuvm>:
{
80107080:	f3 0f 1e fb          	endbr32 
80107084:	55                   	push   %ebp
80107085:	89 e5                	mov    %esp,%ebp
80107087:	8b 55 0c             	mov    0xc(%ebp),%edx
8010708a:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010708d:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80107090:	39 d1                	cmp    %edx,%ecx
80107092:	73 0c                	jae    801070a0 <deallocuvm+0x20>
}
80107094:	5d                   	pop    %ebp
80107095:	e9 86 fa ff ff       	jmp    80106b20 <deallocuvm.part.0>
8010709a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801070a0:	89 d0                	mov    %edx,%eax
801070a2:	5d                   	pop    %ebp
801070a3:	c3                   	ret    
801070a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801070af:	90                   	nop

801070b0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801070b0:	f3 0f 1e fb          	endbr32 
801070b4:	55                   	push   %ebp
801070b5:	89 e5                	mov    %esp,%ebp
801070b7:	57                   	push   %edi
801070b8:	56                   	push   %esi
801070b9:	53                   	push   %ebx
801070ba:	83 ec 0c             	sub    $0xc,%esp
801070bd:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801070c0:	85 f6                	test   %esi,%esi
801070c2:	74 55                	je     80107119 <freevm+0x69>
  if(newsz >= oldsz)
801070c4:	31 c9                	xor    %ecx,%ecx
801070c6:	ba 00 00 00 80       	mov    $0x80000000,%edx
801070cb:	89 f0                	mov    %esi,%eax
801070cd:	89 f3                	mov    %esi,%ebx
801070cf:	e8 4c fa ff ff       	call   80106b20 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801070d4:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801070da:	eb 0b                	jmp    801070e7 <freevm+0x37>
801070dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801070e0:	83 c3 04             	add    $0x4,%ebx
801070e3:	39 df                	cmp    %ebx,%edi
801070e5:	74 23                	je     8010710a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801070e7:	8b 03                	mov    (%ebx),%eax
801070e9:	a8 01                	test   $0x1,%al
801070eb:	74 f3                	je     801070e0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801070ed:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
801070f2:	83 ec 0c             	sub    $0xc,%esp
801070f5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801070f8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801070fd:	50                   	push   %eax
801070fe:	e8 7d b3 ff ff       	call   80102480 <kfree>
80107103:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107106:	39 df                	cmp    %ebx,%edi
80107108:	75 dd                	jne    801070e7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010710a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010710d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107110:	5b                   	pop    %ebx
80107111:	5e                   	pop    %esi
80107112:	5f                   	pop    %edi
80107113:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107114:	e9 67 b3 ff ff       	jmp    80102480 <kfree>
    panic("freevm: no pgdir");
80107119:	83 ec 0c             	sub    $0xc,%esp
8010711c:	68 36 7c 10 80       	push   $0x80107c36
80107121:	e8 5a 92 ff ff       	call   80100380 <panic>
80107126:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010712d:	8d 76 00             	lea    0x0(%esi),%esi

80107130 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107130:	f3 0f 1e fb          	endbr32 
80107134:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107135:	31 c9                	xor    %ecx,%ecx
{
80107137:	89 e5                	mov    %esp,%ebp
80107139:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
8010713c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010713f:	8b 45 08             	mov    0x8(%ebp),%eax
80107142:	e8 c9 f8 ff ff       	call   80106a10 <walkpgdir>
  if(pte == 0)
80107147:	85 c0                	test   %eax,%eax
80107149:	74 05                	je     80107150 <clearpteu+0x20>
    panic("clearpteu");
  *pte &= ~PTE_U;
8010714b:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010714e:	c9                   	leave  
8010714f:	c3                   	ret    
    panic("clearpteu");
80107150:	83 ec 0c             	sub    $0xc,%esp
80107153:	68 47 7c 10 80       	push   $0x80107c47
80107158:	e8 23 92 ff ff       	call   80100380 <panic>
8010715d:	8d 76 00             	lea    0x0(%esi),%esi

80107160 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107160:	f3 0f 1e fb          	endbr32 
80107164:	55                   	push   %ebp
80107165:	89 e5                	mov    %esp,%ebp
80107167:	57                   	push   %edi
80107168:	56                   	push   %esi
80107169:	53                   	push   %ebx
8010716a:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
8010716d:	e8 2e fb ff ff       	call   80106ca0 <setupkvm>
80107172:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107175:	85 c0                	test   %eax,%eax
80107177:	0f 84 9c 00 00 00    	je     80107219 <copyuvm+0xb9>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010717d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107180:	85 c9                	test   %ecx,%ecx
80107182:	0f 84 91 00 00 00    	je     80107219 <copyuvm+0xb9>
80107188:	31 f6                	xor    %esi,%esi
8010718a:	eb 4a                	jmp    801071d6 <copyuvm+0x76>
8010718c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107190:	83 ec 04             	sub    $0x4,%esp
80107193:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107199:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010719c:	68 00 10 00 00       	push   $0x1000
801071a1:	57                   	push   %edi
801071a2:	50                   	push   %eax
801071a3:	e8 f8 d6 ff ff       	call   801048a0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
801071a8:	58                   	pop    %eax
801071a9:	5a                   	pop    %edx
801071aa:	53                   	push   %ebx
801071ab:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801071ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
801071b1:	b9 00 10 00 00       	mov    $0x1000,%ecx
801071b6:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801071bc:	52                   	push   %edx
801071bd:	89 f2                	mov    %esi,%edx
801071bf:	e8 cc f8 ff ff       	call   80106a90 <mappages>
801071c4:	83 c4 10             	add    $0x10,%esp
801071c7:	85 c0                	test   %eax,%eax
801071c9:	78 39                	js     80107204 <copyuvm+0xa4>
  for(i = 0; i < sz; i += PGSIZE){
801071cb:	81 c6 00 10 00 00    	add    $0x1000,%esi
801071d1:	39 75 0c             	cmp    %esi,0xc(%ebp)
801071d4:	76 43                	jbe    80107219 <copyuvm+0xb9>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801071d6:	8b 45 08             	mov    0x8(%ebp),%eax
801071d9:	31 c9                	xor    %ecx,%ecx
801071db:	89 f2                	mov    %esi,%edx
801071dd:	e8 2e f8 ff ff       	call   80106a10 <walkpgdir>
801071e2:	85 c0                	test   %eax,%eax
801071e4:	74 3e                	je     80107224 <copyuvm+0xc4>
    if(!(*pte & PTE_P))
801071e6:	8b 18                	mov    (%eax),%ebx
801071e8:	f6 c3 01             	test   $0x1,%bl
801071eb:	74 44                	je     80107231 <copyuvm+0xd1>
    pa = PTE_ADDR(*pte);
801071ed:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
801071ef:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
801071f5:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
801071fb:	e8 40 b4 ff ff       	call   80102640 <kalloc>
80107200:	85 c0                	test   %eax,%eax
80107202:	75 8c                	jne    80107190 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
80107204:	83 ec 0c             	sub    $0xc,%esp
80107207:	ff 75 e0             	pushl  -0x20(%ebp)
8010720a:	e8 a1 fe ff ff       	call   801070b0 <freevm>
  return 0;
8010720f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107216:	83 c4 10             	add    $0x10,%esp
}
80107219:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010721c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010721f:	5b                   	pop    %ebx
80107220:	5e                   	pop    %esi
80107221:	5f                   	pop    %edi
80107222:	5d                   	pop    %ebp
80107223:	c3                   	ret    
      panic("copyuvm: pte should exist");
80107224:	83 ec 0c             	sub    $0xc,%esp
80107227:	68 51 7c 10 80       	push   $0x80107c51
8010722c:	e8 4f 91 ff ff       	call   80100380 <panic>
      panic("copyuvm: page not present");
80107231:	83 ec 0c             	sub    $0xc,%esp
80107234:	68 6b 7c 10 80       	push   $0x80107c6b
80107239:	e8 42 91 ff ff       	call   80100380 <panic>
8010723e:	66 90                	xchg   %ax,%ax

80107240 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107240:	f3 0f 1e fb          	endbr32 
80107244:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107245:	31 c9                	xor    %ecx,%ecx
{
80107247:	89 e5                	mov    %esp,%ebp
80107249:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
8010724c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010724f:	8b 45 08             	mov    0x8(%ebp),%eax
80107252:	e8 b9 f7 ff ff       	call   80106a10 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107257:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107259:	c9                   	leave  
  if((*pte & PTE_U) == 0)
8010725a:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
8010725c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107261:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107264:	05 00 00 00 80       	add    $0x80000000,%eax
80107269:	83 fa 05             	cmp    $0x5,%edx
8010726c:	ba 00 00 00 00       	mov    $0x0,%edx
80107271:	0f 45 c2             	cmovne %edx,%eax
}
80107274:	c3                   	ret    
80107275:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010727c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107280 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107280:	f3 0f 1e fb          	endbr32 
80107284:	55                   	push   %ebp
80107285:	89 e5                	mov    %esp,%ebp
80107287:	57                   	push   %edi
80107288:	56                   	push   %esi
80107289:	53                   	push   %ebx
8010728a:	83 ec 0c             	sub    $0xc,%esp
8010728d:	8b 75 14             	mov    0x14(%ebp),%esi
80107290:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107293:	85 f6                	test   %esi,%esi
80107295:	75 3c                	jne    801072d3 <copyout+0x53>
80107297:	eb 67                	jmp    80107300 <copyout+0x80>
80107299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801072a0:	8b 55 0c             	mov    0xc(%ebp),%edx
801072a3:	89 fb                	mov    %edi,%ebx
801072a5:	29 d3                	sub    %edx,%ebx
801072a7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
801072ad:	39 f3                	cmp    %esi,%ebx
801072af:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801072b2:	29 fa                	sub    %edi,%edx
801072b4:	83 ec 04             	sub    $0x4,%esp
801072b7:	01 c2                	add    %eax,%edx
801072b9:	53                   	push   %ebx
801072ba:	ff 75 10             	pushl  0x10(%ebp)
801072bd:	52                   	push   %edx
801072be:	e8 dd d5 ff ff       	call   801048a0 <memmove>
    len -= n;
    buf += n;
801072c3:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
801072c6:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
  while(len > 0){
801072cc:	83 c4 10             	add    $0x10,%esp
801072cf:	29 de                	sub    %ebx,%esi
801072d1:	74 2d                	je     80107300 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
801072d3:	89 d7                	mov    %edx,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
801072d5:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
801072d8:	89 55 0c             	mov    %edx,0xc(%ebp)
801072db:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
801072e1:	57                   	push   %edi
801072e2:	ff 75 08             	pushl  0x8(%ebp)
801072e5:	e8 56 ff ff ff       	call   80107240 <uva2ka>
    if(pa0 == 0)
801072ea:	83 c4 10             	add    $0x10,%esp
801072ed:	85 c0                	test   %eax,%eax
801072ef:	75 af                	jne    801072a0 <copyout+0x20>
  }
  return 0;
}
801072f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801072f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801072f9:	5b                   	pop    %ebx
801072fa:	5e                   	pop    %esi
801072fb:	5f                   	pop    %edi
801072fc:	5d                   	pop    %ebp
801072fd:	c3                   	ret    
801072fe:	66 90                	xchg   %ax,%ax
80107300:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107303:	31 c0                	xor    %eax,%eax
}
80107305:	5b                   	pop    %ebx
80107306:	5e                   	pop    %esi
80107307:	5f                   	pop    %edi
80107308:	5d                   	pop    %ebp
80107309:	c3                   	ret    

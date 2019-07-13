pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
-- todo: modify run with "make test" or similar

function doutput(s,tof,bp)
 local prnt = tof or print
 local j = 1
 for i=1,#s do
  local c = sub(s,i,i)
  if c == "\n" then
   local st=sub(s,j,i-1)
   j = i+1
   if (bp and i % 14 == 0) then
    while(not btnp(0)) do
    end
   end
   prnt(st)
  end
 end

 if j!=#s then
  print(sub(s,j,#s))
 end
 print("done")
end

-- for debugging
-- print("^"..testpatch.."$")

-- todo: remove comment lines when patching
local commentpatch = [==[
//
]==]
assert("\n" == commentpatch)

-- todo: fix issue with misplaced end statement
-- todo: modify make patched code look like in pico8
local ifpatch = [==[
if (not i) a=1 a=2
]==]
assert("if (not i) then  a=1 a=2 end \n" == ifpatch)

local negpatch = [==[
i != a
]==]
assert("i ~= a\n" == negpatch)

-- todo: fix issue with missing/misplaced parens
-- todo: modify make patched code look like in pico8
local addpatch = [==[
i += a
]==]
assert("i = i + ( a) \n" == addpatch)

-- todo: fix issue with missing/misplaced parens
-- todo: modify make patched code look like in pico8
local subpatch = [==[
i -= a
]==]
assert("i = i - ( a) \n" == subpatch)

-- todo: fix issue with missing/misplaced parens
-- todo: modify make patched code look like in pico8
local mulpatch = [==[
i *= a
]==]
assert("i = i * ( a) \n" == mulpatch)

-- todo: fix issue with missing/misplaced parens
-- todo: modify make patched code look like in pico8
local divpatch = [==[
i /= a
]==]
assert("i = i / ( a) \n" == divpatch)

-- todo: fix issue with missing/misplaced parens
-- todo: modify make patched code look like in pico8
local modpatch = [==[
i %= a
]==]
assert("i = i % ( a) \n" == modpatch)


local advspacepatch1 = [==[
i+=a
]==]
assert("i = i + (a) \n" == advspacepatch1)

local advspacepatch2 = [==[
i+=  b
]==]
assert("i = i + (  b) \n" == advspacepatch2)

local advspacepatch3 = [==[
i  +=c
]==]
assert("i = i + (c) \n" == advspacepatch3)

local advspacepatch3 = [==[
i  +=   d
]==]
assert("i = i + (   d) \n" == advspacepatch3)

local advspacepatch4 = [==[
i+=e   ]==]
assert("i = i + (e)    " == advspacepatch4)

local advspacepatch5 = [==[
i  +=   f    ]==]
assert("i = i + (   f)     " == advspacepatch5)

local advspacepatch6 = [==[
  i+=g   ]==]
assert("  i = i + (g)    " == advspacepatch6)

local advspacepatch7 = [==[
  i  +=   h    ]==]
assert("  i = i + (   h)     " == advspacepatch7)

local advspacepatch8 = [==[
if x then i += h end
]==]
assert("if x then i = i + ( h)  end\n" == advspacepatch8)

local advspacepatch9 = [==[
if x then i += h + 1 end
]==]
assert( "if x then i = i + ( h + 1)  end\n" == advspacepatch9)

local advspacepatch10 = [==[
if x then i += h + e end]==]
assert( "if x then i = i + ( h + e)  end" == advspacepatch10)

local advspacepatch11 = [==[
if x then i += h - e end]==]
assert( "if x then i = i + ( h - e)  end" == advspacepatch11)

-- todo: add more patching tests
c=[==[

comments:
"//"
//


shorthands:
"if (not i) a=1 a=2"
if (not i) a=1 a=2


unary math operators:
"i != a"
i != a
"i += a"
i += a
"i -= a"
i -= a
"i *= a"
i *= a
"i /= a"
i /= a
"i %= a"
i %= a


unary math operators - adcanced tests:
"i+=a"
i+=a
"i+=  b"
i+=  b
"i  +=c"
i  +=c
"i  +=   d"
i  +=   d
"i+=e   "
i+=e
"i  +=   f    "
i  +=   f
"  i+=g   "
  i+=g
"  i  +=   h    "
  i  +=   h
"if x then i += h end"
if x then i += h end
"if x then i += h + 1 end"
if x then i += h + 1 end

"if x then i += h + e end"
if x then i += h + e end
"if x then i += h - e end"
if x then i += h - e end
"if x then i += h * e end"
if x then i += h * e end
"if x then i += h / e end"
if x then i += h / e end
"if x then i += h % e end"
if x then i += h % e end

"if x then i += h ! e end"
if x then i += h ! e end
"if x then i += h " e end"
if x then i += h " e end
"if x then i += h $e end"
if x then i += h $ e end
"if x then i += h & e end"
if x then i += h & e end
"if x then i += h ( e end"
if x then i += h ( e end
"if x then i += h ) e end"
if x then i += h ) e end
"if x then i += h = e end"
if x then i += h = e end
"if x then i += h ? e end"
if x then i += h ? e end
"if x then i += h ` e end"
if x then i += h ` e end
"if x then i += h \ e end"
if x then i += h \ e end
"if x then i += h ^ e end"
if x then i += h ^ e end
"if x then i += h | e end"
if x then i += h | e end
"if x then i += h < e end"
if x then i += h < e end
"if x then i += h > e end"
if x then i += h > e end

"if x then i += h , e end"
if x then i += h , e end
"if x then i += h . e end"
if x then i += h . e end
"if x then i += h ; e end"
if x then i += h ; e end
"if x then i += h : e end"
if x then i += h : e end
"if x then i += h _ e end"
if x then i += h _ e end
"if x then i += h # e end"
if x then i += h # e end
"if x then i += h ' e end"
if x then i += h ' e end
"if x then i += h ~ e end"
if x then i += h ~ e end
"if x then i += h == e end"
if x then i += h == e end

"if x then i += h or e end"
if x then i += h or e end
"if x then i += h and e end"
if x then i += h and e end
"if x then i += h not e end"
if x then i += h not e end
"if x then i += h else e end"
if x then i += h else e end
"if x then i += h(e) e end"
if x then i += h(e) end
"if x then i += h -- e end"
if x then i += h -- e end
"if x then i += h // e end"
if x then i += h // e end
"if x then i += h(e,f) end"
if x then i += h(e,f) end
"if x then i += h [ e end"
if x then i += h [ e end
"if x then i += h ] e end"
if x then i += h ] e end
"if x then i += h[e] end"
if x then i += h[e] end

]==]

cls()

doutput(c,printh)
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
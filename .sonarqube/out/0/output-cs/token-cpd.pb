Í
`C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Views\Repartidor\Registrar.cshtml.cs
	namespace 	
Gtrack
 
. 
Views 
. 

Repartidor !
{ 
public 

class 
RegistrarModel 
:  !
	PageModel" +
{ 
public 
void 
OnGet 
( 
) 
{ 	
}		 	
}

 
} ˙
hC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Views\Admin\RegistrarAdministrador.cshtml.cs
	namespace 	
Gtrack
 
. 
Views 
. 
Admin 
{ 
public 

class '
RegistrarAdministradorModel ,
:- .
	PageModel/ 8
{ 
public 
void 
OnGet 
( 
) 
{ 	
}		 	
}

 
} Ï
aC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Views\Admin\Administradores.cshtml.cs
	namespace 	
Gtrack
 
. 
Views 
. 
Admin 
{ 
public 

class  
AdministradoresModel %
:& '
	PageModel( 1
{ 
public 
void 
OnGet 
( 
) 
{ 	
}		 	
}

 
} ﬁ
ZC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Views\Admin\Negocios.cshtml.cs
	namespace 	
Gtrack
 
. 
Views 
. 
Admin 
{ 
public 

class 
NegociosModel 
:  
	PageModel! *
{ 
public 
void 
OnGet 
( 
) 
{ 	
}		 	
}

 
} Ì
ZC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Utilities\ValidadorPassword.cs
	namespace 	
Gtrack
 
; 
public 
static 
class 
ValidadorPassword %
{ 
public 

static 
bool 
EsValida 
(  
string  &
?& '
password( 0
)0 1
=>2 4
! 	
string	 
. 
IsNullOrEmpty 
( 
password &
)& '
&& 

password 
. 
Length 
>= 
$num 
&&		 

password		 
.		 
Any		 
(		 
char		 
.		 
IsDigit		 $
)		$ %
&&

 

password

 
.

 
Any

 
(

 
char

 
.

 
IsLetter

 %
)

% &
;

& '
} –
RC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Utilities\TokenUtil.cs
	namespace 	
Gtrack
 
; 
public 
static 
class 
	TokenUtil 
{ 
public		 

static		 
string		 
Generar		  
(		  !
)		! "
=>		# %
WebEncoders

 
.

 
Base64UrlEncode

 #
(

# $!
RandomNumberGenerator

$ 9
.

9 :
GetBytes

: B
(

B C
$num

C E
)

E F
)

F G
;

G H
public 

static 
string 
Hash 
( 
string $
token% *
)* +
=>, .
Convert 
. 
ToHexString 
( 
SHA256 "
." #
HashData# +
(+ ,
Encoding, 4
.4 5
UTF85 9
.9 :
GetBytes: B
(B C
tokenC H
)H I
)I J
)J K
;K L
} Œ
QC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Utilities\Patrones.cs
	namespace 	
Gtrack
 
; 
public 
static 
partial 
class 
Patrones $
{ 
private		 
const		 
int		 
TiempoLimiteMs		 $
=		% &
$num		' *
;		* +
[ 
GeneratedRegex 
( 
$str #
,# $
RegexOptions% 1
.1 2
None2 6
,6 7
TiempoLimiteMs8 F
)F G
]G H
public 

static 
partial 
Regex 
CodigoPedido  ,
(, -
)- .
;. /
[ 
GeneratedRegex 
( 
$str &
,& '
RegexOptions( 4
.4 5
None5 9
,9 :
TiempoLimiteMs; I
)I J
]J K
public 

static 
partial 
Regex /
#CodigoPedidoSinDistinguirMayusculas  C
(C D
)D E
;E F
[ 
GeneratedRegex 
( 
ReglasValidacion $
.$ %
	PlacaMoto% .
,. /
RegexOptions0 <
.< =
None= A
,A B
TiempoLimiteMsC Q
)Q R
]R S
public 

static 
partial 
Regex 
	PlacaMoto  )
() *
)* +
;+ ,
[ 
GeneratedRegex 
( 
ReglasValidacion $
.$ %

PlacaCarro% /
,/ 0
RegexOptions1 =
.= >
None> B
,B C
TiempoLimiteMsD R
)R S
]S T
public 

static 
partial 
Regex 

PlacaCarro  *
(* +
)+ ,
;, -
[ 
GeneratedRegex 
( 
$str $
,$ %
RegexOptions& 2
.2 3
None3 7
,7 8
TiempoLimiteMs9 G
)G H
]H I
public 

static 
partial 
Regex 
Negrita  '
(' (
)( )
;) *
} í!
dC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Utilities\InvariantDecimalModelBinder.cs
	namespace 	
Gtrack
 
; 
public		 
class		 '
InvariantDecimalModelBinder		 (
(		( )
bool		) -

admiteNulo		. 8
)		8 9
:		: ;
IModelBinder		< H
{

 
public 

Task 
BindModelAsync 
( 
ModelBindingContext 2
bindingContext3 A
)A B
{ 
var 
	resultado 
= 
bindingContext &
.& '
ValueProvider' 4
.4 5
GetValue5 =
(= >
bindingContext> L
.L M
	ModelNameM V
)V W
;W X
if 

( 
	resultado 
== 
ValueProviderResult ,
., -
None- 1
)1 2
return3 9
Task: >
.> ?
CompletedTask? L
;L M
bindingContext 
. 

ModelState !
.! "
SetModelValue" /
(/ 0
bindingContext0 >
.> ?
	ModelName? H
,H I
	resultadoJ S
)S T
;T U
var 
texto 
= 
	resultado 
. 

FirstValue (
?( )
.) *
Trim* .
(. /
)/ 0
;0 1
if 

( 
string 
. 
IsNullOrEmpty  
(  !
texto! &
)& '
)' (
{ 	
if 
( 

admiteNulo 
) 
bindingContext *
.* +
Result+ 1
=2 3
ModelBindingResult4 F
.F G
SuccessG N
(N O
nullO S
)S T
;T U
else 
bindingContext 
.  

ModelState  *
.* +
TryAddModelError+ ;
(; <
bindingContext< J
.J K
	ModelNameK T
,T U
$strV i
)i j
;j k
return 
Task 
. 
CompletedTask %
;% &
} 	
if 

( 
decimal 
. 
TryParse 
( 
texto "
," #
NumberStyles$ 0
.0 1
AllowLeadingSign1 A
|B C
NumberStylesD P
.P Q
AllowDecimalPointQ b
,b c
CultureInfo 
. 
InvariantCulture ,
,, -
out. 1
var2 5
valor6 ;
); <
)< =
bindingContext 
. 
Result !
=" #
ModelBindingResult$ 6
.6 7
Success7 >
(> ?
valor? D
)D E
;E F
else 
bindingContext 
. 

ModelState %
.% &
TryAddModelError& 6
(6 7
bindingContext7 E
.E F
	ModelNameF O
,O P
$strQ k
)k l
;l m
return   
Task   
.   
CompletedTask   !
;  ! "
}!! 
}"" 
public$$ 
class$$ /
#InvariantDecimalModelBinderProvider$$ 0
:$$1 2 
IModelBinderProvider$$3 G
{%% 
public&& 

IModelBinder&& 
?&& 
	GetBinder&& "
(&&" #&
ModelBinderProviderContext&&# =
context&&> E
)&&E F
=>&&G I
context'' 
.'' 
Metadata'' 
.'' !
UnderlyingOrModelType'' .
==''/ 1
typeof''2 8
(''8 9
decimal''9 @
)''@ A
?(( 
new(( '
InvariantDecimalModelBinder(( -
(((- .
context((. 5
.((5 6
Metadata((6 >
.((> ?
IsNullableValueType((? R
)((R S
:)) 
null)) 
;)) 
}** £
ZC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Utilities\GeneradorPassword.cs
	namespace 	
Gtrack
 
; 
public 
static 
class 
GeneradorPassword %
{ 
private 
const 
string 
Letras 
=  !
$str" T
;T U
private 
const 
string 
Digitos  
=! "
$str# -
;- .
public 

static 
string 
Temporal !
(! "
int" %
largo& +
=, -
$num. 0
)0 1
{ 
var 
todos 
= 
Letras 
+ 
Digitos $
;$ %
var 
chars 
= 
new 
List 
< 
char !
>! "
{ 	
Letras 
[ !
RandomNumberGenerator (
.( )
GetInt32) 1
(1 2
Letras2 8
.8 9
Length9 ?
)? @
]@ A
,A B
Digitos 
[ !
RandomNumberGenerator )
.) *
GetInt32* 2
(2 3
Digitos3 :
.: ;
Length; A
)A B
]B C
} 	
;	 

while 
( 
chars 
. 
Count 
< 
largo "
)" #
chars 
. 
Add 
( 
todos 
[ !
RandomNumberGenerator 1
.1 2
GetInt322 :
(: ;
todos; @
.@ A
LengthA G
)G H
]H I
)I J
;J K
return 
new 
string 
( 
chars 
.  
OrderBy  '
(' (
_( )
=>* ,!
RandomNumberGenerator- B
.B C
GetInt32C K
(K L
intL O
.O P
MaxValueP X
)X Y
)Y Z
.Z [
ToArray[ b
(b c
)c d
)d e
;e f
} 
} Ù!
YC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Utilities\EstadoPedidoInfo.cs
	namespace 	
Gtrack
 
; 
public 
static 
class 
EstadoPedidoInfo $
{ 
public 

static 
string 
Nombre 
(  
int  #
estadoId$ ,
), -
=>. 0
(1 2
EstadoPedido2 >
)> ?
estadoId? G
switchH N
{ 
EstadoPedido 
. 
Recibido 
=>  
$str! +
,+ ,
EstadoPedido		 
.		 
EnPreparacion		 "
=>		# %
$str		& 6
,		6 7
EstadoPedido

 
.

 
ListoParaEntrega

 %
=>

& (
$str

) =
,

= >
EstadoPedido 
. 
Asignado 
=>  
$str! +
,+ ,
EstadoPedido 
. 
EnCamino 
=>  
$str! ,
,, -
EstadoPedido 
. 
	Entregado 
=> !
$str" -
,- .
EstadoPedido 
. 
	Cancelado 
=> !
$str" -
,- .
_ 	
=>
 
$str 
} 
; 
public 

static 
string 
Color 
( 
int "
estadoId# +
)+ ,
=>- /
(0 1
EstadoPedido1 =
)= >
estadoId> F
switchG M
{ 
EstadoPedido 
. 
Recibido 
=>  
$str! *
,* +
EstadoPedido 
. 
EnPreparacion "
=># %
$str& /
,/ 0
EstadoPedido 
. 
ListoParaEntrega %
=>& (
$str) 2
,2 3
EstadoPedido 
. 
Asignado 
=>  
$str! *
,* +
EstadoPedido 
. 
EnCamino 
=>  
$str! *
,* +
EstadoPedido 
. 
	Entregado 
=> !
$str" +
,+ ,
EstadoPedido 
. 
	Cancelado 
=> !
$str" +
,+ ,
_ 	
=>
 
$str 
} 
; 
public 

static 
string 
NombreCuenta %
(% &
EstadoCuenta& 2
e3 4
)4 5
=>6 8
e9 :
switch; A
{ 
EstadoCuenta   
.   
Activo   
=>   
$str   '
,  ' (
EstadoCuenta!! 
.!! 
PendienteValidacion!! (
=>!!) +
$str!!, E
,!!E F
EstadoCuenta"" 
."" 

Suspendido"" 
=>""  "
$str""# /
,""/ 0
EstadoCuenta## 
.## 
	Rechazado## 
=>## !
$str##" -
,##- .
EstadoCuenta$$ 
.$$ 
PendienteActivacion$$ (
=>$$) +
$str$$, E
,$$E F
_%% 	
=>%%
 
$str%% 
}&& 
;&& 
public(( 

static(( 
string(( 
ColorCuenta(( $
((($ %
EstadoCuenta((% 1
e((2 3
)((3 4
=>((5 7
e((8 9
switch((: @
{)) 
EstadoCuenta** 
.** 
Activo** 
=>** 
$str** (
,**( )
EstadoCuenta++ 
.++ 
PendienteValidacion++ (
=>++) +
$str++, 5
,++5 6
EstadoCuenta,, 
.,, 

Suspendido,, 
=>,,  "
$str,,# ,
,,,, -
EstadoCuenta-- 
.-- 
	Rechazado-- 
=>-- !
$str--" +
,--+ ,
EstadoCuenta.. 
... 
PendienteActivacion.. (
=>..) +
$str.., 5
,..5 6
_// 	
=>//
 
$str// 
}00 
;00 
}11 ‚$
]C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Utilities\BCryptPasswordHasher.cs
	namespace 	
Gtrack
 
; 
public 
class  
BCryptPasswordHasher !
:" #
IPasswordHasher$ 3
<3 4
Usuario4 ;
>; <
{ 
public 

const 
int 
FactorTrabajo "
=# $
$num% '
;' (
private 
readonly 
PasswordHasher #
<# $
Usuario$ +
>+ ,
hasherAnterior- ;
=< =
new> A
(A B
)B C
;C D
public 

string 
HashPassword 
( 
Usuario &
usuario' .
,. /
string0 6
password7 ?
)? @
=>A C
BCrypt 
. 
Net 
. 
BCrypt 
. 
HashPassword &
(& '
password' /
,/ 0
FactorTrabajo1 >
)> ?
;? @
public 
&
PasswordVerificationResult % 
VerifyHashedPassword& :
(: ;
Usuario; B
usuarioC J
,J K
stringL R
hashedPasswordS a
,a b
stringc i
providedPasswordj z
)z {
{ 
if 

( 
string 
. 
IsNullOrEmpty  
(  !
hashedPassword! /
)/ 0
||1 3
string4 :
.: ;
IsNullOrEmpty; H
(H I
providedPasswordI Y
)Y Z
)Z [
return &
PasswordVerificationResult -
.- .
Failed. 4
;4 5
if!! 

(!! 
EsHashBCrypt!! 
(!! 
hashedPassword!! '
)!!' (
)!!( )
{"" 	
try## 
{$$ 
if%% 
(%% 
!%% 
BCrypt%% 
.%% 
Net%% 
.%%  
BCrypt%%  &
.%%& '
Verify%%' -
(%%- .
providedPassword%%. >
,%%> ?
hashedPassword%%@ N
)%%N O
)%%O P
return&& &
PasswordVerificationResult&& 5
.&&5 6
Failed&&6 <
;&&< =
return(( 
BCrypt(( 
.(( 
Net(( !
.((! "
BCrypt((" (
.((( )
PasswordNeedsRehash(() <
(((< =
hashedPassword((= K
,((K L
FactorTrabajo((M Z
)((Z [
?)) &
PasswordVerificationResult)) 0
.))0 1
SuccessRehashNeeded))1 D
:** &
PasswordVerificationResult** 0
.**0 1
Success**1 8
;**8 9
}++ 
catch,, 
(,, 
BCrypt,, 
.,, 
Net,, 
.,, 
SaltParseException,, 0
),,0 1
{-- 
return.. &
PasswordVerificationResult.. 1
...1 2
Failed..2 8
;..8 9
}// 
}00 	
try33 
{44 	
return55 
hasherAnterior55 !
.55! " 
VerifyHashedPassword55" 6
(556 7
usuario557 >
,55> ?
hashedPassword55@ N
,55N O
providedPassword55P `
)55` a
==66 &
PasswordVerificationResult66 0
.660 1
Failed661 7
?77 &
PasswordVerificationResult77 ,
.77, -
Failed77- 3
:88 &
PasswordVerificationResult88 ,
.88, -
SuccessRehashNeeded88- @
;88@ A
}99 	
catch:: 
(:: 
FormatException:: 
):: 
{;; 	
return== &
PasswordVerificationResult== -
.==- .
Failed==. 4
;==4 5
}>> 	
}?? 
privateAA 
staticAA 
boolAA 
EsHashBCryptAA $
(AA$ %
stringAA% +
hashAA, 0
)AA0 1
=>AA2 4
hashBB 
.BB 
LengthBB 
==BB 
$numBB 
&&BB 
(BB 
hashBB "
.BB" #

StartsWithBB# -
(BB- .
$strBB. 4
)BB4 5
||BB6 8
hashBB9 =
.BB= >

StartsWithBB> H
(BBH I
$strBBI O
)BBO P
||BBQ S
hashBBT X
.BBX Y

StartsWithBBY c
(BBc d
$strBBd j
)BBj k
)BBk l
;BBl m
}CC ·
^C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Utilities\ActividadesEconomicas.cs
	namespace 	
Gtrack
 
; 
public 
static 
class !
ActividadesEconomicas )
{ 
public 

static 
readonly 
IReadOnlyList (
<( )
string) /
>/ 0
Lista1 6
=7 8
[ 
$str 
,  
$str 
, 
$str		  
,		  !
$str

 
,

 
$str 
, 
$str 
, 
$str "
," #
$str 
] 
; 
} “E
XC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\UbicacionService.cs
	namespace 	
Gtrack
 
; 
public 
class 
UbicacionService 
(  
IUbicacionRepository 
ubicaciones $
,$ %
IPedidoRepository 
pedidos 
, 
AppDbContext 
context 
, 
ILogger		 
<		 
UbicacionService		 
>		 
logger		 $
)		$ %
:		& '
IUbicacionService		( 9
{

 
public 

async 
Task 
< 
( 
bool 
Ok 
, 
string  &
?& '
Error( -
)- .
>. /
ActualizarAsync0 ?
(? @
int@ C
repartidorUsuarioIdD W
,W X
intY \
pedidoId] e
,e f
decimalg n
lato r
,r s
decimalt {
lng| 
)	 Ä
{ 
if 

( 
lat 
< 
- 
$num 
|| 
lat 
> 
$num  #
||$ &
lng' *
<+ ,
-- .
$num. 2
||3 5
lng6 9
>: ;
$num< @
)@ A
{ 	
return 
( 
false 
, 
$str y
)y z
;z {
} 	
var 
pedido 
= 
await 
pedidos "
." #
ObtenerPorIdAsync# 4
(4 5
pedidoId5 =
)= >
;> ?
if 

( 
pedido 
is 
null 
) 
{ 	
return 
( 
false 
, 
$str 9
)9 :
;: ;
} 	
if 

( 
pedido 
. 
EstadoPedidoId !
!=" $
(% &
int& )
)) *
EstadoPedido* 6
.6 7
EnCamino7 ?
)? @
{ 	
return 
( 
false 
, 
$str A
)A B
;B C
} 	
var!! 

repartidor!! 
=!! 
await!! 
context!! &
.!!& '
Repartidores!!' 3
."" 
AsNoTracking"" 
("" 
)"" 
.## 
FirstOrDefaultAsync##  
(##  !
r##! "
=>### %
r##& '
.##' (
	UsuarioId##( 1
==##2 4
repartidorUsuarioId##5 H
)##H I
;##I J
if%% 

(%% 

repartidor%% 
is%% 
null%% 
||%% !
pedido%%" (
.%%( )
RepartidorId%%) 5
!=%%6 8

repartidor%%9 C
.%%C D
Id%%D F
)%%F G
{&& 	
return'' 
('' 
false'' 
,'' 
$str'' B
)''B C
;''C D
}(( 	
var++ 
actual++ 
=++ 
await++ 
ubicaciones++ &
.++& '
ObtenerAsync++' 3
(++3 4
pedidoId++4 <
)++< =
;++= >
if,, 

(,, 
actual,, 
is,, 
not,, 
null,, 
),, 
{-- 	
var.. 

diferencia.. 
=.. 
DateTime.. %
...% &
UtcNow..& ,
-..- .
actual../ 5
...5 6
FechaActualizacion..6 H
;..H I
if// 
(// 

diferencia// 
>=// 
TimeSpan// &
.//& '
Zero//' +
&&//, .

diferencia/// 9
<//: ;
TimeSpan//< D
.//D E
FromSeconds//E P
(//P Q
$num//Q R
)//R S
)//S T
{00 
return11 
(11 
true11 
,11 
null11 "
)11" #
;11# $
}22 
}33 	
try55 
{66 	
await77 
ubicaciones77 
.77 
GuardarAsync77 *
(77* +
pedidoId77+ 3
,773 4
lat775 8
,778 9
lng77: =
)77= >
;77> ?
return88 
(88 
true88 
,88 
null88 
)88 
;88  
}99 	
catch:: 
(:: 
	Exception:: 
ex:: 
):: 
{;; 	
logger<< 
.<< 
LogError<< 
(<< 
ex<< 
,<< 
$str<<  U
,<<U V
pedidoId<<W _
)<<_ `
;<<` a
return== 
(== 
false== 
,== 
$str== D
)==D E
;==E F
}>> 	
}?? 
publicAA 

asyncAA 
TaskAA 
<AA 
(AA 
boolAA 
OkAA 
,AA 
stringAA  &
?AA& '
ErrorAA( -
,AA- .
decimalAA/ 6
?AA6 7
LatitudAA8 ?
,AA? @
decimalAAA H
?AAH I
LongitudAAJ R
,AAR S
DateTimeAAT \
?AA\ ]
FechaUtcAA^ f
,AAf g
stringAAh n
?AAn o
EstadoAAp v
)AAv w
>AAw x"
ObtenerPorCodigoAsync	AAy é
(
AAé è
string
AAè ï
codigoPedido
AAñ ¢
)
AA¢ £
{BB 
ifCC 

(CC 
stringCC 
.CC 
IsNullOrWhiteSpaceCC %
(CC% &
codigoPedidoCC& 2
)CC2 3
)CC3 4
{DD 	
returnEE 
(EE 
falseEE 
,EE 
$strEE ?
,EE? @
nullEEA E
,EEE F
nullEEG K
,EEK L
nullEEM Q
,EEQ R
nullEES W
)EEW X
;EEX Y
}FF 	
varHH 
pedidoHH 
=HH 
awaitHH 
pedidosHH "
.HH" #!
ObtenerPorCodigoAsyncHH# 8
(HH8 9
codigoPedidoHH9 E
.HHE F
TrimHHF J
(HHJ K
)HHK L
)HHL M
;HHM N
ifII 

(II 
pedidoII 
isII 
nullII 
)II 
{JJ 	
returnKK 
(KK 
falseKK 
,KK 
$strKK 9
,KK9 :
nullKK; ?
,KK? @
nullKKA E
,KKE F
nullKKG K
,KKK L
nullKKM Q
)KKQ R
;KKR S
}LL 	
varNN 
estadoNN 
=NN 
(NN 
(NN 
EstadoPedidoNN #
)NN# $
pedidoNN$ *
.NN* +
EstadoPedidoIdNN+ 9
)NN9 :
.NN: ;
ToStringNN; C
(NNC D
)NND E
;NNE F
ifRR 

(RR 
pedidoRR 
.RR 
EstadoPedidoIdRR !
!=RR" $
(RR% &
intRR& )
)RR) *
EstadoPedidoRR* 6
.RR6 7
EnCaminoRR7 ?
)RR? @
{SS 	
returnTT 
(TT 
falseTT 
,TT 
$strTT J
,TTJ K
nullTTL P
,TTP Q
nullTTR V
,TTV W
nullTTX \
,TT\ ]
estadoTT^ d
)TTd e
;TTe f
}UU 	
varWW 
	ubicacionWW 
=WW 
awaitWW 
ubicacionesWW )
.WW) *
ObtenerAsyncWW* 6
(WW6 7
pedidoWW7 =
.WW= >
IdWW> @
)WW@ A
;WWA B
ifXX 

(XX 
	ubicacionXX 
isXX 
nullXX 
)XX 
{YY 	
returnZZ 
(ZZ 
falseZZ 
,ZZ 
$strZZ J
,ZZJ K
nullZZL P
,ZZP Q
nullZZR V
,ZZV W
nullZZX \
,ZZ\ ]
estadoZZ^ d
)ZZd e
;ZZe f
}[[ 	
var]] 
fechaUtc]] 
=]] 
DateTime]] 
.]]  
SpecifyKind]]  +
(]]+ ,
	ubicacion]], 5
.]]5 6
FechaActualizacion]]6 H
,]]H I
DateTimeKind]]J V
.]]V W
Utc]]W Z
)]]Z [
;]][ \
return^^ 
(^^ 
true^^ 
,^^ 
null^^ 
,^^ 
	ubicacion^^ %
.^^% &
Latitud^^& -
,^^- .
	ubicacion^^/ 8
.^^8 9
Longitud^^9 A
,^^A B
fechaUtc^^C K
,^^K L
estado^^M S
)^^S T
;^^T U
}__ 
}`` ºƒ
VC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\ReporteService.cs
	namespace 	
Gtrack
 
; 
public 
class 
ReporteService 
( 
AppDbContext (
db) +
,+ ,
INegocioRepository- ?
negocios@ H
)H I
:J K
IReporteServiceL [
{ 
private 
static 
readonly 
CultureInfo '
Es( *
=+ ,
new- 0
(0 1
$str1 8
)8 9
;9 :
private

 
static

 
readonly

 
string

 "
[

" #
]

# $
Paleta

% +
=

, -
[ 	
$str	 
, 
$str 
, 
$str (
,( )
$str* 3
,3 4
$str5 >
,> ?
$str@ I
,I J
$strK T
,T U
$strV _
]_ `
;` a
private 
static 
DateTime 
InicioDiaUtc (
(( )
DateTime) 1
diaLocal2 :
): ;
=>< >
TimeZoneInfo 
. 
ConvertTimeToUtc %
(% &
DateTime 
. 
SpecifyKind  
(  !
diaLocal! )
.) *
Date* .
,. /
DateTimeKind0 <
.< =
Unspecified= H
)H I
,I J
TimeZoneInfoK W
.W X
LocalX ]
)] ^
;^ _
private 
static 
DateTime 
ALocal "
(" #
DateTime# +
fechaBd, 3
)3 4
=>5 7
DateTime 
. 
SpecifyKind 
( 
fechaBd $
,$ %
DateTimeKind& 2
.2 3
Utc3 6
)6 7
.7 8
ToLocalTime8 C
(C D
)D E
;E F
private 
static 
decimal 
Pct 
( 
int "
parte# (
,( )
int* -
total. 3
)3 4
=>5 7
total 
== 
$num 
? 
$num 
: 
Math 
. 
Round #
(# $
parte$ )
** +
$num, 0
/1 2
total3 8
,8 9
$num: ;
); <
;< =
private 
static 
string 
	NombreMes #
(# $
DateTime$ ,
f- .
). /
{ 
var 
mes 
= 
Es 
. 
DateTimeFormat #
.# $
GetMonthName$ 0
(0 1
f1 2
.2 3
Month3 8
)8 9
;9 :
return 
char 
. 
ToUpper 
( 
mes 
[  
$num  !
]! "
," #
Es$ &
)& '
+( )
mes* -
[- .
$num. /
../ 1
]1 2
+3 4
$str5 8
+9 :
f; <
.< =
Year= A
;A B
} 
private!! 
static!! 
List!! 
<!! 
DateTime!!  
>!!  !
MesesDelRango!!" /
(!!/ 0
DateTime!!0 8
desde!!9 >
,!!> ?
DateTime!!@ H
hasta!!I N
)!!N O
{"" 
var## 
meses## 
=## 
new## 
List## 
<## 
DateTime## %
>##% &
(##& '
)##' (
;##( )
var$$ 
actual$$ 
=$$ 
new$$ 
DateTime$$ !
($$! "
desde$$" '
.$$' (
Year$$( ,
,$$, -
desde$$. 3
.$$3 4
Month$$4 9
,$$9 :
$num$$; <
)$$< =
;$$= >
var%% 
fin%% 
=%% 
new%% 
DateTime%% 
(%% 
hasta%% $
.%%$ %
Year%%% )
,%%) *
hasta%%+ 0
.%%0 1
Month%%1 6
,%%6 7
$num%%8 9
)%%9 :
;%%: ;
while&& 
(&& 
actual&& 
<=&& 
fin&& 
)&& 
{'' 	
meses(( 
.(( 
Add(( 
((( 
actual(( 
)(( 
;(( 
actual)) 
=)) 
actual)) 
.)) 
	AddMonths)) %
())% &
$num))& '
)))' (
;))( )
}** 	
return++ 
meses++ 
;++ 
},, 
private.. 
static.. 
List.. 
<.. 
FilaEstadoReporte.. )
>..) *
ContarPorEstado..+ :
(..: ;
List..; ?
<..? @
int..@ C
>..C D
estados..E L
)..L M
{// 
var00 
total00 
=00 
estados00 
.00 
Count00 !
;00! "
return11 
Enum11 
.11 
	GetValues11 
<11 
EstadoPedido11 *
>11* +
(11+ ,
)11, -
.22 
Select22 
(22 
e22 
=>22 
{33 
var44 
cantidad44 
=44 
estados44 &
.44& '
Count44' ,
(44, -
x44- .
=>44/ 1
x442 3
==444 6
(447 8
int448 ;
)44; <
e44< =
)44= >
;44> ?
return55 
new55 
FilaEstadoReporte55 ,
{66 
EstadoId77 
=77 
(77  
int77  #
)77# $
e77$ %
,77% &
Estado88 
=88 
EstadoPedidoInfo88 -
.88- .
Nombre88. 4
(884 5
(885 6
int886 9
)889 :
e88: ;
)88; <
,88< =
Color99 
=99 
EstadoPedidoInfo99 ,
.99, -
Color99- 2
(992 3
(993 4
int994 7
)997 8
e998 9
)999 :
,99: ;
Cantidad:: 
=:: 
cantidad:: '
,::' (

Porcentaje;; 
=;;  
Pct;;! $
(;;$ %
cantidad;;% -
,;;- .
total;;/ 4
);;4 5
}<< 
;<< 
}== 
)== 
.>> 
ToList>> 
(>> 
)>> 
;>> 
}?? 
publicCC 

asyncCC 
TaskCC 
<CC 
ReporteNegocioDtoCC '
?CC' (
>CC( )&
GenerarReporteNegocioAsyncCC* D
(CCD E
intCCE H
usuarioNegocioIdCCI Y
,CCY Z
DateTimeCC[ c
desdeCCd i
,CCi j
DateTimeCCk s
hastaCCt y
)CCy z
{DD 
varEE 
negocioEE 
=EE 
awaitEE 
negociosEE $
.EE$ %$
ObtenerPorUsuarioIdAsyncEE% =
(EE= >
usuarioNegocioIdEE> N
)EEN O
;EEO P
ifFF 

(FF 
negocioFF 
isFF 
nullFF 
)FF 
returnFF #
nullFF$ (
;FF( )
varHH 
desdeUtcHH 
=HH 
InicioDiaUtcHH #
(HH# $
desdeHH$ )
)HH) *
;HH* +
varII 
hastaUtcII 
=II 
InicioDiaUtcII #
(II# $
hastaII$ )
.II) *
DateII* .
.II. /
AddDaysII/ 6
(II6 7
$numII7 8
)II8 9
)II9 :
;II: ;
varLL 
filasLL 
=LL 
awaitLL 
dbLL 
.LL 
PedidosLL $
.LL$ %
AsNoTrackingLL% 1
(LL1 2
)LL2 3
.MM 
WhereMM 
(MM 
pMM 
=>MM 
pMM 
.MM 
	NegocioIdMM #
==MM$ &
negocioMM' .
.MM. /
IdMM/ 1
&&MM2 4
pMM5 6
.MM6 7
FechaCreacionMM7 D
>=MME G
desdeUtcMMH P
&&MMQ S
pMMT U
.MMU V
FechaCreacionMMV c
<MMd e
hastaUtcMMf n
)MMn o
.NN 
OrderByDescendingNN 
(NN 
pNN  
=>NN! #
pNN$ %
.NN% &
FechaCreacionNN& 3
)NN3 4
.OO 
SelectOO 
(OO 
pOO 
=>OO 
newOO 
{PP 
pQQ 
.QQ 
IdQQ 
,QQ 
pRR 
.RR 
CodigoRR 
,RR 
pSS 
.SS 
	ClienteIdSS 
,SS 
pTT 
.TT 
FechaCreacionTT 
,TT  
pUU 
.UU 
EstadoPedidoIdUU  
,UU  !
ClienteVV 
=VV 
pVV 
.VV 
ClienteVV #
!=VV$ &
nullVV' +
?VV, -
pVV. /
.VV/ 0
ClienteVV0 7
.VV7 8
NombreCompletoVV8 F
:VVG H
nullVVI M
,VVM N

RepartidorWW 
=WW 
pWW 
.WW 

RepartidorWW )
!=WW* ,
nullWW- 1
?WW2 3
pWW4 5
.WW5 6

RepartidorWW6 @
.WW@ A
NombreCompletoWWA O
:WWP Q
nullWWR V
,WWV W
TotalXX 
=XX 
pXX 
.XX 
ItemsXX 
.XX  
SumXX  #
(XX# $
iXX$ %
=>XX& (
iXX) *
.XX* +
CantidadXX+ 3
*XX4 5
iXX6 7
.XX7 8
PrecioUnitarioXX8 F
)XXF G
}YY 
)YY 
.ZZ 
ToListAsyncZZ 
(ZZ 
)ZZ 
;ZZ 
var\\ 

entregados\\ 
=\\ 
filas\\ 
.\\ 
Where\\ $
(\\$ %
f\\% &
=>\\' )
f\\* +
.\\+ ,
EstadoPedidoId\\, :
==\\; =
(\\> ?
int\\? B
)\\B C
EstadoPedido\\C O
.\\O P
	Entregado\\P Y
)\\Y Z
.\\Z [
ToList\\[ a
(\\a b
)\\b c
;\\c d
var]] 

cancelados]] 
=]] 
filas]] 
.]] 
Count]] $
(]]$ %
f]]% &
=>]]' )
f]]* +
.]]+ ,
EstadoPedidoId]], :
==]]; =
(]]> ?
int]]? B
)]]B C
EstadoPedido]]C O
.]]O P
	Cancelado]]P Y
)]]Y Z
;]]Z [
var__ 
reporte__ 
=__ 
new__ 
ReporteNegocioDto__ +
{`` 	
NombreNegocioaa 
=aa 
negocioaa #
.aa# $
Nombreaa$ *
,aa* +
Desdebb 
=bb 
desdebb 
.bb 
Datebb 
,bb 
Hastacc 
=cc 
hastacc 
.cc 
Datecc 
,cc 

GeneradoEndd 
=dd 
DateTimedd !
.dd! "
Nowdd" %
,dd% &
TotalPedidosee 
=ee 
filasee  
.ee  !
Countee! &
,ee& '

Entregadosff 
=ff 

entregadosff #
.ff# $
Countff$ )
,ff) *

Canceladosgg 
=gg 

canceladosgg #
,gg# $
TasaEntregahh 
=hh 
Pcthh 
(hh 

entregadoshh (
.hh( )
Counthh) .
,hh. /
filashh0 5
.hh5 6
Counthh6 ;
)hh; <
,hh< =
ValorEntregadoii 
=ii 

entregadosii '
.ii' (
Sumii( +
(ii+ ,
fii, -
=>ii. 0
fii1 2
.ii2 3
Totalii3 8
)ii8 9
,ii9 :
	PorEstadojj 
=jj 
ContarPorEstadojj '
(jj' (
filasjj( -
.jj- .
Selectjj. 4
(jj4 5
fjj5 6
=>jj7 9
fjj: ;
.jj; <
EstadoPedidoIdjj< J
)jjJ K
.jjK L
ToListjjL R
(jjR S
)jjS T
)jjT U
,jjU V
Pedidoskk 
=kk 
filaskk 
.kk 
Selectkk "
(kk" #
fkk# $
=>kk% '
newkk( +
FilaPedidoReportekk, =
{ll 
Codigomm 
=mm 
fmm 
.mm 
Codigomm !
,mm! "
Clientenn 
=nn 
fnn 
.nn 
Clientenn #
??nn$ &
$"nn' )
$strnn) 2
{nn2 3
fnn3 4
.nn4 5
	ClienteIdnn5 >
}nn> ?
"nn? @
,nn@ A
Fechaoo 
=oo 
ALocaloo 
(oo 
foo  
.oo  !
FechaCreacionoo! .
)oo. /
,oo/ 0
Estadopp 
=pp 
EstadoPedidoInfopp )
.pp) *
Nombrepp* 0
(pp0 1
fpp1 2
.pp2 3
EstadoPedidoIdpp3 A
)ppA B
,ppB C

Repartidorqq 
=qq 
fqq 
.qq 

Repartidorqq )
??qq* ,
$strqq- :
,qq: ;

ValorTotalrr 
=rr 
frr 
.rr 
Totalrr $
}ss 
)ss 
.ss 
ToListss 
(ss 
)ss 
}tt 	
;tt	 

varww 
localesww 
=ww 
filasww 
.ww 
Selectww "
(ww" #
fww# $
=>ww% '
newww( +
{ww, -
Fechaww. 3
=ww4 5
ALocalww6 <
(ww< =
fww= >
.ww> ?
FechaCreacionww? L
)wwL M
,wwM N
fwwO P
.wwP Q
EstadoPedidoIdwwQ _
,ww_ `
fwwa b
.wwb c
Totalwwc h
}wwi j
)wwj k
.wwk l
ToListwwl r
(wwr s
)wws t
;wwt u
foreachxx 
(xx 
varxx 
mesxx 
inxx 
MesesDelRangoxx )
(xx) *
desdexx* /
,xx/ 0
hastaxx1 6
)xx6 7
)xx7 8
{yy 	
varzz 
delMeszz 
=zz 
localeszz  
.zz  !
Wherezz! &
(zz& '
fzz' (
=>zz) +
fzz, -
.zz- .
Fechazz. 3
.zz3 4
Yearzz4 8
==zz9 ;
meszz< ?
.zz? @
Yearzz@ D
&&zzE G
fzzH I
.zzI J
FechazzJ O
.zzO P
MonthzzP U
==zzV X
meszzY \
.zz\ ]
Monthzz] b
)zzb c
.zzc d
ToListzzd j
(zzj k
)zzk l
;zzl m
reporte{{ 
.{{ 
PorMes{{ 
.{{ 
Add{{ 
({{ 
new{{ "
FilaMesReporte{{# 1
{|| 
Mes}} 
=}} 
	NombreMes}} 
(}}  
mes}}  #
)}}# $
,}}$ %
Total~~ 
=~~ 
delMes~~ 
.~~ 
Count~~ $
,~~$ %

Entregados 
= 
delMes #
.# $
Count$ )
() *
f* +
=>, .
f/ 0
.0 1
EstadoPedidoId1 ?
==@ B
(C D
intD G
)G H
EstadoPedidoH T
.T U
	EntregadoU ^
)^ _
,_ `

Cancelados
ÄÄ 
=
ÄÄ 
delMes
ÄÄ #
.
ÄÄ# $
Count
ÄÄ$ )
(
ÄÄ) *
f
ÄÄ* +
=>
ÄÄ, .
f
ÄÄ/ 0
.
ÄÄ0 1
EstadoPedidoId
ÄÄ1 ?
==
ÄÄ@ B
(
ÄÄC D
int
ÄÄD G
)
ÄÄG H
EstadoPedido
ÄÄH T
.
ÄÄT U
	Cancelado
ÄÄU ^
)
ÄÄ^ _
,
ÄÄ_ `
ValorEntregado
ÅÅ 
=
ÅÅ  
delMes
ÅÅ! '
.
ÅÅ' (
Where
ÅÅ( -
(
ÅÅ- .
f
ÅÅ. /
=>
ÅÅ0 2
f
ÅÅ3 4
.
ÅÅ4 5
EstadoPedidoId
ÅÅ5 C
==
ÅÅD F
(
ÅÅG H
int
ÅÅH K
)
ÅÅK L
EstadoPedido
ÅÅL X
.
ÅÅX Y
	Entregado
ÅÅY b
)
ÅÅb c
.
ÅÅc d
Sum
ÅÅd g
(
ÅÅg h
f
ÅÅh i
=>
ÅÅj l
f
ÅÅm n
.
ÅÅn o
Total
ÅÅo t
)
ÅÅt u
}
ÇÇ 
)
ÇÇ 
;
ÇÇ 
}
ÉÉ 	
return
ÖÖ 
reporte
ÖÖ 
;
ÖÖ 
}
ÜÜ 
public
ää 

async
ää 
Task
ää 
<
ää  
HistorialExportDto
ää (
?
ää( )
>
ää) *#
ObtenerHistorialAsync
ää+ @
(
ää@ A
int
ääA D
usuarioNegocioId
ääE U
,
ääU V
DateTime
ääW _
desde
ää` e
,
ääe f
DateTime
ääg o
hasta
ääp u
)
ääu v
{
ãã 
var
åå 
negocio
åå 
=
åå 
await
åå 
negocios
åå $
.
åå$ %&
ObtenerPorUsuarioIdAsync
åå% =
(
åå= >
usuarioNegocioId
åå> N
)
ååN O
;
ååO P
if
çç 

(
çç 
negocio
çç 
is
çç 
null
çç 
)
çç 
return
çç #
null
çç$ (
;
çç( )
var
èè 
desdeUtc
èè 
=
èè 
InicioDiaUtc
èè #
(
èè# $
desde
èè$ )
)
èè) *
;
èè* +
var
êê 
hastaUtc
êê 
=
êê 
InicioDiaUtc
êê #
(
êê# $
hasta
êê$ )
.
êê) *
Date
êê* .
.
êê. /
AddDays
êê/ 6
(
êê6 7
$num
êê7 8
)
êê8 9
)
êê9 :
;
êê: ;
var
ëë 
	entregado
ëë 
=
ëë 
(
ëë 
int
ëë 
)
ëë 
EstadoPedido
ëë )
.
ëë) *
	Entregado
ëë* 3
;
ëë3 4
var
íí 
	cancelado
íí 
=
íí 
(
íí 
int
íí 
)
íí 
EstadoPedido
íí )
.
íí) *
	Cancelado
íí* 3
;
íí3 4
var
ïï 
filas
ïï 
=
ïï 
await
ïï 
db
ïï 
.
ïï 
Pedidos
ïï $
.
ïï$ %
AsNoTracking
ïï% 1
(
ïï1 2
)
ïï2 3
.
ññ 
Where
ññ 
(
ññ 
p
ññ 
=>
ññ 
p
ññ 
.
ññ 
	NegocioId
ññ #
==
ññ$ &
negocio
ññ' .
.
ññ. /
Id
ññ/ 1
&&
óó 
p
óó 
.
óó 
FechaCreacion
óó *
>=
óó+ -
desdeUtc
óó. 6
&&
óó7 9
p
óó: ;
.
óó; <
FechaCreacion
óó< I
<
óóJ K
hastaUtc
óóL T
&&
òò 
(
òò 
p
òò 
.
òò 
EstadoPedidoId
òò ,
==
òò- /
	entregado
òò0 9
||
òò: <
p
òò= >
.
òò> ?
EstadoPedidoId
òò? M
==
òòN P
	cancelado
òòQ Z
)
òòZ [
)
òò[ \
.
ôô 
OrderByDescending
ôô 
(
ôô 
p
ôô  
=>
ôô! #
p
ôô$ %
.
ôô% &
FechaCreacion
ôô& 3
)
ôô3 4
.
öö 
Select
öö 
(
öö 
p
öö 
=>
öö 
new
öö 
{
õõ 
p
úú 
.
úú 
Codigo
úú 
,
úú 
p
ùù 
.
ùù 
	ClienteId
ùù 
,
ùù 
p
ûû 
.
ûû 
FechaCreacion
ûû 
,
ûû  
p
üü 
.
üü 
EstadoPedidoId
üü  
,
üü  !
Cliente
†† 
=
†† 
p
†† 
.
†† 
Cliente
†† #
!=
††$ &
null
††' +
?
††, -
p
††. /
.
††/ 0
Cliente
††0 7
.
††7 8
NombreCompleto
††8 F
:
††G H
null
††I M
,
††M N

Repartidor
°° 
=
°° 
p
°° 
.
°° 

Repartidor
°° )
!=
°°* ,
null
°°- 1
?
°°2 3
p
°°4 5
.
°°5 6

Repartidor
°°6 @
.
°°@ A
NombreCompleto
°°A O
:
°°P Q
null
°°R V
,
°°V W
Total
¢¢ 
=
¢¢ 
p
¢¢ 
.
¢¢ 
Items
¢¢ 
.
¢¢  
Sum
¢¢  #
(
¢¢# $
i
¢¢$ %
=>
¢¢& (
i
¢¢) *
.
¢¢* +
Cantidad
¢¢+ 3
*
¢¢4 5
i
¢¢6 7
.
¢¢7 8
PrecioUnitario
¢¢8 F
)
¢¢F G
}
££ 
)
££ 
.
§§ 
ToListAsync
§§ 
(
§§ 
)
§§ 
;
§§ 
return
¶¶ 
new
¶¶  
HistorialExportDto
¶¶ %
{
ßß 	
NombreNegocio
®® 
=
®® 
negocio
®® #
.
®®# $
Nombre
®®$ *
,
®®* +
Desde
©© 
=
©© 
desde
©© 
.
©© 
Date
©© 
,
©© 
Hasta
™™ 
=
™™ 
hasta
™™ 
.
™™ 
Date
™™ 
,
™™ 

GeneradoEn
´´ 
=
´´ 
DateTime
´´ !
.
´´! "
Now
´´" %
,
´´% &
Filas
¨¨ 
=
¨¨ 
filas
¨¨ 
.
¨¨ 
Select
¨¨  
(
¨¨  !
f
¨¨! "
=>
¨¨# %
new
¨¨& )
FilaPedidoReporte
¨¨* ;
{
≠≠ 
Codigo
ÆÆ 
=
ÆÆ 
f
ÆÆ 
.
ÆÆ 
Codigo
ÆÆ !
,
ÆÆ! "
Cliente
ØØ 
=
ØØ 
f
ØØ 
.
ØØ 
Cliente
ØØ #
??
ØØ$ &
$"
ØØ' )
$str
ØØ) 2
{
ØØ2 3
f
ØØ3 4
.
ØØ4 5
	ClienteId
ØØ5 >
}
ØØ> ?
"
ØØ? @
,
ØØ@ A
Fecha
∞∞ 
=
∞∞ 
ALocal
∞∞ 
(
∞∞ 
f
∞∞  
.
∞∞  !
FechaCreacion
∞∞! .
)
∞∞. /
,
∞∞/ 0
Estado
±± 
=
±± 
EstadoPedidoInfo
±± )
.
±±) *
Nombre
±±* 0
(
±±0 1
f
±±1 2
.
±±2 3
EstadoPedidoId
±±3 A
)
±±A B
,
±±B C

Repartidor
≤≤ 
=
≤≤ 
f
≤≤ 
.
≤≤ 

Repartidor
≤≤ )
??
≤≤* ,
$str
≤≤- :
,
≤≤: ;

ValorTotal
≥≥ 
=
≥≥ 
f
≥≥ 
.
≥≥ 
Total
≥≥ $
}
¥¥ 
)
¥¥ 
.
¥¥ 
ToList
¥¥ 
(
¥¥ 
)
¥¥ 
}
µµ 	
;
µµ	 

}
∂∂ 
public
∫∫ 

async
∫∫ 
Task
∫∫ 
<
∫∫ 
ReporteAdminDto
∫∫ %
>
∫∫% &&
GenerarReporteAdminAsync
∫∫' ?
(
∫∫? @
DateTime
∫∫@ H
desde
∫∫I N
,
∫∫N O
DateTime
∫∫P X
hasta
∫∫Y ^
)
∫∫^ _
{
ªª 
var
ºº 
desdeUtc
ºº 
=
ºº 
InicioDiaUtc
ºº #
(
ºº# $
desde
ºº$ )
)
ºº) *
;
ºº* +
var
ΩΩ 
hastaUtc
ΩΩ 
=
ΩΩ 
InicioDiaUtc
ΩΩ #
(
ΩΩ# $
hasta
ΩΩ$ )
.
ΩΩ) *
Date
ΩΩ* .
.
ΩΩ. /
AddDays
ΩΩ/ 6
(
ΩΩ6 7
$num
ΩΩ7 8
)
ΩΩ8 9
)
ΩΩ9 :
;
ΩΩ: ;
var
¿¿ 
negociosRango
¿¿ 
=
¿¿ 
await
¿¿ !
db
¿¿" $
.
¿¿$ %
Negocios
¿¿% -
.
¿¿- .
AsNoTracking
¿¿. :
(
¿¿: ;
)
¿¿; <
.
¡¡ 
Where
¡¡ 
(
¡¡ 
n
¡¡ 
=>
¡¡ 
n
¡¡ 
.
¡¡ 
FechaRegistro
¡¡ '
>=
¡¡( *
desdeUtc
¡¡+ 3
&&
¡¡4 6
n
¡¡7 8
.
¡¡8 9
FechaRegistro
¡¡9 F
<
¡¡G H
hastaUtc
¡¡I Q
)
¡¡Q R
.
¬¬ 
OrderByDescending
¬¬ 
(
¬¬ 
n
¬¬  
=>
¬¬! #
n
¬¬$ %
.
¬¬% &
FechaRegistro
¬¬& 3
)
¬¬3 4
.
√√ 
Select
√√ 
(
√√ 
n
√√ 
=>
√√ 
new
√√ 
{
ƒƒ 
n
≈≈ 
.
≈≈ 
Nombre
≈≈ 
,
≈≈ 
n
∆∆ 
.
∆∆ 
TipoActividad
∆∆ 
,
∆∆  
	Documento
«« 
=
«« 
n
«« 
.
«« 
Usuario
«« %
!
««% &
.
««& '
	Documento
««' 0
,
««0 1
Correo
»» 
=
»» 
n
»» 
.
»» 
Usuario
»» "
.
»»" #
Correo
»»# )
,
»») *
n
…… 
.
…… 
FechaRegistro
…… 
,
……  
Estado
   
=
   
n
   
.
   
Usuario
   "
.
  " #
Estado
  # )
}
ÀÀ 
)
ÀÀ 
.
ÃÃ 
ToListAsync
ÃÃ 
(
ÃÃ 
)
ÃÃ 
;
ÃÃ 
var
ŒŒ 
activosTotal
ŒŒ 
=
ŒŒ 
await
ŒŒ  
db
ŒŒ! #
.
ŒŒ# $
Negocios
ŒŒ$ ,
.
ŒŒ, -

CountAsync
ŒŒ- 7
(
ŒŒ7 8
n
ŒŒ8 9
=>
ŒŒ: <
n
ŒŒ= >
.
ŒŒ> ?
Usuario
ŒŒ? F
!
ŒŒF G
.
ŒŒG H
Estado
ŒŒH N
==
ŒŒO Q
EstadoCuenta
ŒŒR ^
.
ŒŒ^ _
Activo
ŒŒ_ e
)
ŒŒe f
;
ŒŒf g
var
œœ 
repartidores
œœ 
=
œœ 
await
œœ  
db
œœ! #
.
œœ# $
Repartidores
œœ$ 0
.
–– 

CountAsync
–– 
(
–– 
r
–– 
=>
–– 
r
–– 
.
–– 
FechaRegistro
–– ,
>=
––- /
desdeUtc
––0 8
&&
––9 ;
r
––< =
.
––= >
FechaRegistro
––> K
<
––L M
hastaUtc
––N V
)
––V W
;
––W X
var
”” 
pedidos
”” 
=
”” 
await
”” 
db
”” 
.
”” 
Pedidos
”” &
.
””& '
AsNoTracking
””' 3
(
””3 4
)
””4 5
.
‘‘ 
Where
‘‘ 
(
‘‘ 
p
‘‘ 
=>
‘‘ 
p
‘‘ 
.
‘‘ 
FechaCreacion
‘‘ '
>=
‘‘( *
desdeUtc
‘‘+ 3
&&
‘‘4 6
p
‘‘7 8
.
‘‘8 9
FechaCreacion
‘‘9 F
<
‘‘G H
hastaUtc
‘‘I Q
)
‘‘Q R
.
’’ 
Select
’’ 
(
’’ 
p
’’ 
=>
’’ 
new
’’ 
{
÷÷ 
p
◊◊ 
.
◊◊ 
	NegocioId
◊◊ 
,
◊◊ 
p
ÿÿ 
.
ÿÿ 
EstadoPedidoId
ÿÿ  
,
ÿÿ  !
Total
ŸŸ 
=
ŸŸ 
p
ŸŸ 
.
ŸŸ 
Items
ŸŸ 
.
ŸŸ  
Sum
ŸŸ  #
(
ŸŸ# $
i
ŸŸ$ %
=>
ŸŸ& (
i
ŸŸ) *
.
ŸŸ* +
Cantidad
ŸŸ+ 3
*
ŸŸ4 5
i
ŸŸ6 7
.
ŸŸ7 8
PrecioUnitario
ŸŸ8 F
)
ŸŸF G
}
⁄⁄ 
)
⁄⁄ 
.
€€ 
ToListAsync
€€ 
(
€€ 
)
€€ 
;
€€ 
var
›› 
entregadosPedidos
›› 
=
›› 
pedidos
››  '
.
››' (
Where
››( -
(
››- .
p
››. /
=>
››0 2
p
››3 4
.
››4 5
EstadoPedidoId
››5 C
==
››D F
(
››G H
int
››H K
)
››K L
EstadoPedido
››L X
.
››X Y
	Entregado
››Y b
)
››b c
.
››c d
ToList
››d j
(
››j k
)
››k l
;
››l m
var
ﬂﬂ 
reporte
ﬂﬂ 
=
ﬂﬂ 
new
ﬂﬂ 
ReporteAdminDto
ﬂﬂ )
{
‡‡ 	
Desde
·· 
=
·· 
desde
·· 
.
·· 
Date
·· 
,
·· 
Hasta
‚‚ 
=
‚‚ 
hasta
‚‚ 
.
‚‚ 
Date
‚‚ 
,
‚‚ 

GeneradoEn
„„ 
=
„„ 
DateTime
„„ !
.
„„! "
Now
„„" %
,
„„% &!
NegociosRegistrados
‰‰ 
=
‰‰  !
negociosRango
‰‰" /
.
‰‰/ 0
Count
‰‰0 5
,
‰‰5 6"
NegociosActivosTotal
ÂÂ  
=
ÂÂ! "
activosTotal
ÂÂ# /
,
ÂÂ/ 0%
RepartidoresRegistrados
ÊÊ #
=
ÊÊ$ %
repartidores
ÊÊ& 2
,
ÊÊ2 3
TotalPedidos
ÁÁ 
=
ÁÁ 
pedidos
ÁÁ "
.
ÁÁ" #
Count
ÁÁ# (
,
ÁÁ( )
PedidosEntregados
ËË 
=
ËË 
entregadosPedidos
ËË  1
.
ËË1 2
Count
ËË2 7
,
ËË7 8
ValorEntregado
ÈÈ 
=
ÈÈ 
entregadosPedidos
ÈÈ .
.
ÈÈ. /
Sum
ÈÈ/ 2
(
ÈÈ2 3
p
ÈÈ3 4
=>
ÈÈ5 7
p
ÈÈ8 9
.
ÈÈ9 :
Total
ÈÈ: ?
)
ÈÈ? @
,
ÈÈ@ A
PedidosPorEstado
ÍÍ 
=
ÍÍ 
ContarPorEstado
ÍÍ .
(
ÍÍ. /
pedidos
ÍÍ/ 6
.
ÍÍ6 7
Select
ÍÍ7 =
(
ÍÍ= >
p
ÍÍ> ?
=>
ÍÍ@ B
p
ÍÍC D
.
ÍÍD E
EstadoPedidoId
ÍÍE S
)
ÍÍS T
.
ÍÍT U
ToList
ÍÍU [
(
ÍÍ[ \
)
ÍÍ\ ]
)
ÍÍ] ^
,
ÍÍ^ _
Negocios
ÎÎ 
=
ÎÎ 
negociosRango
ÎÎ $
.
ÎÎ$ %
Select
ÎÎ% +
(
ÎÎ+ ,
n
ÎÎ, -
=>
ÎÎ. 0
new
ÎÎ1 4 
FilaNegocioReporte
ÎÎ5 G
{
ÏÏ 
Nombre
ÌÌ 
=
ÌÌ 
n
ÌÌ 
.
ÌÌ 
Nombre
ÌÌ !
,
ÌÌ! "
	Actividad
ÓÓ 
=
ÓÓ 
n
ÓÓ 
.
ÓÓ 
TipoActividad
ÓÓ +
,
ÓÓ+ ,
	Documento
ÔÔ 
=
ÔÔ 
n
ÔÔ 
.
ÔÔ 
	Documento
ÔÔ '
,
ÔÔ' (
Correo
 
=
 
n
 
.
 
Correo
 !
,
! "
FechaRegistro
ÒÒ 
=
ÒÒ 
ALocal
ÒÒ  &
(
ÒÒ& '
n
ÒÒ' (
.
ÒÒ( )
FechaRegistro
ÒÒ) 6
)
ÒÒ6 7
,
ÒÒ7 8
Estado
ÚÚ 
=
ÚÚ 
EstadoPedidoInfo
ÚÚ )
.
ÚÚ) *
NombreCuenta
ÚÚ* 6
(
ÚÚ6 7
n
ÚÚ7 8
.
ÚÚ8 9
Estado
ÚÚ9 ?
)
ÚÚ? @
}
ÛÛ 
)
ÛÛ 
.
ÛÛ 
ToList
ÛÛ 
(
ÛÛ 
)
ÛÛ 
}
ÙÙ 	
;
ÙÙ	 

var
˜˜ 
fechasLocales
˜˜ 
=
˜˜ 
negociosRango
˜˜ )
.
˜˜) *
Select
˜˜* 0
(
˜˜0 1
n
˜˜1 2
=>
˜˜3 5
ALocal
˜˜6 <
(
˜˜< =
n
˜˜= >
.
˜˜> ?
FechaRegistro
˜˜? L
)
˜˜L M
)
˜˜M N
.
˜˜N O
ToList
˜˜O U
(
˜˜U V
)
˜˜V W
;
˜˜W X
foreach
¯¯ 
(
¯¯ 
var
¯¯ 
mes
¯¯ 
in
¯¯ 
MesesDelRango
¯¯ )
(
¯¯) *
desde
¯¯* /
,
¯¯/ 0
hasta
¯¯1 6
)
¯¯6 7
)
¯¯7 8
{
˘˘ 	
reporte
˙˙ 
.
˙˙ 
NegociosPorMes
˙˙ "
.
˙˙" #
Add
˙˙# &
(
˙˙& '
new
˙˙' *
FilaMesReporte
˙˙+ 9
{
˚˚ 
Mes
¸¸ 
=
¸¸ 
	NombreMes
¸¸ 
(
¸¸  
mes
¸¸  #
)
¸¸# $
,
¸¸$ %
Total
˝˝ 
=
˝˝ 
fechasLocales
˝˝ %
.
˝˝% &
Count
˝˝& +
(
˝˝+ ,
f
˝˝, -
=>
˝˝. 0
f
˝˝1 2
.
˝˝2 3
Year
˝˝3 7
==
˝˝8 :
mes
˝˝; >
.
˝˝> ?
Year
˝˝? C
&&
˝˝D F
f
˝˝G H
.
˝˝H I
Month
˝˝I N
==
˝˝O Q
mes
˝˝R U
.
˝˝U V
Month
˝˝V [
)
˝˝[ \
}
˛˛ 
)
˛˛ 
;
˛˛ 
}
ˇˇ 	
reporte
ÇÇ 
.
ÇÇ 
NegociosPorEstado
ÇÇ !
=
ÇÇ" #
Enum
ÇÇ$ (
.
ÇÇ( )
	GetValues
ÇÇ) 2
<
ÇÇ2 3
EstadoCuenta
ÇÇ3 ?
>
ÇÇ? @
(
ÇÇ@ A
)
ÇÇA B
.
ÉÉ 
Select
ÉÉ 
(
ÉÉ 
e
ÉÉ 
=>
ÉÉ 
{
ÑÑ 
var
ÖÖ 
cantidad
ÖÖ 
=
ÖÖ 
negociosRango
ÖÖ ,
.
ÖÖ, -
Count
ÖÖ- 2
(
ÖÖ2 3
n
ÖÖ3 4
=>
ÖÖ5 7
n
ÖÖ8 9
.
ÖÖ9 :
Estado
ÖÖ: @
==
ÖÖA C
e
ÖÖD E
)
ÖÖE F
;
ÖÖF G
return
ÜÜ 
new
ÜÜ 
FilaConteoReporte
ÜÜ ,
{
áá 
Etiqueta
àà 
=
àà 
EstadoPedidoInfo
àà /
.
àà/ 0
NombreCuenta
àà0 <
(
àà< =
e
àà= >
)
àà> ?
,
àà? @
Color
ââ 
=
ââ 
EstadoPedidoInfo
ââ ,
.
ââ, -
ColorCuenta
ââ- 8
(
ââ8 9
e
ââ9 :
)
ââ: ;
,
ââ; <
Cantidad
ää 
=
ää 
cantidad
ää '
,
ää' (

Porcentaje
ãã 
=
ãã  
Pct
ãã! $
(
ãã$ %
cantidad
ãã% -
,
ãã- .
negociosRango
ãã/ <
.
ãã< =
Count
ãã= B
)
ããB C
}
åå 
;
åå 
}
çç 
)
çç 
.
éé 
Where
éé 
(
éé 
f
éé 
=>
éé 
f
éé 
.
éé 
Cantidad
éé "
>
éé# $
$num
éé% &
)
éé& '
.
èè 
ToList
èè 
(
èè 
)
èè 
;
èè 
reporte
íí 
.
íí "
NegociosPorActividad
íí $
=
íí% &
negociosRango
íí' 4
.
ìì 
GroupBy
ìì 
(
ìì 
n
ìì 
=>
ìì 
string
ìì  
.
ìì  ! 
IsNullOrWhiteSpace
ìì! 3
(
ìì3 4
n
ìì4 5
.
ìì5 6
TipoActividad
ìì6 C
)
ììC D
?
ììE F
$str
ììG V
:
ììW X
n
ììY Z
.
ììZ [
TipoActividad
ìì[ h
)
ììh i
.
îî 
OrderByDescending
îî 
(
îî 
g
îî  
=>
îî! #
g
îî$ %
.
îî% &
Count
îî& +
(
îî+ ,
)
îî, -
)
îî- .
.
ïï 
ThenBy
ïï 
(
ïï 
g
ïï 
=>
ïï 
g
ïï 
.
ïï 
Key
ïï 
)
ïï 
.
ññ 
Select
ññ 
(
ññ 
(
ññ 
g
ññ 
,
ññ 
i
ññ 
)
ññ 
=>
ññ 
new
ññ !
FilaConteoReporte
ññ" 3
{
óó 
Etiqueta
òò 
=
òò 
g
òò 
.
òò 
Key
òò  
,
òò  !
Color
ôô 
=
ôô 
Paleta
ôô 
[
ôô 
i
ôô  
%
ôô! "
Paleta
ôô# )
.
ôô) *
Length
ôô* 0
]
ôô0 1
,
ôô1 2
Cantidad
öö 
=
öö 
g
öö 
.
öö 
Count
öö "
(
öö" #
)
öö# $
,
öö$ %

Porcentaje
õõ 
=
õõ 
Pct
õõ  
(
õõ  !
g
õõ! "
.
õõ" #
Count
õõ# (
(
õõ( )
)
õõ) *
,
õõ* +
negociosRango
õõ, 9
.
õõ9 :
Count
õõ: ?
)
õõ? @
}
úú 
)
úú 
.
ùù 
ToList
ùù 
(
ùù 
)
ùù 
;
ùù 
var
†† 
top
†† 
=
†† 
pedidos
†† 
.
°° 
GroupBy
°° 
(
°° 
p
°° 
=>
°° 
p
°° 
.
°° 
	NegocioId
°° %
)
°°% &
.
¢¢ 
Select
¢¢ 
(
¢¢ 
g
¢¢ 
=>
¢¢ 
new
¢¢ 
{
££ 
	NegocioId
§§ 
=
§§ 
g
§§ 
.
§§ 
Key
§§ !
,
§§! "
Pedidos
•• 
=
•• 
g
•• 
.
•• 
Count
•• !
(
••! "
)
••" #
,
••# $

Entregados
¶¶ 
=
¶¶ 
g
¶¶ 
.
¶¶ 
Count
¶¶ $
(
¶¶$ %
p
¶¶% &
=>
¶¶' )
p
¶¶* +
.
¶¶+ ,
EstadoPedidoId
¶¶, :
==
¶¶; =
(
¶¶> ?
int
¶¶? B
)
¶¶B C
EstadoPedido
¶¶C O
.
¶¶O P
	Entregado
¶¶P Y
)
¶¶Y Z
,
¶¶Z [
Valor
ßß 
=
ßß 
g
ßß 
.
ßß 
Where
ßß 
(
ßß  
p
ßß  !
=>
ßß" $
p
ßß% &
.
ßß& '
EstadoPedidoId
ßß' 5
==
ßß6 8
(
ßß9 :
int
ßß: =
)
ßß= >
EstadoPedido
ßß> J
.
ßßJ K
	Entregado
ßßK T
)
ßßT U
.
ßßU V
Sum
ßßV Y
(
ßßY Z
p
ßßZ [
=>
ßß\ ^
p
ßß_ `
.
ßß` a
Total
ßßa f
)
ßßf g
}
®® 
)
®® 
.
©© 
OrderByDescending
©© 
(
©© 
x
©©  
=>
©©! #
x
©©$ %
.
©©% &
Pedidos
©©& -
)
©©- .
.
™™ 
ThenBy
™™ 
(
™™ 
x
™™ 
=>
™™ 
x
™™ 
.
™™ 
	NegocioId
™™ $
)
™™$ %
.
´´ 
Take
´´ 
(
´´ 
$num
´´ 
)
´´ 
.
¨¨ 
ToList
¨¨ 
(
¨¨ 
)
¨¨ 
;
¨¨ 
if
ÆÆ 

(
ÆÆ 
top
ÆÆ 
.
ÆÆ 
Count
ÆÆ 
>
ÆÆ 
$num
ÆÆ 
)
ÆÆ 
{
ØØ 	
var
∞∞ 
ids
∞∞ 
=
∞∞ 
top
∞∞ 
.
∞∞ 
Select
∞∞  
(
∞∞  !
t
∞∞! "
=>
∞∞# %
t
∞∞& '
.
∞∞' (
	NegocioId
∞∞( 1
)
∞∞1 2
.
∞∞2 3
ToList
∞∞3 9
(
∞∞9 :
)
∞∞: ;
;
∞∞; <
var
±± 
nombres
±± 
=
±± 
await
±± 
db
±±  "
.
±±" #
Negocios
±±# +
.
±±+ ,
AsNoTracking
±±, 8
(
±±8 9
)
±±9 :
.
≤≤ 
Where
≤≤ 
(
≤≤ 
n
≤≤ 
=>
≤≤ 
ids
≤≤ 
.
≤≤  
Contains
≤≤  (
(
≤≤( )
n
≤≤) *
.
≤≤* +
Id
≤≤+ -
)
≤≤- .
)
≤≤. /
.
≥≥ 
ToDictionaryAsync
≥≥ "
(
≥≥" #
n
≥≥# $
=>
≥≥% '
n
≥≥( )
.
≥≥) *
Id
≥≥* ,
,
≥≥, -
n
≥≥. /
=>
≥≥0 2
n
≥≥3 4
.
≥≥4 5
Nombre
≥≥5 ;
)
≥≥; <
;
≥≥< =
reporte
µµ 
.
µµ 
TopNegocios
µµ 
=
µµ  !
top
µµ" %
.
µµ% &
Select
µµ& ,
(
µµ, -
t
µµ- .
=>
µµ/ 1
new
µµ2 5#
FilaTopNegocioReporte
µµ6 K
{
∂∂ 
Nombre
∑∑ 
=
∑∑ 
nombres
∑∑  
.
∑∑  !
GetValueOrDefault
∑∑! 2
(
∑∑2 3
t
∑∑3 4
.
∑∑4 5
	NegocioId
∑∑5 >
,
∑∑> ?
$"
∑∑@ B
$str
∑∑B K
{
∑∑K L
t
∑∑L M
.
∑∑M N
	NegocioId
∑∑N W
}
∑∑W X
"
∑∑X Y
)
∑∑Y Z
,
∑∑Z [
Pedidos
∏∏ 
=
∏∏ 
t
∏∏ 
.
∏∏ 
Pedidos
∏∏ #
,
∏∏# $

Entregados
ππ 
=
ππ 
t
ππ 
.
ππ 

Entregados
ππ )
,
ππ) *
ValorEntregado
∫∫ 
=
∫∫  
t
∫∫! "
.
∫∫" #
Valor
∫∫# (
}
ªª 
)
ªª 
.
ªª 
ToList
ªª 
(
ªª 
)
ªª 
;
ªª 
}
ºº 	
return
ææ 
reporte
ææ 
;
ææ 
}
øø 
}¿¿ ﬂå
YC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\RepartidorService.cs
	namespace 	
Gtrack
 
; 
public 
	interface 
IRepartidorService #
{ 
Task 
< 	
ResultadoRegistro	 
> 
RegistrarAsync *
(* +
int+ .
usuarioNegocioId/ ?
,? @!
RegistroRepartidorDtoA V
dtoW Z
,Z [
Func\ `
<` a
stringa g
,g h
stringi o
>o p
construirEnlace	q Ä
)
Ä Å
;
Å Ç
Task 
< 	
(	 

bool
 
Ok 
, 
string 
Mensaje !
)! "
>" ##
ReenviarActivacionAsync$ ;
(; <
int< ?
usuarioNegocioId@ P
,P Q
intR U
repartidorIdV b
,b c
Funcd h
<h i
stringi o
,o p
stringq w
>w x
construirEnlace	y à
)
à â
;
â ä
Task 
< 	
List	 
< 

Repartidor 
> 
> 
ListarAsync &
(& '
int' *
usuarioNegocioId+ ;
); <
;< =
} 
public 
class 
RepartidorService 
( !
IRepartidorRepository 
repartidores &
,& '
INegocioRepository 
negocios 
,  
IUsuarioRepository 
usuarios 
,  $
IActivacionCuentaService 

activacion '
,' (
ILogger 
< 
RepartidorService 
> 
logger %
)% &
:' (
IRepartidorService) ;
{ 
private 
const 
int '
MaxCorreosActivacionPorHora 1
=2 3
$num4 5
;5 6
public 

async 
Task 
< 
List 
< 

Repartidor %
>% &
>& '
ListarAsync( 3
(3 4
int4 7
usuarioNegocioId8 H
)H I
{ 
var 
negocio 
= 
await 
negocios $
.$ %$
ObtenerPorUsuarioIdAsync% =
(= >
usuarioNegocioId> N
)N O
;O P
return 
negocio 
is 
null 
?  
[! "
]" #
:$ %
await& +
repartidores, 8
.8 9!
ListarPorNegocioAsync9 N
(N O
negocioO V
.V W
IdW Y
)Y Z
;Z [
} 
public   

async   
Task   
<   
ResultadoRegistro   '
>  ' (
RegistrarAsync  ) 7
(  7 8
int  8 ;
usuarioNegocioId  < L
,  L M!
RegistroRepartidorDto  N c
dto  d g
,  g h
Func  i m
<  m n
string  n t
,  t u
string  v |
>  | }
construirEnlace	  ~ ç
)
  ç é
{!! 
var"" 
negocio"" 
="" 
await"" 
negocios"" $
.""$ %$
ObtenerPorUsuarioIdAsync""% =
(""= >
usuarioNegocioId""> N
)""N O
;""O P
if## 

(## 
negocio## 
is## 
null## 
)## 
return## #
new##$ '
(##' (
false##( -
,##- .
$str##/ V
,##V W
false##X ]
,##] ^
null##_ c
)##c d
;##d e
var%% 
	documento%% 
=%% 
dto%% 
.%% 
	Documento%% %
.%%% &
Trim%%& *
(%%* +
)%%+ ,
;%%, -
var&& 
correo&& 
=&& 
dto&& 
.&& 
Correo&& 
.&&  
Trim&&  $
(&&$ %
)&&% &
;&&& '
var'' 
telefono'' 
='' 
dto'' 
.'' 
Telefono'' #
.''# $
Trim''$ (
(''( )
)'') *
;''* +
var++ 
anterior++ 
=++ 
await++ 
repartidores++ )
.++) * 
BuscarEliminadoAsync++* >
(++> ?
correo++? E
,++E F
	documento++G P
)++P Q
;++Q R
await.. 
usuarios.. 
... "
LiberarEliminadosAsync.. -
(..- .
correo... 4
,..4 5
	documento..6 ?
)..? @
;..@ A
if11 

(11 
await11 
negocios11 
.11  
ExisteDocumentoAsync11 /
(11/ 0
	documento110 9
)119 :
)11: ;
return22 
new22 
(22 
false22 
,22 
$str22 T
,22T U
false22V [
,22[ \
null22] a
,22a b
nameof22c i
(22i j
dto22j m
.22m n
	Documento22n w
)22w x
)22x y
;22y z
if33 

(33 
await33 
usuarios33 
.33 !
ObtenerPorCorreoAsync33 0
(330 1
correo331 7
)337 8
is339 ;
not33< ?
null33@ D
)33D E
return44 
new44 
(44 
false44 
,44 
$str44 S
,44S T
false44U Z
,44Z [
null44\ `
,44` a
nameof44b h
(44h i
dto44i l
.44l m
Correo44m s
)44s t
)44t u
;44u v
if55 

(55 
await55 
repartidores55 
.55 
TelefonoEnUsoAsync55 1
(551 2
telefono552 :
)55: ;
)55; <
return66 
new66 
(66 
false66 
,66 
$str66 I
,66I J
false66K P
,66P Q
null66R V
,66V W
nameof66X ^
(66^ _
dto66_ b
.66b c
Telefono66c k
)66k l
)66l m
;66m n
var88 
conPlaca88 
=88 
dto88 
.88 
Vehiculo88 #
is88$ &
TipoVehiculo88' 3
.883 4
Moto884 8
or889 ;
TipoVehiculo88< H
.88H I
Carro88I N
;88N O
if:: 

(:: 
anterior:: 
?:: 
.:: 
Usuario:: 
is::  
not::! $
null::% )
)::) *
return;; 
await;; 
ReactivarAsync;; '
(;;' (
anterior;;( 0
,;;0 1
negocio;;2 9
,;;9 :
dto;;; >
,;;> ?
correo;;@ F
,;;F G
	documento;;H Q
,;;Q R
telefono;;S [
,;;[ \
conPlaca;;] e
,;;e f
construirEnlace;;g v
);;v w
;;;w x
var>> 
usuario>> 
=>> 
new>> 
Usuario>> !
{?? 	
Correo@@ 
=@@ 
correo@@ 
,@@ 
	DocumentoAA 
=AA 
	documentoAA !
,AA! "
PasswordHashBB 
=BB 
$strBB 
,BB 
RolCC 
=CC 

RolUsuarioCC 
.CC 

RepartidorCC '
,CC' (
EstadoDD 
=DD 
EstadoCuentaDD !
.DD! "
PendienteActivacionDD" 5
}EE 	
;EE	 

varGG 

repartidorGG 
=GG 
newGG 

RepartidorGG '
{HH 	
	NegocioIdII 
=II 
negocioII 
.II  
IdII  "
,II" #
NombreCompletoJJ 
=JJ 
dtoJJ  
.JJ  !
NombreCompletoJJ! /
.JJ/ 0
TrimJJ0 4
(JJ4 5
)JJ5 6
,JJ6 7
TelefonoKK 
=KK 
telefonoKK 
,KK  
VehiculoLL 
=LL 
dtoLL 
.LL 
VehiculoLL #
!LL# $
.LL$ %
ValueLL% *
,LL* +
PlacaMM 
=MM 
conPlacaMM 
?MM 
ReglasValidacionMM /
.MM/ 0
NormalizarPlacaMM0 ?
(MM? @
dtoMM@ C
.MMC D
PlacaMMD I
)MMI J
:MMK L
nullMMM Q
}NN 	
;NN	 

tryPP 
{QQ 	
awaitRR 
repartidoresRR 
.RR $
RegistrarRepartidorAsyncRR 7
(RR7 8
usuarioRR8 ?
,RR? @

repartidorRRA K
)RRK L
;RRL M
}SS 	
catchTT 
(TT 
DbUpdateExceptionTT  
exTT! #
)TT# $
{UU 	
loggerVV 
.VV 
LogErrorVV 
(VV 
exVV 
,VV 
$strVV  K
,VVK L
correoVVM S
)VVS T
;VVT U
returnWW 
newWW 
(WW 
falseWW 
,WW 
$strWW Z
,WWZ [
falseWW\ a
,WWa b
nullWWc g
)WWg h
;WWh i
}XX 	
var[[ 
enviado[[ 
=[[ 
await[[ 

activacion[[ &
.[[& '
EnviarEnlaceAsync[[' 8
([[8 9
usuario[[9 @
,[[@ A

repartidor[[B L
.[[L M
NombreCompleto[[M [
,[[[ \
negocio[[] d
.[[d e
Nombre[[e k
,[[k l
construirEnlace[[m |
)[[| }
;[[} ~
return\\ 
new\\ 
(\\ 
true\\ 
,\\ 
null\\ 
,\\ 
enviado\\ &
,\\& '
null\\( ,
)\\, -
;\\- .
}]] 
private__ 
async__ 
Task__ 
<__ 
ResultadoRegistro__ (
>__( )
ReactivarAsync__* 8
(__8 9

Repartidor__9 C
rep__D G
,__G H
Negocio__I P
negocio__Q X
,__X Y!
RegistroRepartidorDto__Z o
dto__p s
,__s t
string`` 
correo`` 
,`` 
string`` 
	documento`` '
,``' (
string``) /
telefono``0 8
,``8 9
bool``: >
conPlaca``? G
,``G H
Func``I M
<``M N
string``N T
,``T U
string``V \
>``\ ]
construirEnlace``^ m
)``m n
{aa 
varbb 
usuariobb 
=bb 
repbb 
.bb 
Usuariobb !
!bb! "
;bb" #
usuariocc 
.cc 
Correocc 
=cc 
correocc 
;cc  
usuariodd 
.dd 
	Documentodd 
=dd 
	documentodd %
;dd% &
usuarioee 
.ee 
PasswordHashee 
=ee 
$stree !
;ee! "
usuarioff 
.ff 
Estadoff 
=ff 
EstadoCuentaff %
.ff% &
PendienteActivacionff& 9
;ff9 :
usuariogg 
.gg 
IntentosFallidosgg  
=gg! "
$numgg# $
;gg$ %
usuariohh 
.hh 
BloqueadoHastahh 
=hh  
nullhh! %
;hh% &
usuarioii 
.ii 
MotivoRechazoii 
=ii 
nullii  $
;ii$ %
repkk 
.kk 
	NegocioIdkk 
=kk 
negociokk 
.kk  
Idkk  "
;kk" #
repll 
.ll 
NombreCompletoll 
=ll 
dtoll  
.ll  !
NombreCompletoll! /
.ll/ 0
Trimll0 4
(ll4 5
)ll5 6
;ll6 7
repmm 
.mm 
Telefonomm 
=mm 
telefonomm 
;mm  
repnn 
.nn 
Vehiculonn 
=nn 
dtonn 
.nn 
Vehiculonn #
!nn# $
.nn$ %
Valuenn% *
;nn* +
repoo 
.oo 
Placaoo 
=oo 
conPlacaoo 
?oo 
ReglasValidacionoo /
.oo/ 0
NormalizarPlacaoo0 ?
(oo? @
dtooo@ C
.ooC D
PlacaooD I
)ooI J
:ooK L
nullooM Q
;ooQ R
reppp 
.pp 
FechaRegistropp 
=pp 
DateTimepp $
.pp$ %
UtcNowpp% +
;pp+ ,
tryrr 
{ss 	
awaittt 
repartidorestt 
.tt 
ReactivarAsynctt -
(tt- .
reptt. 1
)tt1 2
;tt2 3
}uu 	
catchvv 
(vv 
DbUpdateExceptionvv  
exvv! #
)vv# $
{ww 	
loggerxx 
.xx 
LogErrorxx 
(xx 
exxx 
,xx 
$strxx  M
,xxM N
correoxxO U
)xxU V
;xxV W
returnyy 
newyy 
(yy 
falseyy 
,yy 
$stryy Z
,yyZ [
falseyy\ a
,yya b
nullyyc g
)yyg h
;yyh i
}zz 	
var|| 
enviado|| 
=|| 
await|| 

activacion|| &
.||& '
EnviarEnlaceAsync||' 8
(||8 9
usuario||9 @
,||@ A
rep||B E
.||E F
NombreCompleto||F T
,||T U
negocio||V ]
.||] ^
Nombre||^ d
,||d e
construirEnlace||f u
)||u v
;||v w
return}} 
new}} 
(}} 
true}} 
,}} 
null}} 
,}} 
enviado}} &
,}}& '
null}}( ,
)}}, -
;}}- .
}~~ 
public
ÄÄ 

async
ÄÄ 
Task
ÄÄ 
<
ÄÄ 
(
ÄÄ 
bool
ÄÄ 
Ok
ÄÄ 
,
ÄÄ 
string
ÄÄ  &
Mensaje
ÄÄ' .
)
ÄÄ. /
>
ÄÄ/ 0%
ReenviarActivacionAsync
ÄÄ1 H
(
ÄÄH I
int
ÄÄI L
usuarioNegocioId
ÄÄM ]
,
ÄÄ] ^
int
ÄÄ_ b
repartidorId
ÄÄc o
,
ÄÄo p
Func
ÄÄq u
<
ÄÄu v
string
ÄÄv |
,
ÄÄ| }
stringÄÄ~ Ñ
>ÄÄÑ Ö
construirEnlaceÄÄÜ ï
)ÄÄï ñ
{
ÅÅ 
var
ÇÇ 
negocio
ÇÇ 
=
ÇÇ 
await
ÇÇ 
negocios
ÇÇ $
.
ÇÇ$ %&
ObtenerPorUsuarioIdAsync
ÇÇ% =
(
ÇÇ= >
usuarioNegocioId
ÇÇ> N
)
ÇÇN O
;
ÇÇO P
if
ÉÉ 

(
ÉÉ 
negocio
ÉÉ 
is
ÉÉ 
null
ÉÉ 
)
ÉÉ 
return
ÉÉ #
(
ÉÉ$ %
false
ÉÉ% *
,
ÉÉ* +
$str
ÉÉ, S
)
ÉÉS T
;
ÉÉT U
var
ÖÖ 

repartidor
ÖÖ 
=
ÖÖ 
await
ÖÖ 
repartidores
ÖÖ +
.
ÖÖ+ ,#
ObtenerDeNegocioAsync
ÖÖ, A
(
ÖÖA B
negocio
ÖÖB I
.
ÖÖI J
Id
ÖÖJ L
,
ÖÖL M
repartidorId
ÖÖN Z
)
ÖÖZ [
;
ÖÖ[ \
if
ÜÜ 

(
ÜÜ 

repartidor
ÜÜ 
?
ÜÜ 
.
ÜÜ 
Usuario
ÜÜ 
is
ÜÜ  "
null
ÜÜ# '
)
ÜÜ' (
return
ÜÜ) /
(
ÜÜ0 1
false
ÜÜ1 6
,
ÜÜ6 7
$str
ÜÜ8 n
)
ÜÜn o
;
ÜÜo p
var
àà 
usuario
àà 
=
àà 

repartidor
àà  
.
àà  !
Usuario
àà! (
;
àà( )
if
ââ 

(
ââ 
usuario
ââ 
.
ââ 
Estado
ââ 
!=
ââ 
EstadoCuenta
ââ *
.
ââ* +!
PendienteActivacion
ââ+ >
)
ââ> ?
return
ää 
(
ää 
false
ää 
,
ää 
$"
ää 
{
ää 

repartidor
ää (
.
ää( )
NombreCompleto
ää) 7
}
ää7 8
$str
ää8 M
"
ääM N
)
ääN O
;
ääO P
if
åå 

(
åå 
await
åå 

activacion
åå 
.
åå #
EnviosUltimaHoraAsync
åå 2
(
åå2 3
usuario
åå3 :
.
åå: ;
Id
åå; =
)
åå= >
>=
åå? A)
MaxCorreosActivacionPorHora
ååB ]
)
åå] ^
return
çç 
(
çç 
false
çç 
,
çç 
$str
çç }
)
çç} ~
;
çç~ 
var
èè 
enviado
èè 
=
èè 
await
èè 

activacion
èè &
.
èè& '
EnviarEnlaceAsync
èè' 8
(
èè8 9
usuario
èè9 @
,
èè@ A

repartidor
èèB L
.
èèL M
NombreCompleto
èèM [
,
èè[ \
negocio
èè] d
.
èèd e
Nombre
èèe k
,
èèk l
construirEnlace
èèm |
)
èè| }
;
èè} ~
return
êê 
enviado
êê 
?
ëë 
(
ëë 
true
ëë 
,
ëë 
$"
ëë 
$str
ëë <
{
ëë< =
usuario
ëë= D
.
ëëD E
Correo
ëëE K
}
ëëK L
$str
ëëL M
"
ëëM N
)
ëëN O
:
íí 
(
íí 
false
íí 
,
íí 
$str
íí Z
)
ííZ [
;
íí[ \
}
ìì 
}îî «X
[C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\RecuperacionService.cs
	namespace 	
Gtrack
 
; 
public 
class 
RecuperacionService  
(  !
IUsuarioRepository 
usuarios 
,  (
ITokenRecuperacionRepository  
tokens! '
,' (
IPasswordHasher 
< 
Usuario 
> 
hasher #
,# $
IEmailService		 
email		 
,		 
ILogger

 
<

 
RecuperacionService

 
>

  
logger

! '
)

' (
:

) * 
IRecuperacionService

+ ?
{ 
public 

const 
string  
MensajeTokenInvalido ,
=- .
$str/ m
;m n
private 
const 
int !
MaxSolicitudesPorHora +
=, -
$num. /
;/ 0
private 
const 
int 
MinutosVigencia %
=& '
$num( *
;* +
public 

async 
Task 
< 
ResultadoSolicitud (
>( )
SolicitarAsync* 8
(8 9
string9 ?
correo@ F
,F G
FuncH L
<L M
stringM S
,S T
stringU [
>[ \
construirEnlace] l
)l m
{ 
var 
usuario 
= 
await 
usuarios $
.$ %!
ObtenerPorCorreoAsync% :
(: ;
correo; A
.A B
TrimB F
(F G
)G H
)H I
;I J
if 

( 
usuario 
is 
null 
) 
return #
ResultadoSolicitud$ 6
.6 7
	Procesada7 @
;@ A
var 
desde 
= 
DateTime 
. 
UtcNow #
.# $
AddHours$ ,
(, -
-- .
$num. /
)/ 0
;0 1
if 

( 
await 
tokens 
. 
ContarDesdeAsync )
() *
usuario* 1
.1 2
Id2 4
,4 5
desde6 ;
); <
>== ?!
MaxSolicitudesPorHora@ U
)U V
return 
ResultadoSolicitud %
.% &
LimiteSuperado& 4
;4 5
var 
token 
= 
	TokenUtil 
. 
Generar %
(% &
)& '
;' (
await 
tokens 
. 
AgregarAsync !
(! "
new" %
TokenRecuperacion& 7
{ 	
	UsuarioId 
= 
usuario 
.  
Id  "
," #
	TokenHash 
= 
	TokenUtil !
.! "
Hash" &
(& '
token' ,
), -
,- .
Expira 
= 
DateTime 
. 
UtcNow $
.$ %

AddMinutes% /
(/ 0
MinutosVigencia0 ?
)? @
} 	
)	 

;
 
var!! 
enlace!! 
=!! 
construirEnlace!! $
(!!$ %
token!!% *
)!!* +
;!!+ ,
await"" 
email"" 
."" 
EnviarAsync"" 
(""  
usuario""  '
.""' (
Correo""( .
,"". /
$str""0 T
,""T U
PlantillaCorreo""V e
.""e f
Crear""f k
(""k l
etiqueta## 
:## 
$str## 2
,##2 3
titulo$$ 
:$$ 
$str$$ .
,$$. /
saludo%% 
:%% 
$str%% 
,%% 
parrafos&& 
:&& 
['' 
$str(( `
,((` a
$str)) G
]** 
,** 

textoBoton++ 
:++ 
$str++ 0
,++0 1
urlBoton,, 
:,, 
enlace,, 
,,, 
nota-- 
:-- 
$"-- 
$str-- ,
{--, -
MinutosVigencia--- <
}--< =
$str	--= ∑
"
--∑ ∏
,
--∏ π
tipoNota.. 
:.. 
TipoNota.. 
... 
Aviso.. $
)..$ %
)..% &
;..& '
return00 
ResultadoSolicitud00 !
.00! "
	Procesada00" +
;00+ ,
}11 
public33 

async33 
Task33 
<33 
bool33 
>33 
TokenVigenteAsync33 -
(33- .
string33. 4
token335 :
)33: ;
{44 
if55 

(55 
string55 
.55 
IsNullOrWhiteSpace55 %
(55% &
token55& +
)55+ ,
)55, -
return55. 4
false555 :
;55: ;
var66 
t66 
=66 
await66 
tokens66 
.66 
ObtenerPorHashAsync66 0
(660 1
	TokenUtil661 :
.66: ;
Hash66; ?
(66? @
token66@ E
)66E F
)66F G
;66G H
return77 
t77 
is77 
not77 
null77 
&&77 
!77  !
t77! "
.77" #
Usado77# (
&&77) +
t77, -
.77- .
Expira77. 4
>775 6
DateTime777 ?
.77? @
UtcNow77@ F
;77F G
}88 
public:: 

async:: 
Task:: 
<:: 
(:: 
bool:: 
Ok:: 
,:: 
string::  &
?::& '
Error::( -
)::- .
>::. /
RestablecerAsync::0 @
(::@ A
string::A G
token::H M
,::M N
string::O U
nueva::V [
,::[ \
string::] c
confirmacion::d p
)::p q
{;; 
var<< 
t<< 
=<< 
string<< 
.<< 
IsNullOrWhiteSpace<< )
(<<) *
token<<* /
)<</ 0
?<<1 2
null<<3 7
:<<8 9
await<<: ?
tokens<<@ F
.<<F G
ObtenerPorHashAsync<<G Z
(<<Z [
	TokenUtil<<[ d
.<<d e
Hash<<e i
(<<i j
token<<j o
)<<o p
)<<p q
;<<q r
if== 

(== 
t== 
is== 
null== 
||== 
t== 
.== 
Usado==  
||==! #
t==$ %
.==% &
Expira==& ,
<===- /
DateTime==0 8
.==8 9
UtcNow==9 ?
)==? @
return>> 
(>> 
false>> 
,>>  
MensajeTokenInvalido>> /
)>>/ 0
;>>0 1
ifAA 

(AA 
nuevaAA 
!=AA 
confirmacionAA !
||AA" $
!AA% &
ValidadorPasswordAA& 7
.AA7 8
EsValidaAA8 @
(AA@ A
nuevaAAA F
)AAF G
)AAG H
returnBB 
(BB 
falseBB 
,BB 
$strBB [
)BB[ \
;BB\ ]
varDD 
usuarioDD 
=DD 
awaitDD 
usuariosDD $
.DD$ %
ObtenerPorIdAsyncDD% 6
(DD6 7
tDD7 8
.DD8 9
	UsuarioIdDD9 B
)DDB C
;DDC D
ifEE 

(EE 
usuarioEE 
isEE 
nullEE 
)EE 
returnEE #
(EE$ %
falseEE% *
,EE* + 
MensajeTokenInvalidoEE, @
)EE@ A
;EEA B
ifHH 

(HH 
EsLaMismaContrasenaHH 
(HH  
usuarioHH  '
,HH' (
nuevaHH) .
)HH. /
)HH/ 0
returnII 
(II 
falseII 
,II 
$strII Q
)IIQ R
;IIR S
usuarioKK 
.KK 
PasswordHashKK 
=KK 
hasherKK %
.KK% &
HashPasswordKK& 2
(KK2 3
usuarioKK3 :
,KK: ;
nuevaKK< A
)KKA B
;KKB C
ifOO 

(OO 
usuarioOO 
.OO 
EstadoOO 
==OO 
EstadoCuentaOO *
.OO* +
PendienteActivacionOO+ >
)OO> ?
usuarioOO@ G
.OOG H
EstadoOOH N
=OOO P
EstadoCuentaOOQ ]
.OO] ^
ActivoOO^ d
;OOd e
awaitQQ 
usuariosQQ 
.QQ 
ActualizarAsyncQQ &
(QQ& '
usuarioQQ' .
)QQ. /
;QQ/ 0
awaitTT 
tokensTT 
.TT $
InvalidarPendientesAsyncTT -
(TT- .
usuarioTT. 5
.TT5 6
IdTT6 8
)TT8 9
;TT9 :
tryVV 
{WW 	
awaitXX 
emailXX 
.XX 
EnviarAsyncXX #
(XX# $
usuarioXX$ +
.XX+ ,
CorreoXX, 2
,XX2 3
$strXX4 T
,XXT U
PlantillaCorreoXXV e
.XXe f
CrearXXf k
(XXk l
etiquetaYY 
:YY 
$strYY 2
,YY2 3
tituloZZ 
:ZZ 
$strZZ 7
,ZZ7 8
saludo[[ 
:[[ 
$str[[ 
,[[  
parrafos\\ 
:\\ 
[\\ 
$str	\\ ë
]
\\ë í
,
\\í ì
nota]] 
:]] 
$str]] h
,]]h i
tipoNota^^ 
:^^ 
TipoNota^^ "
.^^" #
Aviso^^# (
)^^( )
)^^) *
;^^* +
}__ 	
catch`` 
(`` 
	Exception`` 
ex`` 
)`` 
{aa 	
loggerbb 
.bb 
LogErrorbb 
(bb 
exbb 
,bb 
$strbb  p
,bbp q
usuariobbr y
.bby z
Correo	bbz Ä
)
bbÄ Å
;
bbÅ Ç
}cc 	
returnee 
(ee 
trueee 
,ee 
nullee 
)ee 
;ee 
}ff 
privatejj 
booljj 
EsLaMismaContrasenajj $
(jj$ %
Usuariojj% ,
usuariojj- 4
,jj4 5
stringjj6 <
nuevajj= B
)jjB C
{kk 
tryll 
{mm 	
returnnn 
hashernn 
.nn  
VerifyHashedPasswordnn .
(nn. /
usuarionn/ 6
,nn6 7
usuarionn8 ?
.nn? @
PasswordHashnn@ L
,nnL M
nuevannN S
)nnS T
!=nnU W&
PasswordVerificationResultnnX r
.nnr s
Failednns y
;nny z
}oo 	
catchpp 
(pp 
FormatExceptionpp 
)pp 
{qq 	
returnrr 
falserr 
;rr 
}ss 	
}tt 
}uu å≥
WC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\PlantillaCorreo.cs
	namespace 	
Gtrack
 
; 
public 
record 

CorreoHtml 
( 
string 
Html  $
,$ %
string& ,
Texto- 2
)2 3
;3 4
public 
enum 
TipoNota 
{ 
Info 
, 
Aviso "
," #
Exito$ )
}* +
public 
static 
class 
PlantillaCorreo #
{ 
public 

const 
string 
ContentIdLogo %
=& '
$str( 5
;5 6
private 
const 
string 
Fuente 
=  !
$str" x
;x y
public 

static 

CorreoHtml 
Crear "
(" #
string 
titulo 
, 
string 
saludo 
, 
IEnumerable 
< 
string 
> 
parrafos $
,$ %
string 
? 
etiqueta 
= 
null 
,  
IEnumerable 
< 
( 
string 
Etiqueta $
,$ %
string& ,
Valor- 2
)2 3
>3 4
?4 5
datos6 ;
=< =
null> B
,B C
string 
? 
codigo 
= 
null 
, 
string 
? 

textoBoton 
= 
null !
,! "
string   
?   
urlBoton   
=   
null   
,    
string!! 
?!! 
nota!! 
=!! 
null!! 
,!! 
TipoNota"" 
tipoNota"" 
="" 
TipoNota"" $
.""$ %
Info""% )
,"") *
string## 
?## 
resumen## 
=## 
null## 
)## 
{$$ 
var%% 
listaParrafos%% 
=%% 
parrafos%% $
.%%$ %
Where%%% *
(%%* +
p%%+ ,
=>%%- /
!%%0 1
string%%1 7
.%%7 8
IsNullOrWhiteSpace%%8 J
(%%J K
p%%K L
)%%L M
)%%M N
.%%N O
ToList%%O U
(%%U V
)%%V W
;%%W X
var&& 
filas&& 
=&& 
datos&& 
?&& 
.&& 
Where&&  
(&&  !
d&&! "
=>&&# %
!&&& '
string&&' -
.&&- .
IsNullOrWhiteSpace&&. @
(&&@ A
d&&A B
.&&B C
Valor&&C H
)&&H I
)&&I J
.&&J K
ToList&&K Q
(&&Q R
)&&R S
??&&T V
[&&W X
]&&X Y
;&&Y Z
var'' 
hayBoton'' 
='' 
!'' 
string'' 
.'' 
IsNullOrWhiteSpace'' 1
(''1 2

textoBoton''2 <
)''< =
&&''> @
!''A B
string''B H
.''H I
IsNullOrWhiteSpace''I [
(''[ \
urlBoton''\ d
)''d e
;''e f
var** 
vistaPrevia** 
=** 
resumen** !
??**" $
(**% &
listaParrafos**& 3
.**3 4
Count**4 9
>**: ;
$num**< =
?**> ?

SinFormato**@ J
(**J K
listaParrafos**K X
[**X Y
$num**Y Z
]**Z [
)**[ \
:**] ^
titulo**_ e
)**e f
;**f g
if++ 

(++ 
vistaPrevia++ 
.++ 
Length++ 
>++  
$num++! $
)++$ %
vistaPrevia++& 1
=++2 3
vistaPrevia++4 ?
[++? @
..++@ B
$num++B E
]++E F
+++G H
$str++I L
;++L M
var-- 
html-- 
=-- 
new-- 
StringBuilder-- $
(--$ %
)--% &
;--& '
if.. 

(.. 
!.. 
string.. 
... 
IsNullOrWhiteSpace.. &
(..& '
etiqueta..' /
)../ 0
)..0 1
html..2 6
...6 7
Append..7 =
(..= >
Bloque..> D
(..D E
BloqueEtiqueta..E S
,..S T
(..U V
$str..V ]
,..] ^
E.._ `
(..` a
etiqueta..a i
)..i j
)..j k
)..k l
)..l m
;..m n
html// 
.// 
Append// 
(// 
Bloque// 
(// 
BloqueTitulo// '
,//' (
(//) *
$str//* 1
,//1 2
E//3 4
(//4 5
titulo//5 ;
)//; <
)//< =
)//= >
)//> ?
;//? @
html00 
.00 
Append00 
(00 
Bloque00 
(00 
BloqueSaludo00 '
,00' (
(00) *
$str00* 1
,001 2
E003 4
(004 5
saludo005 ;
)00; <
)00< =
)00= >
)00> ?
;00? @
foreach11 
(11 
var11 
p11 
in11 
listaParrafos11 '
)11' (
html11) -
.11- .
Append11. 4
(114 5
Bloque115 ;
(11; <
BloqueParrafo11< I
,11I J
(11K L
$str11L S
,11S T

ConFormato11U _
(11_ `
p11` a
)11a b
)11b c
)11c d
)11d e
;11e f
if33 

(33 
filas33 
.33 
Count33 
>33 
$num33 
)33 
{44 	
var55 
contenidoFilas55 
=55  
new55! $
StringBuilder55% 2
(552 3
)553 4
;554 5
for66 
(66 
var66 
i66 
=66 
$num66 
;66 
i66 
<66 
filas66  %
.66% &
Count66& +
;66+ ,
i66- .
++66. 0
)660 1
{77 
if88 
(88 
i88 
>88 
$num88 
)88 
contenidoFilas88 )
.88) *
Append88* 0
(880 1
BloqueSeparadorDato881 D
)88D E
;88E F
contenidoFilas99 
.99 
Append99 %
(99% &
Bloque99& ,
(99, -
BloqueFilaDato99- ;
,99; <
(99= >
$str99> H
,99H I
E99J K
(99K L
filas99L Q
[99Q R
i99R S
]99S T
.99T U
Etiqueta99U ]
)99] ^
)99^ _
,99_ `
(99a b
$str99b i
,99i j
E99k l
(99l m
filas99m r
[99r s
i99s t
]99t u
.99u v
Valor99v {
)99{ |
)99| }
)99} ~
)99~ 
;	99 Ä
}:: 
html;; 
.;; 
Append;; 
(;; 
Bloque;; 
(;; 
BloqueDatos;; *
,;;* +
(;;, -
$str;;- 4
,;;4 5
contenidoFilas;;6 D
.;;D E
ToString;;E M
(;;M N
);;N O
);;O P
);;P Q
);;Q R
;;;R S
}<< 	
if>> 

(>> 
!>> 
string>> 
.>> 
IsNullOrWhiteSpace>> &
(>>& '
codigo>>' -
)>>- .
)>>. /
html>>0 4
.>>4 5
Append>>5 ;
(>>; <
Bloque>>< B
(>>B C
BloqueCodigo>>C O
,>>O P
(>>Q R
$str>>R Z
,>>Z [
E>>\ ]
(>>] ^
codigo>>^ d
)>>d e
)>>e f
)>>f g
)>>g h
;>>h i
if@@ 

(@@ 
hayBoton@@ 
)@@ 
{AA 	
htmlBB 
.BB 
AppendBB 
(BB 
BloqueBB 
(BB 
BloqueBotonBB *
,BB* +
(BB, -
$strBB- 2
,BB2 3
EBB4 5
(BB5 6
urlBotonBB6 >
)BB> ?
)BB? @
,BB@ A
(BBB C
$strBBC J
,BBJ K
EBBL M
(BBM N

textoBotonBBN X
)BBX Y
)BBY Z
)BBZ [
)BB[ \
;BB\ ]
htmlCC 
.CC 
AppendCC 
(CC 
BloqueCC 
(CC #
BloqueEnlaceAlternativoCC 6
,CC6 7
(CC8 9
$strCC9 >
,CC> ?
ECC@ A
(CCA B
urlBotonCCB J
)CCJ K
)CCK L
)CCL M
)CCM N
;CCN O
}DD 	
ifFF 

(FF 
!FF 
stringFF 
.FF 
IsNullOrWhiteSpaceFF &
(FF& '
notaFF' +
)FF+ ,
)FF, -
{GG 	
varHH 
(HH 
fondoHH 
,HH 
acentoHH 
,HH 
colorHH  %
)HH% &
=HH' (
tipoNotaHH) 1
switchHH2 8
{II 
TipoNotaJJ 
.JJ 
AvisoJJ 
=>JJ !
(JJ" #
$strJJ# ,
,JJ, -
$strJJ. 7
,JJ7 8
$strJJ9 B
)JJB C
,JJC D
TipoNotaKK 
.KK 
ExitoKK 
=>KK !
(KK" #
$strKK# ,
,KK, -
$strKK. 7
,KK7 8
$strKK9 B
)KKB C
,KKC D
_LL 
=>LL 
(LL 
$strLL 
,LL  
$strLL! *
,LL* +
$strLL, 5
)LL5 6
}MM 
;MM 
htmlNN 
.NN 
AppendNN 
(NN 
BloqueNN 
(NN 

BloqueNotaNN )
,NN) *
(NN+ ,
$strNN, 3
,NN3 4
fondoNN5 :
)NN: ;
,NN; <
(NN= >
$strNN> F
,NNF G
acentoNNH N
)NNN O
,NNO P
(NNQ R
$strNNR Y
,NNY Z
colorNN[ `
)NN` a
,NNa b
(NNc d
$strNNd k
,NNk l

ConFormatoNNm w
(NNw x
notaNNx |
)NN| }
)NN} ~
)NN~ 
)	NN Ä
;
NNÄ Å
}OO 	
varQQ 
	documentoQQ 
=QQ 
BloqueQQ 
(QQ 
DisenoQQ %
,QQ% &
(RR 
$strRR 
,RR 
FuenteRR 
)RR 
,RR 
(SS 
$strSS 
,SS 
ESS 
(SS 
tituloSS 
)SS  
)SS  !
,SS! "
(TT 
$strTT 
,TT 
ETT 
(TT 
vistaPreviaTT '
)TT' (
)TT( )
,TT) *
(UU 
$strUU 
,UU 
ContentIdLogoUU "
)UU" #
,UU# $
(VV 
$strVV 
,VV 
DateTimeVV 
.VV 
UtcNowVV $
.VV$ %
YearVV% )
.VV) *
ToStringVV* 2
(VV2 3
)VV3 4
)VV4 5
,VV5 6
(WW 
$strWW 
,WW 
htmlWW 
.WW 
ToStringWW '
(WW' (
)WW( )
)WW) *
)WW* +
;WW+ ,
returnYY 
newYY 

CorreoHtmlYY 
(YY 
	documentoZZ 
,ZZ 
ConstruirTexto[[ 
([[ 
titulo[[ !
,[[! "
saludo[[# )
,[[) *
listaParrafos[[+ 8
,[[8 9
etiqueta[[: B
,[[B C
filas[[D I
,[[I J
codigo[[K Q
,[[Q R
hayBoton\\ 
?\\ 

textoBoton\\ %
:\\& '
null\\( ,
,\\, -
hayBoton\\. 6
?\\7 8
urlBoton\\9 A
:\\B C
null\\D H
,\\H I
nota\\J N
)\\N O
)\\O P
;\\P Q
}]] 
public`` 

static`` 

CorreoHtml`` 

DesdeTexto`` '
(``' (
string``( .
asunto``/ 5
,``5 6
string``7 =
texto``> C
)``C D
{aa 
varbb 
parrafosbb 
=bb 
textobb 
.bb 
Replacebb $
(bb$ %
$strbb% +
,bb+ ,
$strbb- 1
)bb1 2
.cc 
Splitcc 
(cc 
$charcc 
,cc 
StringSplitOptionscc +
.cc+ ,
RemoveEmptyEntriescc, >
|cc? @
StringSplitOptionsccA S
.ccS T
TrimEntriesccT _
)cc_ `
;cc` a
returndd 
Creardd 
(dd 
titulodd 
:dd 
asuntodd #
,dd# $
saludodd% +
:dd+ ,
$strdd- 4
,dd4 5
parrafosdd6 >
:dd> ?
parrafosdd@ H
)ddH I
;ddI J
}ee 
privatekk 
statickk 
stringkk 
Ekk 
(kk 
stringkk "
?kk" #
skk$ %
)kk% &
=>kk' )

WebUtilityll 
.ll 

HtmlEncodell 
(ll 
sll 
??ll  "
$strll# %
)ll% &
.ll& '
Replacell' .
(ll. /
$strll/ 2
,ll2 3
$strll4 <
)ll< =
.ll= >
Replacell> E
(llE F
$strllF I
,llI J
$strllK S
)llS T
;llT U
privatenn 
staticnn 
stringnn 

ConFormatonn $
(nn$ %
stringnn% +
textonn, 1
)nn1 2
=>nn3 5
Patronesoo 
.oo 
Negritaoo 
(oo 
)oo 
.oo 
Replaceoo "
(oo" #
Eoo# $
(oo$ %
textooo% *
)oo* +
,oo+ ,
$stroo- k
)ook l
;ool m
privateqq 
staticqq 
stringqq 

SinFormatoqq $
(qq$ %
stringqq% +
textoqq, 1
)qq1 2
=>qq3 5
textoqq6 ;
.qq; <
Replaceqq< C
(qqC D
$strqqD H
,qqH I
$strqqJ L
)qqL M
;qqM N
privatess 
staticss 
stringss 
Bloquess  
(ss  !
stringss! '
	plantillass( 1
,ss1 2
paramsss3 9
(ss: ;
stringss; A
ClavessB G
,ssG H
stringssI O
ValorssP U
)ssU V
[ssV W
]ssW X
valoresssY `
)ss` a
{tt 
varuu 
	resultadouu 
=uu 
	plantillauu !
;uu! "
foreachvv 
(vv 
varvv 
(vv 
clavevv 
,vv 
valorvv "
)vv" #
invv$ &
valoresvv' .
)vv. /
	resultadoww 
=ww 
	resultadoww !
.ww! "
Replaceww" )
(ww) *
$strww* .
+ww/ 0
claveww1 6
+ww7 8
$strww9 =
,ww= >
valorww? D
)wwD E
;wwE F
returnxx 
	resultadoxx 
;xx 
}yy 
private{{ 
static{{ 
string{{ 
ConstruirTexto{{ (
({{( )
string{{) /
titulo{{0 6
,{{6 7
string{{8 >
saludo{{? E
,{{E F
List{{G K
<{{K L
string{{L R
>{{R S
parrafos{{T \
,{{\ ]
string{{^ d
?{{d e
etiqueta{{f n
,{{n o
List|| 
<|| 
(|| 
string|| 
Etiqueta|| 
,|| 
string|| %
Valor||& +
)||+ ,
>||, -
datos||. 3
,||3 4
string||5 ;
?||; <
codigo||= C
,||C D
string||E K
?||K L

textoBoton||M W
,||W X
string||Y _
?||_ `
urlBoton||a i
,||i j
string||k q
?||q r
nota||s w
)||w x
{}} 
var~~ 
t~~ 
=~~ 
new~~ 
StringBuilder~~ !
(~~! "
)~~" #
;~~# $
t 	
.	 


AppendLine
 
( 
$str @
)@ A
;A B
t
ÄÄ 	
.
ÄÄ	 


AppendLine
ÄÄ
 
(
ÄÄ 
new
ÄÄ 
string
ÄÄ 
(
ÄÄ  
$char
ÄÄ  #
,
ÄÄ# $
$num
ÄÄ% '
)
ÄÄ' (
)
ÄÄ( )
.
ÄÄ) *

AppendLine
ÄÄ* 4
(
ÄÄ4 5
)
ÄÄ5 6
;
ÄÄ6 7
if
ÅÅ 

(
ÅÅ 
!
ÅÅ 
string
ÅÅ 
.
ÅÅ  
IsNullOrWhiteSpace
ÅÅ &
(
ÅÅ& '
etiqueta
ÅÅ' /
)
ÅÅ/ 0
)
ÅÅ0 1
t
ÅÅ2 3
.
ÅÅ3 4

AppendLine
ÅÅ4 >
(
ÅÅ> ?
etiqueta
ÅÅ? G
.
ÅÅG H
ToUpperInvariant
ÅÅH X
(
ÅÅX Y
)
ÅÅY Z
)
ÅÅZ [
;
ÅÅ[ \
t
ÇÇ 	
.
ÇÇ	 


AppendLine
ÇÇ
 
(
ÇÇ 
titulo
ÇÇ 
)
ÇÇ 
.
ÇÇ 

AppendLine
ÇÇ '
(
ÇÇ' (
)
ÇÇ( )
;
ÇÇ) *
t
ÉÉ 	
.
ÉÉ	 


AppendLine
ÉÉ
 
(
ÉÉ 
saludo
ÉÉ 
)
ÉÉ 
.
ÉÉ 

AppendLine
ÉÉ '
(
ÉÉ' (
)
ÉÉ( )
;
ÉÉ) *
foreach
ÑÑ 
(
ÑÑ 
var
ÑÑ 
p
ÑÑ 
in
ÑÑ 
parrafos
ÑÑ "
)
ÑÑ" #
t
ÑÑ$ %
.
ÑÑ% &

AppendLine
ÑÑ& 0
(
ÑÑ0 1

SinFormato
ÑÑ1 ;
(
ÑÑ; <
p
ÑÑ< =
)
ÑÑ= >
)
ÑÑ> ?
.
ÑÑ? @

AppendLine
ÑÑ@ J
(
ÑÑJ K
)
ÑÑK L
;
ÑÑL M
foreach
ÜÜ 
(
ÜÜ 
var
ÜÜ 
(
ÜÜ 
e
ÜÜ 
,
ÜÜ 
v
ÜÜ 
)
ÜÜ 
in
ÜÜ 
datos
ÜÜ $
)
ÜÜ$ %
t
ÜÜ& '
.
ÜÜ' (

AppendLine
ÜÜ( 2
(
ÜÜ2 3
$"
ÜÜ3 5
$str
ÜÜ5 9
{
ÜÜ9 :
e
ÜÜ: ;
}
ÜÜ; <
$str
ÜÜ< >
{
ÜÜ> ?
v
ÜÜ? @
}
ÜÜ@ A
"
ÜÜA B
)
ÜÜB C
;
ÜÜC D
if
áá 

(
áá 
datos
áá 
.
áá 
Count
áá 
>
áá 
$num
áá 
)
áá 
t
áá 
.
áá 

AppendLine
áá )
(
áá) *
)
áá* +
;
áá+ ,
if
ââ 

(
ââ 
!
ââ 
string
ââ 
.
ââ  
IsNullOrWhiteSpace
ââ &
(
ââ& '
codigo
ââ' -
)
ââ- .
)
ââ. /
t
ââ0 1
.
ââ1 2

AppendLine
ââ2 <
(
ââ< =
$"
ââ= ?
$str
ââ? J
{
ââJ K
codigo
ââK Q
}
ââQ R
"
ââR S
)
ââS T
.
ââT U

AppendLine
ââU _
(
ââ_ `
)
ââ` a
;
ââa b
if
ää 

(
ää 

textoBoton
ää 
is
ää 
not
ää 
null
ää "
&&
ää# %
urlBoton
ää& .
is
ää/ 1
not
ää2 5
null
ää6 :
)
ää: ;
t
ää< =
.
ää= >

AppendLine
ää> H
(
ääH I
$"
ääI K
{
ääK L

textoBoton
ääL V
}
ääV W
$str
ääW Y
{
ääY Z
urlBoton
ääZ b
}
ääb c
"
ääc d
)
ääd e
.
ääe f

AppendLine
ääf p
(
ääp q
)
ääq r
;
äär s
if
ãã 

(
ãã 
!
ãã 
string
ãã 
.
ãã  
IsNullOrWhiteSpace
ãã &
(
ãã& '
nota
ãã' +
)
ãã+ ,
)
ãã, -
t
ãã. /
.
ãã/ 0

AppendLine
ãã0 :
(
ãã: ;

SinFormato
ãã; E
(
ããE F
nota
ããF J
)
ããJ K
)
ããK L
.
ããL M

AppendLine
ããM W
(
ããW X
)
ããX Y
;
ããY Z
t
çç 	
.
çç	 


AppendLine
çç
 
(
çç 
$str
çç 
)
çç 
;
çç 
t
éé 	
.
éé	 


AppendLine
éé
 
(
éé 
$str
éé r
)
éér s
;
éés t
return
èè 
t
èè 
.
èè 
ToString
èè 
(
èè 
)
èè 
;
èè 
}
êê 
private
ïï 
const
ïï 
string
ïï 
Diseno
ïï 
=
ïï  !
$str
ïÎ" 
;
ÎÎ 
private
ÌÌ 
const
ÌÌ 
string
ÌÌ 
BloqueEtiqueta
ÌÌ '
=
ÌÌ( )
$str
Ì* 
;
 
private
ÚÚ 
const
ÚÚ 
string
ÚÚ 
BloqueTitulo
ÚÚ %
=
ÚÚ& '
$str
Úı( 
;
ıı 
private
˜˜ 
const
˜˜ 
string
˜˜ 
BloqueSaludo
˜˜ %
=
˜˜& '
$str
˜˙( 
;
˙˙ 
private
¸¸ 
const
¸¸ 
string
¸¸ 
BloqueParrafo
¸¸ &
=
¸¸' (
$str
¸ˇ) 
;
ˇˇ 
private
ÅÅ 
const
ÅÅ 
string
ÅÅ 
BloqueDatos
ÅÅ $
=
ÅÅ% &
$str
ÅÖ' 
;
ÖÖ 
private
áá 
const
áá 
string
áá 
BloqueFilaDato
áá '
=
áá( )
$str
áç* 
;
çç 
private
èè 
const
èè 
string
èè !
BloqueSeparadorDato
èè ,
=
èè- .
$str
èí/ 
;
íí 
private
îî 
const
îî 
string
îî 
BloqueCodigo
îî %
=
îî& '
$str
îõ( 
;
õõ 
private
ùù 
const
ùù 
string
ùù 
BloqueBoton
ùù $
=
ùù% &
$str
ùÆ' 
;
ÆÆ 
private
∞∞ 
const
∞∞ 
string
∞∞ %
BloqueEnlaceAlternativo
∞∞ 0
=
∞∞1 2
$str
∞≥3 
;
≥≥ 
private
µµ 
const
µµ 
string
µµ 

BloqueNota
µµ #
=
µµ$ %
$str
µº& 
;
ºº 
}ΩΩ óŸ
_C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\PerfilRepartidorService.cs
	namespace 	
Gtrack
 
; 
public 
	interface $
IPerfilRepartidorService )
{		 
Task

 
<

 	
PerfilRepartidorDto

	 
?

 
>

 
ObtenerPerfilAsync

 1
(

1 2
int

2 5
	usuarioId

6 ?
)

? @
;

@ A
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
)  !
>! " 
SolicitarCodigoAsync# 7
(7 8
int8 ;
	usuarioId< E
)E F
;F G
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
)  !
>! " 
VerificarCodigoAsync# 7
(7 8
int8 ;
	usuarioId< E
,E F
stringG M
codigoN T
)T U
;U V
Task 
< 	
bool	 
> "
EdicionAutorizadaAsync %
(% &
int& )
	usuarioId* 3
)3 4
;4 5
Task 
< 	
EditarRepartidorDto	 
? 
> "
ObtenerParaEditarAsync 5
(5 6
int6 9
	usuarioId: C
)C D
;D E
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
)  !
>! "
EditarAsync# .
(. /
int/ 2
	usuarioId3 <
,< =
EditarRepartidorDto> Q
dtoR U
)U V
;V W
Task 
< 	
string	 
? 
> !
MotivoNoEditableAsync '
(' (
int( +
	usuarioId, 5
)5 6
;6 7
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
)  !
>! ")
ValidarEliminacionPropiaAsync# @
(@ A
intA D
	usuarioIdE N
)N O
;O P
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
)  !
>! "%
EliminarCuentaPropiaAsync# <
(< =
int= @
	usuarioIdA J
,J K
stringL R
passwordS [
)[ \
;\ ]
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
)  !
>! "-
!ValidarEliminacionPorNegocioAsync# D
(D E
intE H
usuarioNegocioIdI Y
,Y Z
int[ ^
repartidorId_ k
)k l
;l m
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
,  !
string" (
?( )
Nombre* 0
)0 1
>1 2#
EliminarPorNegocioAsync3 J
(J K
intK N
usuarioNegocioIdO _
,_ `
inta d
repartidorIde q
,q r
strings y
password	z Ç
)
Ç É
;
É Ñ
} 
public 
class #
PerfilRepartidorService $
($ %
AppDbContext   
db   
,   !
IRepartidorRepository!! 
repartidores!! &
,!!& '
INegocioRepository"" 
negocios"" 
,""  
IUsuarioRepository## 
usuarios## 
,##  )
ICodigoVerificacionRepository$$ !
codigos$$" )
,$$) *
IPasswordHasher%% 
<%% 
Usuario%% 
>%% 
hasher%% #
,%%# $
IEmailService&& 
email&& 
,&& 
ILogger'' 
<'' #
PerfilRepartidorService'' #
>''# $
logger''% +
)''+ ,
:''- .$
IPerfilRepartidorService''/ G
{(( 
public)) 

const)) 
string)) "
MensajeSinVerificacion)) .
=))/ 0
$str))1 e
;))e f
public** 

const** 
string** 
MensajeConPedidos** )
=*** +
$str**, j
;**j k
public++ 

const++ 
string++ 
MensajeSuspendido++ )
=++* +
$str++, h
;++h i
public,, 

const,, 
string,, 
MensajeSinPermisos,, *
=,,+ ,
$str,,- [
;,,[ \
private.. 
const.. 
string.. %
MensajeEntregasPendientes.. 2
=..3 4
$str..5 {
;..{ |
private// 
const// 
string// ,
 MensajeEntregasPendientesNegocio// 9
=//: ;
$str	//< â
;
//â ä
private00 
const00 
string00 '
MensajeContrasenaIncorrecta00 4
=005 6
$str007 N
;00N O
private33 
const33 
int33 
MaxIntentosCodigo33 '
=33( )
$num33* +
;33+ ,
private44 
const44 
int44 
MinutosBloqueo44 $
=44% &
$num44' )
;44) *
private55 
const55 
int55 !
MinutosVigenciaCodigo55 +
=55, -
$num55. 0
;550 1
private66 
const66 
int66 !
MinutosVentanaEdicion66 +
=66, -
$num66. 0
;660 1
private88 
const88 
string88 
MensajeErrorEnvio88 *
=88+ ,
$str88- b
;88b c
private99 
const99 
string99  
MensajeErrorGuardado99 -
=99. /
$str990 n
;99n o
private:: 
const:: 
string:: !
MensajeCodigoExpirado:: .
=::/ 0
$str::1 i
;::i j
public== 

async== 
Task== 
<== 
PerfilRepartidorDto== )
?==) *
>==* +
ObtenerPerfilAsync==, >
(==> ?
int==? B
	usuarioId==C L
)==L M
{>> 
var?? 
rep?? 
=?? 
await?? 
db?? 
.?? 
Repartidores?? '
.@@ 
AsNoTracking@@ 
(@@ 
)@@ 
.AA 
IncludeAA 
(AA 
rAA 
=>AA 
rAA 
.AA 
UsuarioAA #
)AA# $
.BB 
FirstOrDefaultAsyncBB  
(BB  !
rBB! "
=>BB# %
rBB& '
.BB' (
	UsuarioIdBB( 1
==BB2 4
	usuarioIdBB5 >
)BB> ?
;BB? @
ifCC 

(CC 
repCC 
?CC 
.CC 
UsuarioCC 
isCC 
nullCC  
)CC  !
returnCC" (
nullCC) -
;CC- .
varEE 
negocioEE 
=EE 
awaitEE 
negociosEE $
.EE$ %
BuscarPorIdAsyncEE% 5
(EE5 6
repEE6 9
.EE9 :
	NegocioIdEE: C
)EEC D
;EED E
returnGG 
newGG 
PerfilRepartidorDtoGG &
{HH 	
NombreCompletoII 
=II 
repII  
.II  !
NombreCompletoII! /
,II/ 0
	DocumentoJJ 
=JJ 
repJJ 
.JJ 
UsuarioJJ #
.JJ# $
	DocumentoJJ$ -
,JJ- .
TelefonoKK 
=KK 
repKK 
.KK 
TelefonoKK #
,KK# $
CorreoLL 
=LL 
repLL 
.LL 
UsuarioLL  
.LL  !
CorreoLL! '
,LL' (
VehiculoMM 
=MM 
repMM 
.MM 
VehiculoMM #
,MM# $
PlacaNN 
=NN 
repNN 
.NN 
PlacaNN 
,NN 
NegocioOO 
=OO 
negocioOO 
?OO 
.OO 
NombreOO %
??OO& (
$strOO) +
,OO+ ,
FechaRegistroPP 
=PP 
repPP 
.PP  
FechaRegistroPP  -
,PP- .
EstadoQQ 
=QQ 
repQQ 
.QQ 
UsuarioQQ  
.QQ  !
EstadoQQ! '
,QQ' (
PedidosPendientesRR 
=RR 
awaitRR  %(
ContarPedidosPendientesAsyncRR& B
(RRB C
repRRC F
.RRF G
IdRRG I
)RRI J
}SS 	
;SS	 

}TT 
privateWW 
TaskWW 
<WW 
intWW 
>WW (
ContarPedidosPendientesAsyncWW 2
(WW2 3
intWW3 6
repartidorIdWW7 C
)WWC D
=>WWE G
dbXX 

.XX
 
PedidosXX 
.XX 

CountAsyncXX 
(XX 
pXX 
=>XX  "
pXX# $
.XX$ %
RepartidorIdXX% 1
==XX2 4
repartidorIdXX5 A
&&XXB D
(YY 
pYY 
.YY 
EstadoPedidoIdYY 
==YY  
(YY! "
intYY" %
)YY% &
EstadoPedidoYY& 2
.YY2 3
AsignadoYY3 ;
||YY< >
pYY? @
.YY@ A
EstadoPedidoIdYYA O
==YYP R
(YYS T
intYYT W
)YYW X
EstadoPedidoYYX d
.YYd e
EnCaminoYYe m
)YYm n
)YYn o
;YYo p
public\\ 

async\\ 
Task\\ 
<\\ 
string\\ 
?\\ 
>\\ !
MotivoNoEditableAsync\\ 4
(\\4 5
int\\5 8
	usuarioId\\9 B
)\\B C
{]] 
var^^ 
rep^^ 
=^^ 
await^^ 
repartidores^^ $
.^^$ %$
ObtenerPorUsuarioIdAsync^^% =
(^^= >
	usuarioId^^> G
)^^G H
;^^H I
var__ 
usuario__ 
=__ 
await__ 
usuarios__ $
.__$ %
ObtenerPorIdAsync__% 6
(__6 7
	usuarioId__7 @
)__@ A
;__A B
if`` 

(`` 
rep`` 
is`` 
null`` 
||`` 
usuario`` "
is``# %
null``& *
)``* +
return``, 2
MensajeSinPermisos``3 E
;``E F
ifbb 

(bb 
usuariobb 
.bb 
Estadobb 
==bb 
EstadoCuentabb *
.bb* +

Suspendidobb+ 5
)bb5 6
returnbb7 =
MensajeSuspendidobb> O
;bbO P
ifcc 

(cc 
awaitcc (
ContarPedidosPendientesAsynccc .
(cc. /
repcc/ 2
.cc2 3
Idcc3 5
)cc5 6
>cc7 8
$numcc9 :
)cc: ;
returncc< B
MensajeConPedidosccC T
;ccT U
returndd 
nulldd 
;dd 
}ee 
publicgg 

asyncgg 
Taskgg 
<gg 
(gg 
boolgg 
Okgg 
,gg 
stringgg  &
?gg& '
Errorgg( -
)gg- .
>gg. / 
SolicitarCodigoAsyncgg0 D
(ggD E
intggE H
	usuarioIdggI R
)ggR S
{hh 
varjj 
motivojj 
=jj 
awaitjj !
MotivoNoEditableAsyncjj 0
(jj0 1
	usuarioIdjj1 :
)jj: ;
;jj; <
ifkk 

(kk 
motivokk 
iskk 
notkk 
nullkk 
)kk 
returnkk  &
(kk' (
falsekk( -
,kk- .
motivokk/ 5
)kk5 6
;kk6 7
varmm 
usuariomm 
=mm 
awaitmm 
usuariosmm $
.mm$ %
ObtenerPorIdAsyncmm% 6
(mm6 7
	usuarioIdmm7 @
)mm@ A
;mmA B
ifnn 

(nn 
usuarionn 
isnn 
nullnn 
)nn 
returnnn #
(nn$ %
falsenn% *
,nn* +
MensajeErrorEnvionn, =
)nn= >
;nn> ?
varpp 
ultimopp 
=pp 
awaitpp 
codigospp "
.pp" #
ObtenerUltimoAsyncpp# 5
(pp5 6
	usuarioIdpp6 ?
)pp? @
;pp@ A
ifqq 

(qq 
ultimoqq 
?qq 
.qq 
BloqueadoHastaqq "
isqq# %
{qq& '
}qq( )
hastaqq* /
&&qq0 2
hastaqq3 8
>qq9 :
DateTimeqq; C
.qqC D
UtcNowqqD J
)qqJ K
returnrr 
(rr 
falserr 
,rr 
MensajeBloqueorr )
(rr) *
hastarr* /
)rr/ 0
)rr0 1
;rr1 2
vartt 
codigott 
=tt !
RandomNumberGeneratortt *
.tt* +
GetInt32tt+ 3
(tt3 4
$numtt4 :
,tt: ;
$numtt< C
)ttC D
.ttD E
ToStringttE M
(ttM N
)ttN O
;ttO P
tryvv 
{ww 	
awaitxx 
codigosxx 
.xx 
AgregarAsyncxx &
(xx& '
newxx' *
CodigoVerificacionxx+ =
{yy 
	UsuarioIdzz 
=zz 
	usuarioIdzz %
,zz% &

CodigoHash{{ 
={{ 
	TokenUtil{{ &
.{{& '
Hash{{' +
({{+ ,
codigo{{, 2
){{2 3
,{{3 4
Expira|| 
=|| 
DateTime|| !
.||! "
UtcNow||" (
.||( )

AddMinutes||) 3
(||3 4!
MinutosVigenciaCodigo||4 I
)||I J
}}} 
)}} 
;}} 
await 
email 
. 
EnviarAsync #
(# $
usuario$ +
.+ ,
Correo, 2
,2 3
$str4 Y
,Y Z
PlantillaCorreo[ j
.j k
Creark p
(p q
etiqueta
ÄÄ 
:
ÄÄ 
$str
ÄÄ 5
,
ÄÄ5 6
titulo
ÅÅ 
:
ÅÅ 
$str
ÅÅ .
,
ÅÅ. /
saludo
ÇÇ 
:
ÇÇ 
$str
ÇÇ 
,
ÇÇ  
parrafos
ÉÉ 
:
ÉÉ 
[
ÉÉ 
$str
ÉÉ f
]
ÉÉf g
,
ÉÉg h
codigo
ÑÑ 
:
ÑÑ 
codigo
ÑÑ 
,
ÑÑ 
nota
ÖÖ 
:
ÖÖ 
$"
ÖÖ 
$str
ÖÖ 0
{
ÖÖ0 1#
MinutosVigenciaCodigo
ÖÖ1 F
}
ÖÖF G
$strÖÖG ¢
"ÖÖ¢ £
,ÖÖ£ §
tipoNota
ÜÜ 
:
ÜÜ 
TipoNota
ÜÜ "
.
ÜÜ" #
Aviso
ÜÜ# (
,
ÜÜ( )
resumen
áá 
:
áá 
$"
áá 
$str
áá 8
{
áá8 9
codigo
áá9 ?
}
áá? @
$str
áá@ K
{
ááK L#
MinutosVigenciaCodigo
ááL a
}
ááa b
$str
ááb k
"
áák l
)
áál m
)
áám n
;
áán o
return
àà 
(
àà 
true
àà 
,
àà 
null
àà 
)
àà 
;
àà  
}
ââ 	
catch
ää 
(
ää 
	Exception
ää 
ex
ää 
)
ää 
{
ãã 	
logger
åå 
.
åå 
LogError
åå 
(
åå 
ex
åå 
,
åå 
$str
åå  q
,
ååq r
	usuarioId
åås |
)
åå| }
;
åå} ~
return
çç 
(
çç 
false
çç 
,
çç 
MensajeErrorEnvio
çç ,
)
çç, -
;
çç- .
}
éé 	
}
èè 
public
ëë 

async
ëë 
Task
ëë 
<
ëë 
(
ëë 
bool
ëë 
Ok
ëë 
,
ëë 
string
ëë  &
?
ëë& '
Error
ëë( -
)
ëë- .
>
ëë. /"
VerificarCodigoAsync
ëë0 D
(
ëëD E
int
ëëE H
	usuarioId
ëëI R
,
ëëR S
string
ëëT Z
codigo
ëë[ a
)
ëëa b
{
íí 
var
ìì 
actual
ìì 
=
ìì 
await
ìì 
codigos
ìì "
.
ìì" # 
ObtenerUltimoAsync
ìì# 5
(
ìì5 6
	usuarioId
ìì6 ?
)
ìì? @
;
ìì@ A
var
îî 
ahora
îî 
=
îî 
DateTime
îî 
.
îî 
UtcNow
îî #
;
îî# $
if
ññ 

(
ññ 
actual
ññ 
is
ññ 
null
ññ 
)
ññ 
return
ññ "
(
ññ# $
false
ññ$ )
,
ññ) *#
MensajeCodigoExpirado
ññ+ @
)
ññ@ A
;
ññA B
if
òò 

(
òò 
actual
òò 
.
òò 
BloqueadoHasta
òò !
is
òò" $
{
òò% &
}
òò' (
hasta
òò) .
&&
òò/ 1
hasta
òò2 7
>
òò8 9
ahora
òò: ?
)
òò? @
return
ôô 
(
ôô 
false
ôô 
,
ôô 
MensajeBloqueo
ôô )
(
ôô) *
hasta
ôô* /
)
ôô/ 0
)
ôô0 1
;
ôô1 2
if
õõ 

(
õõ 
actual
õõ 
.
õõ 

Verificado
õõ 
||
õõ  
actual
õõ! '
.
õõ' (
Usado
õõ( -
||
õõ. 0
actual
õõ1 7
.
õõ7 8
Expira
õõ8 >
<=
õõ? A
ahora
õõB G
)
õõG H
return
úú 
(
úú 
false
úú 
,
úú #
MensajeCodigoExpirado
úú 0
)
úú0 1
;
úú1 2
if
ûû 

(
ûû 
actual
ûû 
.
ûû 

CodigoHash
ûû 
!=
ûû  
	TokenUtil
ûû! *
.
ûû* +
Hash
ûû+ /
(
ûû/ 0
codigo
ûû0 6
.
ûû6 7
Trim
ûû7 ;
(
ûû; <
)
ûû< =
)
ûû= >
)
ûû> ?
{
üü 	
actual
†† 
.
†† 
Intentos
†† 
++
†† 
;
†† 
var
°° 
error
°° 
=
°° 
$str
°° ?
;
°°? @
if
££ 
(
££ 
actual
££ 
.
££ 
Intentos
££ 
>=
££  "
MaxIntentosCodigo
££# 4
)
££4 5
{
§§ 
actual
•• 
.
•• 
BloqueadoHasta
•• %
=
••& '
ahora
••( -
.
••- .

AddMinutes
••. 8
(
••8 9
MinutosBloqueo
••9 G
)
••G H
;
••H I
error
¶¶ 
=
¶¶ 
$"
¶¶ 
$str
¶¶ $
{
¶¶$ %
MaxIntentosCodigo
¶¶% 6
}
¶¶6 7
$str
¶¶7 {
{
¶¶{ |
MinutosBloqueo¶¶| ä
}¶¶ä ã
$str¶¶ã î
"¶¶î ï
;¶¶ï ñ
}
ßß 
await
©© 
codigos
©© 
.
©© 
ActualizarAsync
©© )
(
©©) *
actual
©©* 0
)
©©0 1
;
©©1 2
return
™™ 
(
™™ 
false
™™ 
,
™™ 
error
™™  
)
™™  !
;
™™! "
}
´´ 	
actual
≠≠ 
.
≠≠ 

Verificado
≠≠ 
=
≠≠ 
true
≠≠  
;
≠≠  !
actual
ÆÆ 
.
ÆÆ 
Expira
ÆÆ 
=
ÆÆ 
ahora
ÆÆ 
.
ÆÆ 

AddMinutes
ÆÆ (
(
ÆÆ( )#
MinutosVentanaEdicion
ÆÆ) >
)
ÆÆ> ?
;
ÆÆ? @
await
ØØ 
codigos
ØØ 
.
ØØ 
ActualizarAsync
ØØ %
(
ØØ% &
actual
ØØ& ,
)
ØØ, -
;
ØØ- .
return
∞∞ 
(
∞∞ 
true
∞∞ 
,
∞∞ 
null
∞∞ 
)
∞∞ 
;
∞∞ 
}
±± 
public
≥≥ 

async
≥≥ 
Task
≥≥ 
<
≥≥ 
bool
≥≥ 
>
≥≥ $
EdicionAutorizadaAsync
≥≥ 2
(
≥≥2 3
int
≥≥3 6
	usuarioId
≥≥7 @
)
≥≥@ A
{
¥¥ 
var
µµ 
c
µµ 
=
µµ 
await
µµ 
codigos
µµ 
.
µµ  
ObtenerUltimoAsync
µµ 0
(
µµ0 1
	usuarioId
µµ1 :
)
µµ: ;
;
µµ; <
return
∂∂ 
c
∂∂ 
is
∂∂ 
{
∂∂ 

Verificado
∂∂  
:
∂∂  !
true
∂∂" &
,
∂∂& '
Usado
∂∂( -
:
∂∂- .
false
∂∂/ 4
}
∂∂5 6
&&
∂∂7 9
c
∂∂: ;
.
∂∂; <
Expira
∂∂< B
>
∂∂C D
DateTime
∂∂E M
.
∂∂M N
UtcNow
∂∂N T
;
∂∂T U
}
∑∑ 
public
ππ 

async
ππ 
Task
ππ 
<
ππ !
EditarRepartidorDto
ππ )
?
ππ) *
>
ππ* +$
ObtenerParaEditarAsync
ππ, B
(
ππB C
int
ππC F
	usuarioId
ππG P
)
ππP Q
{
∫∫ 
var
ªª 
rep
ªª 
=
ªª 
await
ªª 
db
ªª 
.
ªª 
Repartidores
ªª '
.
ºº 
AsNoTracking
ºº 
(
ºº 
)
ºº 
.
ΩΩ 
Include
ΩΩ 
(
ΩΩ 
r
ΩΩ 
=>
ΩΩ 
r
ΩΩ 
.
ΩΩ 
Usuario
ΩΩ #
)
ΩΩ# $
.
ææ !
FirstOrDefaultAsync
ææ  
(
ææ  !
r
ææ! "
=>
ææ# %
r
ææ& '
.
ææ' (
	UsuarioId
ææ( 1
==
ææ2 4
	usuarioId
ææ5 >
)
ææ> ?
;
ææ? @
if
øø 

(
øø 
rep
øø 
?
øø 
.
øø 
Usuario
øø 
is
øø 
null
øø  
)
øø  !
return
øø" (
null
øø) -
;
øø- .
return
¡¡ 
new
¡¡ !
EditarRepartidorDto
¡¡ &
{
¬¬ 	
NombreCompleto
√√ 
=
√√ 
rep
√√  
.
√√  !
NombreCompleto
√√! /
,
√√/ 0
Telefono
ƒƒ 
=
ƒƒ 
rep
ƒƒ 
.
ƒƒ 
Telefono
ƒƒ #
,
ƒƒ# $
Correo
≈≈ 
=
≈≈ 
rep
≈≈ 
.
≈≈ 
Usuario
≈≈  
.
≈≈  !
Correo
≈≈! '
,
≈≈' (
Vehiculo
∆∆ 
=
∆∆ 
rep
∆∆ 
.
∆∆ 
Vehiculo
∆∆ #
,
∆∆# $
Placa
«« 
=
«« 
rep
«« 
.
«« 
Placa
«« 
}
»» 	
;
»»	 

}
…… 
public
ÀÀ 

async
ÀÀ 
Task
ÀÀ 
<
ÀÀ 
(
ÀÀ 
bool
ÀÀ 
Ok
ÀÀ 
,
ÀÀ 
string
ÀÀ  &
?
ÀÀ& '
Error
ÀÀ( -
)
ÀÀ- .
>
ÀÀ. /
EditarAsync
ÀÀ0 ;
(
ÀÀ; <
int
ÀÀ< ?
	usuarioId
ÀÀ@ I
,
ÀÀI J!
EditarRepartidorDto
ÀÀK ^
dto
ÀÀ_ b
)
ÀÀb c
{
ÃÃ 
if
ÕÕ 

(
ÕÕ 
!
ÕÕ 
await
ÕÕ $
EdicionAutorizadaAsync
ÕÕ )
(
ÕÕ) *
	usuarioId
ÕÕ* 3
)
ÕÕ3 4
)
ÕÕ4 5
return
ÕÕ6 <
(
ÕÕ= >
false
ÕÕ> C
,
ÕÕC D$
MensajeSinVerificacion
ÕÕE [
)
ÕÕ[ \
;
ÕÕ\ ]
var
–– 
motivo
–– 
=
–– 
await
–– #
MotivoNoEditableAsync
–– 0
(
––0 1
	usuarioId
––1 :
)
––: ;
;
––; <
if
—— 

(
—— 
motivo
—— 
is
—— 
not
—— 
null
—— 
)
—— 
return
——  &
(
——' (
false
——( -
,
——- .
motivo
——/ 5
)
——5 6
;
——6 7
try
”” 
{
‘‘ 	
var
’’ 
rep
’’ 
=
’’ 
await
’’ 
db
’’ 
.
’’ 
Repartidores
’’ +
.
÷÷ 
Include
÷÷ 
(
÷÷ 
r
÷÷ 
=>
÷÷ 
r
÷÷ 
.
÷÷  
Usuario
÷÷  '
)
÷÷' (
.
◊◊ !
FirstOrDefaultAsync
◊◊ $
(
◊◊$ %
r
◊◊% &
=>
◊◊' )
r
◊◊* +
.
◊◊+ ,
	UsuarioId
◊◊, 5
==
◊◊6 8
	usuarioId
◊◊9 B
)
◊◊B C
;
◊◊C D
if
ÿÿ 
(
ÿÿ 
rep
ÿÿ 
?
ÿÿ 
.
ÿÿ 
Usuario
ÿÿ 
is
ÿÿ 
null
ÿÿ  $
)
ÿÿ$ %
return
ÿÿ& ,
(
ÿÿ- .
false
ÿÿ. 3
,
ÿÿ3 4"
MensajeErrorGuardado
ÿÿ5 I
)
ÿÿI J
;
ÿÿJ K
var
⁄⁄ 
correo
⁄⁄ 
=
⁄⁄ 
dto
⁄⁄ 
.
⁄⁄ 
Correo
⁄⁄ #
.
⁄⁄# $
Trim
⁄⁄$ (
(
⁄⁄( )
)
⁄⁄) *
;
⁄⁄* +
var
€€ 
telefono
€€ 
=
€€ 
dto
€€ 
.
€€ 
Telefono
€€ '
.
€€' (
Trim
€€( ,
(
€€, -
)
€€- .
;
€€. /
var
›› 
otroConCorreo
›› 
=
›› 
await
››  %
db
››& (
.
››( )
Usuarios
››) 1
.
››1 2
AnyAsync
››2 :
(
››: ;
u
››; <
=>
››= ?
u
››@ A
.
››A B
Correo
››B H
==
››I K
correo
››L R
&&
››S U
u
››V W
.
››W X
Id
››X Z
!=
››[ ]
	usuarioId
››^ g
)
››g h
;
››h i
if
ﬁﬁ 
(
ﬁﬁ 
otroConCorreo
ﬁﬁ 
)
ﬁﬁ 
return
ﬂﬂ 
(
ﬂﬂ 
false
ﬂﬂ 
,
ﬂﬂ 
$str
ﬂﬂ L
)
ﬂﬂL M
;
ﬂﬂM N
var
·· 
telefonoEnUso
·· 
=
·· 
await
‚‚ 
db
‚‚ 
.
‚‚ 
Negocios
‚‚ !
.
‚‚! "
AnyAsync
‚‚" *
(
‚‚* +
n
‚‚+ ,
=>
‚‚- /
n
‚‚0 1
.
‚‚1 2
Telefono
‚‚2 :
==
‚‚; =
telefono
‚‚> F
)
‚‚F G
||
‚‚H J
await
„„ 
db
„„ 
.
„„ 
Repartidores
„„ %
.
„„% &
AnyAsync
„„& .
(
„„. /
r
„„/ 0
=>
„„1 3
r
„„4 5
.
„„5 6
Telefono
„„6 >
==
„„? A
telefono
„„B J
&&
„„K M
r
„„N O
.
„„O P
Id
„„P R
!=
„„S U
rep
„„V Y
.
„„Y Z
Id
„„Z \
&&
‰‰ 
r
‰‰ 
.
‰‰ 
Usuario
‰‰  
!
‰‰  !
.
‰‰! "
Estado
‰‰" (
!=
‰‰) +
EstadoCuenta
‰‰, 8
.
‰‰8 9
	Eliminado
‰‰9 B
)
‰‰B C
||
‰‰D F
await
ÂÂ 
db
ÂÂ 
.
ÂÂ 
Administradores
ÂÂ (
.
ÂÂ( )
AnyAsync
ÂÂ) 1
(
ÂÂ1 2
a
ÂÂ2 3
=>
ÂÂ4 6
a
ÂÂ7 8
.
ÂÂ8 9
Telefono
ÂÂ9 A
==
ÂÂB D
telefono
ÂÂE M
)
ÂÂM N
;
ÂÂN O
if
ÊÊ 
(
ÊÊ 
telefonoEnUso
ÊÊ 
)
ÊÊ 
return
ÁÁ 
(
ÁÁ 
false
ÁÁ 
,
ÁÁ 
$str
ÁÁ N
)
ÁÁN O
;
ÁÁO P
var
ÈÈ 
conPlaca
ÈÈ 
=
ÈÈ 
dto
ÈÈ 
.
ÈÈ 
Vehiculo
ÈÈ '
is
ÈÈ( *
TipoVehiculo
ÈÈ+ 7
.
ÈÈ7 8
Moto
ÈÈ8 <
or
ÈÈ= ?
TipoVehiculo
ÈÈ@ L
.
ÈÈL M
Carro
ÈÈM R
;
ÈÈR S
rep
ÎÎ 
.
ÎÎ 
NombreCompleto
ÎÎ 
=
ÎÎ  
dto
ÎÎ! $
.
ÎÎ$ %
NombreCompleto
ÎÎ% 3
.
ÎÎ3 4
Trim
ÎÎ4 8
(
ÎÎ8 9
)
ÎÎ9 :
;
ÎÎ: ;
rep
ÏÏ 
.
ÏÏ 
Telefono
ÏÏ 
=
ÏÏ 
telefono
ÏÏ #
;
ÏÏ# $
rep
ÌÌ 
.
ÌÌ 
Vehiculo
ÌÌ 
=
ÌÌ 
dto
ÌÌ 
.
ÌÌ 
Vehiculo
ÌÌ '
!
ÌÌ' (
.
ÌÌ( )
Value
ÌÌ) .
;
ÌÌ. /
rep
ÓÓ 
.
ÓÓ 
Placa
ÓÓ 
=
ÓÓ 
conPlaca
ÓÓ  
?
ÓÓ! "
ReglasValidacion
ÓÓ# 3
.
ÓÓ3 4
NormalizarPlaca
ÓÓ4 C
(
ÓÓC D
dto
ÓÓD G
.
ÓÓG H
Placa
ÓÓH M
)
ÓÓM N
:
ÓÓO P
null
ÓÓQ U
;
ÓÓU V
rep
ÔÔ 
.
ÔÔ 
Usuario
ÔÔ 
.
ÔÔ 
Correo
ÔÔ 
=
ÔÔ  
correo
ÔÔ! '
;
ÔÔ' (
var
ÚÚ 
codigo
ÚÚ 
=
ÚÚ 
await
ÚÚ 
codigos
ÚÚ &
.
ÚÚ& ' 
ObtenerUltimoAsync
ÚÚ' 9
(
ÚÚ9 :
	usuarioId
ÚÚ: C
)
ÚÚC D
;
ÚÚD E
if
ÛÛ 
(
ÛÛ 
codigo
ÛÛ 
is
ÛÛ 
not
ÛÛ 
null
ÛÛ "
)
ÛÛ" #
codigo
ÛÛ$ *
.
ÛÛ* +
Usado
ÛÛ+ 0
=
ÛÛ1 2
true
ÛÛ3 7
;
ÛÛ7 8
await
ıı 
db
ıı 
.
ıı 
SaveChangesAsync
ıı %
(
ıı% &
)
ıı& '
;
ıı' (
return
ˆˆ 
(
ˆˆ 
true
ˆˆ 
,
ˆˆ 
null
ˆˆ 
)
ˆˆ 
;
ˆˆ  
}
˜˜ 	
catch
¯¯ 
(
¯¯ 
	Exception
¯¯ 
ex
¯¯ 
)
¯¯ 
{
˘˘ 	
logger
˙˙ 
.
˙˙ 
LogError
˙˙ 
(
˙˙ 
ex
˙˙ 
,
˙˙ 
$str
˙˙  d
,
˙˙d e
	usuarioId
˙˙f o
)
˙˙o p
;
˙˙p q
return
˚˚ 
(
˚˚ 
false
˚˚ 
,
˚˚ "
MensajeErrorGuardado
˚˚ /
)
˚˚/ 0
;
˚˚0 1
}
¸¸ 	
}
˝˝ 
public
ÅÅ 

async
ÅÅ 
Task
ÅÅ 
<
ÅÅ 
(
ÅÅ 
bool
ÅÅ 
Ok
ÅÅ 
,
ÅÅ 
string
ÅÅ  &
?
ÅÅ& '
Error
ÅÅ( -
)
ÅÅ- .
>
ÅÅ. /+
ValidarEliminacionPropiaAsync
ÅÅ0 M
(
ÅÅM N
int
ÅÅN Q
	usuarioId
ÅÅR [
)
ÅÅ[ \
{
ÇÇ 
var
ÉÉ 
rep
ÉÉ 
=
ÉÉ 
await
ÉÉ 
repartidores
ÉÉ $
.
ÉÉ$ %&
ObtenerPorUsuarioIdAsync
ÉÉ% =
(
ÉÉ= >
	usuarioId
ÉÉ> G
)
ÉÉG H
;
ÉÉH I
if
ÑÑ 

(
ÑÑ 
rep
ÑÑ 
is
ÑÑ 
null
ÑÑ 
)
ÑÑ 
return
ÑÑ 
(
ÑÑ  !
false
ÑÑ! &
,
ÑÑ& ' 
MensajeSinPermisos
ÑÑ( :
)
ÑÑ: ;
;
ÑÑ; <
if
ÜÜ 

(
ÜÜ 
await
ÜÜ *
ContarPedidosPendientesAsync
ÜÜ .
(
ÜÜ. /
rep
ÜÜ/ 2
.
ÜÜ2 3
Id
ÜÜ3 5
)
ÜÜ5 6
>
ÜÜ7 8
$num
ÜÜ9 :
)
ÜÜ: ;
return
áá 
(
áá 
false
áá 
,
áá '
MensajeEntregasPendientes
áá 4
)
áá4 5
;
áá5 6
return
ââ 
(
ââ 
true
ââ 
,
ââ 
null
ââ 
)
ââ 
;
ââ 
}
ää 
public
çç 

async
çç 
Task
çç 
<
çç 
(
çç 
bool
çç 
Ok
çç 
,
çç 
string
çç  &
?
çç& '
Error
çç( -
)
çç- .
>
çç. /'
EliminarCuentaPropiaAsync
çç0 I
(
ççI J
int
ççJ M
	usuarioId
ççN W
,
ççW X
string
ççY _
password
çç` h
)
ççh i
{
éé 
var
êê 
(
êê 
ok
êê 
,
êê 
error
êê 
)
êê 
=
êê 
await
êê +
ValidarEliminacionPropiaAsync
êê  =
(
êê= >
	usuarioId
êê> G
)
êêG H
;
êêH I
if
ëë 

(
ëë 
!
ëë 
ok
ëë 
)
ëë 
return
ëë 
(
ëë 
false
ëë 
,
ëë 
error
ëë  %
)
ëë% &
;
ëë& '
var
ìì 
usuario
ìì 
=
ìì 
await
ìì 
usuarios
ìì $
.
ìì$ %
ObtenerPorIdAsync
ìì% 6
(
ìì6 7
	usuarioId
ìì7 @
)
ìì@ A
;
ììA B
if
îî 

(
îî 
usuario
îî 
is
îî 
null
îî 
)
îî 
return
îî #
(
îî$ %
false
îî% *
,
îî* + 
MensajeSinPermisos
îî, >
)
îî> ?
;
îî? @
if
ññ 

(
ññ 
!
ññ 
PasswordCorrecta
ññ 
(
ññ 
usuario
ññ %
,
ññ% &
password
ññ' /
)
ññ/ 0
)
ññ0 1
return
óó 
(
óó 
false
óó 
,
óó )
MensajeContrasenaIncorrecta
óó 6
)
óó6 7
;
óó7 8
return
ôô 
await
ôô 
DarDeBajaAsync
ôô #
(
ôô# $
usuario
ôô$ +
)
ôô+ ,
;
ôô, -
}
öö 
public
ùù 

async
ùù 
Task
ùù 
<
ùù 
(
ùù 
bool
ùù 
Ok
ùù 
,
ùù 
string
ùù  &
?
ùù& '
Error
ùù( -
)
ùù- .
>
ùù. //
!ValidarEliminacionPorNegocioAsync
ùù0 Q
(
ùùQ R
int
ùùR U
usuarioNegocioId
ùùV f
,
ùùf g
int
ùùh k
repartidorId
ùùl x
)
ùùx y
{
ûû 
var
üü 
rep
üü 
=
üü 
await
üü '
RepartidorDelNegocioAsync
üü 1
(
üü1 2
usuarioNegocioId
üü2 B
,
üüB C
repartidorId
üüD P
)
üüP Q
;
üüQ R
if
†† 

(
†† 
rep
†† 
is
†† 
null
†† 
)
†† 
return
†† 
(
††  !
false
††! &
,
††& ' 
MensajeSinPermisos
††( :
)
††: ;
;
††; <
if
¢¢ 

(
¢¢ 
await
¢¢ *
ContarPedidosPendientesAsync
¢¢ .
(
¢¢. /
rep
¢¢/ 2
.
¢¢2 3
Id
¢¢3 5
)
¢¢5 6
>
¢¢7 8
$num
¢¢9 :
)
¢¢: ;
return
££ 
(
££ 
false
££ 
,
££ .
 MensajeEntregasPendientesNegocio
££ ;
)
££; <
;
££< =
return
•• 
(
•• 
true
•• 
,
•• 
null
•• 
)
•• 
;
•• 
}
¶¶ 
public
©© 

async
©© 
Task
©© 
<
©© 
(
©© 
bool
©© 
Ok
©© 
,
©© 
string
©©  &
?
©©& '
Error
©©( -
,
©©- .
string
©©/ 5
?
©©5 6
Nombre
©©7 =
)
©©= >
>
©©> ?%
EliminarPorNegocioAsync
©©@ W
(
©©W X
int
©©X [
usuarioNegocioId
©©\ l
,
©©l m
int
©©n q
repartidorId
©©r ~
,
©©~ 
string©©Ä Ü
password©©á è
)©©è ê
{
™™ 
var
´´ 
(
´´ 
ok
´´ 
,
´´ 
error
´´ 
)
´´ 
=
´´ 
await
´´ /
!ValidarEliminacionPorNegocioAsync
´´  A
(
´´A B
usuarioNegocioId
´´B R
,
´´R S
repartidorId
´´T `
)
´´` a
;
´´a b
if
¨¨ 

(
¨¨ 
!
¨¨ 
ok
¨¨ 
)
¨¨ 
return
¨¨ 
(
¨¨ 
false
¨¨ 
,
¨¨ 
error
¨¨  %
,
¨¨% &
null
¨¨' +
)
¨¨+ ,
;
¨¨, -
var
ÆÆ 
usuarioNegocio
ÆÆ 
=
ÆÆ 
await
ÆÆ "
usuarios
ÆÆ# +
.
ÆÆ+ ,
ObtenerPorIdAsync
ÆÆ, =
(
ÆÆ= >
usuarioNegocioId
ÆÆ> N
)
ÆÆN O
;
ÆÆO P
if
ØØ 

(
ØØ 
usuarioNegocio
ØØ 
is
ØØ 
null
ØØ "
)
ØØ" #
return
ØØ$ *
(
ØØ+ ,
false
ØØ, 1
,
ØØ1 2 
MensajeSinPermisos
ØØ3 E
,
ØØE F
null
ØØG K
)
ØØK L
;
ØØL M
if
±± 

(
±± 
!
±± 
PasswordCorrecta
±± 
(
±± 
usuarioNegocio
±± ,
,
±±, -
password
±±. 6
)
±±6 7
)
±±7 8
return
≤≤ 
(
≤≤ 
false
≤≤ 
,
≤≤ )
MensajeContrasenaIncorrecta
≤≤ 6
,
≤≤6 7
null
≤≤8 <
)
≤≤< =
;
≤≤= >
var
¥¥ 
rep
¥¥ 
=
¥¥ 
await
¥¥ '
RepartidorDelNegocioAsync
¥¥ 1
(
¥¥1 2
usuarioNegocioId
¥¥2 B
,
¥¥B C
repartidorId
¥¥D P
)
¥¥P Q
;
¥¥Q R
if
µµ 

(
µµ 
rep
µµ 
?
µµ 
.
µµ 
Usuario
µµ 
is
µµ 
null
µµ  
)
µµ  !
return
µµ" (
(
µµ) *
false
µµ* /
,
µµ/ 0 
MensajeSinPermisos
µµ1 C
,
µµC D
null
µµE I
)
µµI J
;
µµJ K
var
∑∑ 
(
∑∑ 
	eliminado
∑∑ 
,
∑∑ 
	errorBaja
∑∑ !
)
∑∑! "
=
∑∑# $
await
∑∑% *
DarDeBajaAsync
∑∑+ 9
(
∑∑9 :
rep
∑∑: =
.
∑∑= >
Usuario
∑∑> E
)
∑∑E F
;
∑∑F G
return
∏∏ 
(
∏∏ 
	eliminado
∏∏ 
,
∏∏ 
	errorBaja
∏∏ $
,
∏∏$ %
rep
∏∏& )
.
∏∏) *
NombreCompleto
∏∏* 8
)
∏∏8 9
;
∏∏9 :
}
ππ 
private
ªª 
async
ªª 
Task
ªª 
<
ªª 

Repartidor
ªª !
?
ªª! "
>
ªª" #'
RepartidorDelNegocioAsync
ªª$ =
(
ªª= >
int
ªª> A
usuarioNegocioId
ªªB R
,
ªªR S
int
ªªT W
repartidorId
ªªX d
)
ªªd e
{
ºº 
var
ΩΩ 
negocio
ΩΩ 
=
ΩΩ 
await
ΩΩ 
negocios
ΩΩ $
.
ΩΩ$ %&
ObtenerPorUsuarioIdAsync
ΩΩ% =
(
ΩΩ= >
usuarioNegocioId
ΩΩ> N
)
ΩΩN O
;
ΩΩO P
if
ææ 

(
ææ 
negocio
ææ 
is
ææ 
null
ææ 
)
ææ 
return
ææ #
null
ææ$ (
;
ææ( )
var
¿¿ 
rep
¿¿ 
=
¿¿ 
await
¿¿ 
repartidores
¿¿ $
.
¿¿$ %#
ObtenerDeNegocioAsync
¿¿% :
(
¿¿: ;
negocio
¿¿; B
.
¿¿B C
Id
¿¿C E
,
¿¿E F
repartidorId
¿¿G S
)
¿¿S T
;
¿¿T U
return
¡¡ 
rep
¡¡ 
?
¡¡ 
.
¡¡ 
Usuario
¡¡ 
is
¡¡ 
null
¡¡ #
||
¡¡$ &
rep
¡¡' *
.
¡¡* +
Usuario
¡¡+ 2
.
¡¡2 3
Estado
¡¡3 9
==
¡¡: <
EstadoCuenta
¡¡= I
.
¡¡I J
	Eliminado
¡¡J S
?
¡¡T U
null
¡¡V Z
:
¡¡[ \
rep
¡¡] `
;
¡¡` a
}
¬¬ 
private
«« 
async
«« 
Task
«« 
<
«« 
(
«« 
bool
«« 
Ok
«« 
,
««  
string
««! '
?
««' (
Error
««) .
)
««. /
>
««/ 0
DarDeBajaAsync
««1 ?
(
««? @
Usuario
««@ G
usuario
««H O
)
««O P
{
»» 
try
…… 
{
   	
usuario
ÀÀ 
.
ÀÀ 
Estado
ÀÀ 
=
ÀÀ 
EstadoCuenta
ÀÀ )
.
ÀÀ) *
	Eliminado
ÀÀ* 3
;
ÀÀ3 4
usuario
ÕÕ 
.
ÕÕ $
LiberarIdentificadores
ÕÕ *
(
ÕÕ* +
)
ÕÕ+ ,
;
ÕÕ, -
await
ŒŒ 
usuarios
ŒŒ 
.
ŒŒ 
ActualizarAsync
ŒŒ *
(
ŒŒ* +
usuario
ŒŒ+ 2
)
ŒŒ2 3
;
ŒŒ3 4
return
œœ 
(
œœ 
true
œœ 
,
œœ 
null
œœ 
)
œœ 
;
œœ  
}
–– 	
catch
—— 
(
—— 
	Exception
—— 
ex
—— 
)
—— 
{
““ 	
logger
”” 
.
”” 
LogError
”” 
(
”” 
ex
”” 
,
”” 
$str
””  b
,
””b c
usuario
””d k
.
””k l
Id
””l n
)
””n o
;
””o p
return
‘‘ 
(
‘‘ 
false
‘‘ 
,
‘‘ 
$str
‘‘ R
)
‘‘R S
;
‘‘S T
}
’’ 	
}
÷÷ 
private
ÿÿ 
bool
ÿÿ 
PasswordCorrecta
ÿÿ !
(
ÿÿ! "
Usuario
ÿÿ" )
usuario
ÿÿ* 1
,
ÿÿ1 2
string
ÿÿ3 9
password
ÿÿ: B
)
ÿÿB C
{
ŸŸ 
if
⁄⁄ 

(
⁄⁄ 
string
⁄⁄ 
.
⁄⁄ 
IsNullOrEmpty
⁄⁄  
(
⁄⁄  !
usuario
⁄⁄! (
.
⁄⁄( )
PasswordHash
⁄⁄) 5
)
⁄⁄5 6
||
⁄⁄7 9
string
⁄⁄: @
.
⁄⁄@ A
IsNullOrEmpty
⁄⁄A N
(
⁄⁄N O
password
⁄⁄O W
)
⁄⁄W X
)
⁄⁄X Y
return
⁄⁄Z `
false
⁄⁄a f
;
⁄⁄f g
try
€€ 
{
‹‹ 	
return
›› 
hasher
›› 
.
›› "
VerifyHashedPassword
›› .
(
››. /
usuario
››/ 6
,
››6 7
usuario
››8 ?
.
››? @
PasswordHash
››@ L
,
››L M
password
››N V
)
››V W
!=
››X Z(
PasswordVerificationResult
››[ u
.
››u v
Failed
››v |
;
››| }
}
ﬁﬁ 	
catch
ﬂﬂ 
(
ﬂﬂ 
FormatException
ﬂﬂ 
)
ﬂﬂ 
{
‡‡ 	
return
·· 
false
·· 
;
·· 
}
‚‚ 	
}
„„ 
private
ÂÂ 
static
ÂÂ 
string
ÂÂ 
MensajeBloqueo
ÂÂ (
(
ÂÂ( )
DateTime
ÂÂ) 1
hasta
ÂÂ2 7
)
ÂÂ7 8
{
ÊÊ 
var
ÁÁ 
minutos
ÁÁ 
=
ÁÁ 
Math
ÁÁ 
.
ÁÁ 
Max
ÁÁ 
(
ÁÁ 
$num
ÁÁ  
,
ÁÁ  !
(
ÁÁ" #
int
ÁÁ# &
)
ÁÁ& '
Math
ÁÁ' +
.
ÁÁ+ ,
Ceiling
ÁÁ, 3
(
ÁÁ3 4
(
ÁÁ4 5
hasta
ÁÁ5 :
-
ÁÁ; <
DateTime
ÁÁ= E
.
ÁÁE F
UtcNow
ÁÁF L
)
ÁÁL M
.
ÁÁM N
TotalMinutes
ÁÁN Z
)
ÁÁZ [
)
ÁÁ[ \
;
ÁÁ\ ]
return
ËË 
$"
ËË 
$str
ËË c
{
ËËc d
minutos
ËËd k
}
ËËk l
$str
ËËl w
"
ËËw x
;
ËËx y
}
ÈÈ 
}ÍÍ Á…
UC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\PedidoService.cs
	namespace 	
Gtrack
 
; 
public 
class 
PedidoService 
( 
IPedidoRepository 
pedidos 
, 
INegocioRepository 
negocios 
,  
AppDbContext		 
context		 
,		 
IEmailService

 
email

 
,

 
ILogger 
< 
PedidoService 
> 
logger !
)! "
:# $
IPedidoService% 3
{ 
private 
const 
string 
AlfabetoCodigo '
=( )
$str* K
;K L
public 

async 
Task 
< #
ClienteAutocompletarDto -
?- .
>. /'
BuscarClienteFrecuenteAsync0 K
(K L
intL O
usuarioNegocioIdP `
,` a
stringb h
telefonoi q
)q r
{ 
var 
negocio 
= 
await 
negocios $
.$ %$
ObtenerPorUsuarioIdAsync% =
(= >
usuarioNegocioId> N
)N O
;O P
if 

( 
negocio 
is 
null 
) 
return #
null$ (
;( )
var 
ultimoPedido 
= 
await  
pedidos! (
.( ))
ObtenerUltimoPorTelefonoAsync) F
(F G
negocioG N
.N O
IdO Q
,Q R
telefonoS [
.[ \
Trim\ `
(` a
)a b
)b c
;c d
if 

( 
ultimoPedido 
is 
null  
||! #
ultimoPedido$ 0
.0 1
Cliente1 8
is9 ;
null< @
)@ A
returnB H
nullI M
;M N
return 
new #
ClienteAutocompletarDto *
{ 	
Nombre 
= 
ultimoPedido !
.! "
Cliente" )
.) *
NombreCompleto* 8
,8 9
	Direccion 
= 
ultimoPedido $
.$ %
DireccionEntrega% 5
} 	
;	 

} 
public 

const 
string %
MensajeCamposObligatorios 1
=2 3
$str4 n
;n o
public!! 

async!! 
Task!! 
<!! 
(!! 
bool!! 
Ok!! 
,!! 
string!!  &
?!!& '
Error!!( -
,!!- .
string!!/ 5
?!!5 6
Codigo!!7 =
)!!= >
>!!> ?
RegistrarAsync!!@ N
(!!N O
int!!O R
usuarioNegocioId!!S c
,!!c d
RegistrarPedidoDto!!e w
dto!!x {
)!!{ |
{"" 
var## 
negocio## 
=## 
await## 
negocios## $
.##$ %$
ObtenerPorUsuarioIdAsync##% =
(##= >
usuarioNegocioId##> N
)##N O
;##O P
if$$ 

($$ 
negocio$$ 
is$$ 
null$$ 
)$$ 
return%% 
(%% 
false%% 
,%% 
$str%% B
,%%B C
null%%D H
)%%H I
;%%I J
var(( 
nombre(( 
=(( 
dto(( 
.(( 
ClienteNombre(( &
?((& '
.((' (
Trim((( ,
(((, -
)((- .
??((/ 1
$str((2 4
;((4 5
var)) 
telefono)) 
=)) 
dto)) 
.)) 
ClienteTelefono)) *
?))* +
.))+ ,
Trim)), 0
())0 1
)))1 2
??))3 5
$str))6 8
;))8 9
var** 
	direccion** 
=** 
dto** 
.** 
DireccionEntrega** ,
?**, -
.**- .
Trim**. 2
(**2 3
)**3 4
??**5 7
$str**8 :
;**: ;
var,, 
items,, 
=,, 
(,, 
dto,, 
.,, 
	Productos,, "
??,,# %
[,,& '
],,' (
),,( )
.-- 
Where-- 
(-- 
p-- 
=>-- 
!-- 
string-- 
.--  
IsNullOrWhiteSpace--  2
(--2 3
p--3 4
.--4 5
Descripcion--5 @
)--@ A
)--A B
... 
Select.. 
(.. 
p.. 
=>.. 
new.. 

ItemPedido.. '
{// 
Descripcion00 
=00 
p00 
.00  
Descripcion00  +
.00+ ,
Trim00, 0
(000 1
)001 2
,002 3
Cantidad11 
=11 
p11 
.11 
Cantidad11 %
,11% &
PrecioUnitario22 
=22  
p22! "
.22" #
PrecioUnitario22# 1
}33 
)33 
.44 
ToList44 
(44 
)44 
;44 
if66 

(66 
nombre66 
.66 
Length66 
==66 
$num66 
||66 !
telefono66" *
.66* +
Length66+ 1
==662 4
$num665 6
||667 9
	direccion66: C
.66C D
Length66D J
==66K M
$num66N O
||66P R
dto77 
.77 

MetodoPago77 
is77 
not77 !
{77" #
}77$ %

metodoPago77& 0
||771 3
!774 5
Enum775 9
.779 :
	IsDefined77: C
(77C D

metodoPago77D N
)77N O
||77P R
items77S X
.77X Y
Count77Y ^
==77_ a
$num77b c
)77c d
return88 
(88 
false88 
,88 %
MensajeCamposObligatorios88 4
,884 5
null886 :
)88: ;
;88; <
if:: 

(:: 
items:: 
.:: 
Any:: 
(:: 
i:: 
=>:: 
i:: 
.:: 
Cantidad:: %
<::& '
$num::( )
||::* ,
i::- .
.::. /
PrecioUnitario::/ =
<=::> @
$num::A B
)::B C
)::C D
return;; 
(;; 
false;; 
,;; 
$str;; `
,;;` a
null;;b f
);;f g
;;;g h
intAA 
	clienteIdAA 
;AA 
tryBB 
{CC 	
varDD 
	clienteDbDD 
=DD 
awaitDD !
contextDD" )
.DD) *
SetDD* -
<DD- .
ClienteDD. 5
>DD5 6
(DD6 7
)DD7 8
.EE 
IgnoreQueryFiltersEE #
(EE# $
)EE$ %
.FF 
FirstOrDefaultAsyncFF $
(FF$ %
cFF% &
=>FF' )
cFF* +
.FF+ ,
	NegocioIdFF, 5
==FF6 8
negocioFF9 @
.FF@ A
IdFFA C
&&FFD F
cFFG H
.FFH I
TelefonoFFI Q
==FFR T
telefonoFFU ]
)FF] ^
;FF^ _
ifHH 
(HH 
	clienteDbHH 
!=HH 
nullHH !
)HH! "
{II 
ifJJ 
(JJ 
	clienteDbJJ 
.JJ 
NombreCompletoJJ ,
!=JJ- /
nombreJJ0 6
)JJ6 7
	clienteDbJJ8 A
.JJA B
NombreCompletoJJB P
=JJQ R
nombreJJS Y
;JJY Z
ifKK 
(KK 
	clienteDbKK 
.KK #
DireccionPredeterminadaKK 5
!=KK6 8
	direccionKK9 B
)KKB C
	clienteDbKKD M
.KKM N#
DireccionPredeterminadaKKN e
=KKf g
	direccionKKh q
;KKq r
awaitMM 
contextMM 
.MM 
SaveChangesAsyncMM .
(MM. /
)MM/ 0
;MM0 1
	clienteIdNN 
=NN 
	clienteDbNN %
.NN% &
IdNN& (
;NN( )
}OO 
elsePP 
{QQ 
varRR 
nuevoClienteRR  
=RR! "
newRR# &
ClienteRR' .
{SS 
NombreCompletoTT "
=TT# $
nombreTT% +
,TT+ ,
TelefonoUU 
=UU 
telefonoUU '
,UU' (#
DireccionPredeterminadaVV +
=VV, -
	direccionVV. 7
,VV7 8
FechaRegistroWW !
=WW" #
DateTimeWW$ ,
.WW, -
UtcNowWW- 3
,WW3 4
	NegocioIdXX 
=XX 
negocioXX  '
.XX' (
IdXX( *
}YY 
;YY 
context[[ 
.[[ 
Set[[ 
<[[ 
Cliente[[ #
>[[# $
([[$ %
)[[% &
.[[& '
Add[[' *
([[* +
nuevoCliente[[+ 7
)[[7 8
;[[8 9
await\\ 
context\\ 
.\\ 
SaveChangesAsync\\ .
(\\. /
)\\/ 0
;\\0 1
	clienteId]] 
=]] 
nuevoCliente]] (
.]]( )
Id]]) +
;]]+ ,
}^^ 
}__ 	
catch`` 
(`` 
	Exception`` 
ex`` 
)`` 
{aa 	
contextbb 
.bb 
ChangeTrackerbb !
.bb! "
Clearbb" '
(bb' (
)bb( )
;bb) *
loggercc 
.cc 
LogErrorcc 
(cc 
excc 
,cc 
$strcc  u
,ccu v
negocioccw ~
.cc~ 
Id	cc Å
)
ccÅ Ç
;
ccÇ É
returndd 
(dd 
falsedd 
,dd 
$strdd S
,ddS T
nullddU Y
)ddY Z
;ddZ [
}ee 	
stringgg 
?gg 
codigogg 
=gg 
nullgg 
;gg 
forhh 
(hh 
varhh 
intentohh 
=hh 
$numhh 
;hh 
intentohh %
<hh& '
$numhh( )
;hh) *
intentohh+ 2
++hh2 4
)hh4 5
{ii 	
varjj 
	candidatojj 
=jj !
RandomNumberGeneratorjj 1
.jj1 2
	GetStringjj2 ;
(jj; <
AlfabetoCodigojj< J
,jjJ K
$numjjL M
)jjM N
;jjN O
ifkk 
(kk 
!kk 
awaitkk 
pedidoskk 
.kk 
ExisteCodigoAsynckk 0
(kk0 1
	candidatokk1 :
)kk: ;
)kk; <
{ll 
codigomm 
=mm 
	candidatomm "
;mm" #
breaknn 
;nn 
}oo 
}pp 	
ifrr 

(rr 
codigorr 
isrr 
nullrr 
)rr 
{ss 	
loggertt 
.tt 
LogErrortt 
(tt 
$strtt z
,ttz {
negocio	tt| É
.
ttÉ Ñ
Id
ttÑ Ü
)
ttÜ á
;
ttá à
returnuu 
(uu 
falseuu 
,uu 
$struu S
,uuS T
nulluuU Y
)uuY Z
;uuZ [
}vv 	
varxx 
pedidoxx 
=xx 
newxx 
Pedidoxx 
{yy 	
Codigozz 
=zz 
codigozz 
,zz 
	NegocioId{{ 
={{ 
negocio{{ 
.{{  
Id{{  "
,{{" #
	ClienteId|| 
=|| 
	clienteId|| !
,||! "
DireccionEntrega}} 
=}} 
	direccion}} (
,}}( )
MetodoPagoId~~ 
=~~ 
(~~ 
int~~ 
)~~  

metodoPago~~  *
,~~* +
EstadoPedidoId 
= 
$num 
, 
FechaCreacion
ÄÄ 
=
ÄÄ 
DateTime
ÄÄ $
.
ÄÄ$ %
UtcNow
ÄÄ% +
,
ÄÄ+ ,
Items
ÅÅ 
=
ÅÅ 
items
ÅÅ 
}
ÇÇ 	
;
ÇÇ	 

try
ÑÑ 
{
ÖÖ 	
await
ÜÜ 
pedidos
ÜÜ 
.
ÜÜ 
AgregarAsync
ÜÜ &
(
ÜÜ& '
pedido
ÜÜ' -
)
ÜÜ- .
;
ÜÜ. /
await
áá %
RegistrarHistorialAsync
áá )
(
áá) *
pedido
áá* 0
.
áá0 1
Id
áá1 3
,
áá3 4
(
áá5 6
int
áá6 9
)
áá9 :
EstadoPedido
áá: F
.
ááF G
Recibido
ááG O
,
ááO P
usuarioNegocioId
ááQ a
,
ááa b
$str
áác v
)
ááv w
;
ááw x
}
àà 	
catch
ââ 
(
ââ 
	Exception
ââ 
ex
ââ 
)
ââ 
{
ää 	
logger
ãã 
.
ãã 
LogError
ãã 
(
ãã 
ex
ãã 
,
ãã 
$str
ãã  l
,
ããl m
codigo
ããn t
,
ããt u
negocio
ããv }
.
ãã} ~
Idãã~ Ä
)ããÄ Å
;ããÅ Ç
return
åå 
(
åå 
false
åå 
,
åå 
$str
åå S
,
ååS T
null
ååU Y
)
ååY Z
;
ååZ [
}
çç 	
return
èè 
(
èè 
true
èè 
,
èè 
null
èè 
,
èè 
codigo
èè "
)
èè" #
;
èè# $
}
êê 
private
îî 
static
îî 
readonly
îî 
string
îî "
[
îî" #
]
îî# $
NombresEstado
îî% 2
=
îî3 4
[
ïï 	
$str
ïï	 
,
ïï 
$str
ïï %
,
ïï% &
$str
ïï' ;
,
ïï; <
$str
ïï= G
,
ïïG H
$str
ïïI T
,
ïïT U
$str
ïïV a
,
ïïa b
$str
ïïc n
]
ïïn o
;
ïïo p
private
óó 
const
óó 
string
óó #
MensajeEstadoCambiado
óó .
=
óó/ 0
$stróó1 ç
;óóç é
private
ôô 
static
ôô 
string
ôô 
NombreEstado
ôô &
(
ôô& '
int
ôô' *
estadoId
ôô+ 3
)
ôô3 4
=>
ôô5 7
estadoId
öö 
>=
öö 
$num
öö 
&&
öö 
estadoId
öö !
<
öö" #
NombresEstado
öö$ 1
.
öö1 2
Length
öö2 8
?
öö9 :
NombresEstado
öö; H
[
ööH I
estadoId
ööI Q
]
ööQ R
:
ööS T
$str
ööU b
;
ööb c
public
üü 

static
üü 
string
üü 
?
üü !
ValidarCambioEstado
üü -
(
üü- .
int
üü. 1
estadoActual
üü2 >
,
üü> ?
int
üü@ C
nuevoEstadoId
üüD Q
)
üüQ R
{
†† 
if
°° 

(
°° 
nuevoEstadoId
°° 
<
°° 
(
°° 
int
°°  
)
°°  !
EstadoPedido
°°! -
.
°°- .
Recibido
°°. 6
||
°°7 9
nuevoEstadoId
°°: G
>
°°H I
(
°°J K
int
°°K N
)
°°N O
EstadoPedido
°°O [
.
°°[ \
	Cancelado
°°\ e
)
°°e f
return
¢¢ 
$str
¢¢ 8
;
¢¢8 9
if
•• 

(
•• 
nuevoEstadoId
•• 
==
•• 
estadoActual
•• )
||
••* ,
nuevoEstadoId
••- :
==
••; =
(
••> ?
int
••? B
)
••B C
EstadoPedido
••C O
.
••O P
	Cancelado
••P Y
)
••Y Z
return
¶¶ 
null
¶¶ 
;
¶¶ 
if
®® 

(
®® 
nuevoEstadoId
®® 
<
®® 
estadoActual
®® (
)
®®( )
return
©© 
$"
©© 
$str
©© O
{
©©O P
NombreEstado
©©P \
(
©©\ ]
estadoActual
©©] i
)
©©i j
}
©©j k
$str©©k É
{©©É Ñ
NombreEstado©©Ñ ê
(©©ê ë
nuevoEstadoId©©ë û
)©©û ü
}©©ü †
$str©©† ¢
"©©¢ £
;©©£ §
if
´´ 

(
´´ 
nuevoEstadoId
´´ 
>
´´ 
estadoActual
´´ (
+
´´) *
$num
´´+ ,
)
´´, -
return
¨¨ 
$"
¨¨ 
$str
¨¨ ?
{
¨¨? @
NombreEstado
¨¨@ L
(
¨¨L M
estadoActual
¨¨M Y
)
¨¨Y Z
}
¨¨Z [
$str
¨¨[ u
{
¨¨u v
NombreEstado¨¨v Ç
(¨¨Ç É
estadoActual¨¨É è
+¨¨ê ë
$num¨¨í ì
)¨¨ì î
}¨¨î ï
$str¨¨ï ó
"¨¨ó ò
;¨¨ò ô
return
ÆÆ 
null
ÆÆ 
;
ÆÆ 
}
ØØ 
public
±± 

async
±± 
Task
±± 
<
±± 
(
±± 
bool
±± 
Ok
±± 
,
±± 
string
±±  &
?
±±& '
Error
±±( -
)
±±- .
>
±±. /#
ActualizarEstadoAsync
±±0 E
(
±±E F
int
±±F I
	usuarioId
±±J S
,
±±S T
int
±±U X
pedidoId
±±Y a
,
±±a b
int
±±c f
nuevoEstadoId
±±g t
,
±±t u
int
±±v y
?
±±y z
repartidorId±±{ á
=±±à â
null±±ä é
)±±é è
{
≤≤ 
var
≥≥ 
negocio
≥≥ 
=
≥≥ 
await
≥≥ 
negocios
≥≥ $
.
≥≥$ %&
ObtenerPorUsuarioIdAsync
≥≥% =
(
≥≥= >
	usuarioId
≥≥> G
)
≥≥G H
;
≥≥H I
if
¥¥ 

(
¥¥ 
negocio
¥¥ 
is
¥¥ 
not
¥¥ 
null
¥¥ 
)
¥¥  
{
µµ 	
var
∂∂ 
pedido
∂∂ 
=
∂∂ 
await
∂∂ 
pedidos
∂∂ &
.
∂∂& '
ObtenerPorIdAsync
∂∂' 8
(
∂∂8 9
pedidoId
∂∂9 A
)
∂∂A B
;
∂∂B C
if
∑∑ 
(
∑∑ 
pedido
∑∑ 
is
∑∑ 
null
∑∑ 
||
∑∑ !
pedido
∑∑" (
.
∑∑( )
	NegocioId
∑∑) 2
!=
∑∑3 5
negocio
∑∑6 =
.
∑∑= >
Id
∑∑> @
)
∑∑@ A
return
∏∏ 
(
∏∏ 
false
∏∏ 
,
∏∏ 
$str
∏∏ X
)
∏∏X Y
;
∏∏Y Z
if
ªª 
(
ªª 
pedido
ªª 
.
ªª 
EstadoPedidoId
ªª %
==
ªª& (
(
ªª) *
int
ªª* -
)
ªª- .
EstadoPedido
ªª. :
.
ªª: ;
	Entregado
ªª; D
||
ªªE G
pedido
ªªH N
.
ªªN O
EstadoPedidoId
ªªO ]
==
ªª^ `
(
ªªa b
int
ªªb e
)
ªªe f
EstadoPedido
ªªf r
.
ªªr s
	Cancelado
ªªs |
)
ªª| }
{
ºº 
return
ΩΩ 
(
ΩΩ 
false
ΩΩ 
,
ΩΩ 
$str
ΩΩ b
)
ΩΩb c
;
ΩΩc d
}
ææ 
var
√√ 
estadoActual
√√ 
=
√√ 
pedido
√√ %
.
√√% &
EstadoPedidoId
√√& 4
;
√√4 5
var
ƒƒ 
errorTransicion
ƒƒ 
=
ƒƒ  !!
ValidarCambioEstado
ƒƒ" 5
(
ƒƒ5 6
estadoActual
ƒƒ6 B
,
ƒƒB C
nuevoEstadoId
ƒƒD Q
)
ƒƒQ R
;
ƒƒR S
if
≈≈ 
(
≈≈ 
errorTransicion
≈≈ 
is
≈≈  "
not
≈≈# &
null
≈≈' +
)
≈≈+ ,
{
∆∆ 
return
«« 
(
«« 
false
«« 
,
«« 
errorTransicion
«« .
)
««. /
;
««/ 0
}
»» 
int
   
?
   
nuevoRepartidorId
   "
=
  # $
null
  % )
;
  ) *
if
ÃÃ 
(
ÃÃ 
nuevoEstadoId
ÃÃ 
>=
ÃÃ  
(
ÃÃ! "
int
ÃÃ" %
)
ÃÃ% &
EstadoPedido
ÃÃ& 2
.
ÃÃ2 3
Asignado
ÃÃ3 ;
&&
ÃÃ< >
nuevoEstadoId
ÃÃ? L
<=
ÃÃM O
(
ÃÃP Q
int
ÃÃQ T
)
ÃÃT U
EstadoPedido
ÃÃU a
.
ÃÃa b
	Entregado
ÃÃb k
)
ÃÃk l
{
ÕÕ 
int
ŒŒ 
?
ŒŒ  
repartidorAValidar
ŒŒ '
=
ŒŒ( )
repartidorId
ŒŒ* 6
.
ŒŒ6 7
HasValue
ŒŒ7 ?
&&
ŒŒ@ B
repartidorId
ŒŒC O
.
ŒŒO P
Value
ŒŒP U
>
ŒŒV W
$num
ŒŒX Y
?
œœ 
repartidorId
œœ "
:
–– 
pedido
–– 
.
–– 
RepartidorId
–– )
;
––) *
if
““ 
(
““  
repartidorAValidar
““ &
.
““& '
HasValue
““' /
&&
““0 2 
repartidorAValidar
““3 E
.
““E F
Value
““F K
>
““L M
$num
““N O
)
““O P
{
”” 
var
’’ 
estaSuspendido
’’ &
=
’’' (
await
’’) .
context
’’/ 6
.
’’6 7
Set
’’7 :
<
’’: ;"
SuspensionRepartidor
’’; O
>
’’O P
(
’’P Q
)
’’Q R
.
÷÷ 
AnyAsync
÷÷ !
(
÷÷! "
s
÷÷" #
=>
÷÷$ &
s
÷÷' (
.
÷÷( )
RepartidorId
÷÷) 5
==
÷÷6 8 
repartidorAValidar
÷÷9 K
.
÷÷K L
Value
÷÷L Q
&&
÷÷R T
s
÷÷U V
.
÷÷V W
FechaReactivacion
÷÷W h
==
÷÷i k
null
÷÷l p
)
÷÷p q
;
÷÷q r
if
ÿÿ 
(
ÿÿ 
estaSuspendido
ÿÿ &
)
ÿÿ& '
{
ŸŸ 
return
⁄⁄ 
(
⁄⁄  
false
⁄⁄  %
,
⁄⁄% &
$str⁄⁄' Ü
)⁄⁄Ü á
;⁄⁄á à
}
€€ 
if
›› 
(
›› 
repartidorId
›› $
.
››$ %
HasValue
››% -
&&
››. 0
repartidorId
››1 =
.
››= >
Value
››> C
>
››D E
$num
››F G
)
››G H
{
ﬁﬁ 
nuevoRepartidorId
ﬂﬂ )
=
ﬂﬂ* +
repartidorId
ﬂﬂ, 8
.
ﬂﬂ8 9
Value
ﬂﬂ9 >
;
ﬂﬂ> ?
}
‡‡ 
}
·· 
else
‚‚ 
if
‚‚ 
(
‚‚ 
pedido
‚‚ 
.
‚‚  
RepartidorId
‚‚  ,
is
‚‚- /
null
‚‚0 4
)
‚‚4 5
{
„„ 
return
‰‰ 
(
‰‰ 
false
‰‰ !
,
‰‰! "
$str
‰‰# l
)
‰‰l m
;
‰‰m n
}
ÂÂ 
}
ÊÊ 
try
ËË 
{
ÈÈ 
var
ÏÏ 
filas
ÏÏ 
=
ÏÏ 
await
ÏÏ !
context
ÏÏ" )
.
ÏÏ) *
Pedidos
ÏÏ* 1
.
ÌÌ 
Where
ÌÌ 
(
ÌÌ 
p
ÌÌ 
=>
ÌÌ 
p
ÌÌ  !
.
ÌÌ! "
Id
ÌÌ" $
==
ÌÌ% '
pedido
ÌÌ( .
.
ÌÌ. /
Id
ÌÌ/ 1
&&
ÌÌ2 4
p
ÌÌ5 6
.
ÌÌ6 7
EstadoPedidoId
ÌÌ7 E
==
ÌÌF H
estadoActual
ÌÌI U
)
ÌÌU V
.
ÓÓ  
ExecuteUpdateAsync
ÓÓ '
(
ÓÓ' (
s
ÓÓ( )
=>
ÓÓ* ,
s
ÓÓ- .
.
ÔÔ 
SetProperty
ÔÔ $
(
ÔÔ$ %
p
ÔÔ% &
=>
ÔÔ' )
p
ÔÔ* +
.
ÔÔ+ ,
EstadoPedidoId
ÔÔ, :
,
ÔÔ: ;
nuevoEstadoId
ÔÔ< I
)
ÔÔI J
.
 
SetProperty
 $
(
$ %
p
% &
=>
' )
p
* +
.
+ ,
RepartidorId
, 8
,
8 9
p
: ;
=>
< >
nuevoRepartidorId
? P
??
Q S
p
T U
.
U V
RepartidorId
V b
)
b c
)
c d
;
d e
if
ÚÚ 
(
ÚÚ 
filas
ÚÚ 
==
ÚÚ 
$num
ÚÚ 
)
ÚÚ 
{
ÛÛ 
return
ÙÙ 
(
ÙÙ 
false
ÙÙ !
,
ÙÙ! "#
MensajeEstadoCambiado
ÙÙ# 8
)
ÙÙ8 9
;
ÙÙ9 :
}
ıı 
await
˜˜ %
RegistrarHistorialAsync
˜˜ -
(
˜˜- .
pedido
˜˜. 4
.
˜˜4 5
Id
˜˜5 7
,
˜˜7 8
nuevoEstadoId
˜˜9 F
,
˜˜F G
	usuarioId
˜˜H Q
,
˜˜Q R
null
˜˜S W
)
˜˜W X
;
˜˜X Y
}
¯¯ 
catch
˘˘ 
(
˘˘ 
	Exception
˘˘ 
ex
˘˘ 
)
˘˘  
{
˙˙ 
logger
˚˚ 
.
˚˚ 
LogError
˚˚ 
(
˚˚  
ex
˚˚  "
,
˚˚" #
$str
˚˚$ u
,
˚˚u v
pedidoId
˚˚w 
,˚˚ Ä
negocio˚˚Å à
.˚˚à â
Id˚˚â ã
)˚˚ã å
;˚˚å ç
return
¸¸ 
(
¸¸ 
false
¸¸ 
,
¸¸ 
$str
¸¸ c
)
¸¸c d
;
¸¸d e
}
˝˝ 
return
ˇˇ 
(
ˇˇ 
true
ˇˇ 
,
ˇˇ 
null
ˇˇ 
)
ˇˇ 
;
ˇˇ  
}
ÄÄ 	
var
ÉÉ 

repartidor
ÉÉ 
=
ÉÉ 
await
ÉÉ 
context
ÉÉ &
.
ÉÉ& '
Repartidores
ÉÉ' 3
.
ÑÑ 
AsNoTracking
ÑÑ 
(
ÑÑ 
)
ÑÑ 
.
ÖÖ !
FirstOrDefaultAsync
ÖÖ  
(
ÖÖ  !
r
ÖÖ! "
=>
ÖÖ# %
r
ÖÖ& '
.
ÖÖ' (
	UsuarioId
ÖÖ( 1
==
ÖÖ2 4
	usuarioId
ÖÖ5 >
)
ÖÖ> ?
;
ÖÖ? @
if
áá 

(
áá 

repartidor
áá 
is
áá 
not
áá 
null
áá "
)
áá" #
{
àà 	
var
ââ 
estaSuspendido
ââ 
=
ââ  
await
ââ! &
context
ââ' .
.
ââ. /
Set
ââ/ 2
<
ââ2 3"
SuspensionRepartidor
ââ3 G
>
ââG H
(
ââH I
)
ââI J
.
ää 
AnyAsync
ää 
(
ää 
s
ää 
=>
ää 
s
ää  
.
ää  !
RepartidorId
ää! -
==
ää. 0

repartidor
ää1 ;
.
ää; <
Id
ää< >
&&
ää? A
s
ääB C
.
ääC D
FechaReactivacion
ääD U
==
ääV X
null
ääY ]
)
ää] ^
;
ää^ _
if
åå 
(
åå 
estaSuspendido
åå 
)
åå 
{
çç 
return
éé 
(
éé 
false
éé 
,
éé 
$str
éé ]
)
éé] ^
;
éé^ _
}
èè 
var
ëë 
pedido
ëë 
=
ëë 
await
ëë 
pedidos
ëë &
.
ëë& '
ObtenerPorIdAsync
ëë' 8
(
ëë8 9
pedidoId
ëë9 A
)
ëëA B
;
ëëB C
if
íí 
(
íí 
pedido
íí 
is
íí 
null
íí 
||
íí !
pedido
íí" (
.
íí( )
RepartidorId
íí) 5
!=
íí6 8

repartidor
íí9 C
.
ííC D
Id
ííD F
)
ííF G
{
ìì 
return
îî 
(
îî 
false
îî 
,
îî 
$str
îî \
)
îî\ ]
;
îî] ^
}
ïï 
bool
òò 
transicionValida
òò !
=
òò" #
(
òò$ %
pedido
òò% +
.
òò+ ,
EstadoPedidoId
òò, :
==
òò; =
(
òò> ?
int
òò? B
)
òòB C
EstadoPedido
òòC O
.
òòO P
Asignado
òòP X
&&
òòY [
nuevoEstadoId
òò\ i
==
òòj l
(
òòm n
int
òòn q
)
òòq r
EstadoPedido
òòr ~
.
òò~ 
EnCaminoòò á
)òòá à
||
ôô! #
(
ôô$ %
pedido
ôô% +
.
ôô+ ,
EstadoPedidoId
ôô, :
==
ôô; =
(
ôô> ?
int
ôô? B
)
ôôB C
EstadoPedido
ôôC O
.
ôôO P
EnCamino
ôôP X
&&
ôôY [
nuevoEstadoId
ôô\ i
==
ôôj l
(
ôôm n
int
ôôn q
)
ôôq r
EstadoPedido
ôôr ~
.
ôô~ 
	Entregadoôô à
)ôôà â
;ôôâ ä
if
õõ 
(
õõ 
!
õõ 
transicionValida
õõ !
)
õõ! "
{
úú 
return
ùù 
(
ùù 
false
ùù 
,
ùù 
$str
ùù F
)
ùùF G
;
ùùG H
}
ûû 
try
†† 
{
°° 
var
££ 
estadoActual
££  
=
££! "
pedido
££# )
.
££) *
EstadoPedidoId
££* 8
;
££8 9
var
§§ 
filas
§§ 
=
§§ 
await
§§ !
context
§§" )
.
§§) *
Pedidos
§§* 1
.
•• 
Where
•• 
(
•• 
p
•• 
=>
•• 
p
••  !
.
••! "
Id
••" $
==
••% '
pedido
••( .
.
••. /
Id
••/ 1
&&
••2 4
p
••5 6
.
••6 7
EstadoPedidoId
••7 E
==
••F H
estadoActual
••I U
&&
••V X
p
••Y Z
.
••Z [
RepartidorId
••[ g
==
••h j

repartidor
••k u
.
••u v
Id
••v x
)
••x y
.
¶¶  
ExecuteUpdateAsync
¶¶ '
(
¶¶' (
s
¶¶( )
=>
¶¶* ,
s
¶¶- .
.
¶¶. /
SetProperty
¶¶/ :
(
¶¶: ;
p
¶¶; <
=>
¶¶= ?
p
¶¶@ A
.
¶¶A B
EstadoPedidoId
¶¶B P
,
¶¶P Q
nuevoEstadoId
¶¶R _
)
¶¶_ `
)
¶¶` a
;
¶¶a b
if
®® 
(
®® 
filas
®® 
==
®® 
$num
®® 
)
®® 
{
©© 
return
™™ 
(
™™ 
false
™™ !
,
™™! "
$str
™™# J
)
™™J K
;
™™K L
}
´´ 
await
≠≠ %
RegistrarHistorialAsync
≠≠ -
(
≠≠- .
pedido
≠≠. 4
.
≠≠4 5
Id
≠≠5 7
,
≠≠7 8
nuevoEstadoId
≠≠9 F
,
≠≠F G
	usuarioId
≠≠H Q
,
≠≠Q R
null
≠≠S W
)
≠≠W X
;
≠≠X Y
}
ÆÆ 
catch
ØØ 
(
ØØ 
	Exception
ØØ 
ex
ØØ 
)
ØØ  
{
∞∞ 
logger
±± 
.
±± 
LogError
±± 
(
±±  
ex
±±  "
,
±±" #
$str
±±$ {
,
±±{ |
pedidoId±±} Ö
,±±Ö Ü

repartidor±±á ë
.±±ë í
Id±±í î
)±±î ï
;±±ï ñ
return
≤≤ 
(
≤≤ 
false
≤≤ 
,
≤≤ 
$str
≤≤ c
)
≤≤c d
;
≤≤d e
}
≥≥ 
return
µµ 
(
µµ 
true
µµ 
,
µµ 
null
µµ 
)
µµ 
;
µµ  
}
∂∂ 	
return
∏∏ 
(
∏∏ 
false
∏∏ 
,
∏∏ 
$str
∏∏ H
)
∏∏H I
;
∏∏I J
}
ππ 
private
ΩΩ 
async
ΩΩ 
Task
ΩΩ %
RegistrarHistorialAsync
ΩΩ .
(
ΩΩ. /
int
ΩΩ/ 2
pedidoId
ΩΩ3 ;
,
ΩΩ; <
int
ΩΩ= @
estadoId
ΩΩA I
,
ΩΩI J
int
ΩΩK N
?
ΩΩN O
	usuarioId
ΩΩP Y
,
ΩΩY Z
string
ΩΩ[ a
?
ΩΩa b
observacion
ΩΩc n
)
ΩΩn o
{
ææ 
try
øø 
{
¿¿ 	
var
¡¡ 
fecha
¡¡ 
=
¡¡ 
DateTime
¡¡  
.
¡¡  !
UtcNow
¡¡! '
;
¡¡' (
await
¬¬ 
context
¬¬ 
.
¬¬ 
Database
¬¬ "
.
¬¬" #)
ExecuteSqlInterpolatedAsync
¬¬# >
(
¬¬> ?
$"
√√ 
$str√√ Ä
{√√Ä Å
pedidoId√√Å â
}√√â ä
$str√√ä å
{√√å ç
estadoId√√ç ï
}√√ï ñ
$str√√ñ ò
{√√ò ô
	usuarioId√√ô ¢
}√√¢ £
$str√√£ •
{√√• ¶
observacion√√¶ ±
}√√± ≤
$str√√≤ ¥
{√√¥ µ
fecha√√µ ∫
}√√∫ ª
$str√√ª º
"√√º Ω
)√√Ω æ
;√√æ ø
}
ƒƒ 	
catch
≈≈ 
(
≈≈ 
	Exception
≈≈ 
ex
≈≈ 
)
≈≈ 
{
∆∆ 	
logger
«« 
.
«« 

LogWarning
«« 
(
«« 
ex
««  
,
««  !
$str
««" o
,
««o p
pedidoId
««q y
,
««y z
estadoId««{ É
)««É Ñ
;««Ñ Ö
}
»» 	
}
…… 
public
ÀÀ 

async
ÀÀ 
Task
ÀÀ 
<
ÀÀ 
List
ÀÀ 
<
ÀÀ 
Pedido
ÀÀ !
>
ÀÀ! "
>
ÀÀ" #(
ObtenerPedidosActivosAsync
ÀÀ$ >
(
ÀÀ> ?
int
ÀÀ? B
usuarioNegocioId
ÀÀC S
)
ÀÀS T
{
ÃÃ 
var
ÕÕ 
negocio
ÕÕ 
=
ÕÕ 
await
ÕÕ 
negocios
ÕÕ $
.
ÕÕ$ %&
ObtenerPorUsuarioIdAsync
ÕÕ% =
(
ÕÕ= >
usuarioNegocioId
ÕÕ> N
)
ÕÕN O
;
ÕÕO P
if
ŒŒ 

(
ŒŒ 
negocio
ŒŒ 
is
ŒŒ 
null
ŒŒ 
)
ŒŒ 
return
ŒŒ #
[
ŒŒ$ %
]
ŒŒ% &
;
ŒŒ& '
var
–– 
listaPedidos
–– 
=
–– 
await
––  
pedidos
––! (
.
––( )$
ObtenerPorNegocioAsync
––) ?
(
––? @
negocio
––@ G
.
––G H
Id
––H J
)
––J K
;
––K L
return
““ 
listaPedidos
““ 
.
”” 
Where
”” 
(
”” 
p
”” 
=>
”” 
p
”” 
.
”” 
EstadoPedidoId
”” (
!=
””) +
(
””, -
int
””- 0
)
””0 1
EstadoPedido
””1 =
.
””= >
	Entregado
””> G
&&
””H J
p
””K L
.
””L M
EstadoPedidoId
””M [
!=
””\ ^
(
””_ `
int
””` c
)
””c d
EstadoPedido
””d p
.
””p q
	Cancelado
””q z
)
””z {
.
‘‘ 
ToList
‘‘ 
(
‘‘ 
)
‘‘ 
;
‘‘ 
}
’’ 
public
◊◊ 

async
◊◊ 
Task
◊◊ 
<
◊◊ 
List
◊◊ 
<
◊◊ 
Pedido
◊◊ !
>
◊◊! "
>
◊◊" #*
ObtenerHistorialPedidosAsync
◊◊$ @
(
◊◊@ A
int
◊◊A D
usuarioNegocioId
◊◊E U
)
◊◊U V
{
ÿÿ 
var
ŸŸ 
negocio
ŸŸ 
=
ŸŸ 
await
ŸŸ 
negocios
ŸŸ $
.
ŸŸ$ %&
ObtenerPorUsuarioIdAsync
ŸŸ% =
(
ŸŸ= >
usuarioNegocioId
ŸŸ> N
)
ŸŸN O
;
ŸŸO P
if
⁄⁄ 

(
⁄⁄ 
negocio
⁄⁄ 
is
⁄⁄ 
null
⁄⁄ 
)
⁄⁄ 
return
⁄⁄ #
[
⁄⁄$ %
]
⁄⁄% &
;
⁄⁄& '
var
‹‹ 
listaPedidos
‹‹ 
=
‹‹ 
await
‹‹  
pedidos
‹‹! (
.
‹‹( )$
ObtenerPorNegocioAsync
‹‹) ?
(
‹‹? @
negocio
‹‹@ G
.
‹‹G H
Id
‹‹H J
)
‹‹J K
;
‹‹K L
return
ﬁﬁ 
listaPedidos
ﬁﬁ 
.
ﬂﬂ 
Where
ﬂﬂ 
(
ﬂﬂ 
p
ﬂﬂ 
=>
ﬂﬂ 
p
ﬂﬂ 
.
ﬂﬂ 
EstadoPedidoId
ﬂﬂ (
==
ﬂﬂ) +
(
ﬂﬂ, -
int
ﬂﬂ- 0
)
ﬂﬂ0 1
EstadoPedido
ﬂﬂ1 =
.
ﬂﬂ= >
	Entregado
ﬂﬂ> G
||
ﬂﬂH J
p
ﬂﬂK L
.
ﬂﬂL M
EstadoPedidoId
ﬂﬂM [
==
ﬂﬂ\ ^
(
ﬂﬂ_ `
int
ﬂﬂ` c
)
ﬂﬂc d
EstadoPedido
ﬂﬂd p
.
ﬂﬂp q
	Cancelado
ﬂﬂq z
)
ﬂﬂz {
.
‡‡ 
ToList
‡‡ 
(
‡‡ 
)
‡‡ 
;
‡‡ 
}
·· 
public
‰‰ 

const
‰‰ 
string
‰‰ '
MensajeCodigoNoEncontrado
‰‰ 1
=
‰‰2 3
$str
‰‰4 i
;
‰‰i j
public
ÂÂ 

const
ÂÂ 
int
ÂÂ !
MaxCaracteresMotivo
ÂÂ (
=
ÂÂ) *
$num
ÂÂ+ .
;
ÂÂ. /
private
ÁÁ 
const
ÁÁ 
string
ÁÁ !
MensajeNoCancelable
ÁÁ ,
=
ÁÁ- .
$str
ÁÁ/ V
;
ÁÁV W
private
ËË 
const
ËË 
string
ËË '
MensajeSolicitudDuplicada
ËË 2
=
ËË3 4
$str
ËË5 n
;
ËËn o
private
ÈÈ 
const
ÈÈ 
string
ÈÈ %
MensajeErrorCancelacion
ÈÈ 0
=
ÈÈ1 2
$str
ÈÈ3 j
;
ÈÈj k
public
ÏÏ 

static
ÏÏ 
bool
ÏÏ $
EsCancelablePorCliente
ÏÏ -
(
ÏÏ- .
int
ÏÏ. 1
estadoId
ÏÏ2 :
)
ÏÏ: ;
=>
ÏÏ< >
estadoId
ÌÌ 
>=
ÌÌ 
(
ÌÌ 
int
ÌÌ 
)
ÌÌ 
EstadoPedido
ÌÌ %
.
ÌÌ% &
Recibido
ÌÌ& .
&&
ÌÌ/ 1
estadoId
ÌÌ2 :
<=
ÌÌ; =
(
ÌÌ> ?
int
ÌÌ? B
)
ÌÌB C
EstadoPedido
ÌÌC O
.
ÌÌO P
Asignado
ÌÌP X
;
ÌÌX Y
public
ÔÔ 

async
ÔÔ 
Task
ÔÔ 
<
ÔÔ 
(
ÔÔ 
bool
ÔÔ 
Ok
ÔÔ 
,
ÔÔ 
string
ÔÔ  &
?
ÔÔ& '
Error
ÔÔ( -
)
ÔÔ- .
>
ÔÔ. /%
CancelarPorClienteAsync
ÔÔ0 G
(
ÔÔG H
string
ÔÔH N
?
ÔÔN O
codigo
ÔÔP V
,
ÔÔV W
string
ÔÔX ^
?
ÔÔ^ _
motivo
ÔÔ` f
)
ÔÔf g
{
 
var
ÒÒ 
codigoLimpio
ÒÒ 
=
ÒÒ 
codigo
ÒÒ !
?
ÒÒ! "
.
ÒÒ" #
Trim
ÒÒ# '
(
ÒÒ' (
)
ÒÒ( )
.
ÒÒ) *
ToUpperInvariant
ÒÒ* :
(
ÒÒ: ;
)
ÒÒ; <
??
ÒÒ= ?
$str
ÒÒ@ B
;
ÒÒB C
if
ÚÚ 

(
ÚÚ 
!
ÚÚ 
Patrones
ÚÚ 
.
ÚÚ 
CodigoPedido
ÚÚ "
(
ÚÚ" #
)
ÚÚ# $
.
ÚÚ$ %
IsMatch
ÚÚ% ,
(
ÚÚ, -
codigoLimpio
ÚÚ- 9
)
ÚÚ9 :
)
ÚÚ: ;
return
ÛÛ 
(
ÛÛ 
false
ÛÛ 
,
ÛÛ '
MensajeCodigoNoEncontrado
ÛÛ 4
)
ÛÛ4 5
;
ÛÛ5 6
var
ıı 
motivoLimpio
ıı 
=
ıı 
motivo
ıı !
?
ıı! "
.
ıı" #
Trim
ıı# '
(
ıı' (
)
ıı( )
??
ıı* ,
$str
ıı- /
;
ıı/ 0
if
ˆˆ 

(
ˆˆ 
motivoLimpio
ˆˆ 
.
ˆˆ 
Length
ˆˆ 
==
ˆˆ  "
$num
ˆˆ# $
)
ˆˆ$ %
return
˜˜ 
(
˜˜ 
false
˜˜ 
,
˜˜ 
$str
˜˜ @
)
˜˜@ A
;
˜˜A B
if
¯¯ 

(
¯¯ 
motivoLimpio
¯¯ 
.
¯¯ 
Length
¯¯ 
>
¯¯  !!
MaxCaracteresMotivo
¯¯" 5
)
¯¯5 6
return
˘˘ 
(
˘˘ 
false
˘˘ 
,
˘˘ 
$"
˘˘ 
$str
˘˘ :
{
˘˘: ;!
MaxCaracteresMotivo
˘˘; N
}
˘˘N O
$str
˘˘O Z
"
˘˘Z [
)
˘˘[ \
;
˘˘\ ]
try
˚˚ 
{
¸¸ 	
var
˝˝ 
pedido
˝˝ 
=
˝˝ 
await
˝˝ 
context
˝˝ &
.
˝˝& '
Pedidos
˝˝' .
.
˛˛ 
AsNoTracking
˛˛ 
(
˛˛ 
)
˛˛ 
.
ˇˇ 
Include
ˇˇ 
(
ˇˇ 
p
ˇˇ 
=>
ˇˇ 
p
ˇˇ 
.
ˇˇ  
Cliente
ˇˇ  '
)
ˇˇ' (
.
ÄÄ 
Include
ÄÄ 
(
ÄÄ 
p
ÄÄ 
=>
ÄÄ 
p
ÄÄ 
.
ÄÄ  
Negocio
ÄÄ  '
)
ÄÄ' (
.
ÄÄ( )
ThenInclude
ÄÄ) 4
(
ÄÄ4 5
n
ÄÄ5 6
=>
ÄÄ7 9
n
ÄÄ: ;
!
ÄÄ; <
.
ÄÄ< =
Usuario
ÄÄ= D
)
ÄÄD E
.
ÅÅ !
FirstOrDefaultAsync
ÅÅ $
(
ÅÅ$ %
p
ÅÅ% &
=>
ÅÅ' )
p
ÅÅ* +
.
ÅÅ+ ,
Codigo
ÅÅ, 2
==
ÅÅ3 5
codigoLimpio
ÅÅ6 B
)
ÅÅB C
;
ÅÅC D
if
ÉÉ 
(
ÉÉ 
pedido
ÉÉ 
is
ÉÉ 
null
ÉÉ 
)
ÉÉ 
return
ÉÉ  &
(
ÉÉ' (
false
ÉÉ( -
,
ÉÉ- .'
MensajeCodigoNoEncontrado
ÉÉ/ H
)
ÉÉH I
;
ÉÉI J
if
ÜÜ 
(
ÜÜ 
await
ÜÜ 
context
ÜÜ 
.
ÜÜ $
SolicitudesCancelacion
ÜÜ 4
.
ÜÜ4 5
AnyAsync
ÜÜ5 =
(
ÜÜ= >
s
ÜÜ> ?
=>
ÜÜ@ B
s
ÜÜC D
.
ÜÜD E
PedidoId
ÜÜE M
==
ÜÜN P
pedido
ÜÜQ W
.
ÜÜW X
Id
ÜÜX Z
)
ÜÜZ [
)
ÜÜ[ \
return
áá 
(
áá 
false
áá 
,
áá '
MensajeSolicitudDuplicada
áá 8
)
áá8 9
;
áá9 :
if
ää 
(
ää 
!
ää $
EsCancelablePorCliente
ää '
(
ää' (
pedido
ää( .
.
ää. /
EstadoPedidoId
ää/ =
)
ää= >
)
ää> ?
return
ãã 
(
ãã 
false
ãã 
,
ãã !
MensajeNoCancelable
ãã 2
)
ãã2 3
;
ãã3 4
var
çç 
ahora
çç 
=
çç 
DateTime
çç  
.
çç  !
UtcNow
çç! '
;
çç' (
await
éé 
using
éé 
(
éé 
var
éé 
tx
éé 
=
éé  !
await
éé" '
context
éé( /
.
éé/ 0
Database
éé0 8
.
éé8 9#
BeginTransactionAsync
éé9 N
(
ééN O
)
ééO P
)
ééP Q
{
èè 
var
íí 
filas
íí 
=
íí 
await
íí !
context
íí" )
.
íí) *
Pedidos
íí* 1
.
ìì 
Where
ìì 
(
ìì 
p
ìì 
=>
ìì 
p
ìì  !
.
ìì! "
Id
ìì" $
==
ìì% '
pedido
ìì( .
.
ìì. /
Id
ìì/ 1
&&
ìì2 4
p
îî  !
.
îî! "
EstadoPedidoId
îî" 0
>=
îî1 3
(
îî4 5
int
îî5 8
)
îî8 9
EstadoPedido
îî9 E
.
îîE F
Recibido
îîF N
&&
îîO Q
p
ïï  !
.
ïï! "
EstadoPedidoId
ïï" 0
<=
ïï1 3
(
ïï4 5
int
ïï5 8
)
ïï8 9
EstadoPedido
ïï9 E
.
ïïE F
Asignado
ïïF N
)
ïïN O
.
ññ  
ExecuteUpdateAsync
ññ '
(
ññ' (
s
ññ( )
=>
ññ* ,
s
ññ- .
.
ññ. /
SetProperty
ññ/ :
(
ññ: ;
p
ññ; <
=>
ññ= ?
p
ññ@ A
.
ññA B
EstadoPedidoId
ññB P
,
ññP Q
(
ññR S
int
ññS V
)
ññV W
EstadoPedido
ññW c
.
ññc d
	Cancelado
ññd m
)
ññm n
)
ññn o
;
ñño p
if
òò 
(
òò 
filas
òò 
==
òò 
$num
òò 
)
òò 
{
ôô 
await
öö 
tx
öö 
.
öö 
RollbackAsync
öö *
(
öö* +
)
öö+ ,
;
öö, -
return
õõ 
(
õõ 
false
õõ !
,
õõ! "!
MensajeNoCancelable
õõ# 6
)
õõ6 7
;
õõ7 8
}
úú 
context
ûû 
.
ûû $
SolicitudesCancelacion
ûû .
.
ûû. /
Add
ûû/ 2
(
ûû2 3
new
ûû3 6"
SolicitudCancelacion
ûû7 K
{
üü 
PedidoId
†† 
=
†† 
pedido
†† %
.
††% &
Id
††& (
,
††( )
Motivo
°° 
=
°° 
motivoLimpio
°° )
,
°°) *
FechaSolicitud
¢¢ "
=
¢¢# $
ahora
¢¢% *
}
££ 
)
££ 
;
££ 
await
§§ 
context
§§ 
.
§§ 
SaveChangesAsync
§§ .
(
§§. /
)
§§/ 0
;
§§0 1
await
•• 
tx
•• 
.
•• 
CommitAsync
•• $
(
••$ %
)
••% &
;
••& '
}
¶¶ 
await
©© %
RegistrarHistorialAsync
©© )
(
©©) *
pedido
©©* 0
.
©©0 1
Id
©©1 3
,
©©3 4
(
©©5 6
int
©©6 9
)
©©9 :
EstadoPedido
©©: F
.
©©F G
	Cancelado
©©G P
,
©©P Q
null
©©R V
,
©©V W
$str
©©X r
)
©©r s
;
©©s t
await
´´ '
NotificarCancelacionAsync
´´ +
(
´´+ ,
pedido
´´, 2
,
´´2 3
motivoLimpio
´´4 @
,
´´@ A
ahora
´´B G
)
´´G H
;
´´H I
return
¨¨ 
(
¨¨ 
true
¨¨ 
,
¨¨ 
null
¨¨ 
)
¨¨ 
;
¨¨  
}
≠≠ 	
catch
ÆÆ 
(
ÆÆ 
DbUpdateException
ÆÆ  
ex
ÆÆ! #
)
ÆÆ# $
{
ØØ 	
context
±± 
.
±± 
ChangeTracker
±± !
.
±±! "
Clear
±±" '
(
±±' (
)
±±( )
;
±±) *
logger
≤≤ 
.
≤≤ 

LogWarning
≤≤ 
(
≤≤ 
ex
≤≤  
,
≤≤  !
$str
≤≤" f
,
≤≤f g
codigoLimpio
≤≤h t
)
≤≤t u
;
≤≤u v
return
≥≥ 
(
≥≥ 
false
≥≥ 
,
≥≥ '
MensajeSolicitudDuplicada
≥≥ 4
)
≥≥4 5
;
≥≥5 6
}
¥¥ 	
catch
µµ 
(
µµ 
	Exception
µµ 
ex
µµ 
)
µµ 
{
∂∂ 	
context
∑∑ 
.
∑∑ 
ChangeTracker
∑∑ !
.
∑∑! "
Clear
∑∑" '
(
∑∑' (
)
∑∑( )
;
∑∑) *
logger
∏∏ 
.
∏∏ 
LogError
∏∏ 
(
∏∏ 
ex
∏∏ 
,
∏∏ 
$str
∏∏  \
,
∏∏\ ]
codigoLimpio
∏∏^ j
)
∏∏j k
;
∏∏k l
return
ππ 
(
ππ 
false
ππ 
,
ππ %
MensajeErrorCancelacion
ππ 2
)
ππ2 3
;
ππ3 4
}
∫∫ 	
}
ªª 
private
ææ 
async
ææ 
Task
ææ '
NotificarCancelacionAsync
ææ 0
(
ææ0 1
Pedido
ææ1 7
pedido
ææ8 >
,
ææ> ?
string
ææ@ F
motivo
ææG M
,
ææM N
DateTime
ææO W
fechaUtc
ææX `
)
ææ` a
{
øø 
var
¿¿ 
correo
¿¿ 
=
¿¿ 
pedido
¿¿ 
.
¿¿ 
Negocio
¿¿ #
?
¿¿# $
.
¿¿$ %
Usuario
¿¿% ,
?
¿¿, -
.
¿¿- .
Correo
¿¿. 4
;
¿¿4 5
if
¡¡ 

(
¡¡ 
string
¡¡ 
.
¡¡  
IsNullOrWhiteSpace
¡¡ %
(
¡¡% &
correo
¡¡& ,
)
¡¡, -
)
¡¡- .
return
¡¡/ 5
;
¡¡5 6
try
√√ 
{
ƒƒ 	
var
≈≈ 
fecha
≈≈ 
=
≈≈ 
fechaUtc
≈≈  
.
≈≈  !
AddHours
≈≈! )
(
≈≈) *
-
≈≈* +
$num
≈≈+ ,
)
≈≈, -
.
≈≈- .
ToString
≈≈. 6
(
≈≈6 7
$str
≈≈7 L
,
≈≈L M
new
≈≈N Q
System
≈≈R X
.
≈≈X Y
Globalization
≈≈Y f
.
≈≈f g
CultureInfo
≈≈g r
(
≈≈r s
$str
≈≈s z
)
≈≈z {
)
≈≈{ |
;
≈≈| }
await
∆∆ 
email
∆∆ 
.
∆∆ 
EnviarAsync
∆∆ #
(
∆∆# $
correo
∆∆$ *
,
∆∆* +
$"
∆∆, .
$str
∆∆. 5
{
∆∆5 6
pedido
∆∆6 <
.
∆∆< =
Codigo
∆∆= C
}
∆∆C D
$str
∆∆D ]
"
∆∆] ^
,
∆∆^ _
PlantillaCorreo
∆∆` o
.
∆∆o p
Crear
∆∆p u
(
∆∆u v
etiqueta
«« 
:
«« 
$str
«« ,
,
««, -
titulo
»» 
:
»» 
$str
»» 6
,
»»6 7
saludo
…… 
:
…… 
$"
…… 
$str
……  
{
……  !
pedido
……! '
.
……' (
Negocio
……( /
!
……/ 0
.
……0 1
Nombre
……1 7
}
……7 8
$str
……8 9
"
……9 :
,
……: ;
parrafos
   
:
   
[
   
$"
   
$str
   <
{
  < =
pedido
  = C
.
  C D
Codigo
  D J
}
  J K
$str  K £
"  £ §
]  § •
,  • ¶
datos
ÀÀ 
:
ÀÀ 
[
ÃÃ 
(
ÕÕ 
$str
ÕÕ 
,
ÕÕ 
pedido
ÕÕ %
.
ÕÕ% &
Codigo
ÕÕ& ,
)
ÕÕ, -
,
ÕÕ- .
(
ŒŒ 
$str
ŒŒ 
,
ŒŒ 
pedido
ŒŒ  &
.
ŒŒ& '
Cliente
ŒŒ' .
?
ŒŒ. /
.
ŒŒ/ 0
NombreCompleto
ŒŒ0 >
??
ŒŒ? A
$str
ŒŒB D
)
ŒŒD E
,
ŒŒE F
(
œœ 
$str
œœ +
,
œœ+ ,
pedido
œœ- 3
.
œœ3 4
DireccionEntrega
œœ4 D
)
œœD E
,
œœE F
(
–– 
$str
–– 
,
–– 
motivo
–– %
)
––% &
,
––& '
(
—— 
$str
—— 
,
—— 
fecha
—— #
)
——# $
]
““ 
,
““ 
nota
”” 
:
”” 
$str
”” J
,
””J K
tipoNota
‘‘ 
:
‘‘ 
TipoNota
‘‘ "
.
‘‘" #
Aviso
‘‘# (
,
‘‘( )
resumen
’’ 
:
’’ 
$"
’’ 
$str
’’ 8
{
’’8 9
pedido
’’9 ?
.
’’? @
Codigo
’’@ F
}
’’F G
$str
’’G Q
{
’’Q R
motivo
’’R X
}
’’X Y
"
’’Y Z
)
’’Z [
)
’’[ \
;
’’\ ]
}
÷÷ 	
catch
◊◊ 
(
◊◊ 
	Exception
◊◊ 
ex
◊◊ 
)
◊◊ 
{
ÿÿ 	
logger
ŸŸ 
.
ŸŸ 
LogError
ŸŸ 
(
ŸŸ 
ex
ŸŸ 
,
ŸŸ 
$str
ŸŸ  a
,
ŸŸa b
pedido
ŸŸc i
.
ŸŸi j
Codigo
ŸŸj p
)
ŸŸp q
;
ŸŸq r
}
⁄⁄ 	
}
€€ 
public
ﬁﬁ 

const
ﬁﬁ 
int
ﬁﬁ (
MaxCaracteresObservaciones
ﬁﬁ /
=
ﬁﬁ0 1
$num
ﬁﬁ2 5
;
ﬁﬁ5 6
private
‡‡ 
const
‡‡ 
string
‡‡  
MensajeTipoNovedad
‡‡ +
=
‡‡, -
$str
‡‡. T
;
‡‡T U
private
·· 
const
·· 
string
·· '
MensajeNovedadNoPermitida
·· 2
=
··3 4
$str
··5 h
;
··h i
private
‚‚ 
const
‚‚ 
string
‚‚ !
MensajeErrorNovedad
‚‚ ,
=
‚‚- .
$str
‚‚/ h
;
‚‚h i
public
‰‰ 

async
‰‰ 
Task
‰‰ 
<
‰‰ 
(
‰‰ 
bool
‰‰ 
Ok
‰‰ 
,
‰‰ 
string
‰‰  &
?
‰‰& '
Error
‰‰( -
)
‰‰- .
>
‰‰. /#
RegistrarNovedadAsync
‰‰0 E
(
‰‰E F
int
‰‰F I!
usuarioRepartidorId
‰‰J ]
,
‰‰] ^
int
‰‰_ b
pedidoId
‰‰c k
,
‰‰k l
int
‰‰m p
?
‰‰p q
tipoNovedadId
‰‰r 
,‰‰ Ä
string‰‰Å á
?‰‰á à
observaciones‰‰â ñ
)‰‰ñ ó
{
ÂÂ 
if
ÊÊ 

(
ÊÊ 
tipoNovedadId
ÊÊ 
is
ÊÊ 
null
ÊÊ !
||
ÊÊ" $
!
ÊÊ% &
Enum
ÊÊ& *
.
ÊÊ* +
	IsDefined
ÊÊ+ 4
(
ÊÊ4 5
typeof
ÊÊ5 ;
(
ÊÊ; <
TipoNovedad
ÊÊ< G
)
ÊÊG H
,
ÊÊH I
tipoNovedadId
ÊÊJ W
.
ÊÊW X
Value
ÊÊX ]
)
ÊÊ] ^
)
ÊÊ^ _
return
ÁÁ 
(
ÁÁ 
false
ÁÁ 
,
ÁÁ  
MensajeTipoNovedad
ÁÁ -
)
ÁÁ- .
;
ÁÁ. /
var
ÈÈ 
texto
ÈÈ 
=
ÈÈ 
observaciones
ÈÈ !
?
ÈÈ! "
.
ÈÈ" #
Trim
ÈÈ# '
(
ÈÈ' (
)
ÈÈ( )
??
ÈÈ* ,
$str
ÈÈ- /
;
ÈÈ/ 0
if
ÍÍ 

(
ÍÍ 
texto
ÍÍ 
.
ÍÍ 
Length
ÍÍ 
>
ÍÍ (
MaxCaracteresObservaciones
ÍÍ 5
)
ÍÍ5 6
return
ÎÎ 
(
ÎÎ 
false
ÎÎ 
,
ÎÎ 
$"
ÎÎ 
$str
ÎÎ C
{
ÎÎC D(
MaxCaracteresObservaciones
ÎÎD ^
}
ÎÎ^ _
$str
ÎÎ_ j
"
ÎÎj k
)
ÎÎk l
;
ÎÎl m
try
ÌÌ 
{
ÓÓ 	
var
ÔÔ 

repartidor
ÔÔ 
=
ÔÔ 
await
ÔÔ "
context
ÔÔ# *
.
ÔÔ* +
Repartidores
ÔÔ+ 7
.
 
AsNoTracking
 
(
 
)
 
.
ÒÒ !
FirstOrDefaultAsync
ÒÒ $
(
ÒÒ$ %
r
ÒÒ% &
=>
ÒÒ' )
r
ÒÒ* +
.
ÒÒ+ ,
	UsuarioId
ÒÒ, 5
==
ÒÒ6 8!
usuarioRepartidorId
ÒÒ9 L
)
ÒÒL M
;
ÒÒM N
if
ÛÛ 
(
ÛÛ 

repartidor
ÛÛ 
is
ÛÛ 
null
ÛÛ "
)
ÛÛ" #
return
ÙÙ 
(
ÙÙ 
false
ÙÙ 
,
ÙÙ 
$str
ÙÙ W
)
ÙÙW X
;
ÙÙX Y
var
ˆˆ 
pedido
ˆˆ 
=
ˆˆ 
await
ˆˆ 
context
ˆˆ &
.
ˆˆ& '
Pedidos
ˆˆ' .
.
˜˜ 
AsNoTracking
˜˜ 
(
˜˜ 
)
˜˜ 
.
¯¯ !
FirstOrDefaultAsync
¯¯ $
(
¯¯$ %
p
¯¯% &
=>
¯¯' )
p
¯¯* +
.
¯¯+ ,
Id
¯¯, .
==
¯¯/ 1
pedidoId
¯¯2 :
&&
¯¯; =
p
¯¯> ?
.
¯¯? @
RepartidorId
¯¯@ L
==
¯¯M O

repartidor
¯¯P Z
.
¯¯Z [
Id
¯¯[ ]
)
¯¯] ^
;
¯¯^ _
if
˙˙ 
(
˙˙ 
pedido
˙˙ 
is
˙˙ 
null
˙˙ 
)
˙˙ 
return
˚˚ 
(
˚˚ 
false
˚˚ 
,
˚˚ 
$str
˚˚ \
)
˚˚\ ]
;
˚˚] ^
if
˛˛ 
(
˛˛ 
pedido
˛˛ 
.
˛˛ 
EstadoPedidoId
˛˛ %
==
˛˛& (
(
˛˛) *
int
˛˛* -
)
˛˛- .
EstadoPedido
˛˛. :
.
˛˛: ;
	Entregado
˛˛; D
||
˛˛E G
pedido
˛˛H N
.
˛˛N O
EstadoPedidoId
˛˛O ]
==
˛˛^ `
(
˛˛a b
int
˛˛b e
)
˛˛e f
EstadoPedido
˛˛f r
.
˛˛r s
	Cancelado
˛˛s |
)
˛˛| }
return
ˇˇ 
(
ˇˇ 
false
ˇˇ 
,
ˇˇ '
MensajeNovedadNoPermitida
ˇˇ 8
)
ˇˇ8 9
;
ˇˇ9 :
context
ÇÇ 
.
ÇÇ 
NovedadesPedido
ÇÇ #
.
ÇÇ# $
Add
ÇÇ$ '
(
ÇÇ' (
new
ÇÇ( +
NovedadPedido
ÇÇ, 9
{
ÉÉ 
PedidoId
ÑÑ 
=
ÑÑ 
pedido
ÑÑ !
.
ÑÑ! "
Id
ÑÑ" $
,
ÑÑ$ %
TipoNovedadId
ÖÖ 
=
ÖÖ 
tipoNovedadId
ÖÖ  -
.
ÖÖ- .
Value
ÖÖ. 3
,
ÖÖ3 4
Observaciones
ÜÜ 
=
ÜÜ 
texto
ÜÜ  %
.
ÜÜ% &
Length
ÜÜ& ,
==
ÜÜ- /
$num
ÜÜ0 1
?
ÜÜ2 3
null
ÜÜ4 8
:
ÜÜ9 :
texto
ÜÜ; @
,
ÜÜ@ A
Fecha
áá 
=
áá 
DateTime
áá  
.
áá  !
UtcNow
áá! '
}
àà 
)
àà 
;
àà 
await
ââ 
context
ââ 
.
ââ 
SaveChangesAsync
ââ *
(
ââ* +
)
ââ+ ,
;
ââ, -
return
ää 
(
ää 
true
ää 
,
ää 
null
ää 
)
ää 
;
ää  
}
ãã 	
catch
åå 
(
åå 
	Exception
åå 
ex
åå 
)
åå 
{
çç 	
context
éé 
.
éé 
ChangeTracker
éé !
.
éé! "
Clear
éé" '
(
éé' (
)
éé( )
;
éé) *
logger
èè 
.
èè 
LogError
èè 
(
èè 
ex
èè 
,
èè 
$str
èè  U
,
èèU V
pedidoId
èèW _
)
èè_ `
;
èè` a
return
êê 
(
êê 
false
êê 
,
êê !
MensajeErrorNovedad
êê .
)
êê. /
;
êê/ 0
}
ëë 	
}
íí 
}ìì •±
VC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\NegocioService.cs
	namespace 	
Gtrack
 
; 
public 
class 
NegocioService 
( 
INegocioRepository 
negocios 
,  
IUsuarioRepository 
usuarios 
,  )
ICodigoVerificacionRepository		 !
codigos		" )
,		) *
IPasswordHasher

 
<

 
Usuario

 
>

 
hasher

 #
,

# $
IEmailService 
email 
, 
ILogger 
< 
NegocioService 
> 
logger "
)" #
:$ %
INegocioService& 5
{ 
public 

const 
string "
MensajeSinVerificacion .
=/ 0
$str1 e
;e f
private 
const 
int 
MaxIntentosCodigo '
=( )
$num* +
;+ ,
private 
const 
int 
MinutosBloqueo $
=% &
$num' )
;) *
private 
const 
int !
MinutosVigenciaCodigo +
=, -
$num. 0
;0 1
private 
const 
int !
MinutosVentanaEdicion +
=, -
$num. 0
;0 1
private 
const 
string 
MensajeErrorEnvio *
=+ ,
$str- b
;b c
private 
const 
string  
MensajeErrorGuardado -
=. /
$str0 n
;n o
private 
const 
string !
MensajeCodigoExpirado .
=/ 0
$str1 i
;i j
public 

async 
Task 
< 
( 
bool 
Ok 
, 
string  &
?& '
Error( -
,- .
bool/ 3
CorreoEnviado4 A
)A B
>B C
RegistrarAsyncD R
(R S
RegistroNegocioDtoS e
dtof i
,i j
stringk q
urlRevisionr }
)} ~
{ 
var 
nombre 
= 
dto 
. 
Nombre 
.  
Trim  $
($ %
)% &
;& '
var 
	documento 
= 
dto 
. 
	Documento %
.% &
Trim& *
(* +
)+ ,
;, -
var 
correo 
= 
dto 
. 
Correo 
.  
Trim  $
($ %
)% &
;& '
var 
telefono 
= 
dto 
. 
Telefono #
.# $
Trim$ (
(( )
)) *
;* +
if"" 

("" 
await"" 
negocios"" 
.""  
ExisteDocumentoAsync"" /
(""/ 0
	documento""0 9
)""9 :
||""; =
await""> C
usuarios""D L
.""L M!
ObtenerPorCorreoAsync""M b
(""b c
correo""c i
)""i j
is""k m
not""n q
null""r v
)""v w
return## 
(## 
false## 
,## 
$str## m
,##m n
false##o t
)##t u
;##u v
if%% 

(%% 
await%% 
negocios%% 
.%% 
ExisteTelefonoAsync%% .
(%%. /
telefono%%/ 7
)%%7 8
)%%8 9
return&& 
(&& 
false&& 
,&& 
$str&& ;
,&&; <
false&&= B
)&&B C
;&&C D
if(( 

((( 
dto(( 
.(( 
Password(( 
!=(( 
dto(( 
.((  
ConfirmarPassword((  1
||((2 4
!((5 6
ValidadorPassword((6 G
.((G H
EsValida((H P
(((P Q
dto((Q T
.((T U
Password((U ]
)((] ^
)((^ _
return)) 
()) 
false)) 
,)) 
$str)) [
,))[ \
false))] b
)))b c
;))c d
var++ 
usuario++ 
=++ 
new++ 
Usuario++ !
{,, 	
Correo-- 
=-- 
correo-- 
,-- 
	Documento.. 
=.. 
	documento.. !
,..! "
Rol// 
=// 

RolUsuario// 
.// 
Negocio// $
,//$ %
Estado00 
=00 
EstadoCuenta00 !
.00! "
PendienteValidacion00" 5
}11 	
;11	 

usuario22 
.22 
PasswordHash22 
=22 
hasher22 %
.22% &
HashPassword22& 2
(222 3
usuario223 :
,22: ;
dto22< ?
.22? @
Password22@ H
)22H I
;22I J
var44 
negocio44 
=44 
new44 
Negocio44 !
{55 	
Nombre66 
=66 
nombre66 
,66 
TipoActividad77 
=77 
dto77 
.77  
TipoActividad77  -
.77- .
Trim77. 2
(772 3
)773 4
,774 5
Telefono88 
=88 
telefono88 
,88  
	Direccion99 
=99 
dto99 
.99 
	Direccion99 %
.99% &
Trim99& *
(99* +
)99+ ,
,99, -
FechaRegistro:: 
=:: 
DateTime:: $
.::$ %
UtcNow::% +
};; 	
;;;	 

await== 
negocios== 
.== 
RegistrarAsync== %
(==% &
usuario==& -
,==- .
negocio==/ 6
)==6 7
;==7 8
await@@ &
AvisarAdministradoresAsync@@ (
(@@( )
negocio@@) 0
,@@0 1
	documento@@2 ;
,@@; <
correo@@= C
,@@C D
urlRevision@@E P
)@@P Q
;@@Q R
tryCC 
{DD 	
awaitEE 
emailEE 
.EE 
EnviarAsyncEE #
(EE# $
correoEE$ *
,EE* +
$strEE, A
,EEA B
PlantillaCorreoEEC R
.EER S
CrearEES X
(EEX Y
etiquetaFF 
:FF 
$strFF -
,FF- .
tituloGG 
:GG 
$strGG /
,GG/ 0
saludoHH 
:HH 
$"HH 
$strHH  
{HH  !
nombreHH! '
}HH' (
"HH( )
,HH) *
parrafosII 
:II 
[JJ 
$strKK D
,KKD E
$strLL f
]MM 
,MM 
datosNN 
:NN 
[NN 
(NN 
$strNN "
,NN" #
nombreNN$ *
)NN* +
,NN+ ,
(NN- .
$strNN. 9
,NN9 :
	documentoNN; D
)NND E
,NNE F
(NNG H
$strNNH P
,NNP Q
correoNNR X
)NNX Y
,NNY Z
(NN[ \
$strNN\ d
,NNd e
$strNNf 
)	NN Ä
]
NNÄ Å
,
NNÅ Ç
notaOO 
:OO 
$strOO T
,OOT U
tipoNotaPP 
:PP 
TipoNotaPP "
.PP" #
InfoPP# '
)PP' (
)PP( )
;PP) *
returnQQ 
(QQ 
trueQQ 
,QQ 
nullQQ 
,QQ 
trueQQ  $
)QQ$ %
;QQ% &
}RR 	
catchSS 
(SS 
	ExceptionSS 
exSS 
)SS 
{TT 	
loggerUU 
.UU 
LogErrorUU 
(UU 
exUU 
,UU 
$strUU  d
,UUd e
correoUUf l
)UUl m
;UUm n
returnVV 
(VV 
trueVV 
,VV 
nullVV 
,VV 
falseVV  %
)VV% &
;VV& '
}WW 	
}XX 
private[[ 
async[[ 
Task[[ &
AvisarAdministradoresAsync[[ 1
([[1 2
Negocio[[2 9
negocio[[: A
,[[A B
string[[C I
	documento[[J S
,[[S T
string[[U [
correo[[\ b
,[[b c
string[[d j
urlRevision[[k v
)[[v w
{\\ 
try]] 
{^^ 	
var__ 
administradores__ 
=__  !
await__" '
usuarios__( 0
.__0 1.
"CorreosAdministradoresActivosAsync__1 S
(__S T
)__T U
;__U V
if`` 
(`` 
administradores`` 
.``  
Count``  %
==``& (
$num``) *
)``* +
return``, 2
;``2 3
varbb 
avisobb 
=bb 
PlantillaCorreobb '
.bb' (
Crearbb( -
(bb- .
etiquetacc 
:cc 
$strcc 0
,cc0 1
titulodd 
:dd 
$strdd @
,dd@ A
saludoee 
:ee 
$stree 
,ee  
parrafosff 
:ff 
[gg 
$"hh 
$strhh 
{hh 
negociohh  
.hh  !
Nombrehh! '
}hh' (
$strhh( i
"hhi j
,hhj k
$strii V
]jj 
,jj 
datoskk 
:kk 
[ll 
(mm 
$strmm 
,mm 
negociomm  '
.mm' (
Nombremm( .
)mm. /
,mm/ 0
(mm1 2
$strmm2 =
,mm= >
negociomm? F
.mmF G
TipoActividadmmG T
)mmT U
,mmU V
(mmW X
$strmmX c
,mmc d
	documentomme n
)mmn o
,mmo p
(nn 
$strnn 
,nn 
correonn %
)nn% &
,nn& '
(nn( )
$strnn) 3
,nn3 4
negocionn5 <
.nn< =
Telefononn= E
)nnE F
,nnF G
(nnH I
$strnnI T
,nnT U
negocionnV ]
.nn] ^
	Direccionnn^ g
)nng h
]oo 
,oo 

textoBotonpp 
:pp 
$strpp /
,pp/ 0
urlBotonqq 
:qq 
urlRevisionqq %
,qq% &
notarr 
:rr 
$strrr [
,rr[ \
tipoNotass 
:ss 
TipoNotass "
.ss" #
Infoss# '
,ss' (
resumentt 
:tt 
$"tt 
{tt 
negociott #
.tt# $
Nombrett$ *
}tt* +
$strtt+ O
"ttO P
)ttP Q
;ttQ R
awaitww 
Taskww 
.ww 
WhenAllww 
(ww 
administradoresww .
.ww. /
Selectww/ 5
(ww5 6
asyncww6 ;
paraww< @
=>wwA C
{xx 
tryyy 
{zz 
await{{ 
email{{ 
.{{  
EnviarAsync{{  +
({{+ ,
para{{, 0
,{{0 1
$str{{2 c
,{{c d
aviso{{e j
){{j k
;{{k l
}|| 
catch}} 
(}} 
	Exception}}  
ex}}! #
)}}# $
{~~ 
logger 
. 

LogWarning %
(% &
ex& (
,( )
$str* m
,m n
parao s
,s t
negociou |
.| }
Nombre	} É
)
É Ñ
;
Ñ Ö
}
ÄÄ 
}
ÅÅ 
)
ÅÅ 
)
ÅÅ 
;
ÅÅ 
}
ÇÇ 	
catch
ÉÉ 
(
ÉÉ 
	Exception
ÉÉ 
ex
ÉÉ 
)
ÉÉ 
{
ÑÑ 	
logger
ÖÖ 
.
ÖÖ 
LogError
ÖÖ 
(
ÖÖ 
ex
ÖÖ 
,
ÖÖ 
$str
ÖÖ  _
,
ÖÖ_ `
negocio
ÖÖa h
.
ÖÖh i
Nombre
ÖÖi o
)
ÖÖo p
;
ÖÖp q
}
ÜÜ 	
}
áá 
public
ää 

async
ää 
Task
ää 
<
ää 
PerfilNegocioDto
ää &
?
ää& '
>
ää' ( 
ObtenerPerfilAsync
ää) ;
(
ää; <
int
ää< ?
	usuarioId
ää@ I
)
ääI J
{
ãã 
var
åå 
usuario
åå 
=
åå 
await
åå 
usuarios
åå $
.
åå$ %
ObtenerPorIdAsync
åå% 6
(
åå6 7
	usuarioId
åå7 @
)
åå@ A
;
ååA B
var
çç 
negocio
çç 
=
çç 
await
çç 
negocios
çç $
.
çç$ %&
ObtenerPorUsuarioIdAsync
çç% =
(
çç= >
	usuarioId
çç> G
)
ççG H
;
ççH I
if
éé 

(
éé 
usuario
éé 
is
éé 
null
éé 
||
éé 
negocio
éé &
is
éé' )
null
éé* .
)
éé. /
return
éé0 6
null
éé7 ;
;
éé; <
return
êê 
new
êê 
PerfilNegocioDto
êê #
{
ëë 	
Id
íí 
=
íí 
negocio
íí 
.
íí 
Id
íí 
,
íí 
Nombre
ìì 
=
ìì 
negocio
ìì 
.
ìì 
Nombre
ìì #
,
ìì# $
TipoActividad
îî 
=
îî 
negocio
îî #
.
îî# $
TipoActividad
îî$ 1
,
îî1 2
	Documento
ïï 
=
ïï 
usuario
ïï 
.
ïï  
	Documento
ïï  )
,
ïï) *
Correo
ññ 
=
ññ 
usuario
ññ 
.
ññ 
Correo
ññ #
,
ññ# $
Telefono
óó 
=
óó 
negocio
óó 
.
óó 
Telefono
óó '
,
óó' (
	Direccion
òò 
=
òò 
negocio
òò 
.
òò  
	Direccion
òò  )
,
òò) *
FechaRegistro
ôô 
=
ôô 
negocio
ôô #
.
ôô# $
FechaRegistro
ôô$ 1
,
ôô1 2
Estado
öö 
=
öö 
usuario
öö 
.
öö 
Estado
öö #
}
õõ 	
;
õõ	 

}
úú 
public
üü 

async
üü 
Task
üü 
<
üü %
PerfilPublicoNegocioDto
üü -
?
üü- .
>
üü. /'
ObtenerPerfilPublicoAsync
üü0 I
(
üüI J
int
üüJ M
	negocioId
üüN W
)
üüW X
{
†† 
var
°° 
negocio
°° 
=
°° 
await
°° 
negocios
°° $
.
°°$ %
BuscarPorIdAsync
°°% 5
(
°°5 6
	negocioId
°°6 ?
)
°°? @
;
°°@ A
if
¢¢ 

(
¢¢ 
negocio
¢¢ 
is
¢¢ 
null
¢¢ 
)
¢¢ 
return
¢¢ #
null
¢¢$ (
;
¢¢( )
return
§§ 
new
§§ %
PerfilPublicoNegocioDto
§§ *
{
•• 	
Nombre
¶¶ 
=
¶¶ 
negocio
¶¶ 
.
¶¶ 
Nombre
¶¶ #
,
¶¶# $
TipoActividad
ßß 
=
ßß 
negocio
ßß #
.
ßß# $
TipoActividad
ßß$ 1
,
ßß1 2
	Direccion
®® 
=
®® 
negocio
®® 
.
®®  
	Direccion
®®  )
,
®®) *
Telefono
©© 
=
©© 
negocio
©© 
.
©© 
Telefono
©© '
,
©©' (
FechaRegistro
™™ 
=
™™ 
negocio
™™ #
.
™™# $
FechaRegistro
™™$ 1
}
´´ 	
;
´´	 

}
¨¨ 
public
ØØ 

async
ØØ 
Task
ØØ 
<
ØØ 
(
ØØ 
bool
ØØ 
Ok
ØØ 
,
ØØ 
string
ØØ  &
?
ØØ& '
Error
ØØ( -
)
ØØ- .
>
ØØ. /"
SolicitarCodigoAsync
ØØ0 D
(
ØØD E
int
ØØE H
	usuarioId
ØØI R
)
ØØR S
{
∞∞ 
var
±± 
usuario
±± 
=
±± 
await
±± 
usuarios
±± $
.
±±$ %
ObtenerPorIdAsync
±±% 6
(
±±6 7
	usuarioId
±±7 @
)
±±@ A
;
±±A B
if
≤≤ 

(
≤≤ 
usuario
≤≤ 
is
≤≤ 
null
≤≤ 
)
≤≤ 
return
≤≤ #
(
≤≤$ %
false
≤≤% *
,
≤≤* +
MensajeErrorEnvio
≤≤, =
)
≤≤= >
;
≤≤> ?
var
µµ 
ultimo
µµ 
=
µµ 
await
µµ 
codigos
µµ "
.
µµ" # 
ObtenerUltimoAsync
µµ# 5
(
µµ5 6
	usuarioId
µµ6 ?
)
µµ? @
;
µµ@ A
if
∂∂ 

(
∂∂ 
ultimo
∂∂ 
?
∂∂ 
.
∂∂ 
BloqueadoHasta
∂∂ "
is
∂∂# %
{
∂∂& '
}
∂∂( )
hasta
∂∂* /
&&
∂∂0 2
hasta
∂∂3 8
>
∂∂9 :
DateTime
∂∂; C
.
∂∂C D
UtcNow
∂∂D J
)
∂∂J K
return
∑∑ 
(
∑∑ 
false
∑∑ 
,
∑∑ 
MensajeBloqueo
∑∑ )
(
∑∑) *
hasta
∑∑* /
)
∑∑/ 0
)
∑∑0 1
;
∑∑1 2
var
ππ 
codigo
ππ 
=
ππ #
RandomNumberGenerator
ππ *
.
ππ* +
GetInt32
ππ+ 3
(
ππ3 4
$num
ππ4 :
,
ππ: ;
$num
ππ< C
)
ππC D
.
ππD E
ToString
ππE M
(
ππM N
)
ππN O
;
ππO P
try
ªª 
{
ºº 	
await
ΩΩ 
codigos
ΩΩ 
.
ΩΩ 
AgregarAsync
ΩΩ &
(
ΩΩ& '
new
ΩΩ' * 
CodigoVerificacion
ΩΩ+ =
{
ææ 
	UsuarioId
øø 
=
øø 
	usuarioId
øø %
,
øø% &

CodigoHash
¿¿ 
=
¿¿ 
	TokenUtil
¿¿ &
.
¿¿& '
Hash
¿¿' +
(
¿¿+ ,
codigo
¿¿, 2
)
¿¿2 3
,
¿¿3 4
Expira
¡¡ 
=
¡¡ 
DateTime
¡¡ !
.
¡¡! "
UtcNow
¡¡" (
.
¡¡( )

AddMinutes
¡¡) 3
(
¡¡3 4#
MinutosVigenciaCodigo
¡¡4 I
)
¡¡I J
}
¬¬ 
)
¬¬ 
;
¬¬ 
await
ƒƒ 
email
ƒƒ 
.
ƒƒ 
EnviarAsync
ƒƒ #
(
ƒƒ# $
usuario
ƒƒ$ +
.
ƒƒ+ ,
Correo
ƒƒ, 2
,
ƒƒ2 3
$str
ƒƒ4 Y
,
ƒƒY Z
PlantillaCorreo
ƒƒ[ j
.
ƒƒj k
Crear
ƒƒk p
(
ƒƒp q
etiqueta
≈≈ 
:
≈≈ 
$str
≈≈ 5
,
≈≈5 6
titulo
∆∆ 
:
∆∆ 
$str
∆∆ .
,
∆∆. /
saludo
«« 
:
«« 
$str
«« 
,
««  
parrafos
»» 
:
»» 
[
»» 
$str
»» d
]
»»d e
,
»»e f
codigo
…… 
:
…… 
codigo
…… 
,
…… 
nota
   
:
   
$"
   
$str
   0
{
  0 1#
MinutosVigenciaCodigo
  1 F
}
  F G
$str  G ¢
"  ¢ £
,  £ §
tipoNota
ÀÀ 
:
ÀÀ 
TipoNota
ÀÀ "
.
ÀÀ" #
Aviso
ÀÀ# (
,
ÀÀ( )
resumen
ÃÃ 
:
ÃÃ 
$"
ÃÃ 
$str
ÃÃ 8
{
ÃÃ8 9
codigo
ÃÃ9 ?
}
ÃÃ? @
$str
ÃÃ@ K
{
ÃÃK L#
MinutosVigenciaCodigo
ÃÃL a
}
ÃÃa b
$str
ÃÃb k
"
ÃÃk l
)
ÃÃl m
)
ÃÃm n
;
ÃÃn o
return
ÕÕ 
(
ÕÕ 
true
ÕÕ 
,
ÕÕ 
null
ÕÕ 
)
ÕÕ 
;
ÕÕ  
}
ŒŒ 	
catch
œœ 
(
œœ 
	Exception
œœ 
ex
œœ 
)
œœ 
{
–– 	
logger
—— 
.
—— 
LogError
—— 
(
—— 
ex
—— 
,
—— 
$str
——  d
,
——d e
	usuarioId
——f o
)
——o p
;
——p q
return
““ 
(
““ 
false
““ 
,
““ 
MensajeErrorEnvio
““ ,
)
““, -
;
““- .
}
”” 	
}
‘‘ 
public
÷÷ 

async
÷÷ 
Task
÷÷ 
<
÷÷ 
(
÷÷ 
bool
÷÷ 
Ok
÷÷ 
,
÷÷ 
string
÷÷  &
?
÷÷& '
Error
÷÷( -
)
÷÷- .
>
÷÷. /"
VerificarCodigoAsync
÷÷0 D
(
÷÷D E
int
÷÷E H
	usuarioId
÷÷I R
,
÷÷R S
string
÷÷T Z
codigo
÷÷[ a
)
÷÷a b
{
◊◊ 
var
ÿÿ 
actual
ÿÿ 
=
ÿÿ 
await
ÿÿ 
codigos
ÿÿ "
.
ÿÿ" # 
ObtenerUltimoAsync
ÿÿ# 5
(
ÿÿ5 6
	usuarioId
ÿÿ6 ?
)
ÿÿ? @
;
ÿÿ@ A
var
ŸŸ 
ahora
ŸŸ 
=
ŸŸ 
DateTime
ŸŸ 
.
ŸŸ 
UtcNow
ŸŸ #
;
ŸŸ# $
if
€€ 

(
€€ 
actual
€€ 
is
€€ 
null
€€ 
)
€€ 
return
€€ "
(
€€# $
false
€€$ )
,
€€) *#
MensajeCodigoExpirado
€€+ @
)
€€@ A
;
€€A B
if
›› 

(
›› 
actual
›› 
.
›› 
BloqueadoHasta
›› !
is
››" $
{
››% &
}
››' (
hasta
››) .
&&
››/ 1
hasta
››2 7
>
››8 9
ahora
››: ?
)
››? @
return
ﬁﬁ 
(
ﬁﬁ 
false
ﬁﬁ 
,
ﬁﬁ 
MensajeBloqueo
ﬁﬁ )
(
ﬁﬁ) *
hasta
ﬁﬁ* /
)
ﬁﬁ/ 0
)
ﬁﬁ0 1
;
ﬁﬁ1 2
if
‡‡ 

(
‡‡ 
actual
‡‡ 
.
‡‡ 

Verificado
‡‡ 
||
‡‡  
actual
‡‡! '
.
‡‡' (
Usado
‡‡( -
||
‡‡. 0
actual
‡‡1 7
.
‡‡7 8
Expira
‡‡8 >
<=
‡‡? A
ahora
‡‡B G
)
‡‡G H
return
·· 
(
·· 
false
·· 
,
·· #
MensajeCodigoExpirado
·· 0
)
··0 1
;
··1 2
if
„„ 

(
„„ 
actual
„„ 
.
„„ 

CodigoHash
„„ 
!=
„„  
	TokenUtil
„„! *
.
„„* +
Hash
„„+ /
(
„„/ 0
codigo
„„0 6
.
„„6 7
Trim
„„7 ;
(
„„; <
)
„„< =
)
„„= >
)
„„> ?
{
‰‰ 	
actual
ÂÂ 
.
ÂÂ 
Intentos
ÂÂ 
++
ÂÂ 
;
ÂÂ 
var
ÊÊ 
error
ÊÊ 
=
ÊÊ 
$str
ÊÊ ?
;
ÊÊ? @
if
ËË 
(
ËË 
actual
ËË 
.
ËË 
Intentos
ËË 
>=
ËË  "
MaxIntentosCodigo
ËË# 4
)
ËË4 5
{
ÈÈ 
actual
ÍÍ 
.
ÍÍ 
BloqueadoHasta
ÍÍ %
=
ÍÍ& '
ahora
ÍÍ( -
.
ÍÍ- .

AddMinutes
ÍÍ. 8
(
ÍÍ8 9
MinutosBloqueo
ÍÍ9 G
)
ÍÍG H
;
ÍÍH I
error
ÎÎ 
=
ÎÎ 
$"
ÎÎ 
$str
ÎÎ $
{
ÎÎ$ %
MaxIntentosCodigo
ÎÎ% 6
}
ÎÎ6 7
$str
ÎÎ7 {
{
ÎÎ{ |
MinutosBloqueoÎÎ| ä
}ÎÎä ã
$strÎÎã î
"ÎÎî ï
;ÎÎï ñ
}
ÏÏ 
await
ÓÓ 
codigos
ÓÓ 
.
ÓÓ 
ActualizarAsync
ÓÓ )
(
ÓÓ) *
actual
ÓÓ* 0
)
ÓÓ0 1
;
ÓÓ1 2
return
ÔÔ 
(
ÔÔ 
false
ÔÔ 
,
ÔÔ 
error
ÔÔ  
)
ÔÔ  !
;
ÔÔ! "
}
 	
actual
ÚÚ 
.
ÚÚ 

Verificado
ÚÚ 
=
ÚÚ 
true
ÚÚ  
;
ÚÚ  !
actual
ÛÛ 
.
ÛÛ 
Expira
ÛÛ 
=
ÛÛ 
ahora
ÛÛ 
.
ÛÛ 

AddMinutes
ÛÛ (
(
ÛÛ( )#
MinutosVentanaEdicion
ÛÛ) >
)
ÛÛ> ?
;
ÛÛ? @
await
ÙÙ 
codigos
ÙÙ 
.
ÙÙ 
ActualizarAsync
ÙÙ %
(
ÙÙ% &
actual
ÙÙ& ,
)
ÙÙ, -
;
ÙÙ- .
return
ıı 
(
ıı 
true
ıı 
,
ıı 
null
ıı 
)
ıı 
;
ıı 
}
ˆˆ 
public
¯¯ 

async
¯¯ 
Task
¯¯ 
<
¯¯ 
bool
¯¯ 
>
¯¯ $
EdicionAutorizadaAsync
¯¯ 2
(
¯¯2 3
int
¯¯3 6
	usuarioId
¯¯7 @
)
¯¯@ A
{
˘˘ 
var
˙˙ 
c
˙˙ 
=
˙˙ 
await
˙˙ 
codigos
˙˙ 
.
˙˙  
ObtenerUltimoAsync
˙˙ 0
(
˙˙0 1
	usuarioId
˙˙1 :
)
˙˙: ;
;
˙˙; <
return
˚˚ 
c
˚˚ 
is
˚˚ 
{
˚˚ 

Verificado
˚˚  
:
˚˚  !
true
˚˚" &
,
˚˚& '
Usado
˚˚( -
:
˚˚- .
false
˚˚/ 4
}
˚˚5 6
&&
˚˚7 9
c
˚˚: ;
.
˚˚; <
Expira
˚˚< B
>
˚˚C D
DateTime
˚˚E M
.
˚˚M N
UtcNow
˚˚N T
;
˚˚T U
}
¸¸ 
public
˛˛ 

async
˛˛ 
Task
˛˛ 
<
˛˛ 
EditarNegocioDto
˛˛ &
?
˛˛& '
>
˛˛' ($
ObtenerParaEditarAsync
˛˛) ?
(
˛˛? @
int
˛˛@ C
	usuarioId
˛˛D M
)
˛˛M N
{
ˇˇ 
var
ÄÄ 
usuario
ÄÄ 
=
ÄÄ 
await
ÄÄ 
usuarios
ÄÄ $
.
ÄÄ$ %
ObtenerPorIdAsync
ÄÄ% 6
(
ÄÄ6 7
	usuarioId
ÄÄ7 @
)
ÄÄ@ A
;
ÄÄA B
var
ÅÅ 
negocio
ÅÅ 
=
ÅÅ 
await
ÅÅ 
negocios
ÅÅ $
.
ÅÅ$ %&
ObtenerPorUsuarioIdAsync
ÅÅ% =
(
ÅÅ= >
	usuarioId
ÅÅ> G
)
ÅÅG H
;
ÅÅH I
if
ÇÇ 

(
ÇÇ 
usuario
ÇÇ 
is
ÇÇ 
null
ÇÇ 
||
ÇÇ 
negocio
ÇÇ &
is
ÇÇ' )
null
ÇÇ* .
)
ÇÇ. /
return
ÇÇ0 6
null
ÇÇ7 ;
;
ÇÇ; <
return
ÑÑ 
new
ÑÑ 
EditarNegocioDto
ÑÑ #
{
ÖÖ 	
Nombre
ÜÜ 
=
ÜÜ 
negocio
ÜÜ 
.
ÜÜ 
Nombre
ÜÜ #
,
ÜÜ# $
TipoActividad
áá 
=
áá 
negocio
áá #
.
áá# $
TipoActividad
áá$ 1
,
áá1 2
Correo
àà 
=
àà 
usuario
àà 
.
àà 
Correo
àà #
,
àà# $
Telefono
ââ 
=
ââ 
negocio
ââ 
.
ââ 
Telefono
ââ '
,
ââ' (
	Direccion
ää 
=
ää 
negocio
ää 
.
ää  
	Direccion
ää  )
}
ãã 	
;
ãã	 

}
åå 
public
éé 

async
éé 
Task
éé 
<
éé 
(
éé 
bool
éé 
Ok
éé 
,
éé 
string
éé  &
?
éé& '
Error
éé( -
)
éé- .
>
éé. /
EditarAsync
éé0 ;
(
éé; <
int
éé< ?
	usuarioId
éé@ I
,
ééI J
EditarNegocioDto
ééK [
dto
éé\ _
)
éé_ `
{
èè 
if
êê 

(
êê 
!
êê 
await
êê $
EdicionAutorizadaAsync
êê )
(
êê) *
	usuarioId
êê* 3
)
êê3 4
)
êê4 5
return
êê6 <
(
êê= >
false
êê> C
,
êêC D$
MensajeSinVerificacion
êêE [
)
êê[ \
;
êê\ ]
try
íí 
{
ìì 	
var
îî 
usuario
îî 
=
îî 
await
îî 
usuarios
îî  (
.
îî( )
ObtenerPorIdAsync
îî) :
(
îî: ;
	usuarioId
îî; D
)
îîD E
;
îîE F
var
ïï 
negocio
ïï 
=
ïï 
await
ïï 
negocios
ïï  (
.
ïï( )&
ObtenerPorUsuarioIdAsync
ïï) A
(
ïïA B
	usuarioId
ïïB K
)
ïïK L
;
ïïL M
if
ññ 
(
ññ 
usuario
ññ 
is
ññ 
null
ññ 
||
ññ  "
negocio
ññ# *
is
ññ+ -
null
ññ. 2
)
ññ2 3
return
ññ4 :
(
ññ; <
false
ññ< A
,
ññA B"
MensajeErrorGuardado
ññC W
)
ññW X
;
ññX Y
var
òò 
correo
òò 
=
òò 
dto
òò 
.
òò 
Correo
òò #
.
òò# $
Trim
òò$ (
(
òò( )
)
òò) *
;
òò* +
var
ôô 
telefono
ôô 
=
ôô 
dto
ôô 
.
ôô 
Telefono
ôô '
.
ôô' (
Trim
ôô( ,
(
ôô, -
)
ôô- .
;
ôô. /
var
õõ 
otroConCorreo
õõ 
=
õõ 
await
õõ  %
usuarios
õõ& .
.
õõ. /#
ObtenerPorCorreoAsync
õõ/ D
(
õõD E
correo
õõE K
)
õõK L
;
õõL M
if
úú 
(
úú 
otroConCorreo
úú 
is
úú  
not
úú! $
null
úú% )
&&
úú* ,
otroConCorreo
úú- :
.
úú: ;
Id
úú; =
!=
úú> @
usuario
úúA H
.
úúH I
Id
úúI K
)
úúK L
return
ùù 
(
ùù 
false
ùù 
,
ùù 
$str
ùù L
)
ùùL M
;
ùùM N
if
üü 
(
üü 
await
üü 
negocios
üü 
.
üü !
ExisteTelefonoAsync
üü 2
(
üü2 3
telefono
üü3 ;
,
üü; <
negocio
üü= D
.
üüD E
Id
üüE G
)
üüG H
)
üüH I
return
†† 
(
†† 
false
†† 
,
†† 
$str
†† O
)
††O P
;
††P Q
negocio
¢¢ 
.
¢¢ 
Nombre
¢¢ 
=
¢¢ 
dto
¢¢  
.
¢¢  !
Nombre
¢¢! '
.
¢¢' (
Trim
¢¢( ,
(
¢¢, -
)
¢¢- .
;
¢¢. /
negocio
££ 
.
££ 
TipoActividad
££ !
=
££" #
dto
££$ '
.
££' (
TipoActividad
££( 5
.
££5 6
Trim
££6 :
(
££: ;
)
££; <
;
££< =
negocio
§§ 
.
§§ 
Telefono
§§ 
=
§§ 
telefono
§§ '
;
§§' (
negocio
•• 
.
•• 
	Direccion
•• 
=
•• 
dto
••  #
.
••# $
	Direccion
••$ -
.
••- .
Trim
••. 2
(
••2 3
)
••3 4
;
••4 5
usuario
¶¶ 
.
¶¶ 
Correo
¶¶ 
=
¶¶ 
correo
¶¶ #
;
¶¶# $
await
®® 
negocios
®® 
.
®® 
ActualizarAsync
®® *
(
®®* +
negocio
®®+ 2
)
®®2 3
;
®®3 4
await
©© 
usuarios
©© 
.
©© 
ActualizarAsync
©© *
(
©©* +
usuario
©©+ 2
)
©©2 3
;
©©3 4
var
¨¨ 
codigo
¨¨ 
=
¨¨ 
await
¨¨ 
codigos
¨¨ &
.
¨¨& ' 
ObtenerUltimoAsync
¨¨' 9
(
¨¨9 :
	usuarioId
¨¨: C
)
¨¨C D
;
¨¨D E
if
≠≠ 
(
≠≠ 
codigo
≠≠ 
is
≠≠ 
not
≠≠ 
null
≠≠ "
)
≠≠" #
{
ÆÆ 
codigo
ØØ 
.
ØØ 
Usado
ØØ 
=
ØØ 
true
ØØ #
;
ØØ# $
await
∞∞ 
codigos
∞∞ 
.
∞∞ 
ActualizarAsync
∞∞ -
(
∞∞- .
codigo
∞∞. 4
)
∞∞4 5
;
∞∞5 6
}
±± 
return
≥≥ 
(
≥≥ 
true
≥≥ 
,
≥≥ 
null
≥≥ 
)
≥≥ 
;
≥≥  
}
¥¥ 	
catch
µµ 
(
µµ 
	Exception
µµ 
ex
µµ 
)
µµ 
{
∂∂ 	
logger
∑∑ 
.
∑∑ 
LogError
∑∑ 
(
∑∑ 
ex
∑∑ 
,
∑∑ 
$str
∑∑  W
,
∑∑W X
	usuarioId
∑∑Y b
)
∑∑b c
;
∑∑c d
return
∏∏ 
(
∏∏ 
false
∏∏ 
,
∏∏ "
MensajeErrorGuardado
∏∏ /
)
∏∏/ 0
;
∏∏0 1
}
ππ 	
}
∫∫ 
public
ΩΩ 

async
ΩΩ 
Task
ΩΩ 
<
ΩΩ 
(
ΩΩ 
bool
ΩΩ 
Ok
ΩΩ 
,
ΩΩ 
string
ΩΩ  &
?
ΩΩ& '
Error
ΩΩ( -
)
ΩΩ- .
>
ΩΩ. /%
ValidarEliminacionAsync
ΩΩ0 G
(
ΩΩG H
int
ΩΩH K
	usuarioId
ΩΩL U
,
ΩΩU V
string
ΩΩW ]
password
ΩΩ^ f
)
ΩΩf g
{
ææ 
var
øø 
usuario
øø 
=
øø 
await
øø 
usuarios
øø $
.
øø$ %
ObtenerPorIdAsync
øø% 6
(
øø6 7
	usuarioId
øø7 @
)
øø@ A
;
øøA B
if
¿¿ 

(
¿¿ 
usuario
¿¿ 
is
¿¿ 
null
¿¿ 
)
¿¿ 
return
¿¿ #
(
¿¿$ %
false
¿¿% *
,
¿¿* +
$str
¿¿, N
)
¿¿N O
;
¿¿O P
if
¬¬ 

(
¬¬ 
hasher
¬¬ 
.
¬¬ "
VerifyHashedPassword
¬¬ '
(
¬¬' (
usuario
¬¬( /
,
¬¬/ 0
usuario
¬¬1 8
.
¬¬8 9
PasswordHash
¬¬9 E
,
¬¬E F
password
¬¬G O
)
¬¬O P
==
¬¬Q S(
PasswordVerificationResult
¬¬T n
.
¬¬n o
Failed
¬¬o u
)
¬¬u v
return
√√ 
(
√√ 
false
√√ 
,
√√ 
$str
√√ 2
)
√√2 3
;
√√3 4
var
≈≈ 
negocio
≈≈ 
=
≈≈ 
await
≈≈ 
negocios
≈≈ $
.
≈≈$ %&
ObtenerPorUsuarioIdAsync
≈≈% =
(
≈≈= >
	usuarioId
≈≈> G
)
≈≈G H
;
≈≈H I
if
∆∆ 

(
∆∆ 
negocio
∆∆ 
is
∆∆ 
null
∆∆ 
)
∆∆ 
return
∆∆ #
(
∆∆$ %
false
∆∆% *
,
∆∆* +
$str
∆∆, N
)
∆∆N O
;
∆∆O P
if
»» 

(
»» 
await
»» 
negocios
»» 
.
»» &
TienePedidosActivosAsync
»» 3
(
»»3 4
negocio
»»4 ;
.
»»; <
Id
»»< >
)
»»> ?
)
»»? @
return
…… 
(
…… 
false
…… 
,
…… 
$str
…… Z
)
……Z [
;
……[ \
if
ÀÀ 

(
ÀÀ 
await
ÀÀ 
negocios
ÀÀ 
.
ÀÀ .
 TieneRepartidoresVinculadosAsync
ÀÀ ;
(
ÀÀ; <
negocio
ÀÀ< C
.
ÀÀC D
Id
ÀÀD F
)
ÀÀF G
)
ÀÀG H
return
ÃÃ 
(
ÃÃ 
false
ÃÃ 
,
ÃÃ 
$str
ÃÃ d
)
ÃÃd e
;
ÃÃe f
return
ŒŒ 
(
ŒŒ 
true
ŒŒ 
,
ŒŒ 
null
ŒŒ 
)
ŒŒ 
;
ŒŒ 
}
œœ 
public
—— 

async
—— 
Task
—— 
<
—— 
(
—— 
bool
—— 
Ok
—— 
,
—— 
string
——  &
?
——& '
Error
——( -
)
——- .
>
——. /!
EliminarCuentaAsync
——0 C
(
——C D
int
——D G
	usuarioId
——H Q
,
——Q R
string
——S Y
password
——Z b
)
——b c
{
““ 
var
‘‘ 
(
‘‘ 
ok
‘‘ 
,
‘‘ 
error
‘‘ 
)
‘‘ 
=
‘‘ 
await
‘‘ %
ValidarEliminacionAsync
‘‘  7
(
‘‘7 8
	usuarioId
‘‘8 A
,
‘‘A B
password
‘‘C K
)
‘‘K L
;
‘‘L M
if
’’ 

(
’’ 
!
’’ 
ok
’’ 
)
’’ 
return
’’ 
(
’’ 
false
’’ 
,
’’ 
error
’’  %
)
’’% &
;
’’& '
var
◊◊ 
usuario
◊◊ 
=
◊◊ 
await
◊◊ 
usuarios
◊◊ $
.
◊◊$ %
ObtenerPorIdAsync
◊◊% 6
(
◊◊6 7
	usuarioId
◊◊7 @
)
◊◊@ A
;
◊◊A B
if
ÿÿ 

(
ÿÿ 
usuario
ÿÿ 
is
ÿÿ 
null
ÿÿ 
)
ÿÿ 
return
ÿÿ #
(
ÿÿ$ %
false
ÿÿ% *
,
ÿÿ* +
$str
ÿÿ, N
)
ÿÿN O
;
ÿÿO P
usuario
€€ 
.
€€ 
Estado
€€ 
=
€€ 
EstadoCuenta
€€ %
.
€€% &
	Eliminado
€€& /
;
€€/ 0
await
‹‹ 
usuarios
‹‹ 
.
‹‹ 
ActualizarAsync
‹‹ &
(
‹‹& '
usuario
‹‹' .
)
‹‹. /
;
‹‹/ 0
return
›› 
(
›› 
true
›› 
,
›› 
null
›› 
)
›› 
;
›› 
}
ﬁﬁ 
private
‡‡ 
static
‡‡ 
string
‡‡ 
MensajeBloqueo
‡‡ (
(
‡‡( )
DateTime
‡‡) 1
hasta
‡‡2 7
)
‡‡7 8
{
·· 
var
‚‚ 
minutos
‚‚ 
=
‚‚ 
Math
‚‚ 
.
‚‚ 
Max
‚‚ 
(
‚‚ 
$num
‚‚  
,
‚‚  !
(
‚‚" #
int
‚‚# &
)
‚‚& '
Math
‚‚' +
.
‚‚+ ,
Ceiling
‚‚, 3
(
‚‚3 4
(
‚‚4 5
hasta
‚‚5 :
-
‚‚; <
DateTime
‚‚= E
.
‚‚E F
UtcNow
‚‚F L
)
‚‚L M
.
‚‚M N
TotalMinutes
‚‚N Z
)
‚‚Z [
)
‚‚[ \
;
‚‚\ ]
return
„„ 
$"
„„ 
$str
„„ c
{
„„c d
minutos
„„d k
}
„„k l
$str
„„l w
"
„„w x
;
„„x y
}
‰‰ 
}ÂÂ •

YC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\IUbicacionService.cs
	namespace 	
Gtrack
 
; 
public 
	interface 
IUbicacionService "
{ 
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
)  !
>! "
ActualizarAsync# 2
(2 3
int3 6
repartidorUsuarioId7 J
,J K
intL O
pedidoIdP X
,X Y
decimalZ a
latb e
,e f
decimalg n
lngo r
)r s
;s t
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
,  !
decimal" )
?) *
Latitud+ 2
,2 3
decimal4 ;
?; <
Longitud= E
,E F
DateTimeG O
?O P
FechaUtcQ Y
,Y Z
string[ a
?a b
Estadoc i
)i j
>j k"
ObtenerPorCodigoAsync	l Å
(
Å Ç
string
Ç à
codigoPedido
â ï
)
ï ñ
;
ñ ó
} Ù
WC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\IReporteService.cs
	namespace 	
Gtrack
 
; 
public 
	interface 
IReporteService  
{ 
Task 
< 	
ReporteNegocioDto	 
? 
> &
GenerarReporteNegocioAsync 7
(7 8
int8 ;
usuarioNegocioId< L
,L M
DateTimeN V
desdeW \
,\ ]
DateTime^ f
hastag l
)l m
;m n
Task		 
<		 	
HistorialExportDto			 
?		 
>		 !
ObtenerHistorialAsync		 3
(		3 4
int		4 7
usuarioNegocioId		8 H
,		H I
DateTime		J R
desde		S X
,		X Y
DateTime		Z b
hasta		c h
)		h i
;		i j
Task 
< 	
ReporteAdminDto	 
> $
GenerarReporteAdminAsync 2
(2 3
DateTime3 ;
desde< A
,A B
DateTimeC K
hastaL Q
)Q R
;R S
} 
public 
static 
class 
RangoReporte  
{ 
public 

const 
string 
MensajeInvalido '
=( )
$str* j
;j k
public 

static 
string 
? 
Validar !
(! "
DateTime" *
?* +
desde, 1
,1 2
DateTime3 ;
?; <
hasta= B
)B C
{ 
if 

( 
desde 
is 
null 
|| 
hasta "
is# %
null& *
)* +
return, 2
MensajeInvalido3 B
;B C
var 
d 
= 
desde 
. 
Value 
. 
Date  
;  !
var 
h 
= 
hasta 
. 
Value 
. 
Date  
;  !
if 

( 
d 
> 
h 
) 
return 
MensajeInvalido )
;) *
if 

( 
h 
>= 
d 
. 
	AddMonths 
( 
$num 
)  
)  !
return" (
MensajeInvalido) 8
;8 9
return 
null 
; 
} 
} ¬

\C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\IRecuperacionService.cs
	namespace 	
Gtrack
 
; 
public 
enum 
ResultadoSolicitud 
{  
	Procesada! *
,* +
LimiteSuperado, :
}; <
public 
	interface  
IRecuperacionService %
{ 
Task 
< 	
ResultadoSolicitud	 
> 
SolicitarAsync +
(+ ,
string, 2
correo3 9
,9 :
Func; ?
<? @
string@ F
,F G
stringH N
>N O
construirEnlaceP _
)_ `
;` a
Task 
< 	
bool	 
> 
TokenVigenteAsync  
(  !
string! '
token( -
)- .
;. /
Task		 
<		 	
(			 

bool		
 
Ok		 
,		 
string		 
?		 
Error		  
)		  !
>		! "
RestablecerAsync		# 3
(		3 4
string		4 :
token		; @
,		@ A
string		B H
nueva		I N
,		N O
string		P V
confirmacion		W c
)		c d
;		d e
}

 –
VC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\IPedidoService.cs
	namespace 	
Gtrack
 
; 
public 
	interface 
IPedidoService 
{ 
Task 
< 	#
ClienteAutocompletarDto	  
?  !
>! "'
BuscarClienteFrecuenteAsync# >
(> ?
int? B
usuarioNegocioIdC S
,S T
stringU [
telefono\ d
)d e
;e f
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
,  !
string" (
?( )
Codigo* 0
)0 1
>1 2
RegistrarAsync3 A
(A B
intB E
usuarioNegocioIdF V
,V W
RegistrarPedidoDtoX j
dtok n
)n o
;o p
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
)  !
>! "!
ActualizarEstadoAsync# 8
(8 9
int9 <
	usuarioId= F
,F G
intH K
pedidoIdL T
,T U
intV Y
nuevoEstadoIdZ g
,g h
inti l
?l m
repartidorIdn z
={ |
null	} Å
)
Å Ç
;
Ç É
Task 
< 	
List	 
< 
Pedido 
> 
> &
ObtenerPedidosActivosAsync 1
(1 2
int2 5
usuarioNegocioId6 F
)F G
;G H
Task		 
<		 	
List			 
<		 
Pedido		 
>		 
>		 (
ObtenerHistorialPedidosAsync		 3
(		3 4
int		4 7
usuarioNegocioId		8 H
)		H I
;		I J
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
)  !
>! "#
CancelarPorClienteAsync# :
(: ;
string; A
?A B
codigoC I
,I J
stringK Q
?Q R
motivoS Y
)Y Z
;Z [
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
)  !
>! "!
RegistrarNovedadAsync# 8
(8 9
int9 <
usuarioRepartidorId= P
,P Q
intR U
pedidoIdV ^
,^ _
int` c
?c d
tipoNovedadIde r
,r s
stringt z
?z {
observaciones	| â
)
â ä
;
ä ã
} ó
WC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\INegocioService.cs
	namespace 	
Gtrack
 
; 
public 
	interface 
INegocioService  
{ 
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
,  !
bool" &
CorreoEnviado' 4
)4 5
>5 6
RegistrarAsync7 E
(E F
RegistroNegocioDtoF X
dtoY \
,\ ]
string^ d
urlRevisione p
)p q
;q r
Task		 
<		 	
PerfilNegocioDto			 
?		 
>		 
ObtenerPerfilAsync		 .
(		. /
int		/ 2
	usuarioId		3 <
)		< =
;		= >
Task

 
<

 	#
PerfilPublicoNegocioDto

	  
?

  !
>

! "%
ObtenerPerfilPublicoAsync

# <
(

< =
int

= @
	negocioId

A J
)

J K
;

K L
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
)  !
>! " 
SolicitarCodigoAsync# 7
(7 8
int8 ;
	usuarioId< E
)E F
;F G
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
)  !
>! " 
VerificarCodigoAsync# 7
(7 8
int8 ;
	usuarioId< E
,E F
stringG M
codigoN T
)T U
;U V
Task 
< 	
bool	 
> "
EdicionAutorizadaAsync %
(% &
int& )
	usuarioId* 3
)3 4
;4 5
Task 
< 	
EditarNegocioDto	 
? 
> "
ObtenerParaEditarAsync 2
(2 3
int3 6
	usuarioId7 @
)@ A
;A B
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
)  !
>! "
EditarAsync# .
(. /
int/ 2
	usuarioId3 <
,< =
EditarNegocioDto> N
dtoO R
)R S
;S T
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
)  !
>! "#
ValidarEliminacionAsync# :
(: ;
int; >
	usuarioId? H
,H I
stringJ P
passwordQ Y
)Y Z
;Z [
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
)  !
>! "
EliminarCuentaAsync# 6
(6 7
int7 :
	usuarioId; D
,D E
stringF L
passwordM U
)U V
;V W
} ë
[C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\IExportadorReportes.cs
	namespace 	
Gtrack
 
; 
public 
	interface 
IExportadorReportes $
{ 
byte 
[ 	
]	 

ReporteNegocioExcel 
( 
ReporteNegocioDto 0
r1 2
)2 3
;3 4
byte 
[ 	
]	 

ReporteNegocioPdf 
( 
ReporteNegocioDto .
r/ 0
)0 1
;1 2
byte 
[ 	
]	 

HistorialExcel 
( 
HistorialExportDto ,
h- .
). /
;/ 0
byte		 
[		 	
]			 

HistorialCsv		 
(		 
HistorialExportDto		 *
h		+ ,
)		, -
;		- .
byte

 
[

 	
]

	 

HistorialPdf

 
(

 
HistorialExportDto

 *
h

+ ,
)

, -
;

- .
byte 
[ 	
]	 

ReporteAdminExcel 
( 
ReporteAdminDto ,
r- .
). /
;/ 0
byte 
[ 	
]	 

ReporteAdminPdf 
( 
ReporteAdminDto *
r+ ,
), -
;- .
} …
UC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\IEmailService.cs
	namespace 	
Gtrack
 
; 
public 
	interface 
IEmailService 
{ 
Task 
EnviarAsync	 
( 
string 
para  
,  !
string" (
asunto) /
,/ 0
string1 7
cuerpo8 >
)> ?
;? @
Task		 
EnviarAsync			 
(		 
string		 
para		  
,		  !
string		" (
asunto		) /
,		/ 0

CorreoHtml		1 ;
correo		< B
)		B C
;		C D
}

 ´
TC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\IAuthService.cs
	namespace 	
Gtrack
 
; 
public 
	interface 
IAuthService 
{ 
Task 
< 	
(	 

Usuario
 
? 
Usuario 
, 
string "
?" #
Error$ )
)) *
>* +
IniciarSesionAsync, >
(> ?
LoginDto? G
dtoH K
)K L
;L M
} ﬂü
ZC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\ExportadorReportes.cs
	namespace 	
Gtrack
 
; 
public 
class 
ExportadorReportes 
:  !
IExportadorReportes" 5
{ 
private 
static 
readonly 
CultureInfo '
Es( *
=+ ,
new- 0
(0 1
$str1 8
)8 9
;9 :
private 
static 
readonly 
XLColor #
Azul$ (
=) *
XLColor+ 2
.2 3
FromHtml3 ;
(; <
$str< E
)E F
;F G
private 
const 
string 
AzulHex  
=! "
$str# ,
;, -
private 
const 
string 
FormatoMoneda &
=' (
$str) 2
;2 3
private 
const 
string 
FormatoFechaHora )
=* +
$str, >
;> ?
private 
static 
string 
Moneda  
(  !
decimal! (
v) *
)* +
=>, .
v/ 0
.0 1
ToString1 9
(9 :
$str: >
,> ?
Es@ B
)B C
;C D
private 
static 
string 
Fecha 
(  
DateTime  (
d) *
)* +
=>, .
d/ 0
.0 1
ToString1 9
(9 :
$str: F
,F G
EsH J
)J K
;K L
private 
static 
string 
	FechaHora #
(# $
DateTime$ ,
d- .
). /
=>0 2
d3 4
.4 5
ToString5 =
(= >
$str> P
,P Q
EsR T
)T U
;U V
private 
static 
string 
Rango 
(  
DateTime  (
d) *
,* +
DateTime, 4
h5 6
)6 7
=>8 :
$"; =
{= >
Fecha> C
(C D
dD E
)E F
}F G
$strG K
{K L
FechaL Q
(Q R
hR S
)S T
}T U
"U V
;V W
private 
static 
void 
Poner 
( 
IXLCell %
c& '
,' (
object) /
?/ 0
v1 2
)2 3
{ 
switch 
( 
v 
) 
{ 	
case   
null   
:   
c   
.   
Value   
=    
$str  ! #
;  # $
break  % *
;  * +
case!! 
string!! 
s!! 
:!! 
c!! 
.!! 
Value!! "
=!!# $
s!!% &
;!!& '
break!!( -
;!!- .
case"" 
int"" 
i"" 
:"" 
c"" 
."" 
Value"" 
=""  !
i""" #
;""# $
break""% *
;""* +
case## 
decimal## 
d## 
:## 
c## 
.## 
Value## #
=##$ %
(##& '
double##' -
)##- .
d##. /
;##/ 0
break##1 6
;##6 7
case$$ 
DateTime$$ 
dt$$ 
:$$ 
c$$ 
.$$  
Value$$  %
=$$& '
dt$$( *
;$$* +
break$$, 1
;$$1 2
default%% 
:%% 
c%% 
.%% 
Value%% 
=%% 
v%%  
.%%  !
ToString%%! )
(%%) *
)%%* +
??%%, .
$str%%/ 1
;%%1 2
break%%3 8
;%%8 9
}&& 	
}'' 
private)) 
static)) 
void)) 

TituloHoja)) "
())" #
IXLWorksheet))# /
ws))0 2
,))2 3
string))4 :
titulo)); A
,))A B
params))C I
string))J P
[))P Q
]))Q R
lineas))S Y
)))Y Z
{** 
ws++ 

.++
 
Cell++ 
(++ 
$num++ 
,++ 
$num++ 
)++ 
.++ 
Value++ 
=++ 
titulo++ $
;++$ %
ws,, 

.,,
 
Cell,, 
(,, 
$num,, 
,,, 
$num,, 
),, 
.,, 
Style,, 
.,, 
Font,,  
.,,  !
Bold,,! %
=,,& '
true,,( ,
;,,, -
ws-- 

.--
 
Cell-- 
(-- 
$num-- 
,-- 
$num-- 
)-- 
.-- 
Style-- 
.-- 
Font--  
.--  !
FontSize--! )
=--* +
$num--, .
;--. /
ws.. 

...
 
Cell.. 
(.. 
$num.. 
,.. 
$num.. 
).. 
... 
Style.. 
... 
Font..  
...  !
	FontColor..! *
=..+ ,
Azul..- 1
;..1 2
for// 
(// 
var// 
i// 
=// 
$num// 
;// 
i// 
<// 
lineas// "
.//" #
Length//# )
;//) *
i//+ ,
++//, .
)//. /
ws00 
.00 
Cell00 
(00 
$num00 
+00 
i00 
,00 
$num00 
)00 
.00 
Value00 #
=00$ %
lineas00& ,
[00, -
i00- .
]00. /
;00/ 0
}11 
private33 
static33 
void33 
	Subtitulo33 !
(33! "
IXLWorksheet33" .
ws33/ 1
,331 2
int333 6
fila337 ;
,33; <
string33= C
texto33D I
)33I J
{44 
ws55 

.55
 
Cell55 
(55 
fila55 
,55 
$num55 
)55 
.55 
Value55 
=55  
texto55! &
;55& '
ws66 

.66
 
Cell66 
(66 
fila66 
,66 
$num66 
)66 
.66 
Style66 
.66 
Font66 #
.66# $
Bold66$ (
=66) *
true66+ /
;66/ 0
ws77 

.77
 
Cell77 
(77 
fila77 
,77 
$num77 
)77 
.77 
Style77 
.77 
Font77 #
.77# $
FontSize77$ ,
=77- .
$num77/ 1
;771 2
}88 
private;; 
static;; 
int;; 
Tabla;; 
(;; 
IXLWorksheet;; )
ws;;* ,
,;;, -
int;;. 1
fila;;2 6
,;;6 7
string;;8 >
[;;> ?
];;? @
	cabeceras;;A J
,;;J K
List;;L P
<;;P Q
object;;Q W
?;;W X
[;;X Y
];;Y Z
>;;Z [
datos;;\ a
,;;a b
string;;c i
?;;i j
[;;j k
];;k l
formatos;;m u
);;u v
{<< 
for== 
(== 
var== 
c== 
=== 
$num== 
;== 
c== 
<== 
	cabeceras== %
.==% &
Length==& ,
;==, -
c==. /
++==/ 1
)==1 2
ws>> 
.>> 
Cell>> 
(>> 
fila>> 
,>> 
c>> 
+>> 
$num>> 
)>>  
.>>  !
Value>>! &
=>>' (
	cabeceras>>) 2
[>>2 3
c>>3 4
]>>4 5
;>>5 6
var@@ 
enc@@ 
=@@ 
ws@@ 
.@@ 
Range@@ 
(@@ 
fila@@ 
,@@  
$num@@! "
,@@" #
fila@@$ (
,@@( )
	cabeceras@@* 3
.@@3 4
Length@@4 :
)@@: ;
;@@; <
encAA 
.AA 
StyleAA 
.AA 
FontAA 
.AA 
BoldAA 
=AA 
trueAA "
;AA" #
encBB 
.BB 
StyleBB 
.BB 
FontBB 
.BB 
	FontColorBB  
=BB! "
XLColorBB# *
.BB* +
WhiteBB+ 0
;BB0 1
encCC 
.CC 
StyleCC 
.CC 
FillCC 
.CC 
BackgroundColorCC &
=CC' (
AzulCC) -
;CC- .
encDD 
.DD 
StyleDD 
.DD 
	AlignmentDD 
.DD 

HorizontalDD &
=DD' ('
XLAlignmentHorizontalValuesDD) D
.DDD E
CenterDDE K
;DDK L
varFF 
fFF 
=FF 
filaFF 
+FF 
$numFF 
;FF 
foreachGG 
(GG 
varGG 
dGG 
inGG 
datosGG 
)GG  
{HH 	
forII 
(II 
varII 
cII 
=II 
$numII 
;II 
cII 
<II 
	cabecerasII  )
.II) *
LengthII* 0
;II0 1
cII2 3
++II3 5
)II5 6
{JJ 
varKK 
celdaKK 
=KK 
wsKK 
.KK 
CellKK #
(KK# $
fKK$ %
,KK% &
cKK' (
+KK) *
$numKK+ ,
)KK, -
;KK- .
PonerLL 
(LL 
celdaLL 
,LL 
dLL 
[LL 
cLL  
]LL  !
)LL! "
;LL" #
ifMM 
(MM 
formatosMM 
[MM 
cMM 
]MM 
isMM  "
stringMM# )
fmtMM* -
)MM- .
celdaMM/ 4
.MM4 5
StyleMM5 :
.MM: ;
NumberFormatMM; G
.MMG H
FormatMMH N
=MMO P
fmtMMQ T
;MMT U
}NN 
fOO 
++OO 
;OO 
}PP 	
varRR 
cuerpoRR 
=RR 
wsRR 
.RR 
RangeRR 
(RR 
filaRR "
,RR" #
$numRR$ %
,RR% &
MathRR' +
.RR+ ,
MaxRR, /
(RR/ 0
fRR0 1
-RR2 3
$numRR4 5
,RR5 6
filaRR7 ;
)RR; <
,RR< =
	cabecerasRR> G
.RRG H
LengthRRH N
)RRN O
;RRO P
cuerpoSS 
.SS 
StyleSS 
.SS 
BorderSS 
.SS 
OutsideBorderSS )
=SS* +
XLBorderStyleValuesSS, ?
.SS? @
ThinSS@ D
;SSD E
cuerpoTT 
.TT 
StyleTT 
.TT 
BorderTT 
.TT 
InsideBorderTT (
=TT) *
XLBorderStyleValuesTT+ >
.TT> ?
HairTT? C
;TTC D
returnUU 
fUU 
+UU 
$numUU 
;UU 
}VV 
privateXX 
staticXX 
byteXX 
[XX 
]XX 
GuardarXX !
(XX! "

XLWorkbookXX" ,
wbXX- /
)XX/ 0
{YY 
usingZZ 
varZZ 
msZZ 
=ZZ 
newZZ 
MemoryStreamZZ '
(ZZ' (
)ZZ( )
;ZZ) *
wb[[ 

.[[
 
SaveAs[[ 
([[ 
ms[[ 
)[[ 
;[[ 
return\\ 
ms\\ 
.\\ 
ToArray\\ 
(\\ 
)\\ 
;\\ 
}]] 
private__ 
static__ 
void__ 
HojaPedidos__ #
(__# $

XLWorkbook__$ .
wb__/ 1
,__1 2
string__3 9

nombreHoja__: D
,__D E
List__F J
<__J K
FilaPedidoReporte__K \
>__\ ]
filas__^ c
,__c d
string__e k
tituloEstado__l x
)__x y
{`` 
varaa 
wsaa 
=aa 
wbaa 
.aa 

Worksheetsaa 
.aa 
Addaa "
(aa" #

nombreHojaaa# -
)aa- .
;aa. /
Tablabb 
(bb 
wsbb 
,bb 
$numbb 
,bb 
[cc 
$strcc 
,cc 
$strcc  
,cc  !
$strcc" )
,cc) *
tituloEstadocc+ 7
,cc7 8
$strcc9 E
,ccE F
$strccG T
]ccT U
,ccU V
filasdd 
.dd 
Selectdd 
(dd 
fdd 
=>dd 
newdd !
objectdd" (
?dd( )
[dd) *
]dd* +
{dd, -
fdd. /
.dd/ 0
Codigodd0 6
,dd6 7
fdd8 9
.dd9 :
Clientedd: A
,ddA B
fddC D
.ddD E
FechaddE J
,ddJ K
fddL M
.ddM N
EstadoddN T
,ddT U
fddV W
.ddW X

RepartidorddX b
,ddb c
fddd e
.dde f

ValorTotalddf p
}ddq r
)ddr s
.dds t
ToListddt z
(ddz {
)dd{ |
,dd| }
[ee 
nullee 
,ee 
nullee 
,ee 
FormatoFechaHoraee )
,ee) *
nullee+ /
,ee/ 0
nullee1 5
,ee5 6
FormatoMonedaee7 D
]eeD E
)eeE F
;eeF G
doublegg 
[gg 
]gg 
anchosgg 
=gg 
[gg 
$numgg 
,gg 
$numgg !
,gg! "
$numgg# %
,gg% &
$numgg' )
,gg) *
$numgg+ -
,gg- .
$numgg/ 1
]gg1 2
;gg2 3
forhh 
(hh 
varhh 
ihh 
=hh 
$numhh 
;hh 
ihh 
<hh 
anchoshh "
.hh" #
Lengthhh# )
;hh) *
ihh+ ,
++hh, .
)hh. /
wshh0 2
.hh2 3
Columnhh3 9
(hh9 :
ihh: ;
+hh< =
$numhh> ?
)hh? @
.hh@ A
WidthhhA F
=hhG H
anchoshhI O
[hhO P
ihhP Q
]hhQ R
;hhR S
wsii 

.ii
 
	SheetViewii 
.ii 

FreezeRowsii 
(ii  
$numii  !
)ii! "
;ii" #
}jj 
publicll 

bytell 
[ll 
]ll 
ReporteNegocioExcelll %
(ll% &
ReporteNegocioDtoll& 7
rll8 9
)ll9 :
{mm 
usingnn 
varnn 
wbnn 
=nn 
newnn 

XLWorkbooknn %
(nn% &
)nn& '
;nn' (
varoo 
wsoo 
=oo 
wboo 
.oo 

Worksheetsoo 
.oo 
Addoo "
(oo" #
$stroo# ,
)oo, -
;oo- .

TituloHojaqq 
(qq 
wsqq 
,qq 
$strqq 4
,qq4 5
$"rr 
$strrr 
{rr 
rrr 
.rr 
NombreNegociorr '
}rr' (
"rr( )
,rr) *
$"ss 
$strss 
{ss 
Rangoss 
(ss 
rss 
.ss 
Desdess #
,ss# $
rss% &
.ss& '
Hastass' ,
)ss, -
}ss- .
"ss. /
,ss/ 0
$"tt 
$strtt 
{tt 
	FechaHoratt "
(tt" #
rtt# $
.tt$ %

GeneradoEntt% /
)tt/ 0
}tt0 1
"tt1 2
)tt2 3
;tt3 4
varvv 
filavv 
=vv 
$numvv 
;vv 
	Subtituloww 
(ww 
wsww 
,ww 
filaww 
++ww 
,ww 
$strww +
)ww+ ,
;ww, -
filaxx 
=xx 
Tablaxx 
(xx 
wsxx 
,xx 
filaxx 
,xx 
[xx  
$strxx  +
,xx+ ,
$strxx- 4
]xx4 5
,xx5 6
[yy 	
[zz 
$strzz 
,zz  
rzz! "
.zz" #
TotalPedidoszz# /
]zz/ 0
,zz0 1
[{{ 
$str{{ !
,{{! "
r{{# $
.{{$ %

Entregados{{% /
]{{/ 0
,{{0 1
[|| 
$str|| !
,||! "
r||# $
.||$ %

Cancelados||% /
]||/ 0
,||0 1
[}} 
$str}} "
,}}" #
r}}$ %
.}}% &
TasaEntrega}}& 1
]}}1 2
,}}2 3
[~~ 
$str~~ $
,~~$ %
r~~& '
.~~' (
ValorEntregado~~( 6
]~~6 7
] 	
,	 

[ 
null 
, 
null 
] 
) 
; 
ws
ÅÅ 

.
ÅÅ
 
Cell
ÅÅ 
(
ÅÅ 
fila
ÅÅ 
-
ÅÅ 
$num
ÅÅ 
,
ÅÅ 
$num
ÅÅ 
)
ÅÅ 
.
ÅÅ 
Style
ÅÅ "
.
ÅÅ" #
NumberFormat
ÅÅ# /
.
ÅÅ/ 0
Format
ÅÅ0 6
=
ÅÅ7 8
$str
ÅÅ9 C
;
ÅÅC D
ws
ÇÇ 

.
ÇÇ
 
Cell
ÇÇ 
(
ÇÇ 
fila
ÇÇ 
-
ÇÇ 
$num
ÇÇ 
,
ÇÇ 
$num
ÇÇ 
)
ÇÇ 
.
ÇÇ 
Style
ÇÇ "
.
ÇÇ" #
NumberFormat
ÇÇ# /
.
ÇÇ/ 0
Format
ÇÇ0 6
=
ÇÇ7 8
FormatoMoneda
ÇÇ9 F
;
ÇÇF G
	Subtitulo
ÑÑ 
(
ÑÑ 
ws
ÑÑ 
,
ÑÑ 
fila
ÑÑ 
++
ÑÑ 
,
ÑÑ 
$str
ÑÑ 2
)
ÑÑ2 3
;
ÑÑ3 4
fila
ÖÖ 
=
ÖÖ 
Tabla
ÖÖ 
(
ÖÖ 
ws
ÖÖ 
,
ÖÖ 
fila
ÖÖ 
,
ÖÖ 
[
ÖÖ  
$str
ÖÖ  (
,
ÖÖ( )
$str
ÖÖ* 4
,
ÖÖ4 5
$str
ÖÖ6 B
]
ÖÖB C
,
ÖÖC D
r
ÜÜ 
.
ÜÜ 
	PorEstado
ÜÜ 
.
ÜÜ 
Select
ÜÜ 
(
ÜÜ 
e
ÜÜ  
=>
ÜÜ! #
new
ÜÜ$ '
object
ÜÜ( .
?
ÜÜ. /
[
ÜÜ/ 0
]
ÜÜ0 1
{
ÜÜ2 3
e
ÜÜ4 5
.
ÜÜ5 6
Estado
ÜÜ6 <
,
ÜÜ< =
e
ÜÜ> ?
.
ÜÜ? @
Cantidad
ÜÜ@ H
,
ÜÜH I
e
ÜÜJ K
.
ÜÜK L

Porcentaje
ÜÜL V
}
ÜÜW X
)
ÜÜX Y
.
ÜÜY Z
ToList
ÜÜZ `
(
ÜÜ` a
)
ÜÜa b
,
ÜÜb c
[
áá 
null
áá 
,
áá 
null
áá 
,
áá 
$str
áá #
]
áá# $
)
áá$ %
;
áá% &
	Subtitulo
ââ 
(
ââ 
ws
ââ 
,
ââ 
fila
ââ 
++
ââ 
,
ââ 
$str
ââ /
)
ââ/ 0
;
ââ0 1
var
ää 
porMes
ää 
=
ää 
r
ää 
.
ää 
PorMes
ää 
.
ãã 
Select
ãã 
(
ãã 
m
ãã 
=>
ãã 
new
ãã 
object
ãã #
?
ãã# $
[
ãã$ %
]
ãã% &
{
ãã' (
m
ãã) *
.
ãã* +
Mes
ãã+ .
,
ãã. /
m
ãã0 1
.
ãã1 2
Total
ãã2 7
,
ãã7 8
m
ãã9 :
.
ãã: ;

Entregados
ãã; E
,
ããE F
m
ããG H
.
ããH I

Cancelados
ããI S
,
ããS T
m
ããU V
.
ããV W
ValorEntregado
ããW e
}
ããf g
)
ããg h
.
åå 
ToList
åå 
(
åå 
)
åå 
;
åå 
porMes
çç 
.
çç 
Add
çç 
(
çç 
[
çç 
$str
çç 
,
çç 
r
çç 
.
çç 
PorMes
çç %
.
çç% &
Sum
çç& )
(
çç) *
m
çç* +
=>
çç, .
m
çç/ 0
.
çç0 1
Total
çç1 6
)
çç6 7
,
çç7 8
r
çç9 :
.
çç: ;
PorMes
çç; A
.
ççA B
Sum
ççB E
(
ççE F
m
ççF G
=>
ççH J
m
ççK L
.
ççL M

Entregados
ççM W
)
ççW X
,
ççX Y
r
éé 
.
éé 
PorMes
éé 
.
éé 
Sum
éé  
(
éé  !
m
éé! "
=>
éé# %
m
éé& '
.
éé' (

Cancelados
éé( 2
)
éé2 3
,
éé3 4
r
éé5 6
.
éé6 7
PorMes
éé7 =
.
éé= >
Sum
éé> A
(
ééA B
m
ééB C
=>
ééD F
m
ééG H
.
ééH I
ValorEntregado
ééI W
)
ééW X
]
ééX Y
)
ééY Z
;
ééZ [
var
èè 
	inicioMes
èè 
=
èè 
fila
èè 
;
èè 
fila
êê 
=
êê 
Tabla
êê 
(
êê 
ws
êê 
,
êê 
fila
êê 
,
êê 
[
êê  
$str
êê  %
,
êê% &
$str
êê' 0
,
êê0 1
$str
êê2 >
,
êê> ?
$str
êê@ L
,
êêL M
$str
êêN _
]
êê_ `
,
êê` a
porMes
ëë 
,
ëë 
[
ëë 
null
ëë 
,
ëë 
null
ëë 
,
ëë  
null
ëë! %
,
ëë% &
null
ëë' +
,
ëë+ ,
FormatoMoneda
ëë- :
]
ëë: ;
)
ëë; <
;
ëë< =
ws
íí 

.
íí
 
Range
íí 
(
íí 
	inicioMes
íí 
+
íí 
porMes
íí #
.
íí# $
Count
íí$ )
,
íí) *
$num
íí+ ,
,
íí, -
	inicioMes
íí. 7
+
íí8 9
porMes
íí: @
.
íí@ A
Count
ííA F
,
ííF G
$num
ííH I
)
ííI J
.
ííJ K
Style
ííK P
.
ííP Q
Font
ííQ U
.
ííU V
Bold
ííV Z
=
íí[ \
true
íí] a
;
íía b
double
îî 
[
îî 
]
îî 
anchos
îî 
=
îî 
[
îî 
$num
îî 
,
îî 
$num
îî !
,
îî! "
$num
îî# %
,
îî% &
$num
îî' )
,
îî) *
$num
îî+ -
]
îî- .
;
îî. /
for
ïï 
(
ïï 
var
ïï 
i
ïï 
=
ïï 
$num
ïï 
;
ïï 
i
ïï 
<
ïï 
anchos
ïï "
.
ïï" #
Length
ïï# )
;
ïï) *
i
ïï+ ,
++
ïï, .
)
ïï. /
ws
ïï0 2
.
ïï2 3
Column
ïï3 9
(
ïï9 :
i
ïï: ;
+
ïï< =
$num
ïï> ?
)
ïï? @
.
ïï@ A
Width
ïïA F
=
ïïG H
anchos
ïïI O
[
ïïO P
i
ïïP Q
]
ïïQ R
;
ïïR S
HojaPedidos
óó 
(
óó 
wb
óó 
,
óó 
$str
óó !
,
óó! "
r
óó# $
.
óó$ %
Pedidos
óó% ,
,
óó, -
$str
óó. 6
)
óó6 7
;
óó7 8
return
òò 
Guardar
òò 
(
òò 
wb
òò 
)
òò 
;
òò 
}
ôô 
public
õõ 

byte
õõ 
[
õõ 
]
õõ 
HistorialExcel
õõ  
(
õõ  ! 
HistorialExportDto
õõ! 3
h
õõ4 5
)
õõ5 6
{
úú 
using
ùù 
var
ùù 
wb
ùù 
=
ùù 
new
ùù 

XLWorkbook
ùù %
(
ùù% &
)
ùù& '
;
ùù' (
HojaPedidos
ûû 
(
ûû 
wb
ûû 
,
ûû 
$str
ûû #
,
ûû# $
h
ûû% &
.
ûû& '
Filas
ûû' ,
,
ûû, -
$str
ûû. <
)
ûû< =
;
ûû= >
return
üü 
Guardar
üü 
(
üü 
wb
üü 
)
üü 
;
üü 
}
†† 
public
¢¢ 

byte
¢¢ 
[
¢¢ 
]
¢¢ 
ReporteAdminExcel
¢¢ #
(
¢¢# $
ReporteAdminDto
¢¢$ 3
r
¢¢4 5
)
¢¢5 6
{
££ 
using
§§ 
var
§§ 
wb
§§ 
=
§§ 
new
§§ 

XLWorkbook
§§ %
(
§§% &
)
§§& '
;
§§' (
var
•• 
ws
•• 
=
•• 
wb
•• 
.
•• 

Worksheets
•• 
.
•• 
Add
•• "
(
••" #
$str
••# ,
)
••, -
;
••- .

TituloHoja
ßß 
(
ßß 
ws
ßß 
,
ßß 
$str
ßß B
,
ßßB C
$"
®® 
$str
®® 
{
®® 
Rango
®® 
(
®® 
r
®® 
.
®® 
Desde
®® #
,
®®# $
r
®®% &
.
®®& '
Hasta
®®' ,
)
®®, -
}
®®- .
"
®®. /
,
®®/ 0
$"
©© 
$str
©© 
{
©© 
	FechaHora
©© "
(
©©" #
r
©©# $
.
©©$ %

GeneradoEn
©©% /
)
©©/ 0
}
©©0 1
"
©©1 2
)
©©2 3
;
©©3 4
var
´´ 
fila
´´ 
=
´´ 
$num
´´ 
;
´´ 
	Subtitulo
¨¨ 
(
¨¨ 
ws
¨¨ 
,
¨¨ 
fila
¨¨ 
++
¨¨ 
,
¨¨ 
$str
¨¨ +
)
¨¨+ ,
;
¨¨, -
fila
≠≠ 
=
≠≠ 
Tabla
≠≠ 
(
≠≠ 
ws
≠≠ 
,
≠≠ 
fila
≠≠ 
,
≠≠ 
[
≠≠  
$str
≠≠  +
,
≠≠+ ,
$str
≠≠- 4
]
≠≠4 5
,
≠≠5 6
[
ÆÆ 	
[
ØØ 
$str
ØØ 2
,
ØØ2 3
r
ØØ4 5
.
ØØ5 6!
NegociosRegistrados
ØØ6 I
]
ØØI J
,
ØØJ K
[
∞∞ 
$str
∞∞ 6
,
∞∞6 7
r
∞∞8 9
.
∞∞9 :"
NegociosActivosTotal
∞∞: N
]
∞∞N O
,
∞∞O P
[
±± 
$str
±± 3
,
±±3 4
r
±±5 6
.
±±6 7%
RepartidoresRegistrados
±±7 N
]
±±N O
,
±±O P
[
≤≤ 
$str
≤≤ *
,
≤≤* +
r
≤≤, -
.
≤≤- .
TotalPedidos
≤≤. :
]
≤≤: ;
,
≤≤; <
[
≥≥ 
$str
≥≥ !
,
≥≥! "
r
≥≥# $
.
≥≥$ %
PedidosEntregados
≥≥% 6
]
≥≥6 7
,
≥≥7 8
[
¥¥ 
$str
¥¥ $
,
¥¥$ %
r
¥¥& '
.
¥¥' (
ValorEntregado
¥¥( 6
]
¥¥6 7
]
µµ 	
,
µµ	 

[
µµ 
null
µµ 
,
µµ 
null
µµ 
]
µµ 
)
µµ 
;
µµ 
ws
∂∂ 

.
∂∂
 
Cell
∂∂ 
(
∂∂ 
fila
∂∂ 
-
∂∂ 
$num
∂∂ 
,
∂∂ 
$num
∂∂ 
)
∂∂ 
.
∂∂ 
Style
∂∂ "
.
∂∂" #
NumberFormat
∂∂# /
.
∂∂/ 0
Format
∂∂0 6
=
∂∂7 8
FormatoMoneda
∂∂9 F
;
∂∂F G
	Subtitulo
∏∏ 
(
∏∏ 
ws
∏∏ 
,
∏∏ 
fila
∏∏ 
++
∏∏ 
,
∏∏ 
$str
∏∏ 7
)
∏∏7 8
;
∏∏8 9
fila
ππ 
=
ππ 
Tabla
ππ 
(
ππ 
ws
ππ 
,
ππ 
fila
ππ 
,
ππ 
[
ππ  
$str
ππ  %
,
ππ% &
$str
ππ' 1
]
ππ1 2
,
ππ2 3
r
∫∫ 
.
∫∫ 
NegociosPorMes
∫∫ 
.
∫∫ 
Select
∫∫ #
(
∫∫# $
m
∫∫$ %
=>
∫∫& (
new
∫∫) ,
object
∫∫- 3
?
∫∫3 4
[
∫∫4 5
]
∫∫5 6
{
∫∫7 8
m
∫∫9 :
.
∫∫: ;
Mes
∫∫; >
,
∫∫> ?
m
∫∫@ A
.
∫∫A B
Total
∫∫B G
}
∫∫H I
)
∫∫I J
.
∫∫J K
ToList
∫∫K Q
(
∫∫Q R
)
∫∫R S
,
∫∫S T
[
∫∫U V
null
∫∫V Z
,
∫∫Z [
null
∫∫\ `
]
∫∫` a
)
∫∫a b
;
∫∫b c
	Subtitulo
ºº 
(
ºº 
ws
ºº 
,
ºº 
fila
ºº 
++
ºº 
,
ºº 
$str
ºº D
)
ººD E
;
ººE F
fila
ΩΩ 
=
ΩΩ 
Tabla
ΩΩ 
(
ΩΩ 
ws
ΩΩ 
,
ΩΩ 
fila
ΩΩ 
,
ΩΩ 
[
ΩΩ  
$str
ΩΩ  (
,
ΩΩ( )
$str
ΩΩ* 4
,
ΩΩ4 5
$str
ΩΩ6 B
]
ΩΩB C
,
ΩΩC D
r
ææ 
.
ææ 
NegociosPorEstado
ææ 
.
ææ  
Select
ææ  &
(
ææ& '
e
ææ' (
=>
ææ) +
new
ææ, /
object
ææ0 6
?
ææ6 7
[
ææ7 8
]
ææ8 9
{
ææ: ;
e
ææ< =
.
ææ= >
Etiqueta
ææ> F
,
ææF G
e
ææH I
.
ææI J
Cantidad
ææJ R
,
ææR S
e
ææT U
.
ææU V

Porcentaje
ææV `
}
ææa b
)
ææb c
.
ææc d
ToList
ææd j
(
ææj k
)
ææk l
,
ææl m
[
øø 
null
øø 
,
øø 
null
øø 
,
øø 
$str
øø #
]
øø# $
)
øø$ %
;
øø% &
	Subtitulo
¡¡ 
(
¡¡ 
ws
¡¡ 
,
¡¡ 
fila
¡¡ 
++
¡¡ 
,
¡¡ 
$str
¡¡ E
)
¡¡E F
;
¡¡F G
fila
¬¬ 
=
¬¬ 
Tabla
¬¬ 
(
¬¬ 
ws
¬¬ 
,
¬¬ 
fila
¬¬ 
,
¬¬ 
[
¬¬  
$str
¬¬  +
,
¬¬+ ,
$str
¬¬- 7
,
¬¬7 8
$str
¬¬9 E
]
¬¬E F
,
¬¬F G
r
√√ 
.
√√ "
NegociosPorActividad
√√ "
.
√√" #
Select
√√# )
(
√√) *
e
√√* +
=>
√√, .
new
√√/ 2
object
√√3 9
?
√√9 :
[
√√: ;
]
√√; <
{
√√= >
e
√√? @
.
√√@ A
Etiqueta
√√A I
,
√√I J
e
√√K L
.
√√L M
Cantidad
√√M U
,
√√U V
e
√√W X
.
√√X Y

Porcentaje
√√Y c
}
√√d e
)
√√e f
.
√√f g
ToList
√√g m
(
√√m n
)
√√n o
,
√√o p
[
ƒƒ 
null
ƒƒ 
,
ƒƒ 
null
ƒƒ 
,
ƒƒ 
$str
ƒƒ #
]
ƒƒ# $
)
ƒƒ$ %
;
ƒƒ% &
	Subtitulo
∆∆ 
(
∆∆ 
ws
∆∆ 
,
∆∆ 
fila
∆∆ 
++
∆∆ 
,
∆∆ 
$str
∆∆ C
)
∆∆C D
;
∆∆D E
fila
«« 
=
«« 
Tabla
«« 
(
«« 
ws
«« 
,
«« 
fila
«« 
,
«« 
[
««  
$str
««  (
,
««( )
$str
««* 4
,
««4 5
$str
««6 B
]
««B C
,
««C D
r
»» 
.
»» 
PedidosPorEstado
»» 
.
»» 
Select
»» %
(
»»% &
e
»»& '
=>
»»( *
new
»»+ .
object
»»/ 5
?
»»5 6
[
»»6 7
]
»»7 8
{
»»9 :
e
»»; <
.
»»< =
Estado
»»= C
,
»»C D
e
»»E F
.
»»F G
Cantidad
»»G O
,
»»O P
e
»»Q R
.
»»R S

Porcentaje
»»S ]
}
»»^ _
)
»»_ `
.
»»` a
ToList
»»a g
(
»»g h
)
»»h i
,
»»i j
[
…… 
null
…… 
,
…… 
null
…… 
,
…… 
$str
…… #
]
……# $
)
……$ %
;
……% &
	Subtitulo
ÀÀ 
(
ÀÀ 
ws
ÀÀ 
,
ÀÀ 
fila
ÀÀ 
++
ÀÀ 
,
ÀÀ 
$str
ÀÀ ?
)
ÀÀ? @
;
ÀÀ@ A
Tabla
ÃÃ 
(
ÃÃ 
ws
ÃÃ 
,
ÃÃ 
fila
ÃÃ 
,
ÃÃ 
[
ÃÃ 
$str
ÃÃ "
,
ÃÃ" #
$str
ÃÃ$ -
,
ÃÃ- .
$str
ÃÃ/ ;
,
ÃÃ; <
$str
ÃÃ= N
]
ÃÃN O
,
ÃÃO P
r
ÕÕ 
.
ÕÕ 
TopNegocios
ÕÕ 
.
ÕÕ 
Select
ÕÕ  
(
ÕÕ  !
t
ÕÕ! "
=>
ÕÕ# %
new
ÕÕ& )
object
ÕÕ* 0
?
ÕÕ0 1
[
ÕÕ1 2
]
ÕÕ2 3
{
ÕÕ4 5
t
ÕÕ6 7
.
ÕÕ7 8
Nombre
ÕÕ8 >
,
ÕÕ> ?
t
ÕÕ@ A
.
ÕÕA B
Pedidos
ÕÕB I
,
ÕÕI J
t
ÕÕK L
.
ÕÕL M

Entregados
ÕÕM W
,
ÕÕW X
t
ÕÕY Z
.
ÕÕZ [
ValorEntregado
ÕÕ[ i
}
ÕÕj k
)
ÕÕk l
.
ÕÕl m
ToList
ÕÕm s
(
ÕÕs t
)
ÕÕt u
,
ÕÕu v
[
ŒŒ 
null
ŒŒ 
,
ŒŒ 
null
ŒŒ 
,
ŒŒ 
null
ŒŒ 
,
ŒŒ 
FormatoMoneda
ŒŒ ,
]
ŒŒ, -
)
ŒŒ- .
;
ŒŒ. /
double
–– 
[
–– 
]
–– 
anchos
–– 
=
–– 
[
–– 
$num
–– 
,
–– 
$num
–– !
,
––! "
$num
––# %
,
––% &
$num
––' )
]
––) *
;
––* +
for
—— 
(
—— 
var
—— 
i
—— 
=
—— 
$num
—— 
;
—— 
i
—— 
<
—— 
anchos
—— "
.
——" #
Length
——# )
;
——) *
i
——+ ,
++
——, .
)
——. /
ws
——0 2
.
——2 3
Column
——3 9
(
——9 :
i
——: ;
+
——< =
$num
——> ?
)
——? @
.
——@ A
Width
——A F
=
——G H
anchos
——I O
[
——O P
i
——P Q
]
——Q R
;
——R S
var
‘‘ 
wn
‘‘ 
=
‘‘ 
wb
‘‘ 
.
‘‘ 

Worksheets
‘‘ 
.
‘‘ 
Add
‘‘ "
(
‘‘" #
$str
‘‘# 4
)
‘‘4 5
;
‘‘5 6
Tabla
’’ 
(
’’ 
wn
’’ 
,
’’ 
$num
’’ 
,
’’ 
[
’’ 
$str
’’ 
,
’’  
$str
’’! ,
,
’’, -
$str
’’. 8
,
’’8 9
$str
’’: B
,
’’B C
$str
’’D W
,
’’W X
$str
’’Y a
]
’’a b
,
’’b c
r
÷÷ 
.
÷÷ 
Negocios
÷÷ 
.
÷÷ 
Select
÷÷ 
(
÷÷ 
n
÷÷ 
=>
÷÷  "
new
÷÷# &
object
÷÷' -
?
÷÷- .
[
÷÷. /
]
÷÷/ 0
{
÷÷1 2
n
÷÷3 4
.
÷÷4 5
Nombre
÷÷5 ;
,
÷÷; <
n
÷÷= >
.
÷÷> ?
	Actividad
÷÷? H
,
÷÷H I
n
÷÷J K
.
÷÷K L
	Documento
÷÷L U
,
÷÷U V
n
÷÷W X
.
÷÷X Y
Correo
÷÷Y _
,
÷÷_ `
n
÷÷a b
.
÷÷b c
FechaRegistro
÷÷c p
,
÷÷p q
n
÷÷r s
.
÷÷s t
Estado
÷÷t z
}
÷÷{ |
)
÷÷| }
.
÷÷} ~
ToList÷÷~ Ñ
(÷÷Ñ Ö
)÷÷Ö Ü
,÷÷Ü á
[
◊◊ 
null
◊◊ 
,
◊◊ 
null
◊◊ 
,
◊◊ 
null
◊◊ 
,
◊◊ 
null
◊◊ #
,
◊◊# $
FormatoFechaHora
◊◊% 5
,
◊◊5 6
null
◊◊7 ;
]
◊◊; <
)
◊◊< =
;
◊◊= >
double
ÿÿ 
[
ÿÿ 
]
ÿÿ 
anchosN
ÿÿ 
=
ÿÿ 
[
ÿÿ 
$num
ÿÿ 
,
ÿÿ 
$num
ÿÿ  "
,
ÿÿ" #
$num
ÿÿ$ &
,
ÿÿ& '
$num
ÿÿ( *
,
ÿÿ* +
$num
ÿÿ, .
,
ÿÿ. /
$num
ÿÿ0 2
]
ÿÿ2 3
;
ÿÿ3 4
for
ŸŸ 
(
ŸŸ 
var
ŸŸ 
i
ŸŸ 
=
ŸŸ 
$num
ŸŸ 
;
ŸŸ 
i
ŸŸ 
<
ŸŸ 
anchosN
ŸŸ #
.
ŸŸ# $
Length
ŸŸ$ *
;
ŸŸ* +
i
ŸŸ, -
++
ŸŸ- /
)
ŸŸ/ 0
wn
ŸŸ1 3
.
ŸŸ3 4
Column
ŸŸ4 :
(
ŸŸ: ;
i
ŸŸ; <
+
ŸŸ= >
$num
ŸŸ? @
)
ŸŸ@ A
.
ŸŸA B
Width
ŸŸB G
=
ŸŸH I
anchosN
ŸŸJ Q
[
ŸŸQ R
i
ŸŸR S
]
ŸŸS T
;
ŸŸT U
wn
⁄⁄ 

.
⁄⁄
 
	SheetView
⁄⁄ 
.
⁄⁄ 

FreezeRows
⁄⁄ 
(
⁄⁄  
$num
⁄⁄  !
)
⁄⁄! "
;
⁄⁄" #
return
‹‹ 
Guardar
‹‹ 
(
‹‹ 
wb
‹‹ 
)
‹‹ 
;
‹‹ 
}
›› 
private
„„ 
static
„„ 
string
„„ 
Csv
„„ 
(
„„ 
string
„„ $
valor
„„% *
)
„„* +
{
‰‰ 
if
ÊÊ 

(
ÊÊ 
valor
ÊÊ 
.
ÊÊ 
Length
ÊÊ 
>
ÊÊ 
$num
ÊÊ 
&&
ÊÊ 
$str
ÊÊ  &
.
ÊÊ& '
Contains
ÊÊ' /
(
ÊÊ/ 0
valor
ÊÊ0 5
[
ÊÊ5 6
$num
ÊÊ6 7
]
ÊÊ7 8
)
ÊÊ8 9
)
ÊÊ9 :
valor
ÊÊ; @
=
ÊÊA B
$str
ÊÊC F
+
ÊÊG H
valor
ÊÊI N
;
ÊÊN O
return
ÁÁ 
$str
ÁÁ 
+
ÁÁ 
valor
ÁÁ 
.
ÁÁ 
Replace
ÁÁ #
(
ÁÁ# $
$str
ÁÁ$ (
,
ÁÁ( )
$str
ÁÁ* 0
)
ÁÁ0 1
+
ÁÁ2 3
$str
ÁÁ4 8
;
ÁÁ8 9
}
ËË 
public
ÍÍ 

byte
ÍÍ 
[
ÍÍ 
]
ÍÍ 
HistorialCsv
ÍÍ 
(
ÍÍ  
HistorialExportDto
ÍÍ 1
h
ÍÍ2 3
)
ÍÍ3 4
{
ÎÎ 
var
ÏÏ 
sb
ÏÏ 
=
ÏÏ 
new
ÏÏ 
StringBuilder
ÏÏ "
(
ÏÏ" #
)
ÏÏ# $
;
ÏÏ$ %
sb
ÓÓ 

.
ÓÓ
 

AppendLine
ÓÓ 
(
ÓÓ 
$str
ÓÓ P
)
ÓÓP Q
;
ÓÓQ R
foreach
ÔÔ 
(
ÔÔ 
var
ÔÔ 
f
ÔÔ 
in
ÔÔ 
h
ÔÔ 
.
ÔÔ 
Filas
ÔÔ !
)
ÔÔ! "
{
 	
sb
ÒÒ 
.
ÒÒ 

AppendLine
ÒÒ 
(
ÒÒ 
string
ÒÒ  
.
ÒÒ  !
Join
ÒÒ! %
(
ÒÒ% &
$char
ÒÒ& )
,
ÒÒ) *
Csv
ÚÚ 
(
ÚÚ 
f
ÚÚ 
.
ÚÚ 
Codigo
ÚÚ 
)
ÚÚ 
,
ÚÚ 
Csv
ÛÛ 
(
ÛÛ 
f
ÛÛ 
.
ÛÛ 
Cliente
ÛÛ 
)
ÛÛ 
,
ÛÛ 
Csv
ÙÙ 
(
ÙÙ 
f
ÙÙ 
.
ÙÙ 
Fecha
ÙÙ 
.
ÙÙ 
ToString
ÙÙ $
(
ÙÙ$ %
$str
ÙÙ% 7
,
ÙÙ7 8
CultureInfo
ÙÙ9 D
.
ÙÙD E
InvariantCulture
ÙÙE U
)
ÙÙU V
)
ÙÙV W
,
ÙÙW X
Csv
ıı 
(
ıı 
f
ıı 
.
ıı 
Estado
ıı 
)
ıı 
,
ıı 
Csv
ˆˆ 
(
ˆˆ 
f
ˆˆ 
.
ˆˆ 

Repartidor
ˆˆ  
)
ˆˆ  !
,
ˆˆ! "
f
˜˜ 
.
˜˜ 

ValorTotal
˜˜ 
.
˜˜ 
ToString
˜˜ %
(
˜˜% &
$str
˜˜& ,
,
˜˜, -
CultureInfo
˜˜. 9
.
˜˜9 :
InvariantCulture
˜˜: J
)
˜˜J K
)
˜˜K L
)
˜˜L M
;
˜˜M N
}
¯¯ 	
var
˙˙ 
bom
˙˙ 
=
˙˙ 
new
˙˙ 
UTF8Encoding
˙˙ "
(
˙˙" #
true
˙˙# '
)
˙˙' (
.
˙˙( )
GetPreamble
˙˙) 4
(
˙˙4 5
)
˙˙5 6
;
˙˙6 7
var
˚˚ 
cuerpo
˚˚ 
=
˚˚ 
Encoding
˚˚ 
.
˚˚ 
UTF8
˚˚ "
.
˚˚" #
GetBytes
˚˚# +
(
˚˚+ ,
sb
˚˚, .
.
˚˚. /
ToString
˚˚/ 7
(
˚˚7 8
)
˚˚8 9
)
˚˚9 :
;
˚˚: ;
return
¸¸ 
[
¸¸ 
..
¸¸ 
bom
¸¸ 
,
¸¸ 
..
¸¸ 
cuerpo
¸¸ !
]
¸¸! "
;
¸¸" #
}
˝˝ 
private
ÉÉ 
static
ÉÉ 

IContainer
ÉÉ 
CeldaCab
ÉÉ &
(
ÉÉ& '

IContainer
ÉÉ' 1
c
ÉÉ2 3
)
ÉÉ3 4
=>
ÉÉ5 7
c
ÉÉ8 9
.
ÉÉ9 :

Background
ÉÉ: D
(
ÉÉD E
AzulHex
ÉÉE L
)
ÉÉL M
.
ÉÉM N
Padding
ÉÉN U
(
ÉÉU V
$num
ÉÉV W
)
ÉÉW X
;
ÉÉX Y
private
ÑÑ 
static
ÑÑ 

IContainer
ÑÑ 
Celda
ÑÑ #
(
ÑÑ# $

IContainer
ÑÑ$ .
c
ÑÑ/ 0
)
ÑÑ0 1
=>
ÑÑ2 4
c
ÑÑ5 6
.
ÑÑ6 7
BorderBottom
ÑÑ7 C
(
ÑÑC D
$num
ÑÑD H
)
ÑÑH I
.
ÑÑI J
BorderColor
ÑÑJ U
(
ÑÑU V
$str
ÑÑV _
)
ÑÑ_ `
.
ÑÑ` a
Padding
ÑÑa h
(
ÑÑh i
$num
ÑÑi j
)
ÑÑj k
;
ÑÑk l
private
ÜÜ 
static
ÜÜ 
void
ÜÜ 
Cabecera
ÜÜ  
(
ÜÜ  !
PageDescriptor
ÜÜ! /
page
ÜÜ0 4
,
ÜÜ4 5
string
ÜÜ6 <
titulo
ÜÜ= C
,
ÜÜC D
params
ÜÜE K
string
ÜÜL R
[
ÜÜR S
]
ÜÜS T
lineas
ÜÜU [
)
ÜÜ[ \
{
áá 
page
àà 
.
àà 
Header
àà 
(
àà 
)
àà 
.
àà 
Column
àà 
(
àà 
col
àà  
=>
àà! #
{
ââ 	
col
ää 
.
ää 
Item
ää 
(
ää 
)
ää 
.
ää 
Row
ää 
(
ää 
row
ää 
=>
ää !
{
ãã 
row
åå 
.
åå 
RelativeItem
åå  
(
åå  !
)
åå! "
.
åå" #
Text
åå# '
(
åå' (
$str
åå( 0
)
åå0 1
.
åå1 2
FontSize
åå2 :
(
åå: ;
$num
åå; =
)
åå= >
.
åå> ?
Bold
åå? C
(
ååC D
)
ååD E
.
ååE F
	FontColor
ååF O
(
ååO P
AzulHex
ååP W
)
ååW X
;
ååX Y
row
çç 
.
çç 
RelativeItem
çç  
(
çç  !
)
çç! "
.
çç" #

AlignRight
çç# -
(
çç- .
)
çç. /
.
çç/ 0
AlignMiddle
çç0 ;
(
çç; <
)
çç< =
.
çç= >
Text
çç> B
(
ççB C
titulo
ççC I
)
ççI J
.
ççJ K
FontSize
ççK S
(
ççS T
$num
ççT V
)
ççV W
.
ççW X
SemiBold
ççX `
(
çç` a
)
çça b
;
ççb c
}
éé 
)
éé 
;
éé 
foreach
èè 
(
èè 
var
èè 
l
èè 
in
èè 
lineas
èè $
)
èè$ %
col
êê 
.
êê 
Item
êê 
(
êê 
)
êê 
.
êê 
Text
êê 
(
êê  
l
êê  !
)
êê! "
.
êê" #
FontSize
êê# +
(
êê+ ,
$num
êê, -
)
êê- .
.
êê. /
	FontColor
êê/ 8
(
êê8 9
$str
êê9 B
)
êêB C
;
êêC D
col
ëë 
.
ëë 
Item
ëë 
(
ëë 
)
ëë 
.
ëë 

PaddingTop
ëë !
(
ëë! "
$num
ëë" #
)
ëë# $
.
ëë$ %
LineHorizontal
ëë% 3
(
ëë3 4
$num
ëë4 5
)
ëë5 6
.
ëë6 7
	LineColor
ëë7 @
(
ëë@ A
AzulHex
ëëA H
)
ëëH I
;
ëëI J
}
íí 	
)
íí	 

;
íí
 
}
ìì 
private
ïï 
static
ïï 
void
ïï 
Pie
ïï 
(
ïï 
PageDescriptor
ïï *
page
ïï+ /
)
ïï/ 0
{
ññ 
page
óó 
.
óó 
Footer
óó 
(
óó 
)
óó 
.
óó 
AlignCenter
óó !
(
óó! "
)
óó" #
.
óó# $
DefaultTextStyle
óó$ 4
(
óó4 5
x
óó5 6
=>
óó7 9
x
óó: ;
.
óó; <
FontSize
óó< D
(
óóD E
$num
óóE F
)
óóF G
.
óóG H
	FontColor
óóH Q
(
óóQ R
$str
óóR [
)
óó[ \
)
óó\ ]
.
óó] ^
Text
óó^ b
(
óób c
t
óóc d
=>
óóe g
{
òò 	
t
ôô 
.
ôô 
Span
ôô 
(
ôô 
$str
ôô %
)
ôô% &
;
ôô& '
t
öö 
.
öö 
CurrentPageNumber
öö 
(
öö  
)
öö  !
;
öö! "
t
õõ 
.
õõ 
Span
õõ 
(
õõ 
$str
õõ 
)
õõ 
;
õõ 
t
úú 
.
úú 

TotalPages
úú 
(
úú 
)
úú 
;
úú 
}
ùù 	
)
ùù	 

;
ùù
 
}
ûû 
private
†† 
static
†† 
void
†† 
Seccion
†† 
(
††  
ColumnDescriptor
††  0
col
††1 4
,
††4 5
string
††6 <
titulo
††= C
)
††C D
{
°° 
col
¢¢ 
.
¢¢ 
Item
¢¢ 
(
¢¢ 
)
¢¢ 
.
¢¢ 

PaddingTop
¢¢ 
(
¢¢ 
$num
¢¢  
)
¢¢  !
.
¢¢! "
PaddingBottom
¢¢" /
(
¢¢/ 0
$num
¢¢0 1
)
¢¢1 2
.
¢¢2 3
Text
¢¢3 7
(
¢¢7 8
titulo
¢¢8 >
)
¢¢> ?
.
¢¢? @
FontSize
¢¢@ H
(
¢¢H I
$num
¢¢I K
)
¢¢K L
.
¢¢L M
SemiBold
¢¢M U
(
¢¢U V
)
¢¢V W
.
¢¢W X
	FontColor
¢¢X a
(
¢¢a b
AzulHex
¢¢b i
)
¢¢i j
;
¢¢j k
}
££ 
private
•• 
static
•• 
void
•• 
Indicadores
•• #
(
••# $
ColumnDescriptor
••$ 4
col
••5 8
,
••8 9
params
••: @
(
••A B
string
••B H
Etiqueta
••I Q
,
••Q R
string
••S Y
Valor
••Z _
)
••_ `
[
••` a
]
••a b
kpis
••c g
)
••g h
{
¶¶ 
col
ßß 
.
ßß 
Item
ßß 
(
ßß 
)
ßß 
.
ßß 

PaddingTop
ßß 
(
ßß 
$num
ßß  
)
ßß  !
.
ßß! "
Row
ßß" %
(
ßß% &
row
ßß& )
=>
ßß* ,
{
®® 	
row
©© 
.
©© 
Spacing
©© 
(
©© 
$num
©© 
)
©© 
;
©© 
foreach
™™ 
(
™™ 
var
™™ 
k
™™ 
in
™™ 
kpis
™™ "
)
™™" #
{
´´ 
row
¨¨ 
.
¨¨ 
RelativeItem
¨¨  
(
¨¨  !
)
¨¨! "
.
¨¨" #
Border
¨¨# )
(
¨¨) *
$num
¨¨* +
)
¨¨+ ,
.
¨¨, -
BorderColor
¨¨- 8
(
¨¨8 9
$str
¨¨9 B
)
¨¨B C
.
¨¨C D
Padding
¨¨D K
(
¨¨K L
$num
¨¨L M
)
¨¨M N
.
¨¨N O
Column
¨¨O U
(
¨¨U V
c
¨¨V W
=>
¨¨X Z
{
≠≠ 
c
ÆÆ 
.
ÆÆ 
Item
ÆÆ 
(
ÆÆ 
)
ÆÆ 
.
ÆÆ 
Text
ÆÆ !
(
ÆÆ! "
k
ÆÆ" #
.
ÆÆ# $
Etiqueta
ÆÆ$ ,
)
ÆÆ, -
.
ÆÆ- .
FontSize
ÆÆ. 6
(
ÆÆ6 7
$num
ÆÆ7 8
)
ÆÆ8 9
.
ÆÆ9 :
	FontColor
ÆÆ: C
(
ÆÆC D
$str
ÆÆD M
)
ÆÆM N
;
ÆÆN O
c
ØØ 
.
ØØ 
Item
ØØ 
(
ØØ 
)
ØØ 
.
ØØ 
Text
ØØ !
(
ØØ! "
k
ØØ" #
.
ØØ# $
Valor
ØØ$ )
)
ØØ) *
.
ØØ* +
FontSize
ØØ+ 3
(
ØØ3 4
$num
ØØ4 6
)
ØØ6 7
.
ØØ7 8
SemiBold
ØØ8 @
(
ØØ@ A
)
ØØA B
;
ØØB C
}
∞∞ 
)
∞∞ 
;
∞∞ 
}
±± 
}
≤≤ 	
)
≤≤	 

;
≤≤
 
}
≥≥ 
private
∂∂ 
static
∂∂ 
void
∂∂ 
Barras
∂∂ 
(
∂∂ 
ColumnDescriptor
∂∂ /
col
∂∂0 3
,
∂∂3 4
List
∂∂5 9
<
∂∂9 :
(
∂∂: ;
string
∂∂; A
Etiqueta
∂∂B J
,
∂∂J K
int
∂∂L O
Cantidad
∂∂P X
,
∂∂X Y
string
∂∂Z `
Color
∂∂a f
,
∂∂f g
string
∂∂h n
Detalle
∂∂o v
)
∂∂v w
>
∂∂w x
items
∂∂y ~
)
∂∂~ 
{
∑∑ 
var
∏∏ 
max
∏∏ 
=
∏∏ 
items
∏∏ 
.
∏∏ 
Count
∏∏ 
==
∏∏  
$num
∏∏! "
?
∏∏# $
$num
∏∏% &
:
∏∏' (
items
∏∏) .
.
∏∏. /
Max
∏∏/ 2
(
∏∏2 3
i
∏∏3 4
=>
∏∏5 7
i
∏∏8 9
.
∏∏9 :
Cantidad
∏∏: B
)
∏∏B C
;
∏∏C D
foreach
ππ 
(
ππ 
var
ππ 
it
ππ 
in
ππ 
items
ππ  
)
ππ  !
{
∫∫ 	
col
ªª 
.
ªª 
Item
ªª 
(
ªª 
)
ªª 
.
ªª 
PaddingVertical
ªª &
(
ªª& '
$num
ªª' (
)
ªª( )
.
ªª) *
Row
ªª* -
(
ªª- .
row
ªª. 1
=>
ªª2 4
{
ºº 
row
ΩΩ 
.
ΩΩ 
ConstantItem
ΩΩ  
(
ΩΩ  !
$num
ΩΩ! $
)
ΩΩ$ %
.
ΩΩ% &
AlignMiddle
ΩΩ& 1
(
ΩΩ1 2
)
ΩΩ2 3
.
ΩΩ3 4
Text
ΩΩ4 8
(
ΩΩ8 9
it
ΩΩ9 ;
.
ΩΩ; <
Etiqueta
ΩΩ< D
)
ΩΩD E
.
ΩΩE F
FontSize
ΩΩF N
(
ΩΩN O
$num
ΩΩO P
)
ΩΩP Q
;
ΩΩQ R
row
ææ 
.
ææ 
RelativeItem
ææ  
(
ææ  !
)
ææ! "
.
ææ" #
AlignMiddle
ææ# .
(
ææ. /
)
ææ/ 0
.
ææ0 1
Row
ææ1 4
(
ææ4 5
barra
ææ5 :
=>
ææ; =
{
øø 
var
¿¿ 
p
¿¿ 
=
¿¿ 
max
¿¿ 
==
¿¿  "
$num
¿¿# $
?
¿¿% &
$num
¿¿' )
:
¿¿* +
it
¿¿, .
.
¿¿. /
Cantidad
¿¿/ 7
*
¿¿8 9
$num
¿¿: >
/
¿¿? @
max
¿¿A D
;
¿¿D E
if
¡¡ 
(
¡¡ 
p
¡¡ 
>
¡¡ 
$num
¡¡ 
)
¡¡ 
barra
¡¡ $
.
¡¡$ %
RelativeItem
¡¡% 1
(
¡¡1 2
p
¡¡2 3
)
¡¡3 4
.
¡¡4 5
Height
¡¡5 ;
(
¡¡; <
$num
¡¡< >
)
¡¡> ?
.
¡¡? @

Background
¡¡@ J
(
¡¡J K
it
¡¡K M
.
¡¡M N
Color
¡¡N S
)
¡¡S T
;
¡¡T U
if
¬¬ 
(
¬¬ 
p
¬¬ 
<
¬¬ 
$num
¬¬ 
)
¬¬  
barra
¬¬! &
.
¬¬& '
RelativeItem
¬¬' 3
(
¬¬3 4
$num
¬¬4 8
-
¬¬9 :
p
¬¬; <
)
¬¬< =
.
¬¬= >
Height
¬¬> D
(
¬¬D E
$num
¬¬E G
)
¬¬G H
;
¬¬H I
}
√√ 
)
√√ 
;
√√ 
row
ƒƒ 
.
ƒƒ 
ConstantItem
ƒƒ  
(
ƒƒ  !
$num
ƒƒ! #
)
ƒƒ# $
.
ƒƒ$ %

AlignRight
ƒƒ% /
(
ƒƒ/ 0
)
ƒƒ0 1
.
ƒƒ1 2
AlignMiddle
ƒƒ2 =
(
ƒƒ= >
)
ƒƒ> ?
.
ƒƒ? @
Text
ƒƒ@ D
(
ƒƒD E
it
ƒƒE G
.
ƒƒG H
Detalle
ƒƒH O
)
ƒƒO P
.
ƒƒP Q
FontSize
ƒƒQ Y
(
ƒƒY Z
$num
ƒƒZ [
)
ƒƒ[ \
;
ƒƒ\ ]
}
≈≈ 
)
≈≈ 
;
≈≈ 
}
∆∆ 	
}
«« 
private
…… 
static
…… 
void
…… 
TablaSimple
…… #
(
……# $
ColumnDescriptor
……$ 4
col
……5 8
,
……8 9
string
……: @
[
……@ A
]
……A B
	cabeceras
……C L
,
……L M
float
……N S
[
……S T
]
……T U
anchos
……V \
,
……\ ]
List
……^ b
<
……b c
string
……c i
[
……i j
]
……j k
>
……k l
filas
……m r
,
……r s
int
……t w
[
……w x
]
……x y
?
……y z
alineadasDerecha……{ ã
=……å ç
null……é í
)……í ì
{
   
col
ÀÀ 
.
ÀÀ 
Item
ÀÀ 
(
ÀÀ 
)
ÀÀ 
.
ÀÀ 
Table
ÀÀ 
(
ÀÀ 
t
ÀÀ 
=>
ÀÀ 
{
ÃÃ 	
t
ÕÕ 
.
ÕÕ 
ColumnsDefinition
ÕÕ 
(
ÕÕ  
c
ÕÕ  !
=>
ÕÕ" $
{
ÕÕ% &
foreach
ÕÕ' .
(
ÕÕ/ 0
var
ÕÕ0 3
a
ÕÕ4 5
in
ÕÕ6 8
anchos
ÕÕ9 ?
)
ÕÕ? @
c
ÕÕA B
.
ÕÕB C
RelativeColumn
ÕÕC Q
(
ÕÕQ R
a
ÕÕR S
)
ÕÕS T
;
ÕÕT U
}
ÕÕV W
)
ÕÕW X
;
ÕÕX Y
t
œœ 
.
œœ 
Header
œœ 
(
œœ 
h
œœ 
=>
œœ 
{
–– 
for
—— 
(
—— 
var
—— 
i
—— 
=
—— 
$num
—— 
;
—— 
i
——  !
<
——" #
	cabeceras
——$ -
.
——- .
Length
——. 4
;
——4 5
i
——6 7
++
——7 9
)
——9 :
{
““ 
var
”” 
cel
”” 
=
”” 
h
”” 
.
””  
Cell
””  $
(
””$ %
)
””% &
.
””& '
Element
””' .
(
””. /
CeldaCab
””/ 7
)
””7 8
;
””8 9
if
‘‘ 
(
‘‘ 
alineadasDerecha
‘‘ (
?
‘‘( )
.
‘‘) *
Contains
‘‘* 2
(
‘‘2 3
i
‘‘3 4
)
‘‘4 5
==
‘‘6 8
true
‘‘9 =
)
‘‘= >
cel
‘‘? B
=
‘‘C D
cel
‘‘E H
.
‘‘H I

AlignRight
‘‘I S
(
‘‘S T
)
‘‘T U
;
‘‘U V
cel
’’ 
.
’’ 
Text
’’ 
(
’’ 
	cabeceras
’’ &
[
’’& '
i
’’' (
]
’’( )
)
’’) *
.
’’* +
	FontColor
’’+ 4
(
’’4 5
$str
’’5 >
)
’’> ?
.
’’? @
SemiBold
’’@ H
(
’’H I
)
’’I J
.
’’J K
FontSize
’’K S
(
’’S T
$num
’’T U
)
’’U V
;
’’V W
}
÷÷ 
}
◊◊ 
)
◊◊ 
;
◊◊ 
foreach
ŸŸ 
(
ŸŸ 
var
ŸŸ 
fila
ŸŸ 
in
ŸŸ  
filas
ŸŸ! &
)
ŸŸ& '
{
⁄⁄ 
for
€€ 
(
€€ 
var
€€ 
i
€€ 
=
€€ 
$num
€€ 
;
€€ 
i
€€  !
<
€€" #
fila
€€$ (
.
€€( )
Length
€€) /
;
€€/ 0
i
€€1 2
++
€€2 4
)
€€4 5
{
‹‹ 
var
›› 
cel
›› 
=
›› 
t
›› 
.
››  
Cell
››  $
(
››$ %
)
››% &
.
››& '
Element
››' .
(
››. /
Celda
››/ 4
)
››4 5
;
››5 6
if
ﬁﬁ 
(
ﬁﬁ 
alineadasDerecha
ﬁﬁ (
?
ﬁﬁ( )
.
ﬁﬁ) *
Contains
ﬁﬁ* 2
(
ﬁﬁ2 3
i
ﬁﬁ3 4
)
ﬁﬁ4 5
==
ﬁﬁ6 8
true
ﬁﬁ9 =
)
ﬁﬁ= >
cel
ﬁﬁ? B
=
ﬁﬁC D
cel
ﬁﬁE H
.
ﬁﬁH I

AlignRight
ﬁﬁI S
(
ﬁﬁS T
)
ﬁﬁT U
;
ﬁﬁU V
cel
ﬂﬂ 
.
ﬂﬂ 
Text
ﬂﬂ 
(
ﬂﬂ 
fila
ﬂﬂ !
[
ﬂﬂ! "
i
ﬂﬂ" #
]
ﬂﬂ# $
)
ﬂﬂ$ %
.
ﬂﬂ% &
FontSize
ﬂﬂ& .
(
ﬂﬂ. /
$num
ﬂﬂ/ 0
)
ﬂﬂ0 1
;
ﬂﬂ1 2
}
‡‡ 
}
·· 
}
‚‚ 	
)
‚‚	 

;
‚‚
 
}
„„ 
private
ÂÂ 
static
ÂÂ 
void
ÂÂ 
TablaPedidos
ÂÂ $
(
ÂÂ$ %
ColumnDescriptor
ÂÂ% 5
col
ÂÂ6 9
,
ÂÂ9 :
List
ÂÂ; ?
<
ÂÂ? @
FilaPedidoReporte
ÂÂ@ Q
>
ÂÂQ R
filas
ÂÂS X
,
ÂÂX Y
string
ÂÂZ `
tituloEstado
ÂÂa m
)
ÂÂm n
{
ÊÊ 
TablaSimple
ÁÁ 
(
ÁÁ 
col
ÁÁ 
,
ÁÁ 
[
ËË 
$str
ËË 
,
ËË 
$str
ËË  
,
ËË  !
$str
ËË" )
,
ËË) *
tituloEstado
ËË+ 7
,
ËË7 8
$str
ËË9 E
,
ËËE F
$str
ËËG T
]
ËËT U
,
ËËU V
[
ÈÈ 
$num
ÈÈ 
,
ÈÈ 
$num
ÈÈ 
,
ÈÈ 
$num
ÈÈ 
,
ÈÈ 
$num
ÈÈ #
,
ÈÈ# $
$num
ÈÈ% )
,
ÈÈ) *
$num
ÈÈ+ /
]
ÈÈ/ 0
,
ÈÈ0 1
filas
ÍÍ 
.
ÍÍ 
Select
ÍÍ 
(
ÍÍ 
f
ÍÍ 
=>
ÍÍ 
new
ÍÍ !
[
ÍÍ! "
]
ÍÍ" #
{
ÍÍ$ %
f
ÍÍ& '
.
ÍÍ' (
Codigo
ÍÍ( .
,
ÍÍ. /
f
ÍÍ0 1
.
ÍÍ1 2
Cliente
ÍÍ2 9
,
ÍÍ9 :
	FechaHora
ÍÍ; D
(
ÍÍD E
f
ÍÍE F
.
ÍÍF G
Fecha
ÍÍG L
)
ÍÍL M
,
ÍÍM N
f
ÍÍO P
.
ÍÍP Q
Estado
ÍÍQ W
,
ÍÍW X
f
ÍÍY Z
.
ÍÍZ [

Repartidor
ÍÍ[ e
,
ÍÍe f
Moneda
ÍÍg m
(
ÍÍm n
f
ÍÍn o
.
ÍÍo p

ValorTotal
ÍÍp z
)
ÍÍz {
}
ÍÍ| }
)
ÍÍ} ~
.
ÍÍ~ 
ToListÍÍ Ö
(ÍÍÖ Ü
)ÍÍÜ á
,ÍÍá à
[
ÎÎ 
$num
ÎÎ 
]
ÎÎ 
)
ÎÎ 
;
ÎÎ 
}
ÏÏ 
private
ÓÓ 
static
ÓÓ 
void
ÓÓ 
SinDatos
ÓÓ  
(
ÓÓ  !
ColumnDescriptor
ÓÓ! 1
col
ÓÓ2 5
,
ÓÓ5 6
string
ÓÓ7 =
mensaje
ÓÓ> E
)
ÓÓE F
{
ÔÔ 
col
 
.
 
Item
 
(
 
)
 
.
 
PaddingVertical
 "
(
" #
$num
# $
)
$ %
.
% &
Text
& *
(
* +
mensaje
+ 2
)
2 3
.
3 4
FontSize
4 <
(
< =
$num
= >
)
> ?
.
? @
Italic
@ F
(
F G
)
G H
.
H I
	FontColor
I R
(
R S
$str
S \
)
\ ]
;
] ^
}
ÒÒ 
private
ÛÛ 
static
ÛÛ 
byte
ÛÛ 
[
ÛÛ 
]
ÛÛ 
CrearPdf
ÛÛ "
(
ÛÛ" #
Action
ÛÛ# )
<
ÛÛ) *
PageDescriptor
ÛÛ* 8
>
ÛÛ8 9

configurar
ÛÛ: D
)
ÛÛD E
=>
ÛÛF H
Document
ÙÙ 
.
ÙÙ 
Create
ÙÙ 
(
ÙÙ 
doc
ÙÙ 
=>
ÙÙ 
{
ıı 	
doc
ˆˆ 
.
ˆˆ 
Page
ˆˆ 
(
ˆˆ 
page
ˆˆ 
=>
ˆˆ 
{
˜˜ 
page
¯¯ 
.
¯¯ 
Size
¯¯ 
(
¯¯ 
	PageSizes
¯¯ #
.
¯¯# $
A4
¯¯$ &
)
¯¯& '
;
¯¯' (
page
˘˘ 
.
˘˘ 
Margin
˘˘ 
(
˘˘ 
$num
˘˘ 
)
˘˘ 
;
˘˘  
page
˙˙ 
.
˙˙ 
DefaultTextStyle
˙˙ %
(
˙˙% &
x
˙˙& '
=>
˙˙( *
x
˙˙+ ,
.
˙˙, -
FontSize
˙˙- 5
(
˙˙5 6
$num
˙˙6 8
)
˙˙8 9
)
˙˙9 :
;
˙˙: ;

configurar
˚˚ 
(
˚˚ 
page
˚˚ 
)
˚˚  
;
˚˚  !
Pie
¸¸ 
(
¸¸ 
page
¸¸ 
)
¸¸ 
;
¸¸ 
}
˝˝ 
)
˝˝ 
;
˝˝ 
}
˛˛ 	
)
˛˛	 

.
˛˛
 
GeneratePdf
˛˛ 
(
˛˛ 
)
˛˛ 
;
˛˛ 
public
ÄÄ 

byte
ÄÄ 
[
ÄÄ 
]
ÄÄ 
ReporteNegocioPdf
ÄÄ #
(
ÄÄ# $
ReporteNegocioDto
ÄÄ$ 5
r
ÄÄ6 7
)
ÄÄ7 8
=>
ÄÄ9 ;
CrearPdf
ÄÄ< D
(
ÄÄD E
page
ÄÄE I
=>
ÄÄJ L
{
ÅÅ 
Cabecera
ÇÇ 
(
ÇÇ 
page
ÇÇ 
,
ÇÇ 
$str
ÇÇ +
,
ÇÇ+ ,
$"
ÉÉ 
$str
ÉÉ 
{
ÉÉ 
r
ÉÉ 
.
ÉÉ 
NombreNegocio
ÉÉ '
}
ÉÉ' (
"
ÉÉ( )
,
ÉÉ) *
$"
ÑÑ 
$str
ÑÑ 
{
ÑÑ 
Rango
ÑÑ 
(
ÑÑ 
r
ÑÑ 
.
ÑÑ 
Desde
ÑÑ #
,
ÑÑ# $
r
ÑÑ% &
.
ÑÑ& '
Hasta
ÑÑ' ,
)
ÑÑ, -
}
ÑÑ- .
$str
ÑÑ. ?
{
ÑÑ? @
	FechaHora
ÑÑ@ I
(
ÑÑI J
r
ÑÑJ K
.
ÑÑK L

GeneradoEn
ÑÑL V
)
ÑÑV W
}
ÑÑW X
"
ÑÑX Y
)
ÑÑY Z
;
ÑÑZ [
page
ÜÜ 
.
ÜÜ 
Content
ÜÜ 
(
ÜÜ 
)
ÜÜ 
.
ÜÜ 
Column
ÜÜ 
(
ÜÜ 
col
ÜÜ !
=>
ÜÜ" $
{
áá 	
Indicadores
àà 
(
àà 
col
àà 
,
àà 
(
ââ 
$str
ââ #
,
ââ# $
r
ââ% &
.
ââ& '
TotalPedidos
ââ' 3
.
ââ3 4
ToString
ââ4 <
(
ââ< =
Es
ââ= ?
)
ââ? @
)
ââ@ A
,
ââA B
(
ää 
$str
ää 
,
ää 
r
ää  
.
ää  !

Entregados
ää! +
.
ää+ ,
ToString
ää, 4
(
ää4 5
Es
ää5 7
)
ää7 8
)
ää8 9
,
ää9 :
(
ãã 
$str
ãã 
,
ãã 
r
ãã  
.
ãã  !

Cancelados
ãã! +
.
ãã+ ,
ToString
ãã, 4
(
ãã4 5
Es
ãã5 7
)
ãã7 8
)
ãã8 9
,
ãã9 :
(
åå 
$str
åå "
,
åå" #
r
åå$ %
.
åå% &
TasaEntrega
åå& 1
.
åå1 2
ToString
åå2 :
(
åå: ;
$str
åå; @
,
åå@ A
Es
ååB D
)
ååD E
+
ååF G
$str
ååH L
)
ååL M
,
ååM N
(
çç 
$str
çç "
,
çç" #
Moneda
çç$ *
(
çç* +
r
çç+ ,
.
çç, -
ValorEntregado
çç- ;
)
çç; <
)
çç< =
)
çç= >
;
çç> ?
Seccion
èè 
(
èè 
col
èè 
,
èè 
$str
èè -
)
èè- .
;
èè. /
Barras
êê 
(
êê 
col
êê 
,
êê 
r
êê 
.
êê 
	PorEstado
êê #
.
ëë 
Select
ëë 
(
ëë 
e
ëë 
=>
ëë 
(
ëë 
e
ëë 
.
ëë  
Estado
ëë  &
,
ëë& '
e
ëë( )
.
ëë) *
Cantidad
ëë* 2
,
ëë2 3
e
ëë4 5
.
ëë5 6
Color
ëë6 ;
,
ëë; <
$"
ëë= ?
{
ëë? @
e
ëë@ A
.
ëëA B
Cantidad
ëëB J
}
ëëJ K
$str
ëëK M
{
ëëM N
e
ëëN O
.
ëëO P

Porcentaje
ëëP Z
.
ëëZ [
ToString
ëë[ c
(
ëëc d
$str
ëëd i
,
ëëi j
Es
ëëk m
)
ëëm n
}
ëën o
$str
ëëo r
"
ëër s
)
ëës t
)
ëët u
.
íí 
ToList
íí 
(
íí 
)
íí 
)
íí 
;
íí 
Seccion
îî 
(
îî 
col
îî 
,
îî 
$str
îî *
)
îî* +
;
îî+ ,
var
ïï 
meses
ïï 
=
ïï 
r
ïï 
.
ïï 
PorMes
ïï  
.
ññ 
Select
ññ 
(
ññ 
m
ññ 
=>
ññ 
new
ññ  
[
ññ  !
]
ññ! "
{
ññ# $
m
ññ% &
.
ññ& '
Mes
ññ' *
,
ññ* +
m
ññ, -
.
ññ- .
Total
ññ. 3
.
ññ3 4
ToString
ññ4 <
(
ññ< =
Es
ññ= ?
)
ññ? @
,
ññ@ A
m
ññB C
.
ññC D

Entregados
ññD N
.
ññN O
ToString
ññO W
(
ññW X
Es
ññX Z
)
ññZ [
,
ññ[ \
m
ññ] ^
.
ññ^ _

Cancelados
ññ_ i
.
ññi j
ToString
ññj r
(
ññr s
Es
ññs u
)
ññu v
,
ññv w
Moneda
ññx ~
(
ññ~ 
mññ Ä
.ññÄ Å
ValorEntregadoññÅ è
)ññè ê
}ññë í
)ññí ì
.
óó 
ToList
óó 
(
óó 
)
óó 
;
óó 
meses
òò 
.
òò 
Add
òò 
(
òò 
[
òò 
$str
òò 
,
òò 
r
òò  !
.
òò! "
PorMes
òò" (
.
òò( )
Sum
òò) ,
(
òò, -
m
òò- .
=>
òò/ 1
m
òò2 3
.
òò3 4
Total
òò4 9
)
òò9 :
.
òò: ;
ToString
òò; C
(
òòC D
Es
òòD F
)
òòF G
,
òòG H
r
òòI J
.
òòJ K
PorMes
òòK Q
.
òòQ R
Sum
òòR U
(
òòU V
m
òòV W
=>
òòX Z
m
òò[ \
.
òò\ ]

Entregados
òò] g
)
òòg h
.
òòh i
ToString
òòi q
(
òòq r
Es
òòr t
)
òòt u
,
òòu v
r
ôô 
.
ôô 
PorMes
ôô 
.
ôô  
Sum
ôô  #
(
ôô# $
m
ôô$ %
=>
ôô& (
m
ôô) *
.
ôô* +

Cancelados
ôô+ 5
)
ôô5 6
.
ôô6 7
ToString
ôô7 ?
(
ôô? @
Es
ôô@ B
)
ôôB C
,
ôôC D
Moneda
ôôE K
(
ôôK L
r
ôôL M
.
ôôM N
PorMes
ôôN T
.
ôôT U
Sum
ôôU X
(
ôôX Y
m
ôôY Z
=>
ôô[ ]
m
ôô^ _
.
ôô_ `
ValorEntregado
ôô` n
)
ôôn o
)
ôôo p
]
ôôp q
)
ôôq r
;
ôôr s
TablaSimple
öö 
(
öö 
col
öö 
,
öö 
[
öö 
$str
öö #
,
öö# $
$str
öö% .
,
öö. /
$str
öö0 <
,
öö< =
$str
öö> J
,
ööJ K
$str
ööL ]
]
öö] ^
,
öö^ _
[
õõ 
$num
õõ 
,
õõ 
$num
õõ 
,
õõ 
$num
õõ 
,
õõ  
$num
õõ! %
,
õõ% &
$num
õõ' )
]
õõ) *
,
õõ* +
meses
õõ, 1
,
õõ1 2
[
õõ3 4
$num
õõ4 5
,
õõ5 6
$num
õõ7 8
,
õõ8 9
$num
õõ: ;
,
õõ; <
$num
õõ= >
]
õõ> ?
)
õõ? @
;
õõ@ A
Seccion
ùù 
(
ùù 
col
ùù 
,
ùù 
$str
ùù -
)
ùù- .
;
ùù. /
if
ûû 
(
ûû 
r
ûû 
.
ûû 
Pedidos
ûû 
.
ûû 
Count
ûû 
==
ûû  "
$num
ûû# $
)
ûû$ %
SinDatos
ûû& .
(
ûû. /
col
ûû/ 2
,
ûû2 3
$str
ûû4 ^
)
ûû^ _
;
ûû_ `
else
üü 
TablaPedidos
üü 
(
üü 
col
üü !
,
üü! "
r
üü# $
.
üü$ %
Pedidos
üü% ,
,
üü, -
$str
üü. 6
)
üü6 7
;
üü7 8
}
†† 	
)
††	 

;
††
 
}
°° 
)
°° 
;
°° 
public
££ 

byte
££ 
[
££ 
]
££ 
HistorialPdf
££ 
(
££  
HistorialExportDto
££ 1
h
££2 3
)
££3 4
=>
££5 7
CrearPdf
££8 @
(
££@ A
page
££A E
=>
££F H
{
§§ 
Cabecera
•• 
(
•• 
page
•• 
,
•• 
$str
•• -
,
••- .
$"
¶¶ 
$str
¶¶ 
{
¶¶ 
h
¶¶ 
.
¶¶ 
NombreNegocio
¶¶ '
}
¶¶' (
"
¶¶( )
,
¶¶) *
$"
ßß 
$str
ßß 
{
ßß 
Rango
ßß 
(
ßß 
h
ßß 
.
ßß 
Desde
ßß #
,
ßß# $
h
ßß% &
.
ßß& '
Hasta
ßß' ,
)
ßß, -
}
ßß- .
$str
ßß. ?
{
ßß? @
	FechaHora
ßß@ I
(
ßßI J
h
ßßJ K
.
ßßK L

GeneradoEn
ßßL V
)
ßßV W
}
ßßW X
"
ßßX Y
)
ßßY Z
;
ßßZ [
page
©© 
.
©© 
Content
©© 
(
©© 
)
©© 
.
©© 
Column
©© 
(
©© 
col
©© !
=>
©©" $
{
™™ 	
var
´´ 

entregados
´´ 
=
´´ 
h
´´ 
.
´´ 
Filas
´´ $
.
´´$ %
Count
´´% *
(
´´* +
f
´´+ ,
=>
´´- /
f
´´0 1
.
´´1 2
Estado
´´2 8
==
´´9 ;
EstadoPedidoInfo
´´< L
.
´´L M
Nombre
´´M S
(
´´S T
(
´´T U
int
´´U X
)
´´X Y
EstadoPedido
´´Y e
.
´´e f
	Entregado
´´f o
)
´´o p
)
´´p q
;
´´q r
Indicadores
¨¨ 
(
¨¨ 
col
¨¨ 
,
¨¨ 
(
≠≠ 
$str
≠≠ &
,
≠≠& '
h
≠≠( )
.
≠≠) *
Filas
≠≠* /
.
≠≠/ 0
Count
≠≠0 5
.
≠≠5 6
ToString
≠≠6 >
(
≠≠> ?
Es
≠≠? A
)
≠≠A B
)
≠≠B C
,
≠≠C D
(
ÆÆ 
$str
ÆÆ 
,
ÆÆ 

entregados
ÆÆ )
.
ÆÆ) *
ToString
ÆÆ* 2
(
ÆÆ2 3
Es
ÆÆ3 5
)
ÆÆ5 6
)
ÆÆ6 7
,
ÆÆ7 8
(
ØØ 
$str
ØØ 
,
ØØ 
(
ØØ  
h
ØØ  !
.
ØØ! "
Filas
ØØ" '
.
ØØ' (
Count
ØØ( -
-
ØØ. /

entregados
ØØ0 :
)
ØØ: ;
.
ØØ; <
ToString
ØØ< D
(
ØØD E
Es
ØØE G
)
ØØG H
)
ØØH I
)
ØØI J
;
ØØJ K
Seccion
±± 
(
±± 
col
±± 
,
±± 
$str
±± .
)
±±. /
;
±±/ 0
if
≤≤ 
(
≤≤ 
h
≤≤ 
.
≤≤ 
Filas
≤≤ 
.
≤≤ 
Count
≤≤ 
==
≤≤  
$num
≤≤! "
)
≤≤" #
SinDatos
≤≤$ ,
(
≤≤, -
col
≤≤- 0
,
≤≤0 1
$str
≤≤2 h
)
≤≤h i
;
≤≤i j
else
≥≥ 
TablaPedidos
≥≥ 
(
≥≥ 
col
≥≥ !
,
≥≥! "
h
≥≥# $
.
≥≥$ %
Filas
≥≥% *
,
≥≥* +
$str
≥≥, :
)
≥≥: ;
;
≥≥; <
}
¥¥ 	
)
¥¥	 

;
¥¥
 
}
µµ 
)
µµ 
;
µµ 
public
∑∑ 

byte
∑∑ 
[
∑∑ 
]
∑∑ 
ReporteAdminPdf
∑∑ !
(
∑∑! "
ReporteAdminDto
∑∑" 1
r
∑∑2 3
)
∑∑3 4
=>
∑∑5 7
CrearPdf
∑∑8 @
(
∑∑@ A
page
∑∑A E
=>
∑∑F H
{
∏∏ 
Cabecera
ππ 
(
ππ 
page
ππ 
,
ππ 
$str
ππ 9
,
ππ9 :
$"
∫∫ 
$str
∫∫ 
{
∫∫ 
Rango
∫∫ 
(
∫∫ 
r
∫∫ 
.
∫∫ 
Desde
∫∫ #
,
∫∫# $
r
∫∫% &
.
∫∫& '
Hasta
∫∫' ,
)
∫∫, -
}
∫∫- .
$str
∫∫. ?
{
∫∫? @
	FechaHora
∫∫@ I
(
∫∫I J
r
∫∫J K
.
∫∫K L

GeneradoEn
∫∫L V
)
∫∫V W
}
∫∫W X
"
∫∫X Y
)
∫∫Y Z
;
∫∫Z [
page
ºº 
.
ºº 
Content
ºº 
(
ºº 
)
ºº 
.
ºº 
Column
ºº 
(
ºº 
col
ºº !
=>
ºº" $
{
ΩΩ 	
Indicadores
ææ 
(
ææ 
col
ææ 
,
ææ 
(
øø 
$str
øø "
,
øø" #
r
øø$ %
.
øø% &!
NegociosRegistrados
øø& 9
.
øø9 :
ToString
øø: B
(
øøB C
Es
øøC E
)
øøE F
)
øøF G
,
øøG H
(
¿¿ 
$str
¿¿ )
,
¿¿) *
r
¿¿+ ,
.
¿¿, -"
NegociosActivosTotal
¿¿- A
.
¿¿A B
ToString
¿¿B J
(
¿¿J K
Es
¿¿K M
)
¿¿M N
)
¿¿N O
,
¿¿O P
(
¡¡ 
$str
¡¡ &
,
¡¡& '
r
¡¡( )
.
¡¡) *%
RepartidoresRegistrados
¡¡* A
.
¡¡A B
ToString
¡¡B J
(
¡¡J K
Es
¡¡K M
)
¡¡M N
)
¡¡N O
)
¡¡O P
;
¡¡P Q
Indicadores
¬¬ 
(
¬¬ 
col
¬¬ 
,
¬¬ 
(
√√ 
$str
√√ "
,
√√" #
r
√√$ %
.
√√% &
TotalPedidos
√√& 2
.
√√2 3
ToString
√√3 ;
(
√√; <
Es
√√< >
)
√√> ?
)
√√? @
,
√√@ A
(
ƒƒ 
$str
ƒƒ %
,
ƒƒ% &
r
ƒƒ' (
.
ƒƒ( )
PedidosEntregados
ƒƒ) :
.
ƒƒ: ;
ToString
ƒƒ; C
(
ƒƒC D
Es
ƒƒD F
)
ƒƒF G
)
ƒƒG H
,
ƒƒH I
(
≈≈ 
$str
≈≈ "
,
≈≈" #
Moneda
≈≈$ *
(
≈≈* +
r
≈≈+ ,
.
≈≈, -
ValorEntregado
≈≈- ;
)
≈≈; <
)
≈≈< =
)
≈≈= >
;
≈≈> ?
Seccion
«« 
(
«« 
col
«« 
,
«« 
$str
«« 2
)
««2 3
;
««3 4
Barras
»» 
(
»» 
col
»» 
,
»» 
r
»» 
.
»» 
NegociosPorMes
»» (
.
»»( )
Select
»») /
(
»»/ 0
m
»»0 1
=>
»»2 4
(
»»5 6
m
»»6 7
.
»»7 8
Mes
»»8 ;
,
»»; <
m
»»= >
.
»»> ?
Total
»»? D
,
»»D E
AzulHex
»»F M
,
»»M N
m
»»O P
.
»»P Q
Total
»»Q V
.
»»V W
ToString
»»W _
(
»»_ `
Es
»»` b
)
»»b c
)
»»c d
)
»»d e
.
»»e f
ToList
»»f l
(
»»l m
)
»»m n
)
»»n o
;
»»o p
Seccion
   
(
   
col
   
,
   
$str
   ?
)
  ? @
;
  @ A
if
ÀÀ 
(
ÀÀ 
r
ÀÀ 
.
ÀÀ 
NegociosPorEstado
ÀÀ #
.
ÀÀ# $
Count
ÀÀ$ )
==
ÀÀ* ,
$num
ÀÀ- .
)
ÀÀ. /
SinDatos
ÀÀ0 8
(
ÀÀ8 9
col
ÀÀ9 <
,
ÀÀ< =
$str
ÀÀ> c
)
ÀÀc d
;
ÀÀd e
else
ÃÃ 
Barras
ÃÃ 
(
ÃÃ 
col
ÃÃ 
,
ÃÃ 
r
ÃÃ 
.
ÃÃ 
NegociosPorEstado
ÃÃ 0
.
ÕÕ 
Select
ÕÕ 
(
ÕÕ 
e
ÕÕ 
=>
ÕÕ 
(
ÕÕ 
e
ÕÕ 
.
ÕÕ  
Etiqueta
ÕÕ  (
,
ÕÕ( )
e
ÕÕ* +
.
ÕÕ+ ,
Cantidad
ÕÕ, 4
,
ÕÕ4 5
e
ÕÕ6 7
.
ÕÕ7 8
Color
ÕÕ8 =
,
ÕÕ= >
$"
ÕÕ? A
{
ÕÕA B
e
ÕÕB C
.
ÕÕC D
Cantidad
ÕÕD L
}
ÕÕL M
$str
ÕÕM O
{
ÕÕO P
e
ÕÕP Q
.
ÕÕQ R

Porcentaje
ÕÕR \
.
ÕÕ\ ]
ToString
ÕÕ] e
(
ÕÕe f
$str
ÕÕf k
,
ÕÕk l
Es
ÕÕm o
)
ÕÕo p
}
ÕÕp q
$str
ÕÕq t
"
ÕÕt u
)
ÕÕu v
)
ÕÕv w
.
ŒŒ 
ToList
ŒŒ 
(
ŒŒ 
)
ŒŒ 
)
ŒŒ 
;
ŒŒ 
Seccion
–– 
(
–– 
col
–– 
,
–– 
$str
–– @
)
––@ A
;
––A B
if
—— 
(
—— 
r
—— 
.
—— "
NegociosPorActividad
—— &
.
——& '
Count
——' ,
==
——- /
$num
——0 1
)
——1 2
SinDatos
——3 ;
(
——; <
col
——< ?
,
——? @
$str
——A f
)
——f g
;
——g h
else
““ 
Barras
““ 
(
““ 
col
““ 
,
““ 
r
““ 
.
““ "
NegociosPorActividad
““ 3
.
”” 
Select
”” 
(
”” 
e
”” 
=>
”” 
(
”” 
e
”” 
.
””  
Etiqueta
””  (
,
””( )
e
””* +
.
””+ ,
Cantidad
””, 4
,
””4 5
e
””6 7
.
””7 8
Color
””8 =
,
””= >
$"
””? A
{
””A B
e
””B C
.
””C D
Cantidad
””D L
}
””L M
$str
””M O
{
””O P
e
””P Q
.
””Q R

Porcentaje
””R \
.
””\ ]
ToString
””] e
(
””e f
$str
””f k
,
””k l
Es
””m o
)
””o p
}
””p q
$str
””q t
"
””t u
)
””u v
)
””v w
.
‘‘ 
ToList
‘‘ 
(
‘‘ 
)
‘‘ 
)
‘‘ 
;
‘‘ 
Seccion
÷÷ 
(
÷÷ 
col
÷÷ 
,
÷÷ 
$str
÷÷ >
)
÷÷> ?
;
÷÷? @
Barras
◊◊ 
(
◊◊ 
col
◊◊ 
,
◊◊ 
r
◊◊ 
.
◊◊ 
PedidosPorEstado
◊◊ *
.
ÿÿ 
Select
ÿÿ 
(
ÿÿ 
e
ÿÿ 
=>
ÿÿ 
(
ÿÿ 
e
ÿÿ 
.
ÿÿ  
Estado
ÿÿ  &
,
ÿÿ& '
e
ÿÿ( )
.
ÿÿ) *
Cantidad
ÿÿ* 2
,
ÿÿ2 3
e
ÿÿ4 5
.
ÿÿ5 6
Color
ÿÿ6 ;
,
ÿÿ; <
$"
ÿÿ= ?
{
ÿÿ? @
e
ÿÿ@ A
.
ÿÿA B
Cantidad
ÿÿB J
}
ÿÿJ K
$str
ÿÿK M
{
ÿÿM N
e
ÿÿN O
.
ÿÿO P

Porcentaje
ÿÿP Z
.
ÿÿZ [
ToString
ÿÿ[ c
(
ÿÿc d
$str
ÿÿd i
,
ÿÿi j
Es
ÿÿk m
)
ÿÿm n
}
ÿÿn o
$str
ÿÿo r
"
ÿÿr s
)
ÿÿs t
)
ÿÿt u
.
ŸŸ 
ToList
ŸŸ 
(
ŸŸ 
)
ŸŸ 
)
ŸŸ 
;
ŸŸ 
Seccion
€€ 
(
€€ 
col
€€ 
,
€€ 
$str
€€ :
)
€€: ;
;
€€; <
if
‹‹ 
(
‹‹ 
r
‹‹ 
.
‹‹ 
TopNegocios
‹‹ 
.
‹‹ 
Count
‹‹ #
==
‹‹$ &
$num
‹‹' (
)
‹‹( )
SinDatos
‹‹* 2
(
‹‹2 3
col
‹‹3 6
,
‹‹6 7
$str
‹‹8 b
)
‹‹b c
;
‹‹c d
else
›› 
TablaSimple
›› 
(
›› 
col
››  
,
››  !
[
››" #
$str
››# ,
,
››, -
$str
››. 7
,
››7 8
$str
››9 E
,
››E F
$str
››G X
]
››X Y
,
››Y Z
[
››[ \
$num
››\ ^
,
››^ _
$num
››` b
,
››b c
$num
››d h
,
››h i
$num
››j l
]
››l m
,
››m n
r
ﬁﬁ 
.
ﬁﬁ 
TopNegocios
ﬁﬁ 
.
ﬁﬁ 
Select
ﬁﬁ $
(
ﬁﬁ$ %
t
ﬁﬁ% &
=>
ﬁﬁ' )
new
ﬁﬁ* -
[
ﬁﬁ- .
]
ﬁﬁ. /
{
ﬁﬁ0 1
t
ﬁﬁ2 3
.
ﬁﬁ3 4
Nombre
ﬁﬁ4 :
,
ﬁﬁ: ;
t
ﬁﬁ< =
.
ﬁﬁ= >
Pedidos
ﬁﬁ> E
.
ﬁﬁE F
ToString
ﬁﬁF N
(
ﬁﬁN O
Es
ﬁﬁO Q
)
ﬁﬁQ R
,
ﬁﬁR S
t
ﬁﬁT U
.
ﬁﬁU V

Entregados
ﬁﬁV `
.
ﬁﬁ` a
ToString
ﬁﬁa i
(
ﬁﬁi j
Es
ﬁﬁj l
)
ﬁﬁl m
,
ﬁﬁm n
Moneda
ﬁﬁo u
(
ﬁﬁu v
t
ﬁﬁv w
.
ﬁﬁw x
ValorEntregadoﬁﬁx Ü
)ﬁﬁÜ á
}ﬁﬁà â
)ﬁﬁâ ä
.ﬁﬁä ã
ToListﬁﬁã ë
(ﬁﬁë í
)ﬁﬁí ì
,ﬁﬁì î
[
ﬂﬂ 
$num
ﬂﬂ 
,
ﬂﬂ 
$num
ﬂﬂ 
,
ﬂﬂ 
$num
ﬂﬂ 
]
ﬂﬂ 
)
ﬂﬂ 
;
ﬂﬂ 
Seccion
·· 
(
·· 
col
·· 
,
·· 
$str
·· >
)
··> ?
;
··? @
if
‚‚ 
(
‚‚ 
r
‚‚ 
.
‚‚ 
Negocios
‚‚ 
.
‚‚ 
Count
‚‚  
==
‚‚! #
$num
‚‚$ %
)
‚‚% &
SinDatos
‚‚' /
(
‚‚/ 0
col
‚‚0 3
,
‚‚3 4
$str
‚‚5 Z
)
‚‚Z [
;
‚‚[ \
else
„„ 
TablaSimple
„„ 
(
„„ 
col
„„  
,
„„  !
[
„„" #
$str
„„# ,
,
„„, -
$str
„„. 9
,
„„9 :
$str
„„; E
,
„„E F
$str
„„G Q
,
„„Q R
$str
„„S [
]
„„[ \
,
„„\ ]
[
„„^ _
$num
„„_ c
,
„„c d
$num
„„e g
,
„„g h
$num
„„i m
,
„„m n
$num
„„o s
,
„„s t
$num
„„u y
]
„„y z
,
„„z {
r
‰‰ 
.
‰‰ 
Negocios
‰‰ 
.
‰‰ 
Select
‰‰ !
(
‰‰! "
n
‰‰" #
=>
‰‰$ &
new
‰‰' *
[
‰‰* +
]
‰‰+ ,
{
‰‰- .
n
‰‰/ 0
.
‰‰0 1
Nombre
‰‰1 7
,
‰‰7 8
n
‰‰9 :
.
‰‰: ;
	Actividad
‰‰; D
,
‰‰D E
n
‰‰F G
.
‰‰G H
	Documento
‰‰H Q
,
‰‰Q R
Fecha
‰‰S X
(
‰‰X Y
n
‰‰Y Z
.
‰‰Z [
FechaRegistro
‰‰[ h
)
‰‰h i
,
‰‰i j
n
‰‰k l
.
‰‰l m
Estado
‰‰m s
}
‰‰t u
)
‰‰u v
.
‰‰v w
ToList
‰‰w }
(
‰‰} ~
)
‰‰~ 
)‰‰ Ä
;‰‰Ä Å
}
ÂÂ 	
)
ÂÂ	 

;
ÂÂ
 
}
ÊÊ 
)
ÊÊ 
;
ÊÊ 
}ÁÁ ≤C
XC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\EmailSmtpService.cs
	namespace 	
Gtrack
 
; 
public 
class 
EmailSmtpService 
( 
IConfiguration		 
config		 
,		 
IWebHostEnvironment

 
entorno

 
,

  
ILogger 
< 
EmailSmtpService 
> 
logger $
)$ %
:& '
IEmailService( 5
{ 
public 

Task 
EnviarAsync 
( 
string "
para# '
,' (
string) /
asunto0 6
,6 7
string8 >
cuerpo? E
)E F
=>G I
EnviarAsync 
( 
para 
, 
asunto  
,  !
PlantillaCorreo" 1
.1 2

DesdeTexto2 <
(< =
asunto= C
,C D
cuerpoE K
)K L
)L M
;M N
public 

async 
Task 
EnviarAsync !
(! "
string" (
para) -
,- .
string/ 5
asunto6 <
,< =

CorreoHtml> H
correoI O
)O P
{ 
var 
host 
= 
config 
[ 
$str &
]& '
??( *
$str+ ;
;; <
var 
port 
= 
int 
. 
TryParse 
(  
config  &
[& '
$str' 3
]3 4
,4 5
out6 9
var: =
puerto> D
)D E
?F G
puertoH N
:O P
$numQ T
;T U
var 
user 
= 
config 
[ 
$str &
]& '
??( *
config+ 1
[1 2
$str2 A
]A B
??C E
throwF K
newL O%
InvalidOperationExceptionP i
(i j
$strj |
)| }
;} ~
var 
pass 
= 
config 
[ 
$str *
]* +
??, .
throw/ 4
new5 8%
InvalidOperationException9 R
(R S
$strS i
)i j
;j k
var 
from 
= 
config 
[ 
$str &
]& '
??( *
user+ /
;/ 0
var 
	remitente 
= 
config 
[ 
$str 6
]6 7
??8 :
$str; C
;C D
using 
var 
msg 
= 
new 
MailMessage '
{ 	
From 
= 
new 
MailAddress "
(" #
from# '
,' (
	remitente) 2
,2 3
Encoding4 <
.< =
UTF8= A
)A B
,B C
Subject 
= 
asunto 
, 
SubjectEncoding 
= 
Encoding &
.& '
UTF8' +
,+ ,
BodyEncoding 
= 
Encoding #
.# $
UTF8$ (
}   	
;  	 

msg!! 
.!! 
To!! 
.!! 
Add!! 
(!! 
new!! 
MailAddress!! "
(!!" #
para!!# '
)!!' (
)!!( )
;!!) *
msg$$ 
.$$ 
AlternateViews$$ 
.$$ 
Add$$ 
($$ 
AlternateView$$ ,
.$$, -)
CreateAlternateViewFromString$$- J
($$J K
correo$$K Q
.$$Q R
Texto$$R W
,$$W X
Encoding$$Y a
.$$a b
UTF8$$b f
,$$f g
MediaTypeNames$$h v
.$$v w
Text$$w {
.$${ |
Plain	$$| Å
)
$$Å Ç
)
$$Ç É
;
$$É Ñ
var&& 
	vistaHtml&& 
=&& 
AlternateView&& %
.&&% &)
CreateAlternateViewFromString&&& C
(&&C D
correo&&D J
.&&J K
Html&&K O
,&&O P
Encoding&&Q Y
.&&Y Z
UTF8&&Z ^
,&&^ _
MediaTypeNames&&` n
.&&n o
Text&&o s
.&&s t
Html&&t x
)&&x y
;&&y z
var'' 
logo'' 
='' 
await'' 
LeerLogoAsync'' &
(''& '
)''' (
;''( )
if(( 

((( 
logo(( 
is(( 
not(( 
null(( 
)(( 
{)) 	
	vistaHtml** 
.** 
LinkedResources** %
.**% &
Add**& )
(**) *
new*** -
LinkedResource**. <
(**< =
new**= @
MemoryStream**A M
(**M N
logo**N R
)**R S
,**S T
$str**U `
)**` a
{++ 
	ContentId,, 
=,, 
PlantillaCorreo,, +
.,,+ ,
ContentIdLogo,,, 9
,,,9 :
TransferEncoding--  
=--! "
TransferEncoding--# 3
.--3 4
Base64--4 :
}.. 
).. 
;.. 
}// 	
msg00 
.00 
AlternateViews00 
.00 
Add00 
(00 
	vistaHtml00 (
)00( )
;00) *
using22 
var22 
smtp22 
=22 
new22 

SmtpClient22 '
(22' (
host22( ,
,22, -
port22. 2
)222 3
{33 	
	EnableSsl44 
=44 
true44 
,44 
DeliveryMethod55 
=55 
SmtpDeliveryMethod55 /
.55/ 0
Network550 7
,557 8!
UseDefaultCredentials66 !
=66" #
false66$ )
,66) *
Credentials77 
=77 
new77 
NetworkCredential77 /
(77/ 0
user770 4
,774 5
pass776 :
)77: ;
}88 	
;88	 

await:: 
smtp:: 
.:: 
SendMailAsync::  
(::  !
msg::! $
)::$ %
;::% &
if;; 

(;; 
logger;; 
.;; 
	IsEnabled;; 
(;; 
LogLevel;; %
.;;% &
Information;;& 1
);;1 2
);;2 3
logger<< 
.<< 
LogInformation<< !
(<<! "
$str<<" E
,<<E F
para<<G K
,<<K L
asunto<<M S
)<<S T
;<<T U
}== 
private@@ 
async@@ 
Task@@ 
<@@ 
byte@@ 
[@@ 
]@@ 
?@@ 
>@@ 
LeerLogoAsync@@  -
(@@- .
)@@. /
{AA 
varBB 
carpetaBB 
=BB 
PathBB 
.BB 
CombineBB "
(BB" #
entornoBB# *
.BB* +
WebRootPathBB+ 6
??BB7 9
PathBB: >
.BB> ?
CombineBB? F
(BBF G
entornoBBG N
.BBN O
ContentRootPathBBO ^
,BB^ _
$strBB` i
)BBi j
,BBj k
$strBBl t
)BBt u
;BBu v
foreachCC 
(CC 
varCC 
archivoCC 
inCC 
newCC  #
[CC# $
]CC$ %
{CC& '
$strCC( @
,CC@ A
$strCCB S
}CCT U
)CCU V
{DD 	
varEE 
rutaEE 
=EE 
PathEE 
.EE 
CombineEE #
(EE# $
carpetaEE$ +
,EE+ ,
archivoEE- 4
)EE4 5
;EE5 6
ifFF 
(FF 
FileFF 
.FF 
ExistsFF 
(FF 
rutaFF  
)FF  !
)FF! "
returnFF# )
awaitFF* /
FileFF0 4
.FF4 5
ReadAllBytesAsyncFF5 F
(FFF G
rutaFFG K
)FFK L
;FFL M
}GG 	
loggerII 
.II 

LogWarningII 
(II 
$strII Z
,IIZ [
carpetaII\ c
)IIc d
;IId e
returnJJ 
nullJJ 
;JJ 
}KK 
}LL ‡
^C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\EmailDesarrolloService.cs
	namespace 	
Gtrack
 
; 
public 
class "
EmailDesarrolloService #
(# $
ILogger$ +
<+ ,"
EmailDesarrolloService, B
>B C
loggerD J
)J K
:L M
IEmailServiceN [
{ 
public 

Task 
EnviarAsync 
( 
string "
para# '
,' (
string) /
asunto0 6
,6 7
string8 >
cuerpo? E
)E F
=>G I
EnviarAsync 
( 
para 
, 
asunto  
,  !
PlantillaCorreo" 1
.1 2

DesdeTexto2 <
(< =
asunto= C
,C D
cuerpoE K
)K L
)L M
;M N
public		 

Task		 
EnviarAsync		 
(		 
string		 "
para		# '
,		' (
string		) /
asunto		0 6
,		6 7

CorreoHtml		8 B
correo		C I
)		I J
{

 
if 

( 
logger 
. 
	IsEnabled 
( 
LogLevel %
.% &
Information& 1
)1 2
)2 3
logger 
. 
LogInformation !
(! "
$str" P
,P Q
paraR V
,V W
asuntoX ^
,^ _
Environment` k
.k l
NewLinel s
,s t
correou {
.{ |
Texto	| Å
)
Å Ç
;
Ç É
return 
Task 
. 
CompletedTask !
;! "
} 
} Ó;
SC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\AuthService.cs
	namespace 	
Gtrack
 
; 
public 
class 
AuthService 
( 
IUsuarioRepository +
repo, 0
,0 1
IPasswordHasher2 A
<A B
UsuarioB I
>I J
hasherK Q
)Q R
:S T
IAuthServiceU a
{ 
private 
const 
int 
MaxIntentos !
=" #
$num$ %
;% &
private 
const 
int 
MinutosBloqueo $
=% &
$num' )
;) *
private		 
const		 
string		 
MsgGenerico		 $
=		% &
$str		' I
;		I J
public 

async 
Task 
< 
( 
Usuario 
? 
Usuario  '
,' (
string) /
?/ 0
Error1 6
)6 7
>7 8
IniciarSesionAsync9 K
(K L
LoginDtoL T
dtoU X
)X Y
{ 
var 
usuario 
= 
await 
repo  
.  !,
 ObtenerPorIdentificadorYRolAsync! A
(A B
dtoB E
.E F
IdentificadorF S
.S T
TrimT X
(X Y
)Y Z
,Z [
dto\ _
._ `
Rol` c
)c d
;d e
if 

( 
usuario 
is 
null 
) 
return #
($ %
null% )
,) *
MsgGenerico+ 6
)6 7
;7 8
if 

( 
usuario 
. 
Estado 
== 
EstadoCuenta *
.* +
PendienteActivacion+ >
)> ?
return 
( 
null 
, 
$str	 î
)
î ï
;
ï ñ
var 
ahora 
= 
DateTime 
. 
UtcNow #
;# $
if 

( 
usuario 
. 
BloqueadoHasta "
is# %
{& '
}( )
hasta* /
)/ 0
{ 	
if 
( 
hasta 
> 
ahora 
) 
{ 
var 
minutos 
= 
( 
int "
)" #
Math# '
.' (
Ceiling( /
(/ 0
(0 1
hasta1 6
-7 8
ahora9 >
)> ?
.? @
TotalMinutes@ L
)L M
;M N
return 
( 
null 
, 
$"  
$str  r
{r s
minutoss z
}z {
$str	{ Ü
"
Ü á
)
á à
;
à â
}   
usuario!! 
.!! 
BloqueadoHasta!! "
=!!# $
null!!% )
;!!) *
usuario"" 
."" 
IntentosFallidos"" $
=""% &
$num""' (
;""( )
await## 
repo## 
.## 
ActualizarAsync## &
(##& '
usuario##' .
)##. /
;##/ 0
}$$ 	
var'' 
	resultado'' 
='' 
hasher'' 
.''  
VerifyHashedPassword'' 3
(''3 4
usuario''4 ;
,''; <
usuario''= D
.''D E
PasswordHash''E Q
,''Q R
dto''S V
.''V W
Password''W _
)''_ `
;''` a
if(( 

((( 
	resultado(( 
==(( &
PasswordVerificationResult(( 3
.((3 4
Failed((4 :
)((: ;
{)) 	
usuario** 
.** 
IntentosFallidos** $
++**$ &
;**& '
string++ 
error++ 
=++ 
MsgGenerico++ &
;++& '
if-- 
(-- 
usuario-- 
.-- 
IntentosFallidos-- (
>=--) +
MaxIntentos--, 7
)--7 8
{.. 
usuario// 
.// 
BloqueadoHasta// &
=//' (
ahora//) .
.//. /

AddMinutes/// 9
(//9 :
MinutosBloqueo//: H
)//H I
;//I J
usuario00 
.00 
IntentosFallidos00 (
=00) *
$num00+ ,
;00, -
error11 
=11 
$"11 
$str11 $
{11$ %
MaxIntentos11% 0
}110 1
$str111 g
{11g h
MinutosBloqueo11h v
}11v w
$str	11w Ä
"
11Ä Å
;
11Å Ç
}22 
await44 
repo44 
.44 
ActualizarAsync44 &
(44& '
usuario44' .
)44. /
;44/ 0
return55 
(55 
null55 
,55 
error55 
)55  
;55  !
}66 	
var99 

hayCambios99 
=99 
usuario99  
.99  !
IntentosFallidos99! 1
!=992 4
$num995 6
||997 9
usuario99: A
.99A B
BloqueadoHasta99B P
is99Q S
not99T W
null99X \
;99\ ]
usuario:: 
.:: 
IntentosFallidos::  
=::! "
$num::# $
;::$ %
usuario;; 
.;; 
BloqueadoHasta;; 
=;;  
null;;! %
;;;% &
if?? 

(?? 
	resultado?? 
==?? &
PasswordVerificationResult?? 3
.??3 4
SuccessRehashNeeded??4 G
)??G H
{@@ 	
usuarioAA 
.AA 
PasswordHashAA  
=AA! "
hasherAA# )
.AA) *
HashPasswordAA* 6
(AA6 7
usuarioAA7 >
,AA> ?
dtoAA@ C
.AAC D
PasswordAAD L
)AAL M
;AAM N

hayCambiosBB 
=BB 
trueBB 
;BB 
}CC 	
ifEE 

(EE 

hayCambiosEE 
)EE 
awaitFF 
repoFF 
.FF 
ActualizarAsyncFF &
(FF& '
usuarioFF' .
)FF. /
;FF/ 0
returnII 
usuarioII 
.II 
EstadoII 
switchII $
{JJ 	
EstadoCuentaKK 
.KK 
ActivoKK 
=>KK  "
(KK# $
usuarioKK$ +
,KK+ ,
nullKK- 1
)KK1 2
,KK2 3
EstadoCuentaLL 
.LL 
PendienteValidacionLL ,
=>LL- /
(LL0 1
nullLL1 5
,LL5 6
$strLL7 o
)LLo p
,LLp q
EstadoCuentaMM 
.MM 

SuspendidoMM #
=>MM$ &
(MM' (
nullMM( ,
,MM, -
$strMM. Q
)MMQ R
,MMR S
EstadoCuentaNN 
.NN 
	RechazadoNN "
=>NN# %
(NN& '
nullNN' +
,NN+ ,
$"NN- /
$strNN/ c
{NNc d
usuarioNNd k
.NNk l
MotivoRechazoNNl y
}NNy z
"NNz {
)NN{ |
,NN| }
_OO 
=>OO 
(OO 
nullOO 
,OO 
MsgGenericoOO #
)OO# $
}PP 	
;PP	 

}QQ 
}RR ˜r
]C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\AdministracionService.cs
	namespace 	
Gtrack
 
; 
public 
	interface "
IAdministracionService '
{ 
Task 
< 	
List	 
< 
NegocioAdminDto 
> 
> 
ListarNegociosAsync  3
(3 4
)4 5
;5 6
Task

 
<

 	
(

	 

bool


 
Ok

 
,

 
bool

 
CorreoEnviado

 %
)

% &
>

& '
AprobarNegocioAsync

( ;
(

; <
int

< ?
	negocioId

@ I
,

I J
string

K Q
urlLogin

R Z
)

Z [
;

[ \
Task 
< 	
List	 
< 
AdministradorDto 
> 
>  &
ListarAdministradoresAsync! ;
(; <
)< =
;= >
Task 
< 	
ResultadoRegistro	 
> '
RegistrarAdministradorAsync 7
(7 8$
RegistroAdministradorDto8 P
dtoQ T
,T U
FuncV Z
<Z [
string[ a
,a b
stringc i
>i j
construirEnlacek z
)z {
;{ |
Task 
< 	
(	 

bool
 
Ok 
, 
string 
Mensaje !
)! "
>" ##
ReenviarActivacionAsync$ ;
(; <
int< ?
	usuarioId@ I
,I J
FuncK O
<O P
stringP V
,V W
stringX ^
>^ _
construirEnlace` o
)o p
;p q
} 
public 
class !
AdministracionService "
(" #%
IAdministracionRepository 
admins $
,$ %
INegocioRepository 
negocios 
,  
IUsuarioRepository 
usuarios 
,  $
IActivacionCuentaService 

activacion '
,' (
IEmailService 
email 
, 
ILogger 
< !
AdministracionService !
>! "
logger# )
)) *
:+ ,"
IAdministracionService- C
{ 
private 
const 
int '
MaxCorreosActivacionPorHora 1
=2 3
$num4 5
;5 6
public   

Task   
<   
List   
<   
NegocioAdminDto   $
>  $ %
>  % &
ListarNegociosAsync  ' :
(  : ;
)  ; <
=>  = ?
admins  @ F
.  F G
ListarNegociosAsync  G Z
(  Z [
)  [ \
;  \ ]
public!! 

Task!! 
<!! 
List!! 
<!! 
AdministradorDto!! %
>!!% &
>!!& '&
ListarAdministradoresAsync!!( B
(!!B C
)!!C D
=>!!E G
admins!!H N
.!!N O&
ListarAdministradoresAsync!!O i
(!!i j
)!!j k
;!!k l
public$$ 

async$$ 
Task$$ 
<$$ 
($$ 
bool$$ 
Ok$$ 
,$$ 
bool$$  $
CorreoEnviado$$% 2
)$$2 3
>$$3 4
AprobarNegocioAsync$$5 H
($$H I
int$$I L
	negocioId$$M V
,$$V W
string$$X ^
urlLogin$$_ g
)$$g h
{%% 
if&& 

(&& 
!&& 
await&& 
admins&& 
.&& 
AprobarNegocioAsync&& -
(&&- .
	negocioId&&. 7
)&&7 8
)&&8 9
return&&: @
(&&A B
false&&B G
,&&G H
false&&I N
)&&N O
;&&O P
var(( 
negocio(( 
=(( 
await(( 
negocios(( $
.(($ %
BuscarPorIdAsync((% 5
(((5 6
	negocioId((6 ?
)((? @
;((@ A
var)) 
usuario)) 
=)) 
negocio)) 
is))  
null))! %
?))& '
null))( ,
:))- .
await))/ 4
usuarios))5 =
.))= >
ObtenerPorIdAsync))> O
())O P
negocio))P W
.))W X
	UsuarioId))X a
)))a b
;))b c
if** 

(** 
negocio** 
is** 
null** 
||** 
usuario** &
is**' )
null*** .
)**. /
return**0 6
(**7 8
true**8 <
,**< =
false**> C
)**C D
;**D E
try-- 
{.. 	
await// 
email// 
.// 
EnviarAsync// #
(//# $
usuario//$ +
.//+ ,
Correo//, 2
,//2 3
$str//4 W
,//W X
PlantillaCorreo//Y h
.//h i
Crear//i n
(//n o
etiqueta00 
:00 
$str00 +
,00+ ,
titulo11 
:11 
$str11 5
,115 6
saludo22 
:22 
$"22 
$str22  
{22  !
negocio22! (
.22( )
Nombre22) /
}22/ 0
"220 1
,221 2
parrafos33 
:33 
[44 
$str55 e
,55e f
$str66 
]77 
,77 
datos88 
:88 
[88 
(88 
$str88 "
,88" #
negocio88$ +
.88+ ,
Nombre88, 2
)882 3
,883 4
(885 6
$str886 >
,88> ?
usuario88@ G
.88G H
Correo88H N
)88N O
,88O P
(88Q R
$str88R ]
,88] ^
usuario88_ f
.88f g
	Documento88g p
)88p q
,88q r
(88s t
$str88t |
,88| }
$str	88~ Ü
)
88Ü á
]
88á à
,
88à â

textoBoton99 
:99 
$str99 ,
,99, -
urlBoton:: 
::: 
urlLogin:: "
,::" #
nota;; 
:;; 
$str;; 
,	;; Ä
tipoNota<< 
:<< 
TipoNota<< "
.<<" #
Exito<<# (
,<<( )
resumen== 
:== 
$"== 
{== 
negocio== #
.==# $
Nombre==$ *
}==* +
$str==+ ]
"==] ^
)==^ _
)==_ `
;==` a
return>> 
(>> 
true>> 
,>> 
true>> 
)>> 
;>>  
}?? 	
catch@@ 
(@@ 
	Exception@@ 
ex@@ 
)@@ 
{AA 	
loggerBB 
.BB 
LogErrorBB 
(BB 
exBB 
,BB 
$strBB  d
,BBd e
negocioBBf m
.BBm n
NombreBBn t
)BBt u
;BBu v
returnCC 
(CC 
trueCC 
,CC 
falseCC 
)CC  
;CC  !
}DD 	
}EE 
publicHH 

asyncHH 
TaskHH 
<HH 
ResultadoRegistroHH '
>HH' ('
RegistrarAdministradorAsyncHH) D
(HHD E$
RegistroAdministradorDtoHHE ]
dtoHH^ a
,HHa b
FuncHHc g
<HHg h
stringHHh n
,HHn o
stringHHp v
>HHv w
construirEnlace	HHx á
)
HHá à
{II 
varJJ 
	documentoJJ 
=JJ 
dtoJJ 
.JJ 
	DocumentoJJ %
.JJ% &
TrimJJ& *
(JJ* +
)JJ+ ,
;JJ, -
varKK 
correoKK 
=KK 
dtoKK 
.KK 
CorreoKK 
.KK  
TrimKK  $
(KK$ %
)KK% &
;KK& '
varLL 
telefonoLL 
=LL 
dtoLL 
.LL 
TelefonoLL #
.LL# $
TrimLL$ (
(LL( )
)LL) *
;LL* +
ifOO 

(OO 
awaitOO 
negociosOO 
.OO  
ExisteDocumentoAsyncOO /
(OO/ 0
	documentoOO0 9
)OO9 :
||OO; =
awaitOO> C
usuariosOOD L
.OOL M!
ObtenerPorCorreoAsyncOOM b
(OOb c
correoOOc i
)OOi j
isOOk m
notOOn q
nullOOr v
)OOv w
returnPP 
newPP 
(PP 
falsePP 
,PP 
$strPP R
,PPR S
falsePPT Y
,PPY Z
nullPP[ _
)PP_ `
;PP` a
ifQQ 

(QQ 
awaitQQ 
adminsQQ 
.QQ 
TelefonoEnUsoAsyncQQ +
(QQ+ ,
telefonoQQ, 4
)QQ4 5
)QQ5 6
returnRR 
newRR 
(RR 
falseRR 
,RR 
$strRR L
,RRL M
falseRRN S
,RRS T
nullRRU Y
)RRY Z
;RRZ [
varVV 
usuarioVV 
=VV 
newVV 
UsuarioVV !
{WW 	
CorreoXX 
=XX 
correoXX 
,XX 
	DocumentoYY 
=YY 
	documentoYY !
,YY! "
PasswordHashZZ 
=ZZ 
$strZZ 
,ZZ 
Rol[[ 
=[[ 

RolUsuario[[ 
.[[ 
Administrador[[ *
,[[* +
Estado\\ 
=\\ 
EstadoCuenta\\ !
.\\! "
PendienteActivacion\\" 5
}]] 	
;]]	 

var__ 
admin__ 
=__ 
new__ 
Administrador__ %
{__& '
NombreCompleto__( 6
=__7 8
dto__9 <
.__< =
NombreCompleto__= K
.__K L
Trim__L P
(__P Q
)__Q R
,__R S
Telefono__T \
=__] ^
telefono___ g
}__h i
;__i j
tryaa 
{bb 	
awaitcc 
adminscc 
.cc '
RegistrarAdministradorAsynccc 4
(cc4 5
usuariocc5 <
,cc< =
admincc> C
)ccC D
;ccD E
}dd 	
catchee 
(ee 
DbUpdateExceptionee  
exee! #
)ee# $
{ff 	
loggergg 
.gg 
LogErrorgg 
(gg 
exgg 
,gg 
$strgg  N
,ggN O
correoggP V
)ggV W
;ggW X
returnhh 
newhh 
(hh 
falsehh 
,hh 
$strhh ]
,hh] ^
falsehh_ d
,hhd e
nullhhf j
)hhj k
;hhk l
}ii 	
varll 
enviadoll 
=ll 
awaitll 

activacionll &
.ll& '
EnviarEnlaceAsyncll' 8
(ll8 9
usuarioll9 @
,ll@ A
adminllB G
.llG H
NombreCompletollH V
,llV W
nullllX \
,ll\ ]
construirEnlacell^ m
)llm n
;lln o
returnmm 
newmm 
(mm 
truemm 
,mm 
nullmm 
,mm 
enviadomm &
,mm& '
nullmm( ,
)mm, -
;mm- .
}nn 
publicpp 

asyncpp 
Taskpp 
<pp 
(pp 
boolpp 
Okpp 
,pp 
stringpp  &
Mensajepp' .
)pp. /
>pp/ 0#
ReenviarActivacionAsyncpp1 H
(ppH I
intppI L
	usuarioIdppM V
,ppV W
FuncppX \
<pp\ ]
stringpp] c
,ppc d
stringppe k
>ppk l
construirEnlaceppm |
)pp| }
{qq 
varrr 
usuariorr 
=rr 
awaitrr 
usuariosrr $
.rr$ %
ObtenerPorIdAsyncrr% 6
(rr6 7
	usuarioIdrr7 @
)rr@ A
;rrA B
ifss 

(ss 
usuarioss 
isss 
nullss 
||ss 
usuarioss &
.ss& '
Rolss' *
!=ss+ -

RolUsuarioss. 8
.ss8 9
Administradorss9 F
)ssF G
returntt 
(tt 
falsett 
,tt 
$strtt 8
)tt8 9
;tt9 :
varvv 
adminvv 
=vv 
awaitvv 
adminsvv  
.vv  !$
ObtenerPorUsuarioIdAsyncvv! 9
(vv9 :
usuariovv: A
.vvA B
IdvvB D
)vvD E
;vvE F
varww 
nombreww 
=ww 
adminww 
?ww 
.ww 
NombreCompletoww *
??ww+ -
usuarioww. 5
.ww5 6
Correoww6 <
;ww< =
ifyy 

(yy 
usuarioyy 
.yy 
Estadoyy 
!=yy 
EstadoCuentayy *
.yy* +
PendienteActivacionyy+ >
)yy> ?
returnzz 
(zz 
falsezz 
,zz 
$"zz 
{zz 
nombrezz $
}zz$ %
$strzz% :
"zz: ;
)zz; <
;zz< =
if|| 

(|| 
await|| 

activacion|| 
.|| !
EnviosUltimaHoraAsync|| 2
(||2 3
usuario||3 :
.||: ;
Id||; =
)||= >
>=||? A'
MaxCorreosActivacionPorHora||B ]
)||] ^
return}} 
(}} 
false}} 
,}} 
$str	}} Ä
)
}}Ä Å
;
}}Å Ç
var 
enviado 
= 
await 

activacion &
.& '
EnviarEnlaceAsync' 8
(8 9
usuario9 @
,@ A
adminB G
?G H
.H I
NombreCompletoI W
??X Z
$str[ ]
,] ^
null_ c
,c d
construirEnlacee t
)t u
;u v
return
ÄÄ 
enviado
ÄÄ 
?
ÅÅ 
(
ÅÅ 
true
ÅÅ 
,
ÅÅ 
$"
ÅÅ 
$str
ÅÅ <
{
ÅÅ< =
usuario
ÅÅ= D
.
ÅÅD E
Correo
ÅÅE K
}
ÅÅK L
$str
ÅÅL M
"
ÅÅM N
)
ÅÅN O
:
ÇÇ 
(
ÇÇ 
false
ÇÇ 
,
ÇÇ 
$str
ÇÇ Z
)
ÇÇZ [
;
ÇÇ[ \
}
ÉÉ 
}ÑÑ õ–
_C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\ActivacionCuentaService.cs
	namespace 	
Gtrack
 
; 
public 
enum "
EstadoEnlaceActivacion "
{# $
Valido% +
,+ ,
Invalido- 5
,5 6
Vencido7 >
,> ?
CuentaYaActiva@ N
}O P
public 
record 
InfoActivacion 
( "
EstadoEnlaceActivacion 
Estado !
,! "

RolUsuario 
? 
Rol 
= 
null 
, 
string 

Nombre 
= 
$str 
, 
string 

Correo 
= 
$str 
, 
string 

Negocio 
= 
$str 
) 
; 
public 
	interface $
IActivacionCuentaService )
{ 
Task 
< 	
bool	 
> 
EnviarEnlaceAsync  
(  !
Usuario! (
usuario) 0
,0 1
string2 8
nombre9 ?
,? @
stringA G
?G H
nombreNegocioI V
,V W
FuncX \
<\ ]
string] c
,c d
stringe k
>k l
construirEnlacem |
)| }
;} ~
Task 
< 	
int	 
> !
EnviosUltimaHoraAsync #
(# $
int$ '
	usuarioId( 1
)1 2
;2 3
Task 
< 	
InfoActivacion	 
> 
ConsultarAsync '
(' (
string( .
?. /
token0 5
)5 6
;6 7
Task   
<   	
(  	 

bool  
 
Ok   
,   
string   
?   
Error    
,    !
InfoActivacion  " 0
Info  1 5
)  5 6
>  6 7
ActivarAsync  8 D
(  D E
string!! 
?!! 
token!! 
,!! 
string!! 
?!! 
password!! '
,!!' (
string!!) /
?!!/ 0
confirmacion!!1 =
,!!= >
Func!!? C
<!!C D

RolUsuario!!D N
,!!N O
string!!P V
>!!V W
urlLogin!!X `
)!!` a
;!!a b
}"" 
public$$ 
class$$ #
ActivacionCuentaService$$ $
($$$ %
IUsuarioRepository%% 
usuarios%% 
,%%  (
ITokenRecuperacionRepository&&  
tokens&&! '
,&&' (!
IRepartidorRepository'' 
repartidores'' &
,''& '%
IAdministracionRepository(( 
administradores(( -
,((- .
INegocioRepository)) 
negocios)) 
,))  
IPasswordHasher** 
<** 
Usuario** 
>** 
hasher** #
,**# $
IEmailService++ 
email++ 
,++ 
ILogger,, 
<,, #
ActivacionCuentaService,, #
>,,# $
logger,,% +
),,+ ,
:,,- .$
IActivacionCuentaService,,/ G
{-- 
public.. 

const.. 
int.. 
HorasVigencia.. "
=..# $
$num..% '
;..' (
public00 

async00 
Task00 
<00 
bool00 
>00 
EnviarEnlaceAsync00 -
(00- .
Usuario00. 5
usuario006 =
,00= >
string00? E
nombre00F L
,00L M
string00N T
?00T U
nombreNegocio00V c
,00c d
Func00e i
<00i j
string00j p
,00p q
string00r x
>00x y
construirEnlace	00z â
)
00â ä
{11 
try22 
{33 	
var44 
token44 
=44 
	TokenUtil44 !
.44! "
Generar44" )
(44) *
)44* +
;44+ ,
await55 
tokens55 
.55 
AgregarAsync55 %
(55% &
new55& )
TokenRecuperacion55* ;
{66 
	UsuarioId77 
=77 
usuario77 #
.77# $
Id77$ &
,77& '
	TokenHash88 
=88 
	TokenUtil88 %
.88% &
Hash88& *
(88* +
token88+ 0
)880 1
,881 2
Expira99 
=99 
DateTime99 !
.99! "
UtcNow99" (
.99( )
AddHours99) 1
(991 2
HorasVigencia992 ?
)99? @
}:: 
):: 
;:: 
var<< 
enlace<< 
=<< 
construirEnlace<< (
(<<( )
token<<) .
)<<. /
;<</ 0
var== 
(== 
asunto== 
,== 
correo== 
)==  
===! "
usuario==# *
.==* +
Rol==+ .
====/ 1

RolUsuario==2 <
.==< =
Administrador=== J
?>> )
CorreoActivacionAdministrador>> /
(>>/ 0
usuario>>0 7
,>>7 8
nombre>>9 ?
,>>? @
enlace>>A G
)>>G H
:?? &
CorreoActivacionRepartidor?? ,
(??, -
usuario??- 4
,??4 5
nombre??6 <
,??< =
nombreNegocio??> K
????L N
$str??O Q
,??Q R
enlace??S Y
)??Y Z
;??Z [
awaitAA 
emailAA 
.AA 
EnviarAsyncAA #
(AA# $
usuarioAA$ +
.AA+ ,
CorreoAA, 2
,AA2 3
asuntoAA4 :
,AA: ;
correoAA< B
)AAB C
;AAC D
returnBB 
trueBB 
;BB 
}CC 	
catchDD 
(DD 
	ExceptionDD 
exDD 
)DD 
{EE 	
loggerFF 
.FF 
LogErrorFF 
(FF 
exFF 
,FF 
$strFF  V
,FFV W
usuarioFFX _
.FF_ `
CorreoFF` f
)FFf g
;FFg h
returnGG 
falseGG 
;GG 
}HH 	
}II 
publicKK 

TaskKK 
<KK 
intKK 
>KK !
EnviosUltimaHoraAsyncKK *
(KK* +
intKK+ .
	usuarioIdKK/ 8
)KK8 9
=>KK: <
tokensLL 
.LL 
ContarDesdeAsyncLL 
(LL  
	usuarioIdLL  )
,LL) *
DateTimeLL+ 3
.LL3 4
UtcNowLL4 :
.LL: ;
AddHoursLL; C
(LLC D
-LLD E
$numLLE F
)LLF G
)LLG H
;LLH I
publicNN 

asyncNN 
TaskNN 
<NN 
InfoActivacionNN $
>NN$ %
ConsultarAsyncNN& 4
(NN4 5
stringNN5 ;
?NN; <
tokenNN= B
)NNB C
{OO 
varPP 
(PP 
estadoPP 
,PP 
usuarioPP 
)PP 
=PP 
awaitPP  %
ValidarAsyncPP& 2
(PP2 3
tokenPP3 8
)PP8 9
;PP9 :
returnQQ 
awaitQQ 
	InfoAsyncQQ 
(QQ 
estadoQQ %
,QQ% &
usuarioQQ' .
)QQ. /
;QQ/ 0
}RR 
publicTT 

asyncTT 
TaskTT 
<TT 
(TT 
boolTT 
OkTT 
,TT 
stringTT  &
?TT& '
ErrorTT( -
,TT- .
InfoActivacionTT/ =
InfoTT> B
)TTB C
>TTC D
ActivarAsyncTTE Q
(TTQ R
stringUU 
?UU 
tokenUU 
,UU 
stringUU 
?UU 
passwordUU '
,UU' (
stringUU) /
?UU/ 0
confirmacionUU1 =
,UU= >
FuncUU? C
<UUC D

RolUsuarioUUD N
,UUN O
stringUUP V
>UUV W
urlLoginUUX `
)UU` a
{VV 
varWW 
(WW 
estadoWW 
,WW 
usuarioWW 
)WW 
=WW 
awaitWW  %
ValidarAsyncWW& 2
(WW2 3
tokenWW3 8
)WW8 9
;WW9 :
varXX 
infoXX 
=XX 
awaitXX 
	InfoAsyncXX "
(XX" #
estadoXX# )
,XX) *
usuarioXX+ 2
)XX2 3
;XX3 4
ifYY 

(YY 
estadoYY 
!=YY "
EstadoEnlaceActivacionYY ,
.YY, -
ValidoYY- 3
||YY4 6
usuarioYY7 >
isYY? A
nullYYB F
)YYF G
returnYYH N
(YYO P
falseYYP U
,YYU V
nullYYW [
,YY[ \
infoYY] a
)YYa b
;YYb c
if\\ 

(\\ 
string\\ 
.\\ 
IsNullOrEmpty\\  
(\\  !
password\\! )
)\\) *
||\\+ -
string\\. 4
.\\4 5
IsNullOrEmpty\\5 B
(\\B C
confirmacion\\C O
)\\O P
)\\P Q
return]] 
(]] 
false]] 
,]] 
$str]] N
,]]N O
info]]P T
)]]T U
;]]U V
if^^ 

(^^ 
password^^ 
!=^^ 
confirmacion^^ $
)^^$ %
return__ 
(__ 
false__ 
,__ 
$str__ 9
,__9 :
info__; ?
)__? @
;__@ A
if`` 

(`` 
!`` 
ValidadorPassword`` 
.`` 
EsValida`` '
(``' (
password``( 0
)``0 1
)``1 2
returnaa 
(aa 
falseaa 
,aa 
$straa m
,aam n
infoaao s
)aas t
;aat u
usuariocc 
.cc 
PasswordHashcc 
=cc 
hashercc %
.cc% &
HashPasswordcc& 2
(cc2 3
usuariocc3 :
,cc: ;
passwordcc< D
)ccD E
;ccE F
usuariodd 
.dd 
Estadodd 
=dd 
EstadoCuentadd %
.dd% &
Activodd& ,
;dd, -
usuarioee 
.ee 
IntentosFallidosee  
=ee! "
$numee# $
;ee$ %
usuarioff 
.ff 
BloqueadoHastaff 
=ff  
nullff! %
;ff% &
awaitgg 
usuariosgg 
.gg 
ActualizarAsyncgg &
(gg& '
usuariogg' .
)gg. /
;gg/ 0
awaitjj 
tokensjj 
.jj $
InvalidarPendientesAsyncjj -
(jj- .
usuariojj. 5
.jj5 6
Idjj6 8
)jj8 9
;jj9 :
tryll 
{mm 	
awaitnn 
emailnn 
.nn 
EnviarAsyncnn #
(nn# $
usuarionn$ +
.nn+ ,
Correonn, 2
,nn2 3
$strnn4 U
,nnU V 
CorreoCuentaActivadaoo $
(oo$ %
usuariooo% ,
,oo, -
infooo. 2
,oo2 3
urlLoginoo4 <
(oo< =
usuariooo= D
.ooD E
RolooE H
)ooH I
)ooI J
)ooJ K
;ooK L
}pp 	
catchqq 
(qq 
	Exceptionqq 
exqq 
)qq 
{rr 	
loggertt 
.tt 

LogWarningtt 
(tt 
extt  
,tt  !
$strtt" ^
,tt^ _
usuariott` g
.ttg h
Correotth n
)ttn o
;tto p
}uu 	
returnww 
(ww 
trueww 
,ww 
nullww 
,ww 
infoww  
)ww  !
;ww! "
}xx 
private|| 
static|| 
(|| 
string|| 
Asunto|| !
,||! "

CorreoHtml||# -
Correo||. 4
)||4 5&
CorreoActivacionRepartidor||6 P
(||P Q
Usuario||Q X
usuario||Y `
,||` a
string||b h
nombre||i o
,||o p
string||q w
negocio||x 
,	|| Ä
string
||Å á
enlace
||à é
)
||é è
=>
||ê í
(}} 	
$str}}	 3
,}}3 4
PlantillaCorreo}}5 D
.}}D E
Crear}}E J
(}}J K
etiqueta~~ 
:~~ 
$str~~ ,
,~~, -
titulo 
: 
$str 4
,4 5
saludo
ÄÄ 
:
ÄÄ 
Saludo
ÄÄ 
(
ÄÄ 
nombre
ÄÄ !
)
ÄÄ! "
,
ÄÄ" #
parrafos
ÅÅ 
:
ÅÅ 
[
ÇÇ 
$"
ÉÉ 
$str
ÉÉ 
{
ÉÉ 
negocio
ÉÉ 
}
ÉÉ 
$strÉÉ ¶
"ÉÉ¶ ß
,ÉÉß ®
$str
ÑÑ e
]
ÖÖ 
,
ÖÖ 
datos
ÜÜ 
:
ÜÜ 
[
ÜÜ 
(
ÜÜ 
$str
ÜÜ 
,
ÜÜ 
negocio
ÜÜ  '
)
ÜÜ' (
,
ÜÜ( )
(
ÜÜ* +
$str
ÜÜ+ 3
,
ÜÜ3 4
usuario
ÜÜ5 <
.
ÜÜ< =
Correo
ÜÜ= C
)
ÜÜC D
,
ÜÜD E
(
ÜÜF G
$str
ÜÜG R
,
ÜÜR S
usuario
ÜÜT [
.
ÜÜ[ \
	Documento
ÜÜ\ e
)
ÜÜe f
]
ÜÜf g
,
ÜÜg h

textoBoton
áá 
:
áá 
$str
áá +
,
áá+ ,
urlBoton
àà 
:
àà 
enlace
àà 
,
àà 
nota
ââ 
:
ââ 
$"
ââ 
$str
ââ )
{
ââ) *
HorasVigencia
ââ* 7
}
ââ7 8
$strââ8 ¢
"ââ¢ £
,ââ£ §
tipoNota
ää 
:
ää 
TipoNota
ää 
.
ää 
Aviso
ää $
,
ää$ %
resumen
ãã 
:
ãã 
$"
ãã 
{
ãã 
negocio
ãã 
}
ãã  
$str
ãã  ^
"
ãã^ _
)
ãã_ `
)
ãã` a
;
ããa b
private
çç 
static
çç 
(
çç 
string
çç 
Asunto
çç !
,
çç! "

CorreoHtml
çç# -
Correo
çç. 4
)
çç4 5+
CorreoActivacionAdministrador
çç6 S
(
ççS T
Usuario
ççT [
usuario
çç\ c
,
ççc d
string
ççe k
nombre
ççl r
,
ççr s
string
ççt z
enlaceçç{ Å
)ççÅ Ç
=>ççÉ Ö
(
éé 	
$str
éé	 6
,
éé6 7
PlantillaCorreo
éé8 G
.
ééG H
Crear
ééH M
(
ééM N
etiqueta
èè 
:
èè 
$str
èè ,
,
èè, -
titulo
êê 
:
êê 
$str
êê 7
,
êê7 8
saludo
ëë 
:
ëë 
Saludo
ëë 
(
ëë 
nombre
ëë !
)
ëë! "
,
ëë" #
parrafos
íí 
:
íí 
[
ìì 
$strîî ¨
,îî¨ ≠
$str
ïï e
]
ññ 
,
ññ 
datos
óó 
:
óó 
[
óó 
(
óó 
$str
óó 
,
óó 
$str
óó .
)
óó. /
,
óó/ 0
(
óó1 2
$str
óó2 :
,
óó: ;
usuario
óó< C
.
óóC D
Correo
óóD J
)
óóJ K
,
óóK L
(
óóM N
$str
óóN Y
,
óóY Z
usuario
óó[ b
.
óób c
	Documento
óóc l
)
óól m
]
óóm n
,
óón o

textoBoton
òò 
:
òò 
$str
òò +
,
òò+ ,
urlBoton
ôô 
:
ôô 
enlace
ôô 
,
ôô 
nota
öö 
:
öö 
$"
öö 
$str
öö )
{
öö) *
HorasVigencia
öö* 7
}
öö7 8
$ströö8 ™
"öö™ ´
,öö´ ¨
tipoNota
õõ 
:
õõ 
TipoNota
õõ 
.
õõ 
Aviso
õõ $
,
õõ$ %
resumen
úú 
:
úú 
$str
úú d
)
úúd e
)
úúe f
;
úúf g
private
ûû 
static
ûû 

CorreoHtml
ûû "
CorreoCuentaActivada
ûû 2
(
ûû2 3
Usuario
ûû3 :
usuario
ûû; B
,
ûûB C
InfoActivacion
ûûD R
info
ûûS W
,
ûûW X
string
ûûY _
urlLogin
ûû` h
)
ûûh i
{
üü 
var
†† 
esAdmin
†† 
=
†† 
usuario
†† 
.
†† 
Rol
†† !
==
††" $

RolUsuario
††% /
.
††/ 0
Administrador
††0 =
;
††= >
var
°° 
perfil
°° 
=
°° 
esAdmin
°° 
?
°° 
$str
°° .
:
°°/ 0
$str
°°1 =
;
°°= >
var
¢¢ 
registro
¢¢ 
=
¢¢ 
esAdmin
¢¢ 
?
££ 
$str
££ ?
:
§§ 
string
§§ 
.
§§  
IsNullOrWhiteSpace
§§ '
(
§§' (
info
§§( ,
.
§§, -
Negocio
§§- 4
)
§§4 5
?
•• 
$str
•• @
:
¶¶ 
$"
¶¶ 
$str
¶¶ ;
{
¶¶; <
info
¶¶< @
.
¶¶@ A
Negocio
¶¶A H
}
¶¶H I
$str
¶¶I V
"
¶¶V W
;
¶¶W X
return
®® 
PlantillaCorreo
®® 
.
®® 
Crear
®® $
(
®®$ %
etiqueta
©© 
:
©© 
$str
©© '
,
©©' (
titulo
™™ 
:
™™ 
$str
™™ ,
,
™™, -
saludo
´´ 
:
´´ 
Saludo
´´ 
(
´´ 
info
´´ 
.
´´  
Nombre
´´  &
)
´´& '
,
´´' (
parrafos
¨¨ 
:
¨¨ 
[
≠≠ 
registro
ÆÆ 
+
ÆÆ 
$str
ÆÆ f
,
ÆÆf g
$"
ØØ 
$str
ØØ 1
{
ØØ1 2
perfil
ØØ2 8
}
ØØ8 9
$str
ØØ9 i
"
ØØi j
]
∞∞ 
,
∞∞ 
datos
±± 
:
±± 
[
±± 
(
±± 
$str
±± 
,
±± 
perfil
±± %
)
±±% &
,
±±& '
(
±±( )
$str
±±) 1
,
±±1 2
usuario
±±3 :
.
±±: ;
Correo
±±; A
)
±±A B
,
±±B C
(
±±D E
$str
±±E P
,
±±P Q
usuario
±±R Y
.
±±Y Z
	Documento
±±Z c
)
±±c d
]
±±d e
,
±±e f

textoBoton
≤≤ 
:
≤≤ 
$str
≤≤ (
,
≤≤( )
urlBoton
≥≥ 
:
≥≥ 
urlLogin
≥≥ 
,
≥≥ 
nota
¥¥ 
:
¥¥ 
esAdmin
¥¥ 
?
µµ 
$str
µµ g
:
∂∂ 
$str
∂∂ c
,
∂∂c d
tipoNota
∑∑ 
:
∑∑ 
TipoNota
∑∑ 
.
∑∑ 
Info
∑∑ #
,
∑∑# $
resumen
∏∏ 
:
∏∏ 
$"
∏∏ 
$str
∏∏ $
{
∏∏$ %
perfil
∏∏% +
.
∏∏+ ,
ToLowerInvariant
∏∏, <
(
∏∏< =
)
∏∏= >
}
∏∏> ?
$str
∏∏? q
"
∏∏q r
)
∏∏r s
;
∏∏s t
}
ππ 
private
ΩΩ 
async
ΩΩ 
Task
ΩΩ 
<
ΩΩ 
(
ΩΩ $
EstadoEnlaceActivacion
ΩΩ .
Estado
ΩΩ/ 5
,
ΩΩ5 6
Usuario
ΩΩ7 >
?
ΩΩ> ?
Usuario
ΩΩ@ G
)
ΩΩG H
>
ΩΩH I
ValidarAsync
ΩΩJ V
(
ΩΩV W
string
ΩΩW ]
?
ΩΩ] ^
token
ΩΩ_ d
)
ΩΩd e
{
ææ 
if
øø 

(
øø 
string
øø 
.
øø  
IsNullOrWhiteSpace
øø %
(
øø% &
token
øø& +
)
øø+ ,
)
øø, -
return
øø. 4
(
øø5 6$
EstadoEnlaceActivacion
øø6 L
.
øøL M
Invalido
øøM U
,
øøU V
null
øøW [
)
øø[ \
;
øø\ ]
var
¡¡ 
t
¡¡ 
=
¡¡ 
await
¡¡ 
tokens
¡¡ 
.
¡¡ !
ObtenerPorHashAsync
¡¡ 0
(
¡¡0 1
	TokenUtil
¡¡1 :
.
¡¡: ;
Hash
¡¡; ?
(
¡¡? @
token
¡¡@ E
)
¡¡E F
)
¡¡F G
;
¡¡G H
if
¬¬ 

(
¬¬ 
t
¬¬ 
is
¬¬ 
null
¬¬ 
)
¬¬ 
return
¬¬ 
(
¬¬ $
EstadoEnlaceActivacion
¬¬ 5
.
¬¬5 6
Invalido
¬¬6 >
,
¬¬> ?
null
¬¬@ D
)
¬¬D E
;
¬¬E F
var
≈≈ 
usuario
≈≈ 
=
≈≈ 
await
≈≈ 
usuarios
≈≈ $
.
≈≈$ %
ObtenerPorIdAsync
≈≈% 6
(
≈≈6 7
t
≈≈7 8
.
≈≈8 9
	UsuarioId
≈≈9 B
)
≈≈B C
;
≈≈C D
if
∆∆ 

(
∆∆ 
usuario
∆∆ 
is
∆∆ 
null
∆∆ 
||
∆∆ 
usuario
∆∆ &
.
∆∆& '
Rol
∆∆' *
==
∆∆+ -

RolUsuario
∆∆. 8
.
∆∆8 9
Negocio
∆∆9 @
)
∆∆@ A
return
∆∆B H
(
∆∆I J$
EstadoEnlaceActivacion
∆∆J `
.
∆∆` a
Invalido
∆∆a i
,
∆∆i j
null
∆∆k o
)
∆∆o p
;
∆∆p q
if
»» 

(
»» 
usuario
»» 
.
»» 
Estado
»» 
==
»» 
EstadoCuenta
»» *
.
»»* +
Activo
»»+ 1
)
»»1 2
return
»»3 9
(
»»: ;$
EstadoEnlaceActivacion
»»; Q
.
»»Q R
CuentaYaActiva
»»R `
,
»»` a
usuario
»»b i
)
»»i j
;
»»j k
if
…… 

(
…… 
usuario
…… 
.
…… 
Estado
…… 
!=
…… 
EstadoCuenta
…… *
.
……* +!
PendienteActivacion
……+ >
||
……? A
t
……B C
.
……C D
Usado
……D I
)
……I J
return
……K Q
(
……R S$
EstadoEnlaceActivacion
……S i
.
……i j
Invalido
……j r
,
……r s
usuario
……t {
)
……{ |
;
……| }
if
   

(
   
t
   
.
   
Expira
   
<=
   
DateTime
    
.
    !
UtcNow
  ! '
)
  ' (
return
  ) /
(
  0 1$
EstadoEnlaceActivacion
  1 G
.
  G H
Vencido
  H O
,
  O P
usuario
  Q X
)
  X Y
;
  Y Z
return
ÃÃ 
(
ÃÃ $
EstadoEnlaceActivacion
ÃÃ &
.
ÃÃ& '
Valido
ÃÃ' -
,
ÃÃ- .
usuario
ÃÃ/ 6
)
ÃÃ6 7
;
ÃÃ7 8
}
ÕÕ 
private
–– 
async
–– 
Task
–– 
<
–– 
InfoActivacion
–– %
>
––% &
	InfoAsync
––' 0
(
––0 1$
EstadoEnlaceActivacion
––1 G
estado
––H N
,
––N O
Usuario
––P W
?
––W X
usuario
––Y `
)
––` a
{
—— 
if
““ 

(
““ 
usuario
““ 
is
““ 
null
““ 
)
““ 
return
““ #
new
““$ '
InfoActivacion
““( 6
(
““6 7
estado
““7 =
)
““= >
;
““> ?
if
‘‘ 

(
‘‘ 
usuario
‘‘ 
.
‘‘ 
Rol
‘‘ 
==
‘‘ 

RolUsuario
‘‘ %
.
‘‘% &
Administrador
‘‘& 3
)
‘‘3 4
{
’’ 	
var
÷÷ 
administrador
÷÷ 
=
÷÷ 
await
÷÷  %
administradores
÷÷& 5
.
÷÷5 6&
ObtenerPorUsuarioIdAsync
÷÷6 N
(
÷÷N O
usuario
÷÷O V
.
÷÷V W
Id
÷÷W Y
)
÷÷Y Z
;
÷÷Z [
return
◊◊ 
new
◊◊ 
InfoActivacion
◊◊ %
(
◊◊% &
estado
◊◊& ,
,
◊◊, -
usuario
◊◊. 5
.
◊◊5 6
Rol
◊◊6 9
,
◊◊9 :
administrador
◊◊; H
?
◊◊H I
.
◊◊I J
NombreCompleto
◊◊J X
??
◊◊Y [
$str
◊◊\ ^
,
◊◊^ _
usuario
◊◊` g
.
◊◊g h
Correo
◊◊h n
)
◊◊n o
;
◊◊o p
}
ÿÿ 	
var
⁄⁄ 

repartidor
⁄⁄ 
=
⁄⁄ 
await
⁄⁄ 
repartidores
⁄⁄ +
.
⁄⁄+ ,&
ObtenerPorUsuarioIdAsync
⁄⁄, D
(
⁄⁄D E
usuario
⁄⁄E L
.
⁄⁄L M
Id
⁄⁄M O
)
⁄⁄O P
;
⁄⁄P Q
var
€€ 
negocio
€€ 
=
€€ 

repartidor
€€  
is
€€! #
null
€€$ (
?
€€) *
null
€€+ /
:
€€0 1
await
€€2 7
negocios
€€8 @
.
€€@ A
BuscarPorIdAsync
€€A Q
(
€€Q R

repartidor
€€R \
.
€€\ ]
	NegocioId
€€] f
)
€€f g
;
€€g h
return
‹‹ 
new
‹‹ 
InfoActivacion
‹‹ !
(
‹‹! "
estado
‹‹" (
,
‹‹( )
usuario
‹‹* 1
.
‹‹1 2
Rol
‹‹2 5
,
‹‹5 6

repartidor
‹‹7 A
?
‹‹A B
.
‹‹B C
NombreCompleto
‹‹C Q
??
‹‹R T
$str
‹‹U W
,
‹‹W X
usuario
‹‹Y `
.
‹‹` a
Correo
‹‹a g
,
‹‹g h
negocio
‹‹i p
?
‹‹p q
.
‹‹q r
Nombre
‹‹r x
??
‹‹y {
$str
‹‹| ~
)
‹‹~ 
;‹‹ Ä
}
›› 
private
ﬂﬂ 
static
ﬂﬂ 
string
ﬂﬂ 
Saludo
ﬂﬂ  
(
ﬂﬂ  !
string
ﬂﬂ! '
?
ﬂﬂ' (
nombre
ﬂﬂ) /
)
ﬂﬂ/ 0
=>
ﬂﬂ1 3
string
‡‡ 
.
‡‡  
IsNullOrWhiteSpace
‡‡ !
(
‡‡! "
nombre
‡‡" (
)
‡‡( )
?
‡‡* +
$str
‡‡, 3
:
‡‡4 5
$"
‡‡6 8
$str
‡‡8 >
{
‡‡> ?
nombre
‡‡? E
}
‡‡E F
"
‡‡F G
;
‡‡G H
}·· ê'
]C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\UsuarioRepository.cs
	namespace 	
Gtrack
 
; 
public 
class 
UsuarioRepository 
( 
AppDbContext +
db, .
). /
:0 1
IUsuarioRepository2 D
{ 
public 

Task 
< 
Usuario 
? 
> ,
 ObtenerPorIdentificadorYRolAsync :
(: ;
string; A
identificadorB O
,O P

RolUsuarioQ [
rol\ _
)_ `
=>a c
db 

.
 
Usuarios 
. 
FirstOrDefaultAsync '
(' (
u( )
=>* ,
u		 
.		 
Rol		 
==		 
rol		 
&&		 
(		 
u		 
.		 
Correo		 %
==		& (
identificador		) 6
||		7 9
u		: ;
.		; <
	Documento		< E
==		F H
identificador		I V
)		V W
)		W X
;		X Y
public 

Task 
< 
Usuario 
? 
> !
ObtenerPorCorreoAsync /
(/ 0
string0 6
correo7 =
)= >
=>? A
db 

.
 
Usuarios 
. 
FirstOrDefaultAsync '
(' (
u( )
=>* ,
u- .
.. /
Correo/ 5
==6 8
correo9 ?
)? @
;@ A
public 

Task 
< 
Usuario 
? 
> 
ObtenerPorIdAsync +
(+ ,
int, /
id0 2
)2 3
=>4 6
db 

.
 
Usuarios 
. 
FirstOrDefaultAsync '
(' (
u( )
=>* ,
u- .
.. /
Id/ 1
==2 4
id5 7
)7 8
;8 9
public 

async 
Task 
ActualizarAsync %
(% &
Usuario& -
usuario. 5
)5 6
{ 
db 

.
 
Usuarios 
. 
Update 
( 
usuario "
)" #
;# $
await 
db 
. 
SaveChangesAsync !
(! "
)" #
;# $
} 
public 

Task 
< 
List 
< 
string 
> 
> .
"CorreosAdministradoresActivosAsync @
(@ A
)A B
=>C E
db 

.
 
Usuarios 
. 
AsNoTracking 
( 
) 
. 
Where 
( 
u 
=> 
u 
. 
Rol 
==  

RolUsuario! +
.+ ,
Administrador, 9
&&: <
u= >
.> ?
Estado? E
==F H
EstadoCuentaI U
.U V
ActivoV \
)\ ]
. 
Select 
( 
u 
=> 
u 
. 
Correo !
)! "
. 
ToListAsync 
( 
) 
; 
public 

async 
Task "
LiberarEliminadosAsync ,
(, -
string- 3
correo4 :
,: ;
string< B
	documentoC L
)L M
{ 
var   

eliminados   
=   
await   
db   !
.  ! "
Usuarios  " *
.!! 
Where!! 
(!! 
u!! 
=>!! 
u!! 
.!! 
Estado!!  
==!!! #
EstadoCuenta!!$ 0
.!!0 1
	Eliminado!!1 :
&&!!; =
(!!> ?
u!!? @
.!!@ A
Correo!!A G
==!!H J
correo!!K Q
||!!R T
u!!U V
.!!V W
	Documento!!W `
==!!a c
	documento!!d m
)!!m n
)!!n o
."" 
ToListAsync"" 
("" 
)"" 
;"" 
if## 

(## 

eliminados## 
.## 
Count## 
==## 
$num##  !
)##! "
return### )
;##) *
foreach%% 
(%% 
var%% 
u%% 
in%% 

eliminados%% $
)%%$ %
u%%& '
.%%' ("
LiberarIdentificadores%%( >
(%%> ?
)%%? @
;%%@ A
await&& 
db&& 
.&& 
SaveChangesAsync&& !
(&&! "
)&&" #
;&&# $
}'' 
}(( ∞
_C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\UbicacionRepository.cs
	namespace 	
Gtrack
 
; 
public 
class 
UbicacionRepository  
(  !
AppDbContext! -
db. 0
)0 1
:2 3 
IUbicacionRepository4 H
{ 
public 

async 
Task 
< 
UbicacionPedido %
?% &
>& '
ObtenerAsync( 4
(4 5
int5 8
pedidoId9 A
)A B
=>C E
await 
db 
. 
UbicacionesPedido "
.		 
FirstOrDefaultAsync		  
(		  !
u		! "
=>		# %
u		& '
.		' (
PedidoId		( 0
==		1 3
pedidoId		4 <
)		< =
;		= >
public 

async 
Task 
GuardarAsync "
(" #
int# &
pedidoId' /
,/ 0
decimal1 8
lat9 <
,< =
decimal> E
lngF I
)I J
{ 
var 
	ubicacion 
= 
await 
db  
.  !
UbicacionesPedido! 2
. 
FirstOrDefaultAsync  
(  !
u! "
=># %
u& '
.' (
PedidoId( 0
==1 3
pedidoId4 <
)< =
;= >
if 

( 
	ubicacion 
is 
null 
) 
{ 	
	ubicacion 
= 
new 
UbicacionPedido +
{ 
PedidoId 
= 
pedidoId #
,# $
Latitud 
= 
lat 
, 
Longitud 
= 
lng 
, 
FechaActualizacion "
=# $
DateTime% -
.- .
UtcNow. 4
} 
; 
db 
. 
UbicacionesPedido  
.  !
Add! $
($ %
	ubicacion% .
). /
;/ 0
} 	
else 
{ 	
	ubicacion 
. 
Latitud 
= 
lat  #
;# $
	ubicacion 
. 
Longitud 
=  
lng! $
;$ %
	ubicacion 
. 
FechaActualizacion (
=) *
DateTime+ 3
.3 4
UtcNow4 :
;: ;
db   
.   
UbicacionesPedido    
.    !
Update  ! '
(  ' (
	ubicacion  ( 1
)  1 2
;  2 3
}!! 	
await## 
db## 
.## 
SaveChangesAsync## !
(##! "
)##" #
;### $
}$$ 
}%% Ò
gC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\TokenRecuperacionRepository.cs
	namespace 	
Gtrack
 
; 
public 
class '
TokenRecuperacionRepository (
(( )
AppDbContext) 5
db6 8
)8 9
:: ;(
ITokenRecuperacionRepository< X
{ 
public 

async 
Task 
AgregarAsync "
(" #
TokenRecuperacion# 4
token5 :
): ;
{ 
db		 

.		
 
TokensRecuperacion		 
.		 
Add		 !
(		! "
token		" '
)		' (
;		( )
await

 
db

 
.

 
SaveChangesAsync

 !
(

! "
)

" #
;

# $
} 
public 

Task 
< 
TokenRecuperacion !
?! "
>" #
ObtenerPorHashAsync$ 7
(7 8
string8 >
hash? C
)C D
=>E G
db 

.
 
TokensRecuperacion 
. 
FirstOrDefaultAsync 1
(1 2
t2 3
=>4 6
t7 8
.8 9
	TokenHash9 B
==C E
hashF J
)J K
;K L
public 

Task 
< 
int 
> 
ContarDesdeAsync %
(% &
int& )
	usuarioId* 3
,3 4
DateTime5 =
desde> C
)C D
=>E G
db 

.
 
TokensRecuperacion 
. 

CountAsync (
(( )
t) *
=>+ -
t. /
./ 0
	UsuarioId0 9
==: <
	usuarioId= F
&&G I
tJ K
.K L
FechaCreacionL Y
>=Z \
desde] b
)b c
;c d
public 

async 
Task 
ActualizarAsync %
(% &
TokenRecuperacion& 7
token8 =
)= >
{ 
db 

.
 
TokensRecuperacion 
. 
Update $
($ %
token% *
)* +
;+ ,
await 
db 
. 
SaveChangesAsync !
(! "
)" #
;# $
} 
public 

async 
Task $
InvalidarPendientesAsync .
(. /
int/ 2
	usuarioId3 <
)< =
{ 
var 

pendientes 
= 
await 
db !
.! "
TokensRecuperacion" 4
. 
Where 
( 
t 
=> 
t 
. 
	UsuarioId #
==$ &
	usuarioId' 0
&&1 3
!4 5
t5 6
.6 7
Usado7 <
)< =
. 
ToListAsync 
( 
) 
; 
if 

( 

pendientes 
. 
Count 
== 
$num  !
)! "
return# )
;) *
foreach   
(   
var   
t   
in   

pendientes   $
)  $ %
t  & '
.  ' (
Usado  ( -
=  . /
true  0 4
;  4 5
await!! 
db!! 
.!! 
SaveChangesAsync!! !
(!!! "
)!!" #
;!!# $
}"" 
}## ºN
`C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\RepartidorRepository.cs
	namespace 	
Gtrack
 
; 
public 
class  
RepartidorRepository !
(! "
AppDbContext" .
db/ 1
)1 2
:3 4!
IRepartidorRepository5 J
{ 
public 

async 
Task $
RegistrarRepartidorAsync .
(. /
Usuario/ 6
usuario7 >
,> ?

Repartidor@ J

repartidorK U
)U V
{		 

repartidor 
. 
Usuario 
= 
usuario $
;$ %
await )
LiberarPlacaDeEliminadosAsync +
(+ ,

repartidor, 6
.6 7
Placa7 <
,< =
null> B
)B C
;C D
db 

.
 
Repartidores 
. 
Add 
( 

repartidor &
)& '
;' (
await 
db 
. 
SaveChangesAsync !
(! "
)" #
;# $
} 
public 

async 
Task 
< 

Repartidor  
?  !
>! " 
BuscarEliminadoAsync# 7
(7 8
string8 >
correo? E
,E F
stringG M
	documentoN W
)W X
{ 
var 

candidatos 
= 
await 
db !
.! "
Repartidores" .
. 
Include 
( 
r 
=> 
r 
. 
Usuario #
)# $
. 
Where 
( 
r 
=> 
r 
. 
Usuario !
!! "
." #
Estado# )
==* ,
EstadoCuenta- 9
.9 :
	Eliminado: C
&&D F
( 
r 
. 
Usuario 
. 
Correo !
==" $
correo% +
||, .
r/ 0
.0 1
Usuario1 8
.8 9
Correo9 ?
.? @
EndsWith@ H
(H I
$strI L
+M N
correoO U
)U V
||W Y
r 
. 
Usuario 
. 
	Documento $
==% '
	documento( 1
||2 4
r5 6
.6 7
Usuario7 >
.> ?
	Documento? H
.H I
EndsWithI Q
(Q R
$strR U
+V W
	documentoX a
)a b
)b c
)c d
. 
OrderByDescending 
( 
r  
=>! #
r$ %
.% &
Id& (
)( )
. 
ToListAsync 
( 
) 
; 
return 

candidatos 
. 
FirstOrDefault (
(( )
r) *
=>+ -
r 
. 
Usuario 
! 
. 
Correo 
==  
correo! '
||( *
r+ ,
., -
Usuario- 4
.4 5
Correo5 ;
==< >
$"? A
$strA K
{K L
rL M
.M N
	UsuarioIdN W
}W X
$strX Y
{Y Z
correoZ `
}` a
"a b
||c e
r 
. 
Usuario 
. 
	Documento 
==  "
	documento# ,
||- /
r0 1
.1 2
Usuario2 9
.9 :
	Documento: C
==D F
$"G I
$strI J
{J K
rK L
.L M
	UsuarioIdM V
}V W
$strW X
{X Y
	documentoY b
}b c
"c d
)d e
;e f
} 
public!! 

async!! 
Task!! 
ReactivarAsync!! $
(!!$ %

Repartidor!!% /

repartidor!!0 :
)!!: ;
{"" 
await## )
LiberarPlacaDeEliminadosAsync## +
(##+ ,

repartidor##, 6
.##6 7
Placa##7 <
,##< =

repartidor##> H
.##H I
Id##I K
)##K L
;##L M
await$$ 
db$$ 
.$$ 
SaveChangesAsync$$ !
($$! "
)$$" #
;$$# $
}%% 
private(( 
async(( 
Task(( )
LiberarPlacaDeEliminadosAsync(( 4
(((4 5
string((5 ;
?((; <
placa((= B
,((B C
int((D G
?((G H
	excluirId((I R
)((R S
{)) 
if** 

(** 
string** 
.** 
IsNullOrEmpty**  
(**  !
placa**! &
)**& '
)**' (
return**) /
;**/ 0
var++ 
conPlaca++ 
=++ 
await++ 
db++ 
.++  
Repartidores++  ,
.,, 
Where,, 
(,, 
r,, 
=>,, 
r,, 
.,, 
Placa,, 
==,,  "
placa,,# (
&&,,) +
r,,, -
.,,- .
Usuario,,. 5
!,,5 6
.,,6 7
Estado,,7 =
==,,> @
EstadoCuenta,,A M
.,,M N
	Eliminado,,N W
&&,,X Z
(-- 
	excluirId-- "
==--# %
null--& *
||--+ -
r--. /
.--/ 0
Id--0 2
!=--3 5
	excluirId--6 ?
)--? @
)--@ A
... 
ToListAsync.. 
(.. 
).. 
;.. 
foreach// 
(// 
var// 
r// 
in// 
conPlaca// "
)//" #
r//$ %
.//% &
Placa//& +
=//, -
null//. 2
;//2 3
}00 
public22 

Task22 
<22 
List22 
<22 

Repartidor22 
>22  
>22  !!
ListarPorNegocioAsync22" 7
(227 8
int228 ;
	negocioId22< E
)22E F
=>22G I
db33 

.33
 
Repartidores33 
.44 
AsNoTracking44 
(44 
)44 
.55 
Include55 
(55 
r55 
=>55 
r55 
.55 
Usuario55 #
)55# $
.66 
Where66 
(66 
r66 
=>66 
r66 
.66 
	NegocioId66 #
==66$ &
	negocioId66' 0
&&661 3
r664 5
.665 6
Usuario666 =
!66= >
.66> ?
Estado66? E
!=66F H
EstadoCuenta66I U
.66U V
	Eliminado66V _
)66_ `
.77 
OrderByDescending77 
(77 
r77  
=>77! #
r77$ %
.77% &
FechaRegistro77& 3
)773 4
.88 
ToListAsync88 
(88 
)88 
;88 
public:: 

async:: 
Task:: 
<:: 
bool:: 
>:: 
TelefonoEnUsoAsync:: .
(::. /
string::/ 5
telefono::6 >
)::> ?
=>::@ B
await;; 
db;; 
.;; 
Negocios;; 
.;; 
AnyAsync;; "
(;;" #
n;;# $
=>;;% '
n;;( )
.;;) *
Telefono;;* 2
==;;3 5
telefono;;6 >
);;> ?
||;;@ B
await== 
db== 
.== 
Repartidores== 
.== 
AnyAsync== &
(==& '
r==' (
=>==) +
r==, -
.==- .
Telefono==. 6
====7 9
telefono==: B
&&==C E
r==F G
.==G H
Usuario==H O
!==O P
.==P Q
Estado==Q W
!===X Z
EstadoCuenta==[ g
.==g h
	Eliminado==h q
)==q r
||==s u
await>> 
db>> 
.>> 
Administradores>>  
.>>  !
AnyAsync>>! )
(>>) *
a>>* +
=>>>, .
a>>/ 0
.>>0 1
Telefono>>1 9
==>>: <
telefono>>= E
)>>E F
;>>F G
public@@ 

Task@@ 
<@@ 

Repartidor@@ 
?@@ 
>@@ !
ObtenerDeNegocioAsync@@ 2
(@@2 3
int@@3 6
	negocioId@@7 @
,@@@ A
int@@B E
repartidorId@@F R
)@@R S
=>@@T V
dbAA 

.AA
 
RepartidoresAA 
.BB 
IncludeBB 
(BB 
rBB 
=>BB 
rBB 
.BB 
UsuarioBB #
)BB# $
.CC 
FirstOrDefaultAsyncCC  
(CC  !
rCC! "
=>CC# %
rCC& '
.CC' (
IdCC( *
==CC+ -
repartidorIdCC. :
&&CC; =
rCC> ?
.CC? @
	NegocioIdCC@ I
==CCJ L
	negocioIdCCM V
)CCV W
;CCW X
publicEE 

TaskEE 
<EE 

RepartidorEE 
?EE 
>EE $
ObtenerPorUsuarioIdAsyncEE 5
(EE5 6
intEE6 9
	usuarioIdEE: C
)EEC D
=>EEE G
dbFF 

.FF
 
RepartidoresFF 
.GG 
AsNoTrackingGG 
(GG 
)GG 
.HH 
FirstOrDefaultAsyncHH  
(HH  !
rHH! "
=>HH# %
rHH& '
.HH' (
	UsuarioIdHH( 1
==HH2 4
	usuarioIdHH5 >
)HH> ?
;HH? @
}II Í(
\C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\PedidoRepository.cs
	namespace 	
Gtrack
 
; 
public 
class 
PedidoRepository 
( 
AppDbContext *
db+ -
)- .
:/ 0
IPedidoRepository1 B
{ 
public 

async 
Task 
< 
Pedido 
? 
> 
ObtenerPorIdAsync 0
(0 1
int1 4
id5 7
)7 8
=>9 ;
await 
db 
. 
Pedidos 
.		 
Include		 
(		 
p		 
=>		 
p		 
.		 
Cliente		 #
)		# $
.

 
FirstOrDefaultAsync

  
(

  !
p

! "
=>

# %
p

& '
.

' (
Id

( *
==

+ -
id

. 0
)

0 1
;

1 2
public 

async 
Task 
< 
Pedido 
? 
> !
ObtenerPorCodigoAsync 4
(4 5
string5 ;
codigo< B
)B C
=>D F
await 
db 
. 
Pedidos 
. 
Include 
( 
p 
=> 
p 
. 
Items !
)! "
. 
Include 
( 
p 
=> 
p 
. 
Cliente #
)# $
. 
FirstOrDefaultAsync  
(  !
p! "
=># %
p& '
.' (
Codigo( .
==/ 1
codigo2 8
)8 9
;9 :
public 

async 
Task 
< 
Pedido 
? 
> )
ObtenerUltimoPorTelefonoAsync <
(< =
int= @
	negocioIdA J
,J K
stringL R
telefonoS [
)[ \
=>] _
await 
db 
. 
Pedidos 
. 
Include 
( 
p 
=> 
p 
. 
Cliente #
)# $
. 
Where 
( 
p 
=> 
p 
. 
	NegocioId #
==$ &
	negocioId' 0
&&1 3
p4 5
.5 6
Cliente6 =
!=> @
nullA E
&&F H
pI J
.J K
ClienteK R
.R S
TelefonoS [
==\ ^
telefono_ g
)g h
. 
OrderByDescending 
( 
p  
=>! #
p$ %
.% &
FechaCreacion& 3
)3 4
. 
FirstOrDefaultAsync  
(  !
)! "
;" #
public 

async 
Task 
< 
bool 
> 
ExisteCodigoAsync -
(- .
string. 4
codigo5 ;
); <
=>= ?
await 
db 
. 
Pedidos 
. 
AnyAsync !
(! "
p" #
=>$ &
p' (
.( )
Codigo) /
==0 2
codigo3 9
)9 :
;: ;
public 

async 
Task 
AgregarAsync "
(" #
Pedido# )
pedido* 0
)0 1
{ 
db 

.
 
Pedidos 
. 
Add 
( 
pedido 
) 
; 
await 
db 
. 
SaveChangesAsync !
(! "
)" #
;# $
}   
public"" 

async"" 
Task"" 
ActualizarAsync"" %
(""% &
Pedido""& ,
pedido""- 3
)""3 4
{## 
db$$ 

.$$
 
Pedidos$$ 
.$$ 
Update$$ 
($$ 
pedido$$  
)$$  !
;$$! "
await%% 
db%% 
.%% 
SaveChangesAsync%% !
(%%! "
)%%" #
;%%# $
}&& 
public(( 

async(( 
Task(( 
<(( 
List(( 
<(( 
Pedido(( !
>((! "
>((" #"
ObtenerPorNegocioAsync(($ :
(((: ;
int((; >
	negocioId((? H
)((H I
=>((J L
await)) 
db)) 
.)) 
Pedidos)) 
.** 
Include** 
(** 
p** 
=>** 
p** 
.** 
Cliente** #
)**# $
.++ 
Where++ 
(++ 
p++ 
=>++ 
p++ 
.++ 
	NegocioId++ #
==++$ &
	negocioId++' 0
)++0 1
.,, 
ToListAsync,, 
(,, 
),, 
;,, 
}-- Ï(
]C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\NegocioRepository.cs
	namespace 	
Gtrack
 
; 
public 
class 
NegocioRepository 
( 
AppDbContext +
db, .
). /
:0 1
INegocioRepository2 D
{ 
public 

Task 
< 
Negocio 
? 
> 
BuscarPorIdAsync *
(* +
int+ .
id/ 1
)1 2
=>3 5
db 

.
 
Negocios 
. 
FirstOrDefaultAsync '
(' (
n( )
=>* ,
n- .
.. /
Id/ 1
==2 4
id5 7
)7 8
;8 9
public

 

Task

 
<

 
Negocio

 
?

 
>

 $
ObtenerPorUsuarioIdAsync

 2
(

2 3
int

3 6
	usuarioId

7 @
)

@ A
=>

B D
db 

.
 
Negocios 
. 
FirstOrDefaultAsync '
(' (
n( )
=>* ,
n- .
.. /
	UsuarioId/ 8
==9 ;
	usuarioId< E
)E F
;F G
public 

Task 
< 
bool 
>  
ExisteDocumentoAsync *
(* +
string+ 1
	documento2 ;
); <
=>= ?
db 

.
 
Usuarios 
. 
AnyAsync 
( 
u 
=> !
u" #
.# $
	Documento$ -
==. 0
	documento1 :
): ;
;; <
public 

Task 
< 
bool 
> 
ExisteTelefonoAsync )
() *
string* 0
telefono1 9
,9 :
int; >
?> ?
excluirNegocioId@ P
=Q R
nullS W
)W X
=>Y [
db 

.
 
Negocios 
. 
AnyAsync 
( 
n 
=> !
n" #
.# $
Telefono$ ,
==- /
telefono0 8
&&9 ;
( 
excluirNegocioId 
==  
null! %
||& (
n) *
.* +
Id+ -
!=. 0
excluirNegocioId1 A
)A B
)B C
;C D
public 

async 
Task 
RegistrarAsync $
($ %
Usuario% ,
usuario- 4
,4 5
Negocio6 =
negocio> E
)E F
{ 
negocio 
. 
Usuario 
= 
usuario !
;! "
db 

.
 
Negocios 
. 
Add 
( 
negocio 
)  
;  !
await 
db 
. 
SaveChangesAsync !
(! "
)" #
;# $
} 
public 

async 
Task 
ActualizarAsync %
(% &
Negocio& -
negocio. 5
)5 6
{ 
db 

.
 
Negocios 
. 
Update 
( 
negocio "
)" #
;# $
await 
db 
. 
SaveChangesAsync !
(! "
)" #
;# $
} 
public"" 

Task"" 
<"" 
bool"" 
>"" $
TienePedidosActivosAsync"" .
("". /
int""/ 2
	negocioId""3 <
)""< =
=>""> @
db## 

.##
 
Pedidos## 
.## 
AnyAsync## 
(## 
p## 
=>##  
p##! "
.##" #
	NegocioId### ,
==##- /
	negocioId##0 9
&&##: <
p$$ 
.$$ 
EstadoPedidoId$$ 
!=$$ 
($$  !
int$$! $
)$$$ %
EstadoPedido$$% 1
.$$1 2
	Entregado$$2 ;
&&$$< >
p$$? @
.$$@ A
EstadoPedidoId$$A O
!=$$P R
($$S T
int$$T W
)$$W X
EstadoPedido$$X d
.$$d e
	Cancelado$$e n
)$$n o
;$$o p
public'' 

Task'' 
<'' 
bool'' 
>'' ,
 TieneRepartidoresVinculadosAsync'' 6
(''6 7
int''7 :
	negocioId''; D
)''D E
=>''F H
db(( 

.((
 
Repartidores(( 
.(( 
AnyAsync((  
(((  !
r((! "
=>((# %
r((& '
.((' (
	NegocioId((( 1
==((2 4
	negocioId((5 >
&&((? A
r)) 
.)) 
Usuario)) 
!)) 
.)) 
Estado)) 
!=))  
EstadoCuenta))! -
.))- .
	Eliminado)). 7
)))7 8
;))8 9
}** ∫
^C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\IUsuarioRepository.cs
	namespace 	
Gtrack
 
; 
public 
	interface 
IUsuarioRepository #
{ 
Task 
< 	
Usuario	 
? 
> ,
 ObtenerPorIdentificadorYRolAsync 3
(3 4
string4 :
identificador; H
,H I

RolUsuarioJ T
rolU X
)X Y
;Y Z
Task 
< 	
Usuario	 
? 
> !
ObtenerPorCorreoAsync (
(( )
string) /
correo0 6
)6 7
;7 8
Task 
< 	
Usuario	 
? 
> 
ObtenerPorIdAsync $
($ %
int% (
id) +
)+ ,
;, -
Task 
ActualizarAsync	 
( 
Usuario  
usuario! (
)( )
;) *
Task 
< 	
List	 
< 
string 
> 
> .
"CorreosAdministradoresActivosAsync 9
(9 :
): ;
;; <
Task "
LiberarEliminadosAsync	 
(  
string  &
correo' -
,- .
string/ 5
	documento6 ?
)? @
;@ A
} ≥
`C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\IUbicacionRepository.cs
	namespace 	
Gtrack
 
; 
public 
	interface  
IUbicacionRepository %
{ 
Task 
< 	
UbicacionPedido	 
? 
> 
ObtenerAsync '
(' (
int( +
pedidoId, 4
)4 5
;5 6
Task 
GuardarAsync	 
( 
int 
pedidoId "
," #
decimal$ +
lat, /
,/ 0
decimal1 8
lng9 <
)< =
;= >
} Û
hC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\ITokenRecuperacionRepository.cs
	namespace 	
Gtrack
 
; 
public 
	interface (
ITokenRecuperacionRepository -
{ 
Task 
AgregarAsync	 
( 
TokenRecuperacion '
token( -
)- .
;. /
Task 
< 	
TokenRecuperacion	 
? 
> 
ObtenerPorHashAsync 0
(0 1
string1 7
hash8 <
)< =
;= >
Task		 
<		 	
int			 
>		 
ContarDesdeAsync		 
(		 
int		 "
	usuarioId		# ,
,		, -
DateTime		. 6
desde		7 <
)		< =
;		= >
Task

 
ActualizarAsync

	 
(

 
TokenRecuperacion

 *
token

+ 0
)

0 1
;

1 2
Task $
InvalidarPendientesAsync	 !
(! "
int" %
	usuarioId& /
)/ 0
;0 1
} ã
aC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\IPersonalRepositories.cs
	namespace 	
Gtrack
 
; 
public 
	interface !
IRepartidorRepository &
{ 
Task $
RegistrarRepartidorAsync	 !
(! "
Usuario" )
usuario* 1
,1 2

Repartidor3 =

repartidor> H
)H I
;I J
Task 
< 	
List	 
< 

Repartidor 
> 
> !
ListarPorNegocioAsync 0
(0 1
int1 4
	negocioId5 >
)> ?
;? @
Task 
< 	
bool	 
> 
TelefonoEnUsoAsync !
(! "
string" (
telefono) 1
)1 2
;2 3
Task

 
<

 	

Repartidor

	 
?

 
>

 !
ObtenerDeNegocioAsync

 +
(

+ ,
int

, /
	negocioId

0 9
,

9 :
int

; >
repartidorId

? K
)

K L
;

L M
Task 
< 	

Repartidor	 
? 
> $
ObtenerPorUsuarioIdAsync .
(. /
int/ 2
	usuarioId3 <
)< =
;= >
Task 
< 	

Repartidor	 
? 
>  
BuscarEliminadoAsync *
(* +
string+ 1
correo2 8
,8 9
string: @
	documentoA J
)J K
;K L
Task 
ReactivarAsync	 
( 

Repartidor "

repartidor# -
)- .
;. /
} 
public 
	interface %
IAdministracionRepository *
{ 
Task '
RegistrarAdministradorAsync	 $
($ %
Usuario% ,
usuario- 4
,4 5
Administrador6 C
administradorD Q
)Q R
;R S
Task 
< 	
List	 
< 
AdministradorDto 
> 
>  &
ListarAdministradoresAsync! ;
(; <
)< =
;= >
Task 
< 	
List	 
< 
NegocioAdminDto 
> 
> 
ListarNegociosAsync  3
(3 4
)4 5
;5 6
Task 
< 	
bool	 
> 
AprobarNegocioAsync "
(" #
int# &
	negocioId' 0
)0 1
;1 2
Task 
< 	
bool	 
> 
TelefonoEnUsoAsync !
(! "
string" (
telefono) 1
)1 2
;2 3
Task 
< 	
Administrador	 
? 
> $
ObtenerPorUsuarioIdAsync 1
(1 2
int2 5
	usuarioId6 ?
)? @
;@ A
}   ∏
]C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\IPedidoRepository.cs
	namespace 	
Gtrack
 
; 
public 
	interface 
IPedidoRepository "
{ 
Task 
< 	
Pedido	 
? 
> 
ObtenerPorIdAsync #
(# $
int$ '
id( *
)* +
;+ ,
Task 
< 	
Pedido	 
? 
> !
ObtenerPorCodigoAsync '
(' (
string( .
codigo/ 5
)5 6
;6 7
Task 
< 	
Pedido	 
? 
> )
ObtenerUltimoPorTelefonoAsync /
(/ 0
int0 3
	negocioId4 =
,= >
string? E
telefonoF N
)N O
;O P
Task 
< 	
bool	 
> 
ExisteCodigoAsync  
(  !
string! '
codigo( .
). /
;/ 0
Task		 
AgregarAsync			 
(		 
Pedido		 
pedido		 #
)		# $
;		$ %
Task

 
ActualizarAsync

	 
(

 
Pedido

 
pedido

  &
)

& '
;

' (
Task 
< 	
List	 
< 
Pedido 
> 
> "
ObtenerPorNegocioAsync -
(- .
int. 1
	negocioId2 ;
); <
;< =
} ¥
^C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\INegocioRepository.cs
	namespace 	
Gtrack
 
; 
public 
	interface 
INegocioRepository #
{ 
Task 
< 	
Negocio	 
? 
> 
BuscarPorIdAsync #
(# $
int$ '
id( *
)* +
;+ ,
Task 
< 	
Negocio	 
? 
> $
ObtenerPorUsuarioIdAsync +
(+ ,
int, /
	usuarioId0 9
)9 :
;: ;
Task 
< 	
bool	 
>  
ExisteDocumentoAsync #
(# $
string$ *
	documento+ 4
)4 5
;5 6
Task 
< 	
bool	 
> 
ExisteTelefonoAsync "
(" #
string# )
telefono* 2
,2 3
int4 7
?7 8
excluirNegocioId9 I
=J K
nullL P
)P Q
;Q R
Task 
RegistrarAsync	 
( 
Usuario 
usuario  '
,' (
Negocio) 0
negocio1 8
)8 9
;9 :
Task 
ActualizarAsync	 
( 
Negocio  
negocio! (
)( )
;) *
Task 
< 	
bool	 
> $
TienePedidosActivosAsync '
(' (
int( +
	negocioId, 5
)5 6
;6 7
Task 
< 	
bool	 
> ,
 TieneRepartidoresVinculadosAsync /
(/ 0
int0 3
	negocioId4 =
)= >
;> ?
} Ç
iC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\ICodigoVerificacionRepository.cs
	namespace 	
Gtrack
 
; 
public 
	interface )
ICodigoVerificacionRepository .
{ 
Task 
AgregarAsync	 
( 
CodigoVerificacion (
codigo) /
)/ 0
;0 1
Task 
< 	
CodigoVerificacion	 
? 
> 
ObtenerUltimoAsync 0
(0 1
int1 4
	usuarioId5 >
)> ?
;? @
Task 
ActualizarAsync	 
( 
CodigoVerificacion +
codigo, 2
)2 3
;3 4
} “
hC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\CodigoVerificacionRepository.cs
	namespace 	
Gtrack
 
; 
public 
class (
CodigoVerificacionRepository )
() *
AppDbContext* 6
db7 9
)9 :
:; <)
ICodigoVerificacionRepository= Z
{ 
public 

async 
Task 
AgregarAsync "
(" #
CodigoVerificacion# 5
codigo6 <
)< =
{ 
db		 

.		
 
CodigosVerificacion		 
.		 
Add		 "
(		" #
codigo		# )
)		) *
;		* +
await

 
db

 
.

 
SaveChangesAsync

 !
(

! "
)

" #
;

# $
} 
public 

Task 
< 
CodigoVerificacion "
?" #
># $
ObtenerUltimoAsync% 7
(7 8
int8 ;
	usuarioId< E
)E F
=>G I
db 

.
 
CodigosVerificacion 
. 
Where 
( 
c 
=> 
c 
. 
	UsuarioId #
==$ &
	usuarioId' 0
)0 1
. 
OrderByDescending 
( 
c  
=>! #
c$ %
.% &
FechaCreacion& 3
)3 4
. 
ThenByDescending 
( 
c 
=>  "
c# $
.$ %
Id% '
)' (
. 
FirstOrDefaultAsync  
(  !
)! "
;" #
public 

async 
Task 
ActualizarAsync %
(% &
CodigoVerificacion& 8
codigo9 ?
)? @
{ 
db 

.
 
CodigosVerificacion 
. 
Update %
(% &
codigo& ,
), -
;- .
await 
db 
. 
SaveChangesAsync !
(! "
)" #
;# $
} 
} ãF
dC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\AdministracionRepository.cs
	namespace 	
Gtrack
 
; 
public 
class $
AdministracionRepository %
(% &
AppDbContext& 2
db3 5
)5 6
:7 8%
IAdministracionRepository9 R
{ 
public 

async 
Task '
RegistrarAdministradorAsync 1
(1 2
Usuario2 9
usuario: A
,A B
AdministradorC P
administradorQ ^
)^ _
{		 
administrador

 
.

 
Usuario

 
=

 
usuario

  '
;

' (
db 

.
 
Administradores 
. 
Add 
( 
administrador ,
), -
;- .
await 
db 
. 
SaveChangesAsync !
(! "
)" #
;# $
} 
public 

Task 
< 
List 
< 
AdministradorDto %
>% &
>& '&
ListarAdministradoresAsync( B
(B C
)C D
=>E G
( 	
from	 
u 
in 
db 
. 
Usuarios 
where	 
u 
. 
Rol 
== 

RolUsuario "
." #
Administrador# 0
&&1 3
u4 5
.5 6
Estado6 <
!== ?
EstadoCuenta@ L
.L M
	EliminadoM V
join	 
adm 
in 
db 
. 
Administradores '
on( *
u+ ,
., -
Id- /
equals0 6
adm7 :
.: ;
	UsuarioId; D
intoE I
grupoJ O
from	 
a 
in 
grupo 
. 
DefaultIfEmpty '
(' (
)( )
orderby	 
u 
. 
Id 

descending  
select	 
new 
AdministradorDto $
{	 

	UsuarioId 
= 
u 
. 
Id 
, 
NombreCompleto 
= 
a 
!=  "
null# '
?( )
a* +
.+ ,
NombreCompleto, :
:; <
$str= V
,V W
	Documento 
= 
u 
. 
	Documento $
,$ %
Correo 
= 
u 
. 
Correo 
, 
Telefono 
= 
a 
!= 
null !
?" #
a$ %
.% &
Telefono& .
:/ 0
$str1 4
,4 5
Estado 
= 
u 
. 
Estado 
, 
FechaRegistro 
= 
a 
!= !
null" &
?' (
a) *
.* +
FechaRegistro+ 8
:9 :
(; <
DateTime< D
?D E
)E F
nullF J
}	 

)
 
. 
ToListAsync 
( 
) 
; 
public   

Task   
<   
List   
<   
NegocioAdminDto   $
>  $ %
>  % &
ListarNegociosAsync  ' :
(  : ;
)  ; <
=>  = ?
db!! 

.!!
 
Negocios!! 
."" 
OrderByDescending"" 
("" 
n""  
=>""! #
n""$ %
.""% &
FechaRegistro""& 3
)""3 4
.## 
Select## 
(## 
n## 
=>## 
new## 
NegocioAdminDto## ,
{$$ 
Id%% 
=%% 
n%% 
.%% 
Id%% 
,%% 
Nombre&& 
=&& 
n&& 
.&& 
Nombre&& !
,&&! "
TipoActividad'' 
='' 
n''  !
.''! "
TipoActividad''" /
,''/ 0
	Documento(( 
=(( 
n(( 
.(( 
Usuario(( %
!((% &
.((& '
	Documento((' 0
,((0 1
Correo)) 
=)) 
n)) 
.)) 
Usuario)) "
.))" #
Correo))# )
,))) *
Telefono** 
=** 
n** 
.** 
Telefono** %
,**% &
Estado++ 
=++ 
n++ 
.++ 
Usuario++ "
.++" #
Estado++# )
,++) *
FechaRegistro,, 
=,, 
n,,  !
.,,! "
FechaRegistro,," /
}-- 
)-- 
... 
ToListAsync.. 
(.. 
).. 
;.. 
public00 

async00 
Task00 
<00 
bool00 
>00 
AprobarNegocioAsync00 /
(00/ 0
int000 3
	negocioId004 =
)00= >
{11 
var22 
negocio22 
=22 
await22 
db22 
.22 
Negocios22 '
.22' (
Include22( /
(22/ 0
n220 1
=>222 4
n225 6
.226 7
Usuario227 >
)22> ?
.33 
FirstOrDefaultAsync33  
(33  !
n33! "
=>33# %
n33& '
.33' (
Id33( *
==33+ -
	negocioId33. 7
)337 8
;338 9
var44 
usuario44 
=44 
negocio44 
?44 
.44 
Usuario44 &
;44& '
if55 

(55 
negocio55 
is55 
null55 
||55 
usuario55 &
is55' )
null55* .
||55/ 1
usuario552 9
.559 :
Estado55: @
!=55A C
EstadoCuenta55D P
.55P Q
PendienteValidacion55Q d
)55d e
return66 
false66 
;66 
usuario88 
.88 
Estado88 
=88 
EstadoCuenta88 %
.88% &
Activo88& ,
;88, -
usuario99 
.99 
MotivoRechazo99 
=99 
null99  $
;99$ %
db:: 

.::
 
Entry:: 
(:: 
negocio:: 
):: 
.:: 
Property:: "
(::" #
$str::# 4
)::4 5
.::5 6
CurrentValue::6 B
=::C D
DateTime::E M
.::M N
UtcNow::N T
;::T U
await;; 
db;; 
.;; 
SaveChangesAsync;; !
(;;! "
);;" #
;;;# $
return<< 
true<< 
;<< 
}== 
public?? 

async?? 
Task?? 
<?? 
bool?? 
>?? 
TelefonoEnUsoAsync?? .
(??. /
string??/ 5
telefono??6 >
)??> ?
=>??@ B
await@@ 
db@@ 
.@@ 
Negocios@@ 
.@@ 
AnyAsync@@ "
(@@" #
n@@# $
=>@@% '
n@@( )
.@@) *
Telefono@@* 2
==@@3 5
telefono@@6 >
)@@> ?
||@@@ B
awaitAA 
dbAA 
.AA 
RepartidoresAA 
.AA 
AnyAsyncAA &
(AA& '
rAA' (
=>AA) +
rAA, -
.AA- .
TelefonoAA. 6
==AA7 9
telefonoAA: B
&&AAC E
rAAF G
.AAG H
UsuarioAAH O
!AAO P
.AAP Q
EstadoAAQ W
!=AAX Z
EstadoCuentaAA[ g
.AAg h
	EliminadoAAh q
)AAq r
||AAs u
awaitBB 
dbBB 
.BB 
AdministradoresBB  
.BB  !
AnyAsyncBB! )
(BB) *
aBB* +
=>BB, .
aBB/ 0
.BB0 1
TelefonoBB1 9
==BB: <
telefonoBB= E
)BBE F
;BBF G
publicDD 

TaskDD 
<DD 
AdministradorDD 
?DD 
>DD $
ObtenerPorUsuarioIdAsyncDD  8
(DD8 9
intDD9 <
	usuarioIdDD= F
)DDF G
=>DDH J
dbEE 

.EE
 
AdministradoresEE 
.FF 
AsNoTrackingFF 
(FF 
)FF 
.GG 
FirstOrDefaultAsyncGG  
(GG  !
aGG! "
=>GG# %
aGG& '
.GG' (
	UsuarioIdGG( 1
==GG2 4
	usuarioIdGG5 >
)GG> ?
;GG? @
}HH ÓL
FC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Program.cs
var 
builder 
= 
WebApplication 
. 
CreateBuilder *
(* +
args+ /
)/ 0
;0 1
QuestPDF		 
.		 	
Settings			 
.		 
License		 
=		 
QuestPDF		 $
.		$ %
Infrastructure		% 3
.		3 4
LicenseType		4 ?
.		? @
	Community		@ I
;		I J
builder 
. 
Services 
. #
AddControllersWithViews (
(( )
o) *
=>+ -
o. /
./ 0 
ModelBinderProviders0 D
.D E
InsertE K
(K L
$numL M
,M N
newO R/
#InvariantDecimalModelBinderProviderS v
(v w
)w x
)x y
)y z
;z {
builder 
. 
Services 
. 
AddAntiforgery 
(  
o  !
=>" $
o% &
.& '

HeaderName' 1
=2 3
$str4 N
)N O
;O P
builder 
. 
Services 
. 
AddDbContext 
< 
AppDbContext *
>* +
(+ ,
o, -
=>. 0
o 
. 
UseSqlServer 
( 
builder 
. 
Configuration (
.( )
GetConnectionString) <
(< =
$str= G
)G H
)H I
)I J
;J K
builder 
. 
Services 
. 
	AddScoped 
< 
IUsuarioRepository -
,- .
UsuarioRepository/ @
>@ A
(A B
)B C
;C D
builder 
. 
Services 
. 
	AddScoped 
< (
ITokenRecuperacionRepository 7
,7 8'
TokenRecuperacionRepository9 T
>T U
(U V
)V W
;W X
builder 
. 
Services 
. 
	AddScoped 
< 
INegocioRepository -
,- .
NegocioRepository/ @
>@ A
(A B
)B C
;C D
builder 
. 
Services 
. 
	AddScoped 
< )
ICodigoVerificacionRepository 8
,8 9(
CodigoVerificacionRepository: V
>V W
(W X
)X Y
;Y Z
builder 
. 
Services 
. 
	AddScoped 
< !
IRepartidorRepository 0
,0 1 
RepartidorRepository2 F
>F G
(G H
)H I
;I J
builder 
. 
Services 
. 
	AddScoped 
< %
IAdministracionRepository 4
,4 5$
AdministracionRepository6 N
>N O
(O P
)P Q
;Q R
builder 
. 
Services 
. 
	AddScoped 
< 
IPedidoRepository ,
,, -
PedidoRepository. >
>> ?
(? @
)@ A
;A B
builder 
. 
Services 
. 
	AddScoped 
<  
IUbicacionRepository /
,/ 0
UbicacionRepository1 D
>D E
(E F
)F G
;G H
builder 
. 
Services 
. 
	AddScoped 
< 
IPasswordHasher *
<* +
Usuario+ 2
>2 3
,3 4 
BCryptPasswordHasher5 I
>I J
(J K
)K L
;L M
builder 
. 
Services 
. 
	AddScoped 
< 
IAuthService '
,' (
AuthService) 4
>4 5
(5 6
)6 7
;7 8
builder 
. 
Services 
. 
	AddScoped 
<  
IRecuperacionService /
,/ 0
RecuperacionService1 D
>D E
(E F
)F G
;G H
builder 
. 
Services 
. 
	AddScoped 
< 
INegocioService *
,* +
NegocioService, :
>: ;
(; <
)< =
;= >
builder   
.   
Services   
.   
	AddScoped   
<   $
IActivacionCuentaService   3
,  3 4#
ActivacionCuentaService  5 L
>  L M
(  M N
)  N O
;  O P
builder!! 
.!! 
Services!! 
.!! 
	AddScoped!! 
<!! 
IRepartidorService!! -
,!!- .
RepartidorService!!/ @
>!!@ A
(!!A B
)!!B C
;!!C D
builder"" 
."" 
Services"" 
."" 
	AddScoped"" 
<"" $
IPerfilRepartidorService"" 3
,""3 4#
PerfilRepartidorService""5 L
>""L M
(""M N
)""N O
;""O P
builder## 
.## 
Services## 
.## 
	AddScoped## 
<## "
IAdministracionService## 1
,##1 2!
AdministracionService##3 H
>##H I
(##I J
)##J K
;##K L
builder$$ 
.$$ 
Services$$ 
.$$ 
	AddScoped$$ 
<$$ 
IEmailService$$ (
,$$( )
EmailSmtpService$$* :
>$$: ;
($$; <
)$$< =
;$$= >
builder%% 
.%% 
Services%% 
.%% 
	AddScoped%% 
<%% 
IPedidoService%% )
,%%) *
PedidoService%%+ 8
>%%8 9
(%%9 :
)%%: ;
;%%; <
builder&& 
.&& 
Services&& 
.&& 
	AddScoped&& 
<&& 
IUbicacionService&& ,
,&&, -
UbicacionService&&. >
>&&> ?
(&&? @
)&&@ A
;&&A B
builder'' 
.'' 
Services'' 
.'' 
	AddScoped'' 
<'' 
IReporteService'' *
,''* +
ReporteService'', :
>'': ;
(''; <
)''< =
;''= >
builder(( 
.(( 
Services(( 
.(( 
AddSingleton(( 
<(( 
IExportadorReportes(( 1
,((1 2
ExportadorReportes((3 E
>((E F
(((F G
)((G H
;((H I
builder** 
.** 
Services** 
.** 
AddAuthentication** "
(**" #(
CookieAuthenticationDefaults**# ?
.**? @ 
AuthenticationScheme**@ T
)**T U
.++ 
	AddCookie++ 
(++ 
o++ 
=>++ 
{,, 
o-- 	
.--	 

	LoginPath--
 
=-- 
$str-- &
;--& '
o.. 	
...	 

AccessDeniedPath..
 
=.. 
$str.. -
;..- .
o11 	
.11	 

ExpireTimeSpan11
 
=11 
TimeSpan11 #
.11# $
FromMinutes11$ /
(11/ 0
$num110 2
)112 3
;113 4
o22 	
.22	 

SlidingExpiration22
 
=22 
true22 "
;22" #
o33 	
.33	 

Cookie33
 
.33 
HttpOnly33 
=33 
true33  
;33  !
o44 	
.44	 

Cookie44
 
.44 
SecurePolicy44 
=44 
CookieSecurePolicy44  2
.442 3
SameAsRequest443 @
;44@ A
}55 
)55 
;55 
var77 
app77 
=77 	
builder77
 
.77 
Build77 
(77 
)77 
;77 
if99 
(99 
!99 
app99 
.99 	
Environment99	 
.99 
IsDevelopment99 "
(99" #
)99# $
)99$ %
{:: 
app;; 
.;; 
UseExceptionHandler;; 
(;; 
$str;; )
);;) *
;;;* +
app<< 
.<< 
UseHsts<< 
(<< 
)<< 
;<< 
}== 
app@@ 
.@@ +
UseStatusCodePagesWithReExecute@@ #
(@@# $
$str@@$ 6
,@@6 7
$str@@8 C
)@@C D
;@@D E
appBB 
.BB 
UseHttpsRedirectionBB 
(BB 
)BB 
;BB 
appCC 
.CC 
UseStaticFilesCC 
(CC 
)CC 
;CC 
appDD 
.DD 

UseRoutingDD 
(DD 
)DD 
;DD 
appEE 
.EE 
UseAuthenticationEE 
(EE 
)EE 
;EE 
appFF 
.FF 
UseAuthorizationFF 
(FF 
)FF 
;FF 
appII 
.II 
MapControllerRouteII 
(II 
nameJJ 
:JJ 	
$strJJ
 
,JJ 
patternKK 
:KK 
$strKK 5
)KK5 6
;KK6 7
awaitMM 
appMM 	
.MM	 

RunAsyncMM
 
(MM 
)MM 
;MM °
MC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\Usuario.cs
	namespace 	
Gtrack
 
; 
public 
enum 

RolUsuario 
{ 
Negocio  
,  !

Repartidor" ,
,, -
Administrador. ;
}< =
public 
enum 
EstadoCuenta 
{ 
PendienteValidacion .
,. /
Activo0 6
,6 7

Suspendido8 B
,B C
	RechazadoD M
,M N
	EliminadoO X
,X Y
PendienteActivacionZ m
}n o
public

 
class

 
Usuario

 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
Correo 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
public 

string 
	Documento 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
public 

string 
PasswordHash 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
$str/ 1
;1 2
public 


RolUsuario 
Rol 
{ 
get 
;  
set! $
;$ %
}& '
public 

EstadoCuenta 
Estado 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
EstadoCuenta/ ;
.; <
PendienteValidacion< O
;O P
public 

string 
? 
MotivoRechazo  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

int 
IntentosFallidos 
{  !
get" %
;% &
set' *
;* +
}, -
public 

DateTime 
? 
BloqueadoHasta #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 

void "
LiberarIdentificadores &
(& '
)' (
{ 
Correo 
= 
Recortar 
( 
$" 
$str &
{& '
Id' )
}) *
$str* +
{+ ,
Correo, 2
}2 3
"3 4
,4 5
$num6 9
)9 :
;: ;
	Documento 
= 
Recortar 
( 
$" 
$str  
{  !
Id! #
}# $
$str$ %
{% &
	Documento& /
}/ 0
"0 1
,1 2
$num3 5
)5 6
;6 7
} 
private 
static 
string 
Recortar "
(" #
string# )
valor* /
,/ 0
int1 4
max5 8
)8 9
=>: <
valor= B
.B C
LengthC I
<=J L
maxM P
?Q R
valorS X
:Y Z
valor[ `
[` a
..a c
maxc f
]f g
;g h
}   Â
UC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\UbicacionPedido.cs
	namespace 	
Gtrack
 
; 
public 
class 
UbicacionPedido 
{ 
public 

int 
PedidoId 
{ 
get 
; 
set "
;" #
}$ %
public 

Pedido 
? 
Pedido 
{ 
get 
;  
set! $
;$ %
}& '
public 

decimal 
Latitud 
{ 
get  
;  !
set" %
;% &
}' (
public 

decimal 
Longitud 
{ 
get !
;! "
set# &
;& '
}( )
public		 

DateTime		 
FechaActualizacion		 &
{		' (
get		) ,
;		, -
set		. 1
;		1 2
}		3 4
=		5 6
DateTime		7 ?
.		? @
UtcNow		@ F
;		F G
}

 ñ

WC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\TokenRecuperacion.cs
	namespace 	
Gtrack
 
; 
public 
class 
TokenRecuperacion 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
	UsuarioId 
{ 
get 
; 
set  #
;# $
}% &
public 

string 
	TokenHash 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
public 

DateTime 
FechaCreacion !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
DateTime2 :
.: ;
UtcNow; A
;A B
public		 

DateTime		 
Expira		 
{		 
get		  
;		  !
set		" %
;		% &
}		' (
public

 

bool

 
Usado

 
{

 
get

 
;

 
set

  
;

  !
}

" #
} ÿ
ZC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\SuspensionRepartidor.cs
	namespace 	
Gtrack
 
; 
[ 
Table 
( 
$str 
) 
] 
public 
class  
SuspensionRepartidor !
{ 
[		 
Key		 
]		 	
public

 

int

 
Id

 
{

 
get

 
;

 
set

 
;

 
}

 
public 

int 
RepartidorId 
{ 
get !
;! "
set# &
;& '
}( )
public 

int 
AdministradorId 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

string 
Motivo 
{ 
get 
; 
set  #
;# $
}% &
=' (
string) /
./ 0
Empty0 5
;5 6
public 

DateTime 
FechaSuspension #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 

int 
? (
ReactivadoPorAdministradorId ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
public 

DateTime 
? 
FechaReactivacion &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
} è	
ZC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\SolicitudCancelacion.cs
	namespace 	
Gtrack
 
; 
public 
class  
SolicitudCancelacion !
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
PedidoId 
{ 
get 
; 
set "
;" #
}$ %
public		 

Pedido		 
?		 
Pedido		 
{		 
get		 
;		  
set		! $
;		$ %
}		& '
public

 

string

 
Motivo

 
{

 
get

 
;

 
set

  #
;

# $
}

% &
=

' (
$str

) +
;

+ ,
public 

DateTime 
FechaSolicitud "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
DateTime3 ;
.; <
UtcNow< B
;B C
} ‘
NC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\Personal.cs
	namespace 	
Gtrack
 
; 
public 
enum 
TipoVehiculo 
{ 
	Bicicleta $
,$ %
Moto& *
,* +
Carro, 1
,1 2
APie3 7
}8 9
public 
class 

Repartidor 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public		 

int		 
	UsuarioId		 
{		 
get		 
;		 
set		  #
;		# $
}		% &
public

 

Usuario

 
?

 
Usuario

 
{

 
get

 !
;

! "
set

# &
;

& '
}

( )
public 

int 
	NegocioId 
{ 
get 
; 
set  #
;# $
}% &
public 

string 
NombreCompleto  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
$str1 3
;3 4
public 

string 
Telefono 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
public 

TipoVehiculo 
Vehiculo  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

string 
? 
Placa 
{ 
get 
; 
set  #
;# $
}% &
public 

DateTime 
FechaRegistro !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
DateTime2 :
.: ;
UtcNow; A
;A B
} 
public 
class 
Administrador 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
	UsuarioId 
{ 
get 
; 
set  #
;# $
}% &
public 

Usuario 
? 
Usuario 
{ 
get !
;! "
set# &
;& '
}( )
public 

string 
NombreCompleto  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
$str1 3
;3 4
public 

string 
Telefono 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
public 

DateTime 
FechaRegistro !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
DateTime2 :
.: ;
UtcNow; A
;A B
} Ú
LC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\Pedido.cs
	namespace 	
Gtrack
 
; 
public 
class 
Pedido 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
Codigo 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
public 

int 
	NegocioId 
{ 
get 
; 
set  #
;# $
}% &
public 

Negocio 
? 
Negocio 
{ 
get !
;! "
set# &
;& '
}( )
public

 

int

 
	ClienteId

 
{

 
get

 
;

 
set

  #
;

# $
}

% &
public 

Cliente 
? 
Cliente 
{ 
get !
;! "
set# &
;& '
}( )
public 

int 
? 
RepartidorId 
{ 
get "
;" #
set$ '
;' (
}) *
public 


Repartidor 
? 

Repartidor !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 

string 
DireccionEntrega "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
$str3 5
;5 6
public 

int 
MetodoPagoId 
{ 
get !
;! "
set# &
;& '
}( )
public 

int 
EstadoPedidoId 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
$num. /
;/ 0
public 

DateTime 
FechaCreacion !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
DateTime2 :
.: ;
UtcNow; A
;A B
public 

List 
< 

ItemPedido 
> 
Items !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
[2 3
]3 4
;4 5
} 
public 
class 

ItemPedido 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
PedidoId 
{ 
get 
; 
set "
;" #
}$ %
public 

Pedido 
? 
Pedido 
{ 
get 
;  
set! $
;$ %
}& '
public 

string 
Descripcion 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
$str. 0
;0 1
public   

int   
Cantidad   
{   
get   
;   
set   "
;  " #
}  $ %
public!! 

decimal!! 
PrecioUnitario!! !
{!!" #
get!!$ '
;!!' (
set!!) ,
;!!, -
}!!. /
}"" 
public$$ 
enum$$ 
EstadoPedido$$ 
{%% 
Recibido&& 
,&& 
EnPreparacion'' 
,'' 
ListoParaEntrega(( 
,(( 
Asignado)) 
,)) 
EnCamino** 
,** 
	Entregado++ 
,++ 
	Cancelado,, 
}-- Ò
SC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\NovedadPedido.cs
	namespace 	
Gtrack
 
; 
public 
class 
NovedadPedido 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
PedidoId 
{ 
get 
; 
set "
;" #
}$ %
public		 

Pedido		 
?		 
Pedido		 
{		 
get		 
;		  
set		! $
;		$ %
}		& '
public

 

int

 
TipoNovedadId

 
{

 
get

 "
;

" #
set

$ '
;

' (
}

) *
public 

string 
? 
Observaciones  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

DateTime 
Fecha 
{ 
get 
;  
set! $
;$ %
}& '
=( )
DateTime* 2
.2 3
UtcNow3 9
;9 :
} 
public 
enum 
TipoNovedad 
{ 
ClienteAusente 
, 
DireccionIncorrecta 
,  
ProductoNoDisponible 
, 
Otro 
} ·
MC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\Negocio.cs
	namespace 	
Gtrack
 
; 
public 
class 
Negocio 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
	UsuarioId 
{ 
get 
; 
set  #
;# $
}% &
public		 

Usuario		 
?		 
Usuario		 
{		 
get		 !
;		! "
set		# &
;		& '
}		( )
public

 

string

 
Nombre

 
{

 
get

 
;

 
set

  #
;

# $
}

% &
=

' (
$str

) +
;

+ ,
public 

string 
TipoActividad 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$str0 2
;2 3
public 

string 
Telefono 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
public 

string 
	Direccion 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
public 

DateTime 
FechaRegistro !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
DateTime2 :
.: ;
UtcNow; A
;A B
} ˜
TC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\ErrorViewModel.cs
	namespace 	
Gtrack
 
; 
public 
class 
ErrorViewModel 
{ 
public 

string 
? 
	RequestId 
{ 
get "
;" #
set$ '
;' (
}) *
public 

bool 
ShowRequestId 
=>  
!! "
string" (
.( )
IsNullOrEmpty) 6
(6 7
	RequestId7 @
)@ A
;A B
} Å
XC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\CodigoVerificacion.cs
	namespace 	
Gtrack
 
; 
public 
class 
CodigoVerificacion 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
	UsuarioId 
{ 
get 
; 
set  #
;# $
}% &
public 

string 

CodigoHash 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
$str- /
;/ 0
public		 

DateTime		 
FechaCreacion		 !
{		" #
get		$ '
;		' (
set		) ,
;		, -
}		. /
=		0 1
DateTime		2 :
.		: ;
UtcNow		; A
;		A B
public

 

DateTime

 
Expira

 
{

 
get

  
;

  !
set

" %
;

% &
}

' (
public 

int 
Intentos 
{ 
get 
; 
set "
;" #
}$ %
public 

DateTime 
? 
BloqueadoHasta #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 

bool 

Verificado 
{ 
get  
;  !
set" %
;% &
}' (
public 

bool 
Usado 
{ 
get 
; 
set  
;  !
}" #
} Ö
MC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\Cliente.cs
	namespace 	
Gtrack
 
; 
public 
class 
Cliente 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
NombreCompleto  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
$str1 3
;3 4
public 

string 
Telefono 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
public 

string 
? #
DireccionPredeterminada *
{+ ,
get- 0
;0 1
set2 5
;5 6
}7 8
public		 

DateTime		 
FechaRegistro		 !
{		" #
get		$ '
;		' (
set		) ,
;		, -
}		. /
=		0 1
DateTime		2 :
.		: ;
UtcNow		; A
;		A B
public

 

int

 
	NegocioId

 
{

 
get

 
;

 
set

  #
;

# $
}

% &
public 

Negocio 
? 
Negocio 
{ 
get !
;! "
set# &
;& '
}( )
} Å
VC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\VerificarCodigoDto.cs
	namespace 	
Gtrack
 
; 
public 
class 
VerificarCodigoDto 
{ 
[ 
Display 
( 
Name 
= 
$str ,
), -
]- .
[ 
Required 
( 
ErrorMessage 
= 
$str >
)> ?
]? @
[		 
RegularExpression		 
(		 
$str		 !
,		! "
ErrorMessage		# /
=		0 1
$str		2 M
)		M N
]		N O
public

 

string

 
Codigo

 
{

 
get

 
;

 
set

  #
;

# $
}

% &
=

' (
$str

) +
;

+ ,
} ÷
RC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\RestablecerDto.cs
	namespace 	
Gtrack
 
; 
public 
class 
RestablecerDto 
{ 
public 

string 
Token 
{ 
get 
; 
set "
;" #
}$ %
=& '
$str( *
;* +
public 

string 
NuevaPassword 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$str0 2
;2 3
public 

string 
ConfirmarPassword #
{$ %
get& )
;) *
set+ .
;. /
}0 1
=2 3
$str4 6
;6 7
} Ëa
YC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\RergistroPersonalDtos.cs
	namespace 	
Gtrack
 
; 
public 
record 
ResultadoRegistro 
(  
bool  $
Ok% '
,' (
string) /
?/ 0
Error1 6
,6 7
bool8 <
CorreoEnviado= J
,J K
stringL R
?R S
PasswordTemporalT d
,d e
stringf l
?l m
Campon s
=t u
nullv z
)z {
;{ |
public		 
class		 !
RegistroRepartidorDto		 "
:		# $
IValidatableObject		% 7
{

 
[ 
Display 
( 
Name 
= 
$str %
)% &
]& '
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
[ 
StringLength 
( 
$num 
, 
MinimumLength $
=% &
$num' (
,( )
ErrorMessage* 6
=7 8
$str9 ^
)^ _
]_ `
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
NombrePersona( 5
,5 6
ErrorMessage7 C
=D E
ReglasValidacionF V
.V W 
NombrePersonaMensajeW k
)k l
]l m
public 

string 
NombreCompleto  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
$str1 3
;3 4
[ 
Display 
( 
Name 
= 
$str )
)) *
]* +
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
	Documento( 1
,1 2
ErrorMessage3 ?
=@ A
ReglasValidacionB R
.R S
DocumentoMensajeS c
)c d
]d e
public 

string 
	Documento 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
[ 
Display 
( 
Name 
= 
$str 
) 
]  
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
Telefono( 0
,0 1
ErrorMessage2 >
=? @
ReglasValidacionA Q
.Q R
TelefonoMensajeR a
)a b
]b c
public 

string 
Telefono 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
[ 
Display 
( 
Name 
= 
$str (
)( )
]) *
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
Correo( .
,. /
ErrorMessage0 <
== >
ReglasValidacion? O
.O P
CorreoMensajeP ]
)] ^
]^ _
[ 
StringLength 
( 
$num 
, 
ErrorMessage #
=$ %
$str& =
)= >
]> ?
public 

string 
Correo 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
[!! 
Display!! 
(!! 
Name!! 
=!! 
$str!! &
)!!& '
]!!' (
["" 
Required"" 
("" 
ErrorMessage"" 
="" 
RegistroNegocioDto"" /
.""/ 0
Obligatorio""0 ;
)""; <
]""< =
public## 

TipoVehiculo## 
?## 
Vehiculo## !
{##" #
get##$ '
;##' (
set##) ,
;##, -
}##. /
[%% 
Display%% 
(%% 
Name%% 
=%% 
$str%% 
)%% 
]%% 
public&& 

string&& 
?&& 
Placa&& 
{&& 
get&& 
;&& 
set&&  #
;&&# $
}&&% &
public)) 

IEnumerable)) 
<)) 
ValidationResult)) '
>))' (
Validate))) 1
())1 2
ValidationContext))2 C
context))D K
)))K L
{** 
return++ 
ReglasValidacion++ 
.++  
ValidarVehiculo++  /
(++/ 0
Vehiculo++0 8
,++8 9
Placa++: ?
)++? @
;++@ A
},, 
}-- 
public00 
class00 $
RegistroAdministradorDto00 %
{11 
[22 
Display22 
(22 
Name22 
=22 
$str22 %
)22% &
]22& '
[33 
Required33 
(33 
ErrorMessage33 
=33 
RegistroNegocioDto33 /
.33/ 0
Obligatorio330 ;
)33; <
]33< =
[44 
StringLength44 
(44 
$num44 
,44 
MinimumLength44 $
=44% &
$num44' (
,44( )
ErrorMessage44* 6
=447 8
$str449 ^
)44^ _
]44_ `
[55 
RegularExpression55 
(55 
ReglasValidacion55 '
.55' (
NombrePersona55( 5
,555 6
ErrorMessage557 C
=55D E
ReglasValidacion55F V
.55V W 
NombrePersonaMensaje55W k
)55k l
]55l m
public66 

string66 
NombreCompleto66  
{66! "
get66# &
;66& '
set66( +
;66+ ,
}66- .
=66/ 0
$str661 3
;663 4
[88 
Display88 
(88 
Name88 
=88 
$str88 )
)88) *
]88* +
[99 
Required99 
(99 
ErrorMessage99 
=99 
RegistroNegocioDto99 /
.99/ 0
Obligatorio990 ;
)99; <
]99< =
[:: 
RegularExpression:: 
(:: 
ReglasValidacion:: '
.::' (
	Documento::( 1
,::1 2
ErrorMessage::3 ?
=::@ A
ReglasValidacion::B R
.::R S
DocumentoMensaje::S c
)::c d
]::d e
public;; 

string;; 
	Documento;; 
{;; 
get;; !
;;;! "
set;;# &
;;;& '
};;( )
=;;* +
$str;;, .
;;;. /
[== 
Display== 
(== 
Name== 
=== 
$str== (
)==( )
]==) *
[>> 
Required>> 
(>> 
ErrorMessage>> 
=>> 
RegistroNegocioDto>> /
.>>/ 0
Obligatorio>>0 ;
)>>; <
]>>< =
[?? 
RegularExpression?? 
(?? 
ReglasValidacion?? '
.??' (
Correo??( .
,??. /
ErrorMessage??0 <
=??= >
ReglasValidacion??? O
.??O P
CorreoMensaje??P ]
)??] ^
]??^ _
[@@ 
StringLength@@ 
(@@ 
$num@@ 
,@@ 
ErrorMessage@@ #
=@@$ %
$str@@& =
)@@= >
]@@> ?
publicAA 

stringAA 
CorreoAA 
{AA 
getAA 
;AA 
setAA  #
;AA# $
}AA% &
=AA' (
$strAA) +
;AA+ ,
[CC 
DisplayCC 
(CC 
NameCC 
=CC 
$strCC 
)CC 
]CC  
[DD 
RequiredDD 
(DD 
ErrorMessageDD 
=DD 
RegistroNegocioDtoDD /
.DD/ 0
ObligatorioDD0 ;
)DD; <
]DD< =
[EE 
RegularExpressionEE 
(EE 
ReglasValidacionEE '
.EE' (
TelefonoEE( 0
,EE0 1
ErrorMessageEE2 >
=EE? @
ReglasValidacionEEA Q
.EEQ R
TelefonoMensajeEER a
)EEa b
]EEb c
publicFF 

stringFF 
TelefonoFF 
{FF 
getFF  
;FF  !
setFF" %
;FF% &
}FF' (
=FF) *
$strFF+ -
;FF- .
}GG 
publicJJ 
classJJ 
NegocioAdminDtoJJ 
{KK 
publicLL 

intLL 
IdLL 
{LL 
getLL 
;LL 
setLL 
;LL 
}LL 
publicMM 

stringMM 
NombreMM 
{MM 
getMM 
;MM 
setMM  #
;MM# $
}MM% &
=MM' (
$strMM) +
;MM+ ,
publicNN 

stringNN 
TipoActividadNN 
{NN  !
getNN" %
;NN% &
setNN' *
;NN* +
}NN, -
=NN. /
$strNN0 2
;NN2 3
publicOO 

stringOO 
	DocumentoOO 
{OO 
getOO !
;OO! "
setOO# &
;OO& '
}OO( )
=OO* +
$strOO, .
;OO. /
publicPP 

stringPP 
CorreoPP 
{PP 
getPP 
;PP 
setPP  #
;PP# $
}PP% &
=PP' (
$strPP) +
;PP+ ,
publicQQ 

stringQQ 
TelefonoQQ 
{QQ 
getQQ  
;QQ  !
setQQ" %
;QQ% &
}QQ' (
=QQ) *
$strQQ+ -
;QQ- .
publicRR 

EstadoCuentaRR 
EstadoRR 
{RR  
getRR! $
;RR$ %
setRR& )
;RR) *
}RR+ ,
publicSS 

DateTimeSS 
FechaRegistroSS !
{SS" #
getSS$ '
;SS' (
setSS) ,
;SS, -
}SS. /
}TT 
publicVV 
classVV 
AdministradorDtoVV 
{WW 
publicXX 

intXX 
	UsuarioIdXX 
{XX 
getXX 
;XX 
setXX  #
;XX# $
}XX% &
publicYY 

stringYY 
NombreCompletoYY  
{YY! "
getYY# &
;YY& '
setYY( +
;YY+ ,
}YY- .
=YY/ 0
$strYY1 3
;YY3 4
publicZZ 

stringZZ 
	DocumentoZZ 
{ZZ 
getZZ !
;ZZ! "
setZZ# &
;ZZ& '
}ZZ( )
=ZZ* +
$strZZ, .
;ZZ. /
public[[ 

string[[ 
Correo[[ 
{[[ 
get[[ 
;[[ 
set[[  #
;[[# $
}[[% &
=[[' (
$str[[) +
;[[+ ,
public\\ 

string\\ 
Telefono\\ 
{\\ 
get\\  
;\\  !
set\\" %
;\\% &
}\\' (
=\\) *
$str\\+ -
;\\- .
public]] 

EstadoCuenta]] 
Estado]] 
{]]  
get]]! $
;]]$ %
set]]& )
;]]) *
}]]+ ,
public^^ 

DateTime^^ 
?^^ 
FechaRegistro^^ "
{^^# $
get^^% (
;^^( )
set^^* -
;^^- .
}^^/ 0
}__ ùt
OC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\ReporteDtos.cs
	namespace 	
Gtrack
 
; 
public 
class 
FilaEstadoReporte 
{ 
public 

int 
EstadoId 
{ 
get 
; 
set "
;" #
}$ %
public 

string 
Estado 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
public 

string 
Color 
{ 
get 
; 
set "
;" #
}$ %
=& '
$str( 1
;1 2
public		 

int		 
Cantidad		 
{		 
get		 
;		 
set		 "
;		" #
}		$ %
public

 

decimal

 

Porcentaje

 
{

 
get

  #
;

# $
set

% (
;

( )
}

* +
} 
public 
class 
FilaMesReporte 
{ 
public 

string 
Mes 
{ 
get 
; 
set  
;  !
}" #
=$ %
$str& (
;( )
public 

int 
Total 
{ 
get 
; 
set 
;  
}! "
public 

int 

Entregados 
{ 
get 
;  
set! $
;$ %
}& '
public 

int 

Cancelados 
{ 
get 
;  
set! $
;$ %
}& '
public 

decimal 
ValorEntregado !
{" #
get$ '
;' (
set) ,
;, -
}. /
} 
public 
class 
FilaPedidoReporte 
{ 
public 

string 
Codigo 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
public 

string 
Cliente 
{ 
get 
;  
set! $
;$ %
}& '
=( )
$str* ,
;, -
public 

DateTime 
Fecha 
{ 
get 
;  
set! $
;$ %
}& '
public 

string 
Estado 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
public 

string 

Repartidor 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
$str- /
;/ 0
public 

decimal 

ValorTotal 
{ 
get  #
;# $
set% (
;( )
}* +
} 
public!! 
class!! 
ReporteNegocioDto!! 
{"" 
public## 

string## 
NombreNegocio## 
{##  !
get##" %
;##% &
set##' *
;##* +
}##, -
=##. /
$str##0 2
;##2 3
public$$ 

DateTime$$ 
Desde$$ 
{$$ 
get$$ 
;$$  
set$$! $
;$$$ %
}$$& '
public%% 

DateTime%% 
Hasta%% 
{%% 
get%% 
;%%  
set%%! $
;%%$ %
}%%& '
public&& 

DateTime&& 

GeneradoEn&& 
{&&  
get&&! $
;&&$ %
set&&& )
;&&) *
}&&+ ,
public(( 

int(( 
TotalPedidos(( 
{(( 
get(( !
;((! "
set((# &
;((& '
}((( )
public)) 

int)) 

Entregados)) 
{)) 
get)) 
;))  
set))! $
;))$ %
}))& '
public** 

int** 

Cancelados** 
{** 
get** 
;**  
set**! $
;**$ %
}**& '
public++ 

decimal++ 
TasaEntrega++ 
{++  
get++! $
;++$ %
set++& )
;++) *
}+++ ,
public,, 

decimal,, 
ValorEntregado,, !
{,," #
get,,$ '
;,,' (
set,,) ,
;,,, -
},,. /
public.. 

List.. 
<.. 
FilaEstadoReporte.. !
>..! "
	PorEstado..# ,
{..- .
get../ 2
;..2 3
set..4 7
;..7 8
}..9 :
=..; <
[..= >
]..> ?
;..? @
public// 

List// 
<// 
FilaMesReporte// 
>// 
PorMes//  &
{//' (
get//) ,
;//, -
set//. 1
;//1 2
}//3 4
=//5 6
[//7 8
]//8 9
;//9 :
public00 

List00 
<00 
FilaPedidoReporte00 !
>00! "
Pedidos00# *
{00+ ,
get00- 0
;000 1
set002 5
;005 6
}007 8
=009 :
[00; <
]00< =
;00= >
}11 
public44 
class44 
HistorialExportDto44 
{55 
public66 

string66 
NombreNegocio66 
{66  !
get66" %
;66% &
set66' *
;66* +
}66, -
=66. /
$str660 2
;662 3
public77 

DateTime77 
Desde77 
{77 
get77 
;77  
set77! $
;77$ %
}77& '
public88 

DateTime88 
Hasta88 
{88 
get88 
;88  
set88! $
;88$ %
}88& '
public99 

DateTime99 

GeneradoEn99 
{99  
get99! $
;99$ %
set99& )
;99) *
}99+ ,
public:: 

List:: 
<:: 
FilaPedidoReporte:: !
>::! "
Filas::# (
{::) *
get::+ .
;::. /
set::0 3
;::3 4
}::5 6
=::7 8
[::9 :
]::: ;
;::; <
};; 
public>> 
class>> 
FilaConteoReporte>> 
{?? 
public@@ 

string@@ 
Etiqueta@@ 
{@@ 
get@@  
;@@  !
set@@" %
;@@% &
}@@' (
=@@) *
$str@@+ -
;@@- .
publicAA 

stringAA 
ColorAA 
{AA 
getAA 
;AA 
setAA "
;AA" #
}AA$ %
=AA& '
$strAA( 1
;AA1 2
publicBB 

intBB 
CantidadBB 
{BB 
getBB 
;BB 
setBB "
;BB" #
}BB$ %
publicCC 

decimalCC 

PorcentajeCC 
{CC 
getCC  #
;CC# $
setCC% (
;CC( )
}CC* +
}DD 
publicFF 
classFF 
FilaNegocioReporteFF 
{GG 
publicHH 

stringHH 
NombreHH 
{HH 
getHH 
;HH 
setHH  #
;HH# $
}HH% &
=HH' (
$strHH) +
;HH+ ,
publicII 

stringII 
	ActividadII 
{II 
getII !
;II! "
setII# &
;II& '
}II( )
=II* +
$strII, .
;II. /
publicJJ 

stringJJ 
	DocumentoJJ 
{JJ 
getJJ !
;JJ! "
setJJ# &
;JJ& '
}JJ( )
=JJ* +
$strJJ, .
;JJ. /
publicKK 

stringKK 
CorreoKK 
{KK 
getKK 
;KK 
setKK  #
;KK# $
}KK% &
=KK' (
$strKK) +
;KK+ ,
publicLL 

DateTimeLL 
FechaRegistroLL !
{LL" #
getLL$ '
;LL' (
setLL) ,
;LL, -
}LL. /
publicMM 

stringMM 
EstadoMM 
{MM 
getMM 
;MM 
setMM  #
;MM# $
}MM% &
=MM' (
$strMM) +
;MM+ ,
}NN 
publicPP 
classPP !
FilaTopNegocioReportePP "
{QQ 
publicRR 

stringRR 
NombreRR 
{RR 
getRR 
;RR 
setRR  #
;RR# $
}RR% &
=RR' (
$strRR) +
;RR+ ,
publicSS 

intSS 
PedidosSS 
{SS 
getSS 
;SS 
setSS !
;SS! "
}SS# $
publicTT 

intTT 

EntregadosTT 
{TT 
getTT 
;TT  
setTT! $
;TT$ %
}TT& '
publicUU 

decimalUU 
ValorEntregadoUU !
{UU" #
getUU$ '
;UU' (
setUU) ,
;UU, -
}UU. /
}VV 
publicXX 
classXX 
ReporteAdminDtoXX 
{YY 
publicZZ 

DateTimeZZ 
DesdeZZ 
{ZZ 
getZZ 
;ZZ  
setZZ! $
;ZZ$ %
}ZZ& '
public[[ 

DateTime[[ 
Hasta[[ 
{[[ 
get[[ 
;[[  
set[[! $
;[[$ %
}[[& '
public\\ 

DateTime\\ 

GeneradoEn\\ 
{\\  
get\\! $
;\\$ %
set\\& )
;\\) *
}\\+ ,
public__ 

int__ 
NegociosRegistrados__ "
{__# $
get__% (
;__( )
set__* -
;__- .
}__/ 0
public`` 

int``  
NegociosActivosTotal`` #
{``$ %
get``& )
;``) *
set``+ .
;``. /
}``0 1
publicaa 

intaa #
RepartidoresRegistradosaa &
{aa' (
getaa) ,
;aa, -
setaa. 1
;aa1 2
}aa3 4
publicbb 

intbb 
TotalPedidosbb 
{bb 
getbb !
;bb! "
setbb# &
;bb& '
}bb( )
publiccc 

intcc 
PedidosEntregadoscc  
{cc! "
getcc# &
;cc& '
setcc( +
;cc+ ,
}cc- .
publicdd 

decimaldd 
ValorEntregadodd !
{dd" #
getdd$ '
;dd' (
setdd) ,
;dd, -
}dd. /
publicff 

Listff 
<ff 
FilaMesReporteff 
>ff 
NegociosPorMesff  .
{ff/ 0
getff1 4
;ff4 5
setff6 9
;ff9 :
}ff; <
=ff= >
[ff? @
]ff@ A
;ffA B
publicgg 

Listgg 
<gg 
FilaConteoReportegg !
>gg! "
NegociosPorEstadogg# 4
{gg5 6
getgg7 :
;gg: ;
setgg< ?
;gg? @
}ggA B
=ggC D
[ggE F
]ggF G
;ggG H
publichh 

Listhh 
<hh 
FilaConteoReportehh !
>hh! " 
NegociosPorActividadhh# 7
{hh8 9
gethh: =
;hh= >
sethh? B
;hhB C
}hhD E
=hhF G
[hhH I
]hhI J
;hhJ K
publicii 

Listii 
<ii 
FilaEstadoReporteii !
>ii! "
PedidosPorEstadoii# 3
{ii4 5
getii6 9
;ii9 :
setii; >
;ii> ?
}ii@ A
=iiB C
[iiD E
]iiE F
;iiF G
publicjj 

Listjj 
<jj !
FilaTopNegocioReportejj %
>jj% &
TopNegociosjj' 2
{jj3 4
getjj5 8
;jj8 9
setjj: =
;jj= >
}jj? @
=jjA B
[jjC D
]jjD E
;jjE F
publickk 

Listkk 
<kk 
FilaNegocioReportekk "
>kk" #
Negocioskk$ ,
{kk- .
getkk/ 2
;kk2 3
setkk4 7
;kk7 8
}kk9 :
=kk; <
[kk= >
]kk> ?
;kk? @
}ll 
publicoo 
classoo 
ReporteNegocioVistaoo  
{pp 
publicqq 

DateTimeqq 
Desdeqq 
{qq 
getqq 
;qq  
setqq! $
;qq$ %
}qq& '
publicrr 

DateTimerr 
Hastarr 
{rr 
getrr 
;rr  
setrr! $
;rr$ %
}rr& '
publicss 

ReporteNegocioDtoss 
?ss 
Reportess %
{ss& '
getss( +
;ss+ ,
setss- 0
;ss0 1
}ss2 3
publictt 

stringtt 
?tt 
Errortt 
{tt 
gettt 
;tt 
settt  #
;tt# $
}tt% &
publicuu 

stringuu 
?uu 
Avisouu 
{uu 
getuu 
;uu 
setuu  #
;uu# $
}uu% &
}vv 
publicxx 
classxx 
ReporteAdminVistaxx 
{yy 
publiczz 

DateTimezz 
Desdezz 
{zz 
getzz 
;zz  
setzz! $
;zz$ %
}zz& '
public{{ 

DateTime{{ 
Hasta{{ 
{{{ 
get{{ 
;{{  
set{{! $
;{{$ %
}{{& '
public|| 

ReporteAdminDto|| 
?|| 
Reporte|| #
{||$ %
get||& )
;||) *
set||+ .
;||. /
}||0 1
public}} 

string}} 
?}} 
Error}} 
{}} 
get}} 
;}} 
set}}  #
;}}# $
}}}% &
public~~ 

string~~ 
?~~ 
Aviso~~ 
{~~ 
get~~ 
;~~ 
set~~  #
;~~# $
}~~% &
} 
publicÇÇ 
record
ÇÇ 
BarraGrafica
ÇÇ 
(
ÇÇ 
string
ÇÇ !
Etiqueta
ÇÇ" *
,
ÇÇ* +
int
ÇÇ, /
Cantidad
ÇÇ0 8
,
ÇÇ8 9
string
ÇÇ: @
Color
ÇÇA F
)
ÇÇF G
;
ÇÇG HÑ(
TC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\ReglasValidacion.cs
	namespace 	
Gtrack
 
; 
public 
static 
class 
ReglasValidacion $
{ 
public

 

const

 
string

 
Telefono

  
=

! "
$str

# .
;

. /
public 

const 
string 
TelefonoMensaje '
=( )
$str* s
;s t
public 

const 
string 
	Documento !
=" #
$str$ 1
;1 2
public 

const 
string 
DocumentoMensaje (
=) *
$str+ p
;p q
public 

const 
string 
Correo 
=  
$str! h
;h i
public 

const 
string 
CorreoMensaje %
=& '
$str( b
;b c
public 

const 
string 
NombrePersona %
=& '
$str( _
;_ `
public 

const 
string  
NombrePersonaMensaje ,
=- .
$str/ l
;l m
public 

const 
string 

PlacaCarro "
=# $
$str% 7
;7 8
public 

const 
string 
	PlacaMoto !
=" #
$str$ ;
;; <
public 

const 
string 
PlacaMensajeCarro )
=* +
$str, i
;i j
public   

const   
string   
PlacaMensajeMoto   (
=  ) *
$str  + p
;  p q
public"" 

static"" 
string"" 
NormalizarPlaca"" (
(""( )
string"") /
?""/ 0
placa""1 6
)""6 7
=>""8 :
(## 	
placa##	 
??## 
$str## 
)## 
.## 
Trim## 
(## 
)## 
.## 
Replace## $
(##$ %
$str##% (
,##( )
$str##* ,
)##, -
.##- .
Replace##. 5
(##5 6
$str##6 9
,##9 :
$str##; =
)##= >
.##> ?
ToUpperInvariant##? O
(##O P
)##P Q
;##Q R
public&& 

static&& 
IEnumerable&& 
<&& 
ValidationResult&& .
>&&. /
ValidarVehiculo&&0 ?
(&&? @
TipoVehiculo&&@ L
?&&L M
vehiculo&&N V
,&&V W
string&&X ^
?&&^ _
placa&&` e
)&&e f
{'' 
if(( 

((( 
vehiculo(( 
==(( 
TipoVehiculo(( $
.(($ %
APie((% )
)(() *
{)) 	
yield** 
return** 
new** 
ValidationResult** -
(**- .
$str**. R
,**R S
[**T U
$str**U _
]**_ `
)**` a
;**a b
yield++ 
break++ 
;++ 
},, 	
if.. 

(.. 
vehiculo.. 
is.. 
not.. 
(.. 
TipoVehiculo.. )
...) *
Moto..* .
or../ 1
TipoVehiculo..2 >
...> ?
Carro..? D
)..D E
)..E F
yield..G L
break..M R
;..R S
if00 

(00 
string00 
.00 
IsNullOrWhiteSpace00 %
(00% &
placa00& +
)00+ ,
)00, -
{11 	
yield22 
return22 
new22 
ValidationResult22 -
(22- .
RegistroNegocioDto22. @
.22@ A
Obligatorio22A L
,22L M
[22N O
$str22O V
]22V W
)22W X
;22X Y
yield33 
break33 
;33 
}44 	
var66 
esMoto66 
=66 
vehiculo66 
==66  
TipoVehiculo66! -
.66- .
Moto66. 2
;662 3
var77 
patron77 
=77 
esMoto77 
?77 
Patrones77 &
.77& '
	PlacaMoto77' 0
(770 1
)771 2
:773 4
Patrones775 =
.77= >

PlacaCarro77> H
(77H I
)77I J
;77J K
if88 

(88 
!88 
patron88 
.88 
IsMatch88 
(88 
NormalizarPlaca88 +
(88+ ,
placa88, 1
)881 2
)882 3
)883 4
yield99 
return99 
new99 
ValidationResult99 -
(99- .
esMoto99. 4
?995 6
PlacaMensajeMoto997 G
:99H I
PlacaMensajeCarro99J [
,99[ \
[99] ^
$str99^ e
]99e f
)99f g
;99g h
}:: 
};; √/
VC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\RegistroNegocioDto.cs
	namespace 	
Gtrack
 
; 
public 
class 
RegistroNegocioDto 
{ 
public 

const 
string 
Obligatorio #
=$ %
$str& 9
;9 :
[		 
Display		 
(		 
Name		 
=		 
$str		 (
)		( )
]		) *
[

 
Required

 
(

 
ErrorMessage

 
=

 
Obligatorio

 (
)

( )
]

) *
[ 
StringLength 
( 
$num 
, 
MinimumLength $
=% &
$num' (
,( )
ErrorMessage* 6
=7 8
$str9 ^
)^ _
]_ `
public 

string 
Nombre 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
[ 
Display 
( 
Name 
= 
$str 1
)1 2
]2 3
[ 
Required 
( 
ErrorMessage 
= 
Obligatorio (
)( )
]) *
public 

string 
TipoActividad 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$str0 2
;2 3
[ 
Display 
( 
Name 
= 
$str 2
)2 3
]3 4
[ 
Required 
( 
ErrorMessage 
= 
Obligatorio (
)( )
]) *
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
	Documento( 1
,1 2
ErrorMessage3 ?
=@ A
ReglasValidacionB R
.R S
DocumentoMensajeS c
)c d
]d e
public 

string 
	Documento 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
[ 
Display 
( 
Name 
= 
$str 4
)4 5
]5 6
[ 
Required 
( 
ErrorMessage 
= 
Obligatorio (
)( )
]) *
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
Correo( .
,. /
ErrorMessage0 <
== >
ReglasValidacion? O
.O P
CorreoMensajeP ]
)] ^
]^ _
[ 
StringLength 
( 
$num 
, 
ErrorMessage #
=$ %
$str& =
)= >
]> ?
public 

string 
Correo 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
[ 
Display 
( 
Name 
= 
$str *
)* +
]+ ,
[ 
Required 
( 
ErrorMessage 
= 
Obligatorio (
)( )
]) *
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
Telefono( 0
,0 1
ErrorMessage2 >
=? @
ReglasValidacionA Q
.Q R
TelefonoMensajeR a
)a b
]b c
public   

string   
Telefono   
{   
get    
;    !
set  " %
;  % &
}  ' (
=  ) *
$str  + -
;  - .
["" 
Display"" 
("" 
Name"" 
="" 
$str"" /
)""/ 0
]""0 1
[## 
Required## 
(## 
ErrorMessage## 
=## 
Obligatorio## (
)##( )
]##) *
[$$ 
StringLength$$ 
($$ 
$num$$ 
,$$ 
MinimumLength$$ $
=$$% &
$num$$' (
,$$( )
ErrorMessage$$* 6
=$$7 8
$str$$9 ^
)$$^ _
]$$_ `
public%% 

string%% 
	Direccion%% 
{%% 
get%% !
;%%! "
set%%# &
;%%& '
}%%( )
=%%* +
$str%%, .
;%%. /
['' 
Display'' 
('' 
Name'' 
='' 
$str''  
)''  !
]''! "
[(( 
Required(( 
((( 
ErrorMessage(( 
=(( 
Obligatorio(( (
)((( )
](() *
[)) 
DataType)) 
()) 
DataType)) 
.)) 
Password)) 
)))  
]))  !
public** 

string** 
Password** 
{** 
get**  
;**  !
set**" %
;**% &
}**' (
=**) *
$str**+ -
;**- .
[,, 
Display,, 
(,, 
Name,, 
=,, 
$str,, *
),,* +
],,+ ,
[-- 
Required-- 
(-- 
ErrorMessage-- 
=-- 
Obligatorio-- (
)--( )
]--) *
[.. 
DataType.. 
(.. 
DataType.. 
... 
Password.. 
)..  
]..  !
public// 

string// 
ConfirmarPassword// #
{//$ %
get//& )
;//) *
set//+ .
;//. /
}//0 1
=//2 3
$str//4 6
;//6 7
}00 ‹/
VC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\RegistrarPedidoDto.cs
	namespace 	
Gtrack
 
; 
public 
class 
RegistrarPedidoDto 
{ 
[ 
Display 
( 
Name 
= 
$str (
)( )
]) *
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
[		 
StringLength		 
(		 
$num		 
,		 
MinimumLength		 $
=		% &
$num		' (
,		( )
ErrorMessage		* 6
=		7 8
$str		9 ^
)		^ _
]		_ `
[

 
RegularExpression

 
(

 
ReglasValidacion

 '
.

' (
NombrePersona

( 5
,

5 6
ErrorMessage

7 C
=

D E
ReglasValidacion

F V
.

V W 
NombrePersonaMensaje

W k
)

k l
]

l m
public 

string 
ClienteNombre 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$str0 2
;2 3
[ 
Display 
( 
Name 
= 
$str *
)* +
]+ ,
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
Telefono( 0
,0 1
ErrorMessage2 >
=? @
ReglasValidacionA Q
.Q R
TelefonoMensajeR a
)a b
]b c
public 

string 
ClienteTelefono !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
$str2 4
;4 5
[ 
Display 
( 
Name 
= 
$str *
)* +
]+ ,
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
[ 
StringLength 
( 
$num 
, 
MinimumLength $
=% &
$num' (
,( )
ErrorMessage* 6
=7 8
$str9 ^
)^ _
]_ `
public 

string 
DireccionEntrega "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
$str3 5
;5 6
[ 
Display 
( 
Name 
= 
$str $
)$ %
]% &
[ 
Required 
( 
ErrorMessage 
= 
$str ;
); <
]< =
public 


MetodoPago 
? 

MetodoPago !
{" #
get$ '
;' (
set) ,
;, -
}. /
[ 
	MinLength 
( 
$num 
, 
ErrorMessage 
=  
$str! >
)> ?
]? @
public 

List 
< 
ItemPedidoDto 
> 
	Productos (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
=7 8
[9 :
]: ;
;; <
} 
public 
class 
ItemPedidoDto 
{   
[!! 
Display!! 
(!! 
Name!! 
=!! 
$str!! !
)!!! "
]!!" #
["" 
Required"" 
("" 
ErrorMessage"" 
="" 
RegistroNegocioDto"" /
.""/ 0
Obligatorio""0 ;
)""; <
]""< =
[## 
StringLength## 
(## 
$num## 
,## 
ErrorMessage## #
=##$ %
$str##& =
)##= >
]##> ?
public$$ 

string$$ 
Descripcion$$ 
{$$ 
get$$  #
;$$# $
set$$% (
;$$( )
}$$* +
=$$, -
$str$$. 0
;$$0 1
[&& 
Range&& 

(&&
 
$num&& 
,&& 
$num&& 
,&& 
ErrorMessage&&  
=&&! "
$str&&# Y
)&&Y Z
]&&Z [
public'' 

int'' 
Cantidad'' 
{'' 
get'' 
;'' 
set'' "
;''" #
}''$ %
=''& '
$num''( )
;'') *
[)) 
Range)) 

())
 
$num)) 
,)) 
$num)) 
,)) 
ErrorMessage)) (
=))) *
$str))+ I
)))I J
]))J K
public** 

decimal** 
PrecioUnitario** !
{**" #
get**$ '
;**' (
set**) ,
;**, -
}**. /
}++ 
public-- 
class-- #
ClienteAutocompletarDto-- $
{.. 
public// 

string// 
Nombre// 
{// 
get// 
;// 
set//  #
;//# $
}//% &
=//' (
$str//) +
;//+ ,
public00 

string00 
	Direccion00 
{00 
get00 !
;00! "
set00# &
;00& '
}00( )
=00* +
$str00, .
;00. /
}11 
public33 
enum33 

MetodoPago33 
{44 
Efectivo55 
,55 
Transferencia66 
,66 
Tarjeta77 
}88 ⁄
PC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\RecuperarDto.cs
	namespace 	
Gtrack
 
; 
public 
class 
RecuperarDto 
{ 
[ 
Display 
( 
Name 
= 
$str 3
)3 4
]4 5
[ 
Required 
( 
ErrorMessage 
= 
$str <
)< =
]= >
[		 
RegularExpression		 
(		 
ReglasValidacion		 '
.		' (
Correo		( .
,		. /
ErrorMessage		0 <
=		= >
ReglasValidacion		? O
.		O P
CorreoMensaje		P ]
)		] ^
]		^ _
public

 

string

 
Correo

 
{

 
get

 
;

 
set

  #
;

# $
}

% &
=

' (
$str

) +
;

+ ,
} ÿ1
XC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\PerfilRepartidorDtos.cs
	namespace 	
Gtrack
 
; 
public 
class 
PerfilRepartidorDto  
{ 
public 

string 
NombreCompleto  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
$str1 3
;3 4
public		 

string		 
	Documento		 
{		 
get		 !
;		! "
set		# &
;		& '
}		( )
=		* +
$str		, .
;		. /
public

 

string

 
Telefono

 
{

 
get

  
;

  !
set

" %
;

% &
}

' (
=

) *
$str

+ -
;

- .
public 

string 
Correo 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
public 

TipoVehiculo 
Vehiculo  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

string 
? 
Placa 
{ 
get 
; 
set  #
;# $
}% &
public 

string 
Negocio 
{ 
get 
;  
set! $
;$ %
}& '
=( )
$str* ,
;, -
public 

DateTime 
FechaRegistro !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 

EstadoCuenta 
Estado 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

int 
PedidosPendientes  
{! "
get# &
;& '
set( +
;+ ,
}- .
} 
public 
class 
EditarRepartidorDto  
:! "
IValidatableObject# 5
{ 
[ 
Display 
( 
Name 
= 
$str %
)% &
]& '
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
[ 
StringLength 
( 
$num 
, 
MinimumLength $
=% &
$num' (
,( )
ErrorMessage* 6
=7 8
$str9 ^
)^ _
]_ `
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
NombrePersona( 5
,5 6
ErrorMessage7 C
=D E
ReglasValidacionF V
.V W 
NombrePersonaMensajeW k
)k l
]l m
public 

string 
NombreCompleto  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
$str1 3
;3 4
[ 
Display 
( 
Name 
= 
$str 
) 
]  
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
Telefono( 0
,0 1
ErrorMessage2 >
=? @
ReglasValidacionA Q
.Q R
TelefonoMensajeR a
)a b
]b c
public   

string   
Telefono   
{   
get    
;    !
set  " %
;  % &
}  ' (
=  ) *
$str  + -
;  - .
["" 
Display"" 
("" 
Name"" 
="" 
$str"" (
)""( )
]"") *
[## 
Required## 
(## 
ErrorMessage## 
=## 
RegistroNegocioDto## /
.##/ 0
Obligatorio##0 ;
)##; <
]##< =
[$$ 
RegularExpression$$ 
($$ 
ReglasValidacion$$ '
.$$' (
Correo$$( .
,$$. /
ErrorMessage$$0 <
=$$= >
ReglasValidacion$$? O
.$$O P
CorreoMensaje$$P ]
)$$] ^
]$$^ _
[%% 
StringLength%% 
(%% 
$num%% 
,%% 
ErrorMessage%% #
=%%$ %
$str%%& =
)%%= >
]%%> ?
public&& 

string&& 
Correo&& 
{&& 
get&& 
;&& 
set&&  #
;&&# $
}&&% &
=&&' (
$str&&) +
;&&+ ,
[(( 
Display(( 
((( 
Name(( 
=(( 
$str(( &
)((& '
]((' (
[)) 
Required)) 
()) 
ErrorMessage)) 
=)) 
RegistroNegocioDto)) /
.))/ 0
Obligatorio))0 ;
))); <
]))< =
public** 

TipoVehiculo** 
?** 
Vehiculo** !
{**" #
get**$ '
;**' (
set**) ,
;**, -
}**. /
[,, 
Display,, 
(,, 
Name,, 
=,, 
$str,, 
),, 
],, 
public-- 

string-- 
?-- 
Placa-- 
{-- 
get-- 
;-- 
set--  #
;--# $
}--% &
public00 

IEnumerable00 
<00 
ValidationResult00 '
>00' (
Validate00) 1
(001 2
ValidationContext002 C
context00D K
)00K L
{11 
return22 
ReglasValidacion22 
.22  
ValidarVehiculo22  /
(22/ 0
Vehiculo220 8
,228 9
Placa22: ?
)22? @
;22@ A
}33 
}44 –	
[C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\PerfilPublicoNegocioDto.cs
	namespace 	
Gtrack
 
; 
public 
class #
PerfilPublicoNegocioDto $
{ 
public 

string 
Nombre 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
public 

string 
TipoActividad 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$str0 2
;2 3
public 

string 
	Direccion 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
public		 

string		 
Telefono		 
{		 
get		  
;		  !
set		" %
;		% &
}		' (
=		) *
$str		+ -
;		- .
public

 

DateTime

 
FechaRegistro

 !
{

" #
get

$ '
;

' (
set

) ,
;

, -
}

. /
} å
TC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\PerfilNegocioDto.cs
	namespace 	
Gtrack
 
; 
public 
class 
PerfilNegocioDto 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
Nombre 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
public 

string 
TipoActividad 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$str0 2
;2 3
public		 

string		 
	Documento		 
{		 
get		 !
;		! "
set		# &
;		& '
}		( )
=		* +
$str		, .
;		. /
public

 

string

 
Correo

 
{

 
get

 
;

 
set

  #
;

# $
}

% &
=

' (
$str

) +
;

+ ,
public 

string 
Telefono 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
public 

string 
	Direccion 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
public 

DateTime 
FechaRegistro !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 

EstadoCuenta 
Estado 
{  
get! $
;$ %
set& )
;) *
}+ ,
} Œ
LC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\LoginDto.cs
	namespace 	
Gtrack
 
; 
public 
class 
LoginDto 
{ 
public 


RolUsuario 
Rol 
{ 
get 
;  
set! $
;$ %
}& '
=( )

RolUsuario* 4
.4 5
Negocio5 <
;< =
[		 
Display		 
(		 
Name		 
=		 
$str		 2
)		2 3
]		3 4
[

 
Required

 
(

 
ErrorMessage

 
=

 
$str

 @
)

@ A
]

A B
[ 
StringLength 
( 
$num 
, 
ErrorMessage #
=$ %
$str& =
)= >
]> ?
public 

string 
Identificador 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$str0 2
;2 3
[ 
Display 
( 
Name 
= 
$str  
)  !
]! "
[ 
Required 
( 
ErrorMessage 
= 
$str @
)@ A
]A B
[ 
DataType 
( 
DataType 
. 
Password 
)  
]  !
public 

string 
Password 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
} ◊
UC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\EliminarCuentaDto.cs
	namespace 	
Gtrack
 
; 
public 
class 
EliminarCuentaDto 
{ 
[ 
Display 
( 
Name 
= 
$str  
)  !
]! "
[ 
Required 
( 
ErrorMessage 
= 
$str 4
)4 5
]5 6
[		 
DataType		 
(		 
DataType		 
.		 
Password		 
)		  
]		  !
public

 

string

 
Password

 
{

 
get

  
;

  !
set

" %
;

% &
}

' (
=

) *
$str

+ -
;

- .
} ¥ 
TC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\EditarNegocioDto.cs
	namespace 	
Gtrack
 
; 
public 
class 
EditarNegocioDto 
{ 
[ 
Display 
( 
Name 
= 
$str &
)& '
]' (
[		 
Required		 
(		 
ErrorMessage		 
=		 
RegistroNegocioDto		 /
.		/ 0
Obligatorio		0 ;
)		; <
]		< =
[

 
StringLength

 
(

 
$num

 
,

 
MinimumLength

 $
=

% &
$num

' (
,

( )
ErrorMessage

* 6
=

7 8
$str

9 ^
)

^ _
]

_ `
public 

string 
Nombre 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
[ 
Display 
( 
Name 
= 
$str ,
), -
]- .
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
public 

string 
TipoActividad 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$str0 2
;2 3
[ 
Display 
( 
Name 
= 
$str (
)( )
]) *
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
Correo( .
,. /
ErrorMessage0 <
== >
ReglasValidacion? O
.O P
CorreoMensajeP ]
)] ^
]^ _
[ 
StringLength 
( 
$num 
, 
ErrorMessage #
=$ %
$str& =
)= >
]> ?
public 

string 
Correo 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
[ 
Display 
( 
Name 
= 
$str *
)* +
]+ ,
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
Telefono( 0
,0 1
ErrorMessage2 >
=? @
ReglasValidacionA Q
.Q R
TelefonoMensajeR a
)a b
]b c
public 

string 
Telefono 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
[ 
Display 
( 
Name 
= 
$str 
)  
]  !
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
[ 
StringLength 
( 
$num 
, 
MinimumLength $
=% &
$num' (
,( )
ErrorMessage* 6
=7 8
$str9 ^
)^ _
]_ `
public 

string 
	Direccion 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
}   ¡
TC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\ActivarCuentaDto.cs
	namespace 	
Gtrack
 
; 
public 
class 
ActivarCuentaDto 
{ 
public 

string 
Token 
{ 
get 
; 
set "
;" #
}$ %
=& '
$str( *
;* +
[

 
Display

 
(

 
Name

 
=

 
$str

  
)

  !
]

! "
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
[ 
DataType 
( 
DataType 
. 
Password 
)  
]  !
public 

string 
NuevaPassword 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$str0 2
;2 3
[ 
Display 
( 
Name 
= 
$str *
)* +
]+ ,
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
[ 
DataType 
( 
DataType 
. 
Password 
)  
]  !
[ 
Compare 
( 
nameof 
( 
NuevaPassword !
)! "
," #
ErrorMessage$ 0
=1 2
$str3 Q
)Q R
]R S
public 

string 
ConfirmarPassword #
{$ %
get& )
;) *
set+ .
;. /
}0 1
=2 3
$str4 6
;6 7
public 


RolUsuario 
Rol 
{ 
get 
;  
set! $
;$ %
}& '
=( )

RolUsuario* 4
.4 5

Repartidor5 ?
;? @
public 

string 
Nombre 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
public 

string 
Correo 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
public 

string 
Negocio 
{ 
get 
;  
set! $
;$ %
}& '
=( )
$str* ,
;, -
} ¬º
PC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Data\appDBcontext.cs
	namespace 	
Gtrack
 
; 
public 
class 
AppDbContext 
( 
DbContextOptions *
<* +
AppDbContext+ 7
>7 8
options9 @
)@ A
:B C
	DbContextD M
(M N
optionsN U
)U V
{ 
public 

DbSet 
< 
Usuario 
> 
Usuarios "
=># %
Set& )
<) *
Usuario* 1
>1 2
(2 3
)3 4
;4 5
public 

DbSet 
< 
TokenRecuperacion "
>" #
TokensRecuperacion$ 6
=>7 9
Set: =
<= >
TokenRecuperacion> O
>O P
(P Q
)Q R
;R S
public		 

DbSet		 
<		 
Negocio		 
>		 
Negocios		 "
=>		# %
Set		& )
<		) *
Negocio		* 1
>		1 2
(		2 3
)		3 4
;		4 5
public

 

DbSet

 
<

 
CodigoVerificacion

 #
>

# $
CodigosVerificacion

% 8
=>

9 ;
Set

< ?
<

? @
CodigoVerificacion

@ R
>

R S
(

S T
)

T U
;

U V
public 

DbSet 
< 

Repartidor 
> 
Repartidores )
=>* ,
Set- 0
<0 1

Repartidor1 ;
>; <
(< =
)= >
;> ?
public 

DbSet 
< 
Administrador 
> 
Administradores  /
=>0 2
Set3 6
<6 7
Administrador7 D
>D E
(E F
)F G
;G H
public 

DbSet 
< 
Pedido 
> 
Pedidos  
=>! #
Set$ '
<' (
Pedido( .
>. /
(/ 0
)0 1
;1 2
public 

DbSet 
< 

ItemPedido 
> 
ItemsPedido (
=>) +
Set, /
</ 0

ItemPedido0 :
>: ;
(; <
)< =
;= >
public 

DbSet 
<  
SuspensionRepartidor %
>% & 
SuspensionRepartidor' ;
=>< >
Set? B
<B C 
SuspensionRepartidorC W
>W X
(X Y
)Y Z
;Z [
public 

DbSet 
< 
UbicacionPedido  
>  !
UbicacionesPedido" 3
=>4 6
Set7 :
<: ;
UbicacionPedido; J
>J K
(K L
)L M
;M N
public 

DbSet 
<  
SolicitudCancelacion %
>% &"
SolicitudesCancelacion' =
=>> @
SetA D
<D E 
SolicitudCancelacionE Y
>Y Z
(Z [
)[ \
;\ ]
public 

DbSet 
< 
NovedadPedido 
> 
NovedadesPedido  /
=>0 2
Set3 6
<6 7
NovedadPedido7 D
>D E
(E F
)F G
;G H
	protected 
override 
void 
OnModelCreating +
(+ ,
ModelBuilder, 8
modelBuilder9 E
)E F
{ 
modelBuilder 
. 
Entity 
< 
Usuario #
># $
($ %
e% &
=>' )
{ 	
e 
. 
ToTable 
( 
$str 
,  
t! "
=># %
t& '
.' (

HasTrigger( 2
(2 3
$str3 R
)R S
)S T
;T U
e 
. 
Property 
( 
u 
=> 
u 
. 
PasswordHash *
)* +
.+ ,
HasColumnName, 9
(9 :
$str: J
)J K
;K L
e 
. 
Property 
( 
u 
=> 
u 
. 
Rol !
)! "
." #
HasColumnName# 0
(0 1
$str1 8
)8 9
;9 :
e 
. 
Property 
( 
u 
=> 
u 
. 
Estado $
)$ %
.% &
HasColumnName& 3
(3 4
$str4 D
)D E
;E F
e 
. 
Property 
( 
u 
=> 
u 
. 
Correo $
)$ %
.% &
HasMaxLength& 2
(2 3
$num3 6
)6 7
;7 8
e 
. 
Property 
( 
u 
=> 
u 
. 
	Documento '
)' (
.( )
HasMaxLength) 5
(5 6
$num6 8
)8 9
.9 :
	IsUnicode: C
(C D
falseD I
)I J
;J K
e   
.   
HasIndex   
(   
u   
=>   
u   
.   
Correo   $
)  $ %
.  % &
IsUnique  & .
(  . /
)  / 0
;  0 1
e!! 
.!! 
HasIndex!! 
(!! 
u!! 
=>!! 
u!! 
.!! 
	Documento!! '
)!!' (
.!!( )
IsUnique!!) 1
(!!1 2
)!!2 3
;!!3 4
}"" 	
)""	 

;""
 
modelBuilder$$ 
.$$ 
Entity$$ 
<$$ 
TokenRecuperacion$$ -
>$$- .
($$. /
e$$/ 0
=>$$1 3
{%% 	
e&& 
.&& 
ToTable&& 
(&& 
$str&& )
)&&) *
;&&* +
e'' 
.'' 
Property'' 
('' 
t'' 
=>'' 
t'' 
.'' 
Expira'' $
)''$ %
.''% &
HasColumnName''& 3
(''3 4
$str''4 E
)''E F
;''F G
e(( 
.(( 
Property(( 
((( 
t(( 
=>(( 
t(( 
.(( 
	TokenHash(( '
)((' (
.((( )
HasMaxLength(() 5
(((5 6
$num((6 8
)((8 9
;((9 :
e)) 
.)) 
HasIndex)) 
()) 
t)) 
=>)) 
t)) 
.)) 
	TokenHash)) '
)))' (
.))( )
IsUnique))) 1
())1 2
)))2 3
;))3 4
}** 	
)**	 

;**
 
modelBuilder,, 
.,, 
Entity,, 
<,, 
Negocio,, #
>,,# $
(,,$ %
e,,% &
=>,,' )
{-- 	
e.. 
... 
ToTable.. 
(.. 
$str.. 
)..  
;..  !
e// 
.// 
Property// 
(// 
n// 
=>// 
n// 
.// 
Nombre// $
)//$ %
.//% &
HasMaxLength//& 2
(//2 3
$num//3 6
)//6 7
;//7 8
e00 
.00 
Property00 
(00 
n00 
=>00 
n00 
.00 
TipoActividad00 +
)00+ ,
.00, -
HasMaxLength00- 9
(009 :
$num00: =
)00= >
;00> ?
e11 
.11 
Property11 
(11 
n11 
=>11 
n11 
.11 
Telefono11 &
)11& '
.11' (
HasMaxLength11( 4
(114 5
$num115 7
)117 8
.118 9
	IsUnicode119 B
(11B C
false11C H
)11H I
;11I J
e22 
.22 
Property22 
(22 
n22 
=>22 
n22 
.22 
	Direccion22 '
)22' (
.22( )
HasMaxLength22) 5
(225 6
$num226 9
)229 :
;22: ;
e44 
.44 
Property44 
<44 
DateTime44 
?44  
>44  !
(44! "
$str44" 3
)443 4
;444 5
e55 
.55 
HasIndex55 
(55 
n55 
=>55 
n55 
.55 
Telefono55 &
)55& '
.55' (
IsUnique55( 0
(550 1
)551 2
;552 3
e66 
.66 
HasOne66 
(66 
n66 
=>66 
n66 
.66 
Usuario66 #
)66# $
.66$ %
WithOne66% ,
(66, -
)66- .
.77 
HasForeignKey77 
<77 
Negocio77 &
>77& '
(77' (
n77( )
=>77* ,
n77- .
.77. /
	UsuarioId77/ 8
)778 9
.88 
OnDelete88 
(88 
DeleteBehavior88 (
.88( )
Restrict88) 1
)881 2
;882 3
}99 	
)99	 

;99
 
modelBuilder;; 
.;; 
Entity;; 
<;; 
CodigoVerificacion;; .
>;;. /
(;;/ 0
e;;0 1
=>;;2 4
{<< 	
e== 
.== 
ToTable== 
(== 
$str== *
)==* +
;==+ ,
e>> 
.>> 
Property>> 
(>> 
c>> 
=>>> 
c>> 
.>> 
Expira>> $
)>>$ %
.>>% &
HasColumnName>>& 3
(>>3 4
$str>>4 E
)>>E F
;>>F G
e?? 
.?? 
Property?? 
(?? 
c?? 
=>?? 
c?? 
.?? 

CodigoHash?? (
)??( )
.??) *
HasMaxLength??* 6
(??6 7
$num??7 9
)??9 :
;??: ;
e@@ 
.@@ 
HasIndex@@ 
(@@ 
c@@ 
=>@@ 
c@@ 
.@@ 
	UsuarioId@@ '
)@@' (
;@@( )
}AA 	
)AA	 

;AA
 
modelBuilderCC 
.CC 
EntityCC 
<CC 

RepartidorCC &
>CC& '
(CC' (
eCC( )
=>CC* ,
{DD 	
eEE 
.EE 
ToTableEE 
(EE 
$strEE "
)EE" #
;EE# $
eFF 
.FF 
PropertyFF 
(FF 
rFF 
=>FF 
rFF 
.FF 
VehiculoFF &
)FF& '
.FF' (
HasColumnNameFF( 5
(FF5 6
$strFF6 F
)FFF G
;FFG H
eGG 
.GG 
PropertyGG 
(GG 
rGG 
=>GG 
rGG 
.GG 
NombreCompletoGG ,
)GG, -
.GG- .
HasMaxLengthGG. :
(GG: ;
$numGG; >
)GG> ?
;GG? @
eHH 
.HH 
PropertyHH 
(HH 
rHH 
=>HH 
rHH 
.HH 
TelefonoHH &
)HH& '
.HH' (
HasMaxLengthHH( 4
(HH4 5
$numHH5 7
)HH7 8
.HH8 9
	IsUnicodeHH9 B
(HHB C
falseHHC H
)HHH I
;HHI J
eII 
.II 
PropertyII 
(II 
rII 
=>II 
rII 
.II 
PlacaII #
)II# $
.II$ %
HasMaxLengthII% 1
(II1 2
$numII2 4
)II4 5
.II5 6
	IsUnicodeII6 ?
(II? @
falseII@ E
)IIE F
;IIF G
eJJ 
.JJ 
HasOneJJ 
(JJ 
rJJ 
=>JJ 
rJJ 
.JJ 
UsuarioJJ #
)JJ# $
.JJ$ %
WithManyJJ% -
(JJ- .
)JJ. /
.KK 
HasForeignKeyKK 
(KK 
rKK  
=>KK! #
rKK$ %
.KK% &
	UsuarioIdKK& /
)KK/ 0
.LL 
OnDeleteLL 
(LL 
DeleteBehaviorLL (
.LL( )
RestrictLL) 1
)LL1 2
;LL2 3
}MM 	
)MM	 

;MM
 
modelBuilderOO 
.OO 
EntityOO 
<OO 
AdministradorOO )
>OO) *
(OO* +
eOO+ ,
=>OO- /
{PP 	
eQQ 
.QQ 
ToTableQQ 
(QQ 
$strQQ %
)QQ% &
;QQ& '
eRR 
.RR 
PropertyRR 
(RR 
aRR 
=>RR 
aRR 
.RR 
NombreCompletoRR ,
)RR, -
.RR- .
HasMaxLengthRR. :
(RR: ;
$numRR; >
)RR> ?
;RR? @
eSS 
.SS 
PropertySS 
(SS 
aSS 
=>SS 
aSS 
.SS 
TelefonoSS &
)SS& '
.SS' (
HasMaxLengthSS( 4
(SS4 5
$numSS5 7
)SS7 8
.SS8 9
	IsUnicodeSS9 B
(SSB C
falseSSC H
)SSH I
;SSI J
eTT 
.TT 
HasOneTT 
(TT 
aTT 
=>TT 
aTT 
.TT 
UsuarioTT #
)TT# $
.TT$ %
WithManyTT% -
(TT- .
)TT. /
.UU 
HasForeignKeyUU 
(UU 
aUU  
=>UU! #
aUU$ %
.UU% &
	UsuarioIdUU& /
)UU/ 0
.VV 
OnDeleteVV 
(VV 
DeleteBehaviorVV (
.VV( )
RestrictVV) 1
)VV1 2
;VV2 3
}WW 	
)WW	 

;WW
 
modelBuilderYY 
.YY 
EntityYY 
<YY 
PedidoYY "
>YY" #
(YY# $
eYY$ %
=>YY& (
{ZZ 	
e\\ 
.\\ 
ToTable\\ 
(\\ 
$str\\ 
,\\ 
t\\  !
=>\\" $
{]] 
t^^ 
.^^ 

HasTrigger^^ 
(^^ 
$str^^ =
)^^= >
;^^> ?
t__ 
.__ 

HasTrigger__ 
(__ 
$str__ 8
)__8 9
;__9 :
}`` 
)`` 
;`` 
eaa 
.aa 
Propertyaa 
(aa 
paa 
=>aa 
paa 
.aa 
Codigoaa $
)aa$ %
.aa% &
HasMaxLengthaa& 2
(aa2 3
$numaa3 4
)aa4 5
.aa5 6
IsFixedLengthaa6 C
(aaC D
)aaD E
.aaE F
	IsUnicodeaaF O
(aaO P
falseaaP U
)aaU V
;aaV W
ebb 
.bb 
Propertybb 
(bb 
pbb 
=>bb 
pbb 
.bb 
DireccionEntregabb .
)bb. /
.bb/ 0
HasMaxLengthbb0 <
(bb< =
$numbb= @
)bb@ A
;bbA B
edd 
.dd 
HasOnedd 
(dd 
pdd 
=>dd 
pdd 
.dd 
Negociodd #
)dd# $
.dd$ %
WithManydd% -
(dd- .
)dd. /
.ee 
HasForeignKeyee 
(ee 
pee  
=>ee! #
pee$ %
.ee% &
	NegocioIdee& /
)ee/ 0
.ff 
OnDeleteff 
(ff 
DeleteBehaviorff (
.ff( )
Restrictff) 1
)ff1 2
;ff2 3
ehh 
.hh 
HasOnehh 
(hh 
phh 
=>hh 
phh 
.hh 
Clientehh #
)hh# $
.hh$ %
WithManyhh% -
(hh- .
)hh. /
.ii 
HasForeignKeyii 
(ii 
pii  
=>ii! #
pii$ %
.ii% &
	ClienteIdii& /
)ii/ 0
.jj 
OnDeletejj 
(jj 
DeleteBehaviorjj (
.jj( )
Restrictjj) 1
)jj1 2
;jj2 3
ell 
.ll 
HasManyll 
(ll 
pll 
=>ll 
pll 
.ll 
Itemsll "
)ll" #
.ll# $
WithOnell$ +
(ll+ ,
ill, -
=>ll. 0
ill1 2
.ll2 3
Pedidoll3 9
)ll9 :
.mm 
HasForeignKeymm 
(mm 
imm  
=>mm! #
imm$ %
.mm% &
PedidoIdmm& .
)mm. /
.nn 
OnDeletenn 
(nn 
DeleteBehaviornn (
.nn( )
Cascadenn) 0
)nn0 1
;nn1 2
}oo 	
)oo	 

;oo
 
modelBuilderqq 
.qq 
Entityqq 
<qq 

ItemPedidoqq &
>qq& '
(qq' (
eqq( )
=>qq* ,
{rr 	
ess 
.ss 
ToTabless 
(ss 
$strss "
)ss" #
;ss# $
ett 
.tt 
Propertytt 
(tt 
itt 
=>tt 
itt 
.tt 
Descripciontt )
)tt) *
.tt* +
HasMaxLengthtt+ 7
(tt7 8
$numtt8 ;
)tt; <
;tt< =
euu 
.uu 
Propertyuu 
(uu 
iuu 
=>uu 
iuu 
.uu 
PrecioUnitariouu ,
)uu, -
.uu- .
HasPrecisionuu. :
(uu: ;
$numuu; =
,uu= >
$numuu? @
)uu@ A
;uuA B
}vv 	
)vv	 

;vv
 
modelBuilderyy 
.yy 
Entityyy 
<yy  
SolicitudCancelacionyy 0
>yy0 1
(yy1 2
eyy2 3
=>yy4 6
{zz 	
e{{ 
.{{ 
ToTable{{ 
({{ 
$str{{ ,
){{, -
;{{- .
e|| 
.|| 
Property|| 
(|| 
s|| 
=>|| 
s|| 
.|| 
Motivo|| $
)||$ %
.||% &
HasMaxLength||& 2
(||2 3
$num||3 6
)||6 7
;||7 8
e}} 
.}} 
HasIndex}} 
(}} 
s}} 
=>}} 
s}} 
.}} 
PedidoId}} &
)}}& '
.}}' (
IsUnique}}( 0
(}}0 1
)}}1 2
;}}2 3
e~~ 
.~~ 
HasOne~~ 
(~~ 
s~~ 
=>~~ 
s~~ 
.~~ 
Pedido~~ "
)~~" #
.~~# $
WithMany~~$ ,
(~~, -
)~~- .
. 
HasForeignKey 
( 
s  
=>! #
s$ %
.% &
PedidoId& .
). /
.
ÄÄ 
OnDelete
ÄÄ 
(
ÄÄ 
DeleteBehavior
ÄÄ (
.
ÄÄ( )
Restrict
ÄÄ) 1
)
ÄÄ1 2
;
ÄÄ2 3
}
ÅÅ 	
)
ÅÅ	 

;
ÅÅ
 
modelBuilder
ÑÑ 
.
ÑÑ 
Entity
ÑÑ 
<
ÑÑ 
NovedadPedido
ÑÑ )
>
ÑÑ) *
(
ÑÑ* +
e
ÑÑ+ ,
=>
ÑÑ- /
{
ÖÖ 	
e
ÜÜ 
.
ÜÜ 
ToTable
ÜÜ 
(
ÜÜ 
$str
ÜÜ %
)
ÜÜ% &
;
ÜÜ& '
e
áá 
.
áá 
Property
áá 
(
áá 
n
áá 
=>
áá 
n
áá 
.
áá 
Observaciones
áá +
)
áá+ ,
.
áá, -
HasMaxLength
áá- 9
(
áá9 :
$num
áá: =
)
áá= >
;
áá> ?
e
àà 
.
àà 
Property
àà 
(
àà 
n
àà 
=>
àà 
n
àà 
.
àà 
Fecha
àà #
)
àà# $
.
àà$ %
HasColumnType
àà% 2
(
àà2 3
$str
àà3 A
)
ààA B
;
ààB C
e
ââ 
.
ââ 
HasIndex
ââ 
(
ââ 
n
ââ 
=>
ââ 
n
ââ 
.
ââ 
PedidoId
ââ &
)
ââ& '
;
ââ' (
e
ää 
.
ää 
HasOne
ää 
(
ää 
n
ää 
=>
ää 
n
ää 
.
ää 
Pedido
ää "
)
ää" #
.
ää# $
WithMany
ää$ ,
(
ää, -
)
ää- .
.
ãã 
HasForeignKey
ãã 
(
ãã 
n
ãã  
=>
ãã! #
n
ãã$ %
.
ãã% &
PedidoId
ãã& .
)
ãã. /
.
åå 
OnDelete
åå 
(
åå 
DeleteBehavior
åå (
.
åå( )
Restrict
åå) 1
)
åå1 2
;
åå2 3
}
çç 	
)
çç	 

;
çç
 
modelBuilder
èè 
.
èè 
Entity
èè 
<
èè 
UbicacionPedido
èè +
>
èè+ ,
(
èè, -
e
èè- .
=>
èè/ 1
{
êê 	
e
ëë 
.
ëë 
ToTable
ëë 
(
ëë 
$str
ëë '
)
ëë' (
;
ëë( )
e
íí 
.
íí 
HasKey
íí 
(
íí 
u
íí 
=>
íí 
u
íí 
.
íí 
PedidoId
íí $
)
íí$ %
;
íí% &
e
ìì 
.
ìì 
Property
ìì 
(
ìì 
u
ìì 
=>
ìì 
u
ìì 
.
ìì 
PedidoId
ìì &
)
ìì& '
.
ìì' (!
ValueGeneratedNever
ìì( ;
(
ìì; <
)
ìì< =
;
ìì= >
e
îî 
.
îî 
Property
îî 
(
îî 
u
îî 
=>
îî 
u
îî 
.
îî 
Latitud
îî %
)
îî% &
.
îî& '
HasPrecision
îî' 3
(
îî3 4
$num
îî4 5
,
îî5 6
$num
îî7 8
)
îî8 9
;
îî9 :
e
ïï 
.
ïï 
Property
ïï 
(
ïï 
u
ïï 
=>
ïï 
u
ïï 
.
ïï 
Longitud
ïï &
)
ïï& '
.
ïï' (
HasPrecision
ïï( 4
(
ïï4 5
$num
ïï5 6
,
ïï6 7
$num
ïï8 9
)
ïï9 :
;
ïï: ;
e
ññ 
.
ññ 
Property
ññ 
(
ññ 
u
ññ 
=>
ññ 
u
ññ 
.
ññ  
FechaActualizacion
ññ 0
)
ññ0 1
.
ññ1 2
HasColumnType
ññ2 ?
(
ññ? @
$str
ññ@ N
)
ññN O
;
ññO P
e
òò 
.
òò 
HasOne
òò 
(
òò 
u
òò 
=>
òò 
u
òò 
.
òò 
Pedido
òò "
)
òò" #
.
ôô 
WithOne
ôô 
(
ôô 
)
ôô 
.
öö 
HasForeignKey
öö 
<
öö 
UbicacionPedido
öö .
>
öö. /
(
öö/ 0
u
öö0 1
=>
öö2 4
u
öö5 6
.
öö6 7
PedidoId
öö7 ?
)
öö? @
.
õõ 
OnDelete
õõ 
(
õõ 
DeleteBehavior
õõ (
.
õõ( )
Cascade
õõ) 0
)
õõ0 1
;
õõ1 2
}
úú 	
)
úú	 

;
úú
 
}
ùù 
}ûû ú£
\C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Controllers\UsuarioController.cs
	namespace 	
Gtrack
 
; 
public 
class 
UsuarioController 
( 
IAuthService		 
auth		 
,		  
IRecuperacionService

 
recuperacion

 %
,

% &$
IActivacionCuentaService 

activacion '
)' (
:) *

Controller+ 5
{ 
[ 
HttpGet 
] 
public 

IActionResult 
Login 
( 
string %
?% &
rol' *
=+ ,
null- 1
,1 2
string3 9
?9 :
	returnUrl; D
=E F
nullG K
)K L
{ 
if 

( 
User 
. 
Identity 
? 
. 
IsAuthenticated *
==+ -
true. 2
)2 3
return4 :
RedirectToAction; K
(K L
$strL S
,S T
$strU [
)[ \
;\ ]
var 
dto 
= 
new 
LoginDto 
( 
)  
;  !
var 
volverA 
= 
Url 
. 

IsLocalUrl $
($ %
	returnUrl% .
). /
?0 1
	returnUrl2 ;
:< =
null> B
;B C
if 

( 
Enum 
. 
TryParse 
< 

RolUsuario $
>$ %
(% &
rol& )
,) *
true+ /
,/ 0
out1 4
var5 8
perfil9 ?
)? @
&&A C
EnumD H
.H I
	IsDefinedI R
(R S
perfilS Y
)Y Z
)Z [
dto 
. 
Rol 
= 
perfil 
; 
else 
if 
( 
volverA 
? 
. 

StartsWith $
($ %
$str% -
,- .
StringComparison/ ?
.? @
OrdinalIgnoreCase@ Q
)Q R
==S U
trueV Z
)Z [
dto 
. 
Rol 
= 

RolUsuario  
.  !
Administrador! .
;. /
if 

( 
TempData 
[ 
$str $
]$ %
is& (
string) /
identificador0 =
)= >
dto? B
.B C
IdentificadorC P
=Q R
identificadorS `
;` a
ViewData 
[ 
$str 
] 
= 
volverA  '
;' (
return   
View   
(   
dto   
)   
;   
}!! 
[## 
HttpPost## 
,## $
ValidateAntiForgeryToken## '
]##' (
public$$ 

async$$ 
Task$$ 
<$$ 
IActionResult$$ #
>$$# $
Login$$% *
($$* +
LoginDto$$+ 3
dto$$4 7
,$$7 8
string$$9 ?
?$$? @
	returnUrl$$A J
=$$K L
null$$M Q
)$$Q R
{%% 
if&& 

(&& 
User&& 
.&& 
Identity&& 
?&& 
.&& 
IsAuthenticated&& *
==&&+ -
true&&. 2
)&&2 3
return&&4 :
RedirectToAction&&; K
(&&K L
$str&&L S
,&&S T
$str&&U [
)&&[ \
;&&\ ]
var(( 
volverA(( 
=(( 
Url(( 
.(( 

IsLocalUrl(( $
((($ %
	returnUrl((% .
)((. /
?((0 1
	returnUrl((2 ;
:((< =
null((> B
;((B C
ViewData)) 
[)) 
$str)) 
])) 
=)) 
volverA))  '
;))' (
if** 

(** 
!** 

ModelState** 
.** 
IsValid** 
)**  
return**! '
View**( ,
(**, -
dto**- 0
)**0 1
;**1 2
var,, 
(,, 
usuario,, 
,,, 
error,, 
),, 
=,, 
await,, $
auth,,% )
.,,) *
IniciarSesionAsync,,* <
(,,< =
dto,,= @
),,@ A
;,,A B
if-- 

(-- 
usuario-- 
is-- 
null-- 
)-- 
{.. 	

ModelState// 
.// 
AddModelError// $
(//$ %
$str//% '
,//' (
error//) .
!//. /
)/// 0
;//0 1
return00 
View00 
(00 
dto00 
)00 
;00 
}11 	
var33 
claims33 
=33 
new33 
List33 
<33 
Claim33 #
>33# $
{44 	
new55 
(55 

ClaimTypes55 
.55 
NameIdentifier55 )
,55) *
usuario55+ 2
.552 3
Id553 5
.555 6
ToString556 >
(55> ?
)55? @
)55@ A
,55A B
new66 
(66 

ClaimTypes66 
.66 
Email66  
,66  !
usuario66" )
.66) *
Correo66* 0
)660 1
,661 2
new77 
(77 

ClaimTypes77 
.77 
Role77 
,77  
usuario77! (
.77( )
Rol77) ,
.77, -
ToString77- 5
(775 6
)776 7
)777 8
}88 	
;88	 

var99 
identity99 
=99 
new99 
ClaimsIdentity99 )
(99) *
claims99* 0
,990 1(
CookieAuthenticationDefaults992 N
.99N O 
AuthenticationScheme99O c
)99c d
;99d e
var== 
propiedades== 
=== 
new== $
AuthenticationProperties== 6
{==7 8
IsPersistent==9 E
===F G
false==H M
}==N O
;==O P
await>> 
HttpContext>> 
.>> 
SignInAsync>> %
(>>% &(
CookieAuthenticationDefaults>>& B
.>>B C 
AuthenticationScheme>>C W
,>>W X
new?? 
ClaimsPrincipal?? 
(??  
identity??  (
)??( )
,??) *
propiedades??+ 6
)??6 7
;??7 8
ifBB 

(BB 
volverABB 
isBB 
notBB 
nullBB 
)BB  
returnBB! '
LocalRedirectBB( 5
(BB5 6
volverABB6 =
)BB= >
;BB> ?
returnEE 
RedirectToActionEE 
(EE  
$strEE  '
,EE' (
$strEE) /
)EE/ 0
;EE0 1
}FF 
[II 
HttpPostII 
,II $
ValidateAntiForgeryTokenII '
]II' (
publicJJ 

asyncJJ 
TaskJJ 
<JJ 
IActionResultJJ #
>JJ# $
LogoutJJ% +
(JJ+ ,
)JJ, -
{KK 
tryLL 
{MM 	
awaitNN 
HttpContextNN 
.NN 
SignOutAsyncNN *
(NN* +(
CookieAuthenticationDefaultsNN+ G
.NNG H 
AuthenticationSchemeNNH \
)NN\ ]
;NN] ^
}OO 	
catchPP 
(PP 
	ExceptionPP 
)PP 
{QQ 	
TempDataSS 
[SS 
$strSS 
]SS 
=SS 
$strSS  U
;SSU V
returnTT 
RedirectToActionTT #
(TT# $
$strTT$ +
,TT+ ,
$strTT- 3
)TT3 4
;TT4 5
}UU 	
TempDataXX 
[XX 
$strXX 
]XX 
=XX 
$strXX F
;XXF G
returnYY 
RedirectToActionYY 
(YY  
$strYY  '
,YY' (
$strYY) /
)YY/ 0
;YY0 1
}ZZ 
[]] 
HttpGet]] 
]]] 
public^^ 

IActionResult^^ 
RecuperarContrasena^^ ,
(^^, -
)^^- .
{__ 
if`` 

(`` 
User`` 
.`` 
Identity`` 
?`` 
.`` 
IsAuthenticated`` *
==``+ -
true``. 2
)``2 3
return``4 :
RedirectToAction``; K
(``K L
$str``L S
,``S T
$str``U [
)``[ \
;``\ ]
returnaa 
Viewaa 
(aa 
newaa 
RecuperarDtoaa $
(aa$ %
)aa% &
)aa& '
;aa' (
}bb 
[dd 
HttpPostdd 
,dd $
ValidateAntiForgeryTokendd '
]dd' (
publicee 

asyncee 
Taskee 
<ee 
IActionResultee #
>ee# $
RecuperarContrasenaee% 8
(ee8 9
RecuperarDtoee9 E
dtoeeF I
)eeI J
{ff 
ifgg 

(gg 
!gg 

ModelStategg 
.gg 
IsValidgg 
)gg  
returngg! '
Viewgg( ,
(gg, -
dtogg- 0
)gg0 1
;gg1 2
varii 
	resultadoii 
=ii 
awaitii 
recuperacionii *
.ii* +
SolicitarAsyncii+ 9
(ii9 :
dtoii: =
.ii= >
Correoii> D
,iiD E
tokenjj 
=>jj 
Urljj 
.jj 
Actionjj 
(jj  
nameofjj  &
(jj& '!
RestablecerContrasenajj' <
)jj< =
,jj= >
$strjj? H
,jjH I
newjjJ M
{jjN O
tokenjjP U
}jjV W
,jjW X
RequestjjY `
.jj` a
Schemejja g
)jjg h
!jjh i
)jji j
;jjj k
ifll 

(ll 
	resultadoll 
==ll 
ResultadoSolicitudll +
.ll+ ,
LimiteSuperadoll, :
)ll: ;
{mm 	

ModelStatenn 
.nn 
AddModelErrornn $
(nn$ %
$strnn% '
,nn' (
$strnn) n
)nnn o
;nno p
returnoo 
Viewoo 
(oo 
dtooo 
)oo 
;oo 
}pp 	
TempDatarr 
[rr 
$strrr 
]rr 
=rr 
$strrr o
;rro p
returnss 
RedirectToActionss 
(ss  
nameofss  &
(ss& '
Loginss' ,
)ss, -
)ss- .
;ss. /
}tt 
[vv 
HttpGetvv 
]vv 
publicww 

asyncww 
Taskww 
<ww 
IActionResultww #
>ww# $!
RestablecerContrasenaww% :
(ww: ;
stringww; A
tokenwwB G
)wwG H
{xx 
ifyy 

(yy 
!yy 
awaityy 
recuperacionyy 
.yy  
TokenVigenteAsyncyy  1
(yy1 2
tokenyy2 7
)yy7 8
)yy8 9
returnyy: @
ViewyyA E
(yyE F
$stryyF U
)yyU V
;yyV W
returnzz 
Viewzz 
(zz 
newzz 
RestablecerDtozz &
{zz' (
Tokenzz) .
=zz/ 0
tokenzz1 6
}zz7 8
)zz8 9
;zz9 :
}{{ 
[}} 
HttpPost}} 
,}} $
ValidateAntiForgeryToken}} '
]}}' (
public~~ 

async~~ 
Task~~ 
<~~ 
IActionResult~~ #
>~~# $!
RestablecerContrasena~~% :
(~~: ;
RestablecerDto~~; I
dto~~J M
)~~M N
{ 
var
ÄÄ 
(
ÄÄ 
ok
ÄÄ 
,
ÄÄ 
error
ÄÄ 
)
ÄÄ 
=
ÄÄ 
await
ÄÄ 
recuperacion
ÄÄ  ,
.
ÄÄ, -
RestablecerAsync
ÄÄ- =
(
ÄÄ= >
dto
ÄÄ> A
.
ÄÄA B
Token
ÄÄB G
,
ÄÄG H
dto
ÄÄI L
.
ÄÄL M
NuevaPassword
ÄÄM Z
,
ÄÄZ [
dto
ÄÄ\ _
.
ÄÄ_ `
ConfirmarPassword
ÄÄ` q
)
ÄÄq r
;
ÄÄr s
if
ÇÇ 

(
ÇÇ 
ok
ÇÇ 
)
ÇÇ 
{
ÉÉ 	
TempData
ÑÑ 
[
ÑÑ 
$str
ÑÑ 
]
ÑÑ 
=
ÑÑ  !
$str
ÑÑ" S
;
ÑÑS T
return
ÖÖ 
RedirectToAction
ÖÖ #
(
ÖÖ# $
nameof
ÖÖ$ *
(
ÖÖ* +
Login
ÖÖ+ 0
)
ÖÖ0 1
)
ÖÖ1 2
;
ÖÖ2 3
}
ÜÜ 	
if
àà 

(
àà 
error
àà 
==
àà !
RecuperacionService
àà (
.
àà( )"
MensajeTokenInvalido
àà) =
)
àà= >
return
àà? E
View
ààF J
(
ààJ K
$str
ààK Z
)
ààZ [
;
àà[ \

ModelState
ää 
.
ää 
AddModelError
ää  
(
ää  !
$str
ää! #
,
ää# $
error
ää% *
!
ää* +
)
ää+ ,
;
ää, -
return
ãã 
View
ãã 
(
ãã 
dto
ãã 
)
ãã 
;
ãã 
}
åå 
[
èè 
HttpGet
èè 
]
èè 
public
êê 

async
êê 
Task
êê 
<
êê 
IActionResult
êê #
>
êê# $
ActivarCuenta
êê% 2
(
êê2 3
string
êê3 9
?
êê9 :
token
êê; @
)
êê@ A
{
ëë 
var
íí 
info
íí 
=
íí 
await
íí 

activacion
íí #
.
íí# $
ConsultarAsync
íí$ 2
(
íí2 3
token
íí3 8
)
íí8 9
;
íí9 :
if
ìì 

(
ìì 
info
ìì 
.
ìì 
Estado
ìì 
!=
ìì $
EstadoEnlaceActivacion
ìì 1
.
ìì1 2
Valido
ìì2 8
)
ìì8 9
return
ìì: @
View
ììA E
(
ììE F
$str
ììF `
,
ìì` a
info
ììb f
)
ììf g
;
ììg h
return
ïï 
View
ïï 
(
ïï 
ConDatos
ïï 
(
ïï 
new
ïï  
ActivarCuentaDto
ïï! 1
{
ïï2 3
Token
ïï4 9
=
ïï: ;
token
ïï< A
!
ïïA B
}
ïïC D
,
ïïD E
info
ïïF J
)
ïïJ K
)
ïïK L
;
ïïL M
}
ññ 
[
òò 
HttpPost
òò 
,
òò &
ValidateAntiForgeryToken
òò '
]
òò' (
public
ôô 

async
ôô 
Task
ôô 
<
ôô 
IActionResult
ôô #
>
ôô# $
ActivarCuenta
ôô% 2
(
ôô2 3
ActivarCuentaDto
ôô3 C
dto
ôôD G
)
ôôG H
{
öö 
if
õõ 

(
õõ 
!
õõ 

ModelState
õõ 
.
õõ 
IsValid
õõ 
)
õõ  
{
úú 	
var
ùù 
datos
ùù 
=
ùù 
await
ùù 

activacion
ùù (
.
ùù( )
ConsultarAsync
ùù) 7
(
ùù7 8
dto
ùù8 ;
.
ùù; <
Token
ùù< A
)
ùùA B
;
ùùB C
if
ûû 
(
ûû 
datos
ûû 
.
ûû 
Estado
ûû 
!=
ûû $
EstadoEnlaceActivacion
ûû  6
.
ûû6 7
Valido
ûû7 =
)
ûû= >
return
ûû? E
View
ûûF J
(
ûûJ K
$str
ûûK e
,
ûûe f
datos
ûûg l
)
ûûl m
;
ûûm n
return
üü 
View
üü 
(
üü 
ConDatos
üü  
(
üü  !
dto
üü! $
,
üü$ %
datos
üü& +
)
üü+ ,
)
üü, -
;
üü- .
}
†† 	
var
¢¢ 
(
¢¢ 
ok
¢¢ 
,
¢¢ 
error
¢¢ 
,
¢¢ 
info
¢¢ 
)
¢¢ 
=
¢¢ 
await
¢¢  %

activacion
¢¢& 0
.
¢¢0 1
ActivarAsync
¢¢1 =
(
¢¢= >
dto
¢¢> A
.
¢¢A B
Token
¢¢B G
,
¢¢G H
dto
¢¢I L
.
¢¢L M
NuevaPassword
¢¢M Z
,
¢¢Z [
dto
¢¢\ _
.
¢¢_ `
ConfirmarPassword
¢¢` q
,
¢¢q r
UrlLogin
¢¢s {
)
¢¢{ |
;
¢¢| }
if
§§ 

(
§§ 
ok
§§ 
)
§§ 
{
•• 	
var
¶¶ 
perfil
¶¶ 
=
¶¶ 
info
¶¶ 
.
¶¶ 
Rol
¶¶ !
??
¶¶" $

RolUsuario
¶¶% /
.
¶¶/ 0

Repartidor
¶¶0 :
;
¶¶: ;
var
ßß 
nombrePerfil
ßß 
=
ßß 
perfil
ßß %
==
ßß& (

RolUsuario
ßß) 3
.
ßß3 4
Administrador
ßß4 A
?
ßßB C
$str
ßßD S
:
ßßT U
$str
ßßV b
;
ßßb c
TempData
®® 
[
®® 
$str
®® 
]
®® 
=
®®  !
$"
®®" $
$str
®®$ [
{
®®[ \
nombrePerfil
®®\ h
}
®®h i
$str
®®i j
"
®®j k
;
®®k l
TempData
©© 
[
©© 
$str
©© $
]
©©$ %
=
©©& '
info
©©( ,
.
©©, -
Correo
©©- 3
;
©©3 4
return
™™ 
RedirectToAction
™™ #
(
™™# $
nameof
™™$ *
(
™™* +
Login
™™+ 0
)
™™0 1
,
™™1 2
new
™™3 6
{
™™7 8
rol
™™9 <
=
™™= >
perfil
™™? E
.
™™E F
ToString
™™F N
(
™™N O
)
™™O P
}
™™Q R
)
™™R S
;
™™S T
}
´´ 	
if
≠≠ 

(
≠≠ 
info
≠≠ 
.
≠≠ 
Estado
≠≠ 
!=
≠≠ $
EstadoEnlaceActivacion
≠≠ 1
.
≠≠1 2
Valido
≠≠2 8
)
≠≠8 9
return
≠≠: @
View
≠≠A E
(
≠≠E F
$str
≠≠F `
,
≠≠` a
info
≠≠b f
)
≠≠f g
;
≠≠g h

ModelState
ØØ 
.
ØØ 
AddModelError
ØØ  
(
ØØ  !
$str
ØØ! #
,
ØØ# $
error
ØØ% *
!
ØØ* +
)
ØØ+ ,
;
ØØ, -
return
∞∞ 
View
∞∞ 
(
∞∞ 
ConDatos
∞∞ 
(
∞∞ 
dto
∞∞  
,
∞∞  !
info
∞∞" &
)
∞∞& '
)
∞∞' (
;
∞∞( )
}
±± 
private
≥≥ 
static
≥≥ 
ActivarCuentaDto
≥≥ #
ConDatos
≥≥$ ,
(
≥≥, -
ActivarCuentaDto
≥≥- =
dto
≥≥> A
,
≥≥A B
InfoActivacion
≥≥C Q
info
≥≥R V
)
≥≥V W
{
¥¥ 
dto
µµ 
.
µµ 
Nombre
µµ 
=
µµ 
info
µµ 
.
µµ 
Nombre
µµ  
;
µµ  !
dto
∂∂ 
.
∂∂ 
Correo
∂∂ 
=
∂∂ 
info
∂∂ 
.
∂∂ 
Correo
∂∂  
;
∂∂  !
dto
∑∑ 
.
∑∑ 
Negocio
∑∑ 
=
∑∑ 
info
∑∑ 
.
∑∑ 
Negocio
∑∑ "
;
∑∑" #
dto
∏∏ 
.
∏∏ 
Rol
∏∏ 
=
∏∏ 
info
∏∏ 
.
∏∏ 
Rol
∏∏ 
??
∏∏ 

RolUsuario
∏∏ (
.
∏∏( )

Repartidor
∏∏) 3
;
∏∏3 4
return
ππ 
dto
ππ 
;
ππ 
}
∫∫ 
private
ΩΩ 
string
ΩΩ 
UrlLogin
ΩΩ 
(
ΩΩ 

RolUsuario
ΩΩ &
rol
ΩΩ' *
)
ΩΩ* +
=>
ΩΩ, .
Url
ææ 
.
ææ 
Action
ææ 
(
ææ 
nameof
ææ 
(
ææ 
Login
ææ 
)
ææ  
,
ææ  !
$str
ææ" +
,
ææ+ ,
new
ææ- 0
{
ææ1 2
rol
ææ3 6
=
ææ7 8
rol
ææ9 <
.
ææ< =
ToString
ææ= E
(
ææE F
)
ææF G
}
ææH I
,
ææI J
Request
ææK R
.
ææR S
Scheme
ææS Y
)
ææY Z
!
ææZ [
;
ææ[ \
}øø ‡l
\C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Controllers\ReporteController.cs
	namespace 	
Gtrack
 
. 
Controllers 
{ 
[		 
	Authorize		 
(		 
Roles		 
=		 
$str		  
)		  !
]		! "
public

 

class

 
ReporteController

 "
(

" #
IReporteService 
reportes  
,  !
IExportadorReportes 

exportador &
,& '
ILogger 
< 
ReporteController !
>! "
logger# )
)) *
:+ ,

Controller- 7
{ 
private 
const 
string 
	MimeExcel &
=' (
$str) l
;l m
private 
const 
string 
MimePdf $
=% &
$str' 8
;8 9
private 
const 
string 
MimeCsv $
=% &
$str' 1
;1 2
private 
const 
string 

SinPedidos '
=( )
$str* l
;l m
private 
int 
	UsuarioId 
=>  
int! $
.$ %
Parse% *
(* +
User+ /
./ 0
FindFirstValue0 >
(> ?

ClaimTypes? I
.I J
NameIdentifierJ X
)X Y
!Y Z
)Z [
;[ \
private 
static 
string 
Dia !
(! "
DateTime" *
?* +
d, -
)- .
=>/ 1
d2 3
!3 4
.4 5
Value5 :
.: ;
ToString; C
(C D
$strD P
)P Q
;Q R
[ 	
HttpGet	 
] 
public 
async 
Task 
< 
IActionResult '
>' (
Index) .
(. /
DateTime/ 7
?7 8
desde9 >
,> ?
DateTime@ H
?H I
hastaJ O
)O P
{ 	
var 
hoy 
= 
DateTime 
. 
Today $
;$ %
var 
vista 
= 
new 
ReporteNegocioVista /
{ 
Desde 
= 
desde 
? 
. 
Date #
??$ &
new' *
DateTime+ 3
(3 4
hoy4 7
.7 8
Year8 <
,< =
hoy> A
.A B
MonthB G
,G H
$numI J
)J K
,K L
Hasta   
=   
hasta   
?   
.   
Date   #
??  $ &
hoy  ' *
}!! 
;!! 
if$$ 
($$ 
desde$$ 
is$$ 
null$$ 
&&$$  
hasta$$! &
is$$' )
null$$* .
)$$. /
return$$0 6
View$$7 ;
($$; <
vista$$< A
)$$A B
;$$B C
vista'' 
.'' 
Error'' 
='' 
RangoReporte'' &
.''& '
Validar''' .
(''. /
desde''/ 4
,''4 5
hasta''6 ;
)''; <
;''< =
if(( 
((( 
vista(( 
.(( 
Error(( 
is(( 
not(( "
null((# '
)((' (
return(() /
View((0 4
(((4 5
vista((5 :
)((: ;
;((; <
try** 
{++ 
var,, 
reporte,, 
=,, 
await,, #
reportes,,$ ,
.,,, -&
GenerarReporteNegocioAsync,,- G
(,,G H
	UsuarioId,,H Q
,,,Q R
desde,,S X
!,,X Y
.,,Y Z
Value,,Z _
,,,_ `
hasta,,a f
!,,f g
.,,g h
Value,,h m
),,m n
;,,n o
if-- 
(-- 
reporte-- 
is-- 
null-- #
)--# $
vista.. 
... 
Error.. 
=..  !
$str.." I
;..I J
else// 
if// 
(// 
reporte//  
.//  !
TotalPedidos//! -
==//. 0
$num//1 2
)//2 3
vista00 
.00 
Aviso00 
=00  !

SinPedidos00" ,
;00, -
else11 
vista22 
.22 
Reporte22 !
=22" #
reporte22$ +
;22+ ,
}33 
catch44 
(44 
	Exception44 
ex44 
)44  
{55 
logger66 
.66 
LogError66 
(66  
ex66  "
,66" #
$str66$ d
,66d e
	UsuarioId66f o
)66o p
;66p q
vista77 
.77 
Error77 
=77 
$str77 U
;77U V
}88 
return:: 
View:: 
(:: 
vista:: 
):: 
;:: 
};; 	
[>> 	
HttpGet>>	 
]>> 
public?? 
async?? 
Task?? 
<?? 
IActionResult?? '
>??' (
	Descargar??) 2
(??2 3
DateTime??3 ;
???; <
desde??= B
,??B C
DateTime??D L
???L M
hasta??N S
,??S T
string??U [
formato??\ c
=??d e
$str??f m
)??m n
{@@ 	
varAA 
errorAA 
=AA 
RangoReporteAA $
.AA$ %
ValidarAA% ,
(AA, -
desdeAA- 2
,AA2 3
hastaAA4 9
)AA9 :
;AA: ;
ifBB 
(BB 
errorBB 
isBB 
notBB 
nullBB !
)BB! "
{CC 
TempDataDD 
[DD 
$strDD  
]DD  !
=DD" #
errorDD$ )
;DD) *
returnEE 
RedirectToActionEE '
(EE' (
nameofEE( .
(EE. /
IndexEE/ 4
)EE4 5
)EE5 6
;EE6 7
}FF 
tryHH 
{II 
varJJ 
reporteJJ 
=JJ 
awaitJJ #
reportesJJ$ ,
.JJ, -&
GenerarReporteNegocioAsyncJJ- G
(JJG H
	UsuarioIdJJH Q
,JJQ R
desdeJJS X
!JJX Y
.JJY Z
ValueJJZ _
,JJ_ `
hastaJJa f
!JJf g
.JJg h
ValueJJh m
)JJm n
;JJn o
ifKK 
(KK 
reporteKK 
isKK 
nullKK #
||KK$ &
reporteKK' .
.KK. /
TotalPedidosKK/ ;
==KK< >
$numKK? @
)KK@ A
{LL 
TempDataMM 
[MM 
$strMM $
]MM$ %
=MM& '

SinPedidosMM( 2
;MM2 3
returnNN 
RedirectToActionNN +
(NN+ ,
nameofNN, 2
(NN2 3
IndexNN3 8
)NN8 9
,NN9 :
newNN; >
{NN? @
desdeNNA F
=NNG H
DiaNNI L
(NNL M
desdeNNM R
)NNR S
,NNS T
hastaNNU Z
=NN[ \
DiaNN] `
(NN` a
hastaNNa f
)NNf g
}NNh i
)NNi j
;NNj k
}OO 
varQQ 
nombreQQ 
=QQ 
$"QQ 
$strQQ /
{QQ/ 0
desdeQQ0 5
.QQ5 6
ValueQQ6 ;
:QQ; <
$strQQ< D
}QQD E
$strQQE F
{QQF G
hastaQQG L
.QQL M
ValueQQM R
:QQR S
$strQQS [
}QQ[ \
"QQ\ ]
;QQ] ^
returnRR 
formatoRR 
.RR 
EqualsRR %
(RR% &
$strRR& +
,RR+ ,
StringComparisonRR- =
.RR= >
OrdinalIgnoreCaseRR> O
)RRO P
?SS 
FileSS 
(SS 

exportadorSS %
.SS% &
ReporteNegocioPdfSS& 7
(SS7 8
reporteSS8 ?
)SS? @
,SS@ A
MimePdfSSB I
,SSI J
nombreSSK Q
+SSR S
$strSST Z
)SSZ [
:TT 
FileTT 
(TT 

exportadorTT %
.TT% &
ReporteNegocioExcelTT& 9
(TT9 :
reporteTT: A
)TTA B
,TTB C
	MimeExcelTTD M
,TTM N
nombreTTO U
+TTV W
$strTTX _
)TT_ `
;TT` a
}UU 
catchVV 
(VV 
	ExceptionVV 
exVV 
)VV  
{WW 
loggerXX 
.XX 
LogErrorXX 
(XX  
exXX  "
,XX" #
$strXX$ e
,XXe f
	UsuarioIdXXg p
)XXp q
;XXq r
TempDataYY 
[YY 
$strYY  
]YY  !
=YY" #
$strYY$ [
;YY[ \
returnZZ 
RedirectToActionZZ '
(ZZ' (
nameofZZ( .
(ZZ. /
IndexZZ/ 4
)ZZ4 5
,ZZ5 6
newZZ7 :
{ZZ; <
desdeZZ= B
=ZZC D
DiaZZE H
(ZZH I
desdeZZI N
)ZZN O
,ZZO P
hastaZZQ V
=ZZW X
DiaZZY \
(ZZ\ ]
hastaZZ] b
)ZZb c
}ZZd e
)ZZe f
;ZZf g
}[[ 
}\\ 	
[__ 	
HttpGet__	 
]__ 
public`` 
async`` 
Task`` 
<`` 
IActionResult`` '
>``' (
ExportarHistorial``) :
(``: ;
DateTime``; C
?``C D
desde``E J
,``J K
DateTime``L T
?``T U
hasta``V [
,``[ \
string``] c
formato``d k
=``l m
$str``n u
)``u v
{aa 	
varcc 
errorcc 
=cc 
RangoReportecc $
.cc$ %
Validarcc% ,
(cc, -
desdecc- 2
,cc2 3
hastacc4 9
)cc9 :
;cc: ;
ifdd 
(dd 
errordd 
isdd 
notdd 
nulldd !
)dd! "
{ee 
TempDataff 
[ff 
$strff  
]ff  !
=ff" #
errorff$ )
;ff) *
returngg 
RedirectToActiongg '
(gg' (
$strgg( 3
,gg3 4
$strgg5 =
)gg= >
;gg> ?
}hh 
tryjj 
{kk 
varll 
	historialll 
=ll 
awaitll  %
reportesll& .
.ll. /!
ObtenerHistorialAsyncll/ D
(llD E
	UsuarioIdllE N
,llN O
desdellP U
!llU V
.llV W
ValuellW \
,ll\ ]
hastall^ c
!llc d
.lld e
Valuelle j
)llj k
;llk l
ifoo 
(oo 
	historialoo 
isoo  
nulloo! %
||oo& (
	historialoo) 2
.oo2 3
Filasoo3 8
.oo8 9
Countoo9 >
==oo? A
$numooB C
)ooC D
{pp 
TempDataqq 
[qq 
$strqq $
]qq$ %
=qq& '
$strqq( ]
;qq] ^
returnrr 
RedirectToActionrr +
(rr+ ,
$strrr, 7
,rr7 8
$strrr9 A
)rrA B
;rrB C
}ss 
varuu 
nombreuu 
=uu 
$"uu 
$struu 1
{uu1 2
desdeuu2 7
.uu7 8
Valueuu8 =
:uu= >
$struu> F
}uuF G
$struuG H
{uuH I
hastauuI N
.uuN O
ValueuuO T
:uuT U
$struuU ]
}uu] ^
"uu^ _
;uu_ `
returnvv 
formatovv 
.vv 
ToLowerInvariantvv /
(vv/ 0
)vv0 1
switchvv2 8
{ww 
$strxx 
=>xx 
Filexx !
(xx! "

exportadorxx" ,
.xx, -
HistorialPdfxx- 9
(xx9 :
	historialxx: C
)xxC D
,xxD E
MimePdfxxF M
,xxM N
nombrexxO U
+xxV W
$strxxX ^
)xx^ _
,xx_ `
$stryy 
=>yy 
Fileyy !
(yy! "

exportadoryy" ,
.yy, -
HistorialCsvyy- 9
(yy9 :
	historialyy: C
)yyC D
,yyD E
MimeCsvyyF M
,yyM N
nombreyyO U
+yyV W
$stryyX ^
)yy^ _
,yy_ `
_zz 
=>zz 
Filezz 
(zz 

exportadorzz (
.zz( )
HistorialExcelzz) 7
(zz7 8
	historialzz8 A
)zzA B
,zzB C
	MimeExcelzzD M
,zzM N
nombrezzO U
+zzV W
$strzzX _
)zz_ `
}{{ 
;{{ 
}|| 
catch}} 
(}} 
	Exception}} 
ex}} 
)}}  
{~~ 
logger
ÄÄ 
.
ÄÄ 
LogError
ÄÄ 
(
ÄÄ  
ex
ÄÄ  "
,
ÄÄ" #
$str
ÄÄ$ g
,
ÄÄg h
	UsuarioId
ÄÄi r
)
ÄÄr s
;
ÄÄs t
TempData
ÅÅ 
[
ÅÅ 
$str
ÅÅ  
]
ÅÅ  !
=
ÅÅ" #
$str
ÅÅ$ [
;
ÅÅ[ \
return
ÇÇ 
RedirectToAction
ÇÇ '
(
ÇÇ' (
$str
ÇÇ( 3
,
ÇÇ3 4
$str
ÇÇ5 =
)
ÇÇ= >
;
ÇÇ> ?
}
ÉÉ 
}
ÑÑ 	
}
ÖÖ 
}ÜÜ å‘
_C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Controllers\RepartidorController.cs
	namespace 	
Gtrack
 
; 
[

 
	Authorize

 

]


 
public 
class  
RepartidorController !
(! "!
IRepartidorRepository 
repartidorRepo (
,( )
INegocioRepository 
negocioRepo "
," #
IRepartidorService 
repartidorService (
,( )
AppDbContext 
context 
, 
IPedidoService 
pedidos 
, 
IUbicacionService 
ubicacionService &
,& '$
IPerfilRepartidorService 
perfilService *
,* +
ILogger 
<  
RepartidorController  
>  !
logger" (
)( )
:* +

Controller, 6
{ 
private 
int 
	UsuarioId 
=> 
int  
.  !
Parse! &
(& '
User' +
.+ ,
FindFirstValue, :
(: ;

ClaimTypes; E
.E F
NameIdentifierF T
)T U
!U V
)V W
;W X
private 
string 
EnlaceActivacion #
(# $
string$ *
token+ 0
)0 1
=>2 4
Url 
. 
Action 
( 
$str "
," #
$str$ -
,- .
new/ 2
{3 4
token5 :
}; <
,< =
Request> E
.E F
SchemeF L
)L M
!M N
;N O
[ 
HttpGet 
] 
[ 
	Authorize 
( 
Roles 
= 
$str  
)  !
]! "
public 

async 
Task 
< 
IActionResult #
># $
Index% *
(* +
)+ ,
{ 
var 
negocio 
= 
await 
negocioRepo '
.' ($
ObtenerPorUsuarioIdAsync( @
(@ A
	UsuarioIdA J
)J K
;K L
if   

(   
negocio   
==   
null   
)   
return   #
View  $ (
(  ( )
new  ) ,
List  - 1
<  1 2

Repartidor  2 <
>  < =
(  = >
)  > ?
)  ? @
;  @ A
var"" 
repartidores"" 
="" 
await""  
repartidorRepo""! /
.""/ 0!
ListarPorNegocioAsync""0 E
(""E F
negocio""F M
.""M N
Id""N P
)""P Q
;""Q R
return## 
View## 
(## 
repartidores##  
)##  !
;##! "
}$$ 
[&& 
HttpGet&& 
]&& 
['' 
	Authorize'' 
('' 
Roles'' 
='' 
$str''  
)''  !
]''! "
public(( 

IActionResult(( 
	Registrar(( "
(((" #
)((# $
{)) 
return** 
View** 
(** 
new** !
RegistroRepartidorDto** -
(**- .
)**. /
)**/ 0
;**0 1
}++ 
[-- 
HttpPost-- 
,-- $
ValidateAntiForgeryToken-- '
]--' (
[.. 
	Authorize.. 
(.. 
Roles.. 
=.. 
$str..  
)..  !
]..! "
public// 

async// 
Task// 
<// 
IActionResult// #
>//# $
	Registrar//% .
(//. /!
RegistroRepartidorDto/// D
dto//E H
)//H I
{00 
if11 

(11 
!11 

ModelState11 
.11 
IsValid11 
)11  
{22 	
return33 
View33 
(33 
dto33 
)33 
;33 
}44 	
var77 
	resultado77 
=77 
await77 
repartidorService77 /
.77/ 0
RegistrarAsync770 >
(77> ?
	UsuarioId77? H
,77H I
dto77J M
,77M N
EnlaceActivacion77O _
)77_ `
;77` a
if88 

(88 
!88 
	resultado88 
.88 
Ok88 
)88 
{99 	

ModelState:: 
.:: 
AddModelError:: $
(::$ %
	resultado::% .
.::. /
Campo::/ 4
??::5 7
string::8 >
.::> ?
Empty::? D
,::D E
	resultado::F O
.::O P
Error::P U
!::U V
)::V W
;::W X
return;; 
View;; 
(;; 
dto;; 
);; 
;;; 
}<< 	
var>> 
correo>> 
=>> 
dto>> 
.>> 
Correo>> 
.>>  
Trim>>  $
(>>$ %
)>>% &
;>>& '
if?? 

(?? 
	resultado?? 
.?? 
CorreoEnviado?? #
)??# $
TempData@@ 
[@@ 
$str@@ 
]@@ 
=@@  !
$"@@" $
$str@@$ T
{@@T U
correo@@U [
}@@[ \
$str	@@\ å
"
@@å ç
;
@@ç é
elseAA 
TempDataBB 
[BB 
$strBB 
]BB 
=BB 
$"BB  "
$strBB" s
{BBs t
correoBBt z
}BBz {
$str	BB{ Æ
"
BBÆ Ø
;
BBØ ∞
returnDD 
RedirectToActionDD 
(DD  
nameofDD  &
(DD& '
IndexDD' ,
)DD, -
)DD- .
;DD. /
}EE 
[GG 
HttpPostGG 
,GG $
ValidateAntiForgeryTokenGG '
]GG' (
[HH 
	AuthorizeHH 
(HH 
RolesHH 
=HH 
$strHH  
)HH  !
]HH! "
publicII 

asyncII 
TaskII 
<II 
IActionResultII #
>II# $
ReenviarActivacionII% 7
(II7 8
intII8 ;
idII< >
)II> ?
{JJ 
varKK 
(KK 
okKK 
,KK 
mensajeKK 
)KK 
=KK 
awaitKK !
repartidorServiceKK" 3
.KK3 4#
ReenviarActivacionAsyncKK4 K
(KKK L
	UsuarioIdKKL U
,KKU V
idKKW Y
,KKY Z
EnlaceActivacionKK[ k
)KKk l
;KKl m
TempDataLL 
[LL 
okLL 
?LL 
$strLL 
:LL  !
$strLL" )
]LL) *
=LL+ ,
mensajeLL- 4
;LL4 5
returnMM 
RedirectToActionMM 
(MM  
nameofMM  &
(MM& '
IndexMM' ,
)MM, -
)MM- .
;MM. /
}NN 
[PP 
HttpPostPP 
,PP $
ValidateAntiForgeryTokenPP '
]PP' (
[QQ 
	AuthorizeQQ 
(QQ 
RolesQQ 
=QQ 
$strQQ  
)QQ  !
]QQ! "
publicRR 

asyncRR 
TaskRR 
<RR 
IActionResultRR #
>RR# $
CambiarEstadoRR% 2
(RR2 3
intRR3 6
idRR7 9
)RR9 :
{SS 
varTT 
negocioTT 
=TT 
awaitTT 
negocioRepoTT '
.TT' ($
ObtenerPorUsuarioIdAsyncTT( @
(TT@ A
	UsuarioIdTTA J
)TTJ K
;TTK L
ifUU 

(UU 
negocioUU 
==UU 
nullUU 
)UU 
returnUU #
NotFoundUU$ ,
(UU, -
)UU- .
;UU. /
varWW 

repartidorWW 
=WW 
awaitWW 
contextWW &
.WW& '
SetWW' *
<WW* +

RepartidorWW+ 5
>WW5 6
(WW6 7
)WW7 8
.XX 
IncludeXX 
(XX 
rXX 
=>XX 
rXX 
.XX 
UsuarioXX #
)XX# $
.YY 
FirstOrDefaultAsyncYY  
(YY  !
rYY! "
=>YY# %
rYY& '
.YY' (
IdYY( *
==YY+ -
idYY. 0
&&YY1 3
rYY4 5
.YY5 6
	NegocioIdYY6 ?
==YY@ B
negocioYYC J
.YYJ K
IdYYK M
)YYM N
;YYN O
if[[ 

([[ 

repartidor[[ 
==[[ 
null[[ 
||[[ !

repartidor[[" ,
.[[, -
Usuario[[- 4
==[[5 7
null[[8 <
)[[< =
{\\ 	
TempData]] 
[]] 
$str]] 
]]] 
=]] 
$str]]  V
;]]V W
return^^ 
RedirectToAction^^ #
(^^# $
nameof^^$ *
(^^* +
Index^^+ 0
)^^0 1
)^^1 2
;^^2 3
}__ 	
ifbb 

(bb 

repartidorbb 
.bb 
Usuariobb 
.bb 
Estadobb %
==bb& (
EstadoCuentabb) 5
.bb5 6
PendienteActivacionbb6 I
)bbI J
{cc 	
TempDatadd 
[dd 
$strdd 
]dd 
=dd 
$"dd  "
{dd" #

repartidordd# -
.dd- .
NombreCompletodd. <
}dd< =
$str	dd= Ü
"
ddÜ á
;
ddá à
returnee 
RedirectToActionee #
(ee# $
nameofee$ *
(ee* +
Indexee+ 0
)ee0 1
)ee1 2
;ee2 3
}ff 	
ifjj 

(jj 

repartidorjj 
.jj 
Usuariojj 
.jj 
Estadojj %
!=jj& (
EstadoCuentajj) 5
.jj5 6
Activojj6 <
&&jj= ?
stringjj@ F
.jjF G
IsNullOrEmptyjjG T
(jjT U

repartidorjjU _
.jj_ `
Usuariojj` g
.jjg h
PasswordHashjjh t
)jjt u
)jju v
{kk 	

repartidorll 
.ll 
Usuarioll 
.ll 
Estadoll %
=ll& '
EstadoCuentall( 4
.ll4 5
PendienteActivacionll5 H
;llH I
awaitmm 
contextmm 
.mm 
SaveChangesAsyncmm *
(mm* +
)mm+ ,
;mm, -
varoo 
(oo 
enviadooo 
,oo 
_oo 
)oo 
=oo 
awaitoo $
repartidorServiceoo% 6
.oo6 7#
ReenviarActivacionAsyncoo7 N
(ooN O
	UsuarioIdooO X
,ooX Y

repartidorooZ d
.ood e
Idooe g
,oog h
EnlaceActivacionooi y
)ooy z
;ooz {
ifpp 
(pp 
enviadopp 
)pp 
TempDataqq 
[qq 
$strqq "
]qq" #
=qq$ %
$"qq& (
{qq( )

repartidorqq) 3
.qq3 4
NombreCompletoqq4 B
}qqB C
$str	qqC ç
"
qqç é
;
qqé è
elserr 
TempDatass 
[ss 
$strss  
]ss  !
=ss" #
$"ss$ &
{ss& '

repartidorss' 1
.ss1 2
NombreCompletoss2 @
}ss@ A
$str	ssA °
"
ss° ¢
;
ss¢ £
returntt 
RedirectToActiontt #
(tt# $
nameoftt$ *
(tt* +
Indextt+ 0
)tt0 1
)tt1 2
;tt2 3
}uu 	

repartidorww 
.ww 
Usuarioww 
.ww 
Estadoww !
=ww" #

repartidorww$ .
.ww. /
Usuarioww/ 6
.ww6 7
Estadoww7 =
==ww> @
EstadoCuentawwA M
.wwM N
ActivowwN T
?xx 
EstadoCuentaxx 
.xx 

Suspendidoxx %
:yy 
EstadoCuentayy 
.yy 
Activoyy !
;yy! "
context{{ 
.{{ 
Entry{{ 
({{ 

repartidor{{  
.{{  !
Usuario{{! (
){{( )
.{{) *
State{{* /
={{0 1
EntityState{{2 =
.{{= >
Modified{{> F
;{{F G
await}} 
context}} 
.}} 
SaveChangesAsync}} &
(}}& '
)}}' (
;}}( )
TempData 
[ 
$str 
] 
= 
$str [
;[ \
return
ÄÄ 
RedirectToAction
ÄÄ 
(
ÄÄ  
nameof
ÄÄ  &
(
ÄÄ& '
Index
ÄÄ' ,
)
ÄÄ, -
)
ÄÄ- .
;
ÄÄ. /
}
ÅÅ 
[
ÉÉ 
HttpGet
ÉÉ 
]
ÉÉ 
[
ÑÑ 
	Authorize
ÑÑ 
(
ÑÑ 
Roles
ÑÑ 
=
ÑÑ 
$str
ÑÑ #
)
ÑÑ# $
]
ÑÑ$ %
public
ÖÖ 

async
ÖÖ 
Task
ÖÖ 
<
ÖÖ 
IActionResult
ÖÖ #
>
ÖÖ# $

MisPedidos
ÖÖ% /
(
ÖÖ/ 0
)
ÖÖ0 1
{
ÜÜ 
try
áá 
{
àà 	
var
ââ 

repartidor
ââ 
=
ââ 
await
ââ "
context
ââ# *
.
ââ* +
Repartidores
ââ+ 7
.
ää 
AsNoTracking
ää 
(
ää 
)
ää 
.
ãã !
FirstOrDefaultAsync
ãã $
(
ãã$ %
r
ãã% &
=>
ãã' )
r
ãã* +
.
ãã+ ,
	UsuarioId
ãã, 5
==
ãã6 8
	UsuarioId
ãã9 B
)
ããB C
;
ããC D
if
çç 
(
çç 

repartidor
çç 
==
çç 
null
çç "
)
çç" #
{
éé 
TempData
èè 
[
èè 
$str
èè  
]
èè  !
=
èè" #
$str
èè$ \
;
èè\ ]
return
êê 
View
êê 
(
êê 
new
êê 
List
êê  $
<
êê$ %
Pedido
êê% +
>
êê+ ,
(
êê, -
)
êê- .
)
êê. /
;
êê/ 0
}
ëë 
var
ìì 

misPedidos
ìì 
=
ìì 
await
ìì "
context
ìì# *
.
ìì* +
Pedidos
ìì+ 2
.
îî 
AsNoTracking
îî 
(
îî 
)
îî 
.
ïï 
Include
ïï 
(
ïï 
p
ïï 
=>
ïï 
p
ïï 
.
ïï  
Items
ïï  %
)
ïï% &
.
ññ 
Include
ññ 
(
ññ 
p
ññ 
=>
ññ 
p
ññ 
.
ññ  
Cliente
ññ  '
)
ññ' (
.
óó 
Where
óó 
(
óó 
p
óó 
=>
óó 
p
óó 
.
óó 
RepartidorId
óó *
==
óó+ -

repartidor
óó. 8
.
óó8 9
Id
óó9 ;
&&
óó< >
(
òò 
p
òò 
.
òò 
EstadoPedidoId
òò ,
==
òò- /
(
òò0 1
int
òò1 4
)
òò4 5
EstadoPedido
òò5 A
.
òòA B
Asignado
òòB J
||
òòK M
p
òòN O
.
òòO P
EstadoPedidoId
òòP ^
==
òò_ a
(
òòb c
int
òòc f
)
òòf g
EstadoPedido
òòg s
.
òòs t
EnCamino
òòt |
)
òò| }
)
òò} ~
.
ôô 
OrderByDescending
ôô "
(
ôô" #
p
ôô# $
=>
ôô% '
p
ôô( )
.
ôô) *
FechaCreacion
ôô* 7
)
ôô7 8
.
öö 
ToListAsync
öö 
(
öö 
)
öö 
;
öö 
ViewBag
ùù 
.
ùù 
	Novedades
ùù 
=
ùù 
await
ùù  %
NovedadesDeAsync
ùù& 6
(
ùù6 7

misPedidos
ùù7 A
.
ùùA B
Select
ùùB H
(
ùùH I
p
ùùI J
=>
ùùK M
p
ùùN O
.
ùùO P
Id
ùùP R
)
ùùR S
.
ùùS T
ToList
ùùT Z
(
ùùZ [
)
ùù[ \
)
ùù\ ]
;
ùù] ^
return
üü 
View
üü 
(
üü 

misPedidos
üü "
)
üü" #
;
üü# $
}
†† 	
catch
°° 
(
°° 
	Exception
°° 
ex
°° 
)
°° 
{
¢¢ 	
logger
§§ 
.
§§ 
LogError
§§ 
(
§§ 
ex
§§ 
,
§§ 
$str
§§  b
,
§§b c
	UsuarioId
§§d m
)
§§m n
;
§§n o
return
•• 
View
•• 
(
•• 
(
•• 
List
•• 
<
•• 
Pedido
•• $
>
••$ %
?
••% &
)
••& '
null
••' +
)
••+ ,
;
••, -
}
¶¶ 	
}
ßß 
[
©© 
HttpPost
©© 
,
©© &
ValidateAntiForgeryToken
©© '
]
©©' (
[
™™ 
	Authorize
™™ 
(
™™ 
Roles
™™ 
=
™™ 
$str
™™ #
)
™™# $
]
™™$ %
public
´´ 

async
´´ 
Task
´´ 
<
´´ 
IActionResult
´´ #
>
´´# $
ActualizarEstado
´´% 5
(
´´5 6
int
´´6 9
id
´´: <
,
´´< =
int
´´> A
nuevoEstadoId
´´B O
)
´´O P
{
¨¨ 
if
ÆÆ 

(
ÆÆ 
nuevoEstadoId
ÆÆ 
!=
ÆÆ 
(
ÆÆ 
int
ÆÆ !
)
ÆÆ! "
EstadoPedido
ÆÆ" .
.
ÆÆ. /
EnCamino
ÆÆ/ 7
&&
ÆÆ8 :
nuevoEstadoId
ÆÆ; H
!=
ÆÆI K
(
ÆÆL M
int
ÆÆM P
)
ÆÆP Q
EstadoPedido
ÆÆQ ]
.
ÆÆ] ^
	Entregado
ÆÆ^ g
)
ÆÆg h
{
ØØ 	
TempData
∞∞ 
[
∞∞ 
$str
∞∞ 
]
∞∞ 
=
∞∞ 
$str
∞∞  G
;
∞∞G H
return
±± 
RedirectToAction
±± #
(
±±# $
nameof
±±$ *
(
±±* +

MisPedidos
±±+ 5
)
±±5 6
)
±±6 7
;
±±7 8
}
≤≤ 	
try
¥¥ 
{
µµ 	
var
∂∂ 
(
∂∂ 
ok
∂∂ 
,
∂∂ 
error
∂∂ 
)
∂∂ 
=
∂∂ 
await
∂∂ #
pedidos
∂∂$ +
.
∂∂+ ,#
ActualizarEstadoAsync
∂∂, A
(
∂∂A B
	UsuarioId
∂∂B K
,
∂∂K L
id
∂∂M O
,
∂∂O P
nuevoEstadoId
∂∂Q ^
)
∂∂^ _
;
∂∂_ `
if
∑∑ 
(
∑∑ 
!
∑∑ 
ok
∑∑ 
)
∑∑ 
{
∏∏ 
TempData
ππ 
[
ππ 
$str
ππ  
]
ππ  !
=
ππ" #
error
ππ$ )
??
ππ* ,
$str
ππ- T
;
ππT U
}
∫∫ 
else
ªª 
{
ºº 
TempData
ΩΩ 
[
ΩΩ 
$str
ΩΩ "
]
ΩΩ" #
=
ΩΩ$ %
nuevoEstadoId
ΩΩ& 3
==
ΩΩ4 6
(
ΩΩ7 8
int
ΩΩ8 ;
)
ΩΩ; <
EstadoPedido
ΩΩ< H
.
ΩΩH I
EnCamino
ΩΩI Q
?
ææ 
$str
ææ I
:
øø 
$str
øø 7
;
øø7 8
}
¿¿ 
}
¡¡ 	
catch
¬¬ 
(
¬¬ 
	Exception
¬¬ 
ex
¬¬ 
)
¬¬ 
{
√√ 	
logger
ƒƒ 
.
ƒƒ 
LogError
ƒƒ 
(
ƒƒ 
ex
ƒƒ 
,
ƒƒ 
$str
ƒƒ  U
,
ƒƒU V
id
ƒƒW Y
)
ƒƒY Z
;
ƒƒZ [
TempData
≈≈ 
[
≈≈ 
$str
≈≈ 
]
≈≈ 
=
≈≈ 
$str
≈≈  e
;
≈≈e f
}
∆∆ 	
return
»» 
RedirectToAction
»» 
(
»»  
nameof
»»  &
(
»»& '

MisPedidos
»»' 1
)
»»1 2
)
»»2 3
;
»»3 4
}
…… 
[
ÀÀ 
HttpPost
ÀÀ 
,
ÀÀ &
ValidateAntiForgeryToken
ÀÀ '
]
ÀÀ' (
[
ÃÃ 
	Authorize
ÃÃ 
(
ÃÃ 
Roles
ÃÃ 
=
ÃÃ 
$str
ÃÃ #
)
ÃÃ# $
]
ÃÃ$ %
public
ÕÕ 

async
ÕÕ 
Task
ÕÕ 
<
ÕÕ 
IActionResult
ÕÕ #
>
ÕÕ# $
IniciarEntrega
ÕÕ% 3
(
ÕÕ3 4
int
ÕÕ4 7
id
ÕÕ8 :
)
ÕÕ: ;
=>
ÕÕ< >
await
ŒŒ 
ActualizarEstado
ŒŒ 
(
ŒŒ 
id
ŒŒ !
,
ŒŒ! "
(
ŒŒ# $
int
ŒŒ$ '
)
ŒŒ' (
EstadoPedido
ŒŒ( 4
.
ŒŒ4 5
EnCamino
ŒŒ5 =
)
ŒŒ= >
;
ŒŒ> ?
[
–– 
HttpPost
–– 
,
–– &
ValidateAntiForgeryToken
–– '
]
––' (
[
—— 
	Authorize
—— 
(
—— 
Roles
—— 
=
—— 
$str
—— #
)
——# $
]
——$ %
public
““ 

async
““ 
Task
““ 
<
““ 
IActionResult
““ #
>
““# $
MarcarEntregado
““% 4
(
““4 5
int
““5 8
id
““9 ;
)
““; <
=>
““= ?
await
”” 
ActualizarEstado
”” 
(
”” 
id
”” !
,
””! "
(
””# $
int
””$ '
)
””' (
EstadoPedido
””( 4
.
””4 5
	Entregado
””5 >
)
””> ?
;
””? @
[
◊◊ 
HttpPost
◊◊ 
,
◊◊ &
ValidateAntiForgeryToken
◊◊ '
]
◊◊' (
[
ÿÿ 
	Authorize
ÿÿ 
(
ÿÿ 
Roles
ÿÿ 
=
ÿÿ 
$str
ÿÿ #
)
ÿÿ# $
]
ÿÿ$ %
public
ŸŸ 

async
ŸŸ 
Task
ŸŸ 
<
ŸŸ 
IActionResult
ŸŸ #
>
ŸŸ# $
ReportarNovedad
ŸŸ% 4
(
ŸŸ4 5
int
ŸŸ5 8
id
ŸŸ9 ;
,
ŸŸ; <
int
ŸŸ= @
?
ŸŸ@ A
tipoNovedadId
ŸŸB O
,
ŸŸO P
string
ŸŸQ W
?
ŸŸW X
observaciones
ŸŸY f
)
ŸŸf g
{
⁄⁄ 
var
€€ 
(
€€ 
ok
€€ 
,
€€ 
error
€€ 
)
€€ 
=
€€ 
await
€€ 
pedidos
€€  '
.
€€' (#
RegistrarNovedadAsync
€€( =
(
€€= >
	UsuarioId
€€> G
,
€€G H
id
€€I K
,
€€K L
tipoNovedadId
€€M Z
,
€€Z [
observaciones
€€\ i
)
€€i j
;
€€j k
if
‹‹ 

(
‹‹ 
ok
‹‹ 
)
‹‹ 
TempData
›› 
[
›› 
$str
›› 
]
›› 
=
››  !
$str
››" C
;
››C D
else
ﬁﬁ 
TempData
ﬂﬂ 
[
ﬂﬂ 
$str
ﬂﬂ 
]
ﬂﬂ 
=
ﬂﬂ 
error
ﬂﬂ  %
??
ﬂﬂ& (
$str
ﬂﬂ) b
;
ﬂﬂb c
return
·· 
RedirectToAction
·· 
(
··  
nameof
··  &
(
··& '

MisPedidos
··' 1
)
··1 2
)
··2 3
;
··3 4
}
‚‚ 
private
ÂÂ 
async
ÂÂ 
Task
ÂÂ 
<
ÂÂ 
ILookup
ÂÂ 
<
ÂÂ 
int
ÂÂ "
,
ÂÂ" #
NovedadPedido
ÂÂ$ 1
>
ÂÂ1 2
>
ÂÂ2 3
NovedadesDeAsync
ÂÂ4 D
(
ÂÂD E
List
ÂÂE I
<
ÂÂI J
int
ÂÂJ M
>
ÂÂM N
	pedidoIds
ÂÂO X
)
ÂÂX Y
{
ÊÊ 
try
ÁÁ 
{
ËË 	
var
ÈÈ 
	novedades
ÈÈ 
=
ÈÈ 
await
ÈÈ !
context
ÈÈ" )
.
ÈÈ) *
NovedadesPedido
ÈÈ* 9
.
ÍÍ 
AsNoTracking
ÍÍ 
(
ÍÍ 
)
ÍÍ 
.
ÎÎ 
Where
ÎÎ 
(
ÎÎ 
n
ÎÎ 
=>
ÎÎ 
	pedidoIds
ÎÎ %
.
ÎÎ% &
Contains
ÎÎ& .
(
ÎÎ. /
n
ÎÎ/ 0
.
ÎÎ0 1
PedidoId
ÎÎ1 9
)
ÎÎ9 :
)
ÎÎ: ;
.
ÏÏ 
OrderBy
ÏÏ 
(
ÏÏ 
n
ÏÏ 
=>
ÏÏ 
n
ÏÏ 
.
ÏÏ  
Fecha
ÏÏ  %
)
ÏÏ% &
.
ÌÌ 
ToListAsync
ÌÌ 
(
ÌÌ 
)
ÌÌ 
;
ÌÌ 
return
ÓÓ 
	novedades
ÓÓ 
.
ÓÓ 
ToLookup
ÓÓ %
(
ÓÓ% &
n
ÓÓ& '
=>
ÓÓ( *
n
ÓÓ+ ,
.
ÓÓ, -
PedidoId
ÓÓ- 5
)
ÓÓ5 6
;
ÓÓ6 7
}
ÔÔ 	
catch
 
(
 
	Exception
 
ex
 
)
 
{
ÒÒ 	
logger
ÚÚ 
.
ÚÚ 

LogWarning
ÚÚ 
(
ÚÚ 
ex
ÚÚ  
,
ÚÚ  !
$str
ÚÚ" {
,
ÚÚ{ |
	UsuarioIdÚÚ} Ü
)ÚÚÜ á
;ÚÚá à
return
ÛÛ 

Enumerable
ÛÛ 
.
ÛÛ 
Empty
ÛÛ #
<
ÛÛ# $
NovedadPedido
ÛÛ$ 1
>
ÛÛ1 2
(
ÛÛ2 3
)
ÛÛ3 4
.
ÛÛ4 5
ToLookup
ÛÛ5 =
(
ÛÛ= >
n
ÛÛ> ?
=>
ÛÛ@ B
n
ÛÛC D
.
ÛÛD E
PedidoId
ÛÛE M
)
ÛÛM N
;
ÛÛN O
}
ÙÙ 	
}
ıı 
[
˜˜ 
HttpPost
˜˜ 
,
˜˜ &
ValidateAntiForgeryToken
˜˜ '
]
˜˜' (
[
¯¯ 
	Authorize
¯¯ 
(
¯¯ 
Roles
¯¯ 
=
¯¯ 
$str
¯¯ #
)
¯¯# $
]
¯¯$ %
public
˘˘ 

async
˘˘ 
Task
˘˘ 
<
˘˘ 
IActionResult
˘˘ #
>
˘˘# $!
ActualizarUbicacion
˘˘% 8
(
˘˘8 9
int
˘˘9 <
pedidoId
˘˘= E
,
˘˘E F
decimal
˘˘G N
lat
˘˘O R
,
˘˘R S
decimal
˘˘T [
lng
˘˘\ _
)
˘˘_ `
{
˙˙ 
var
˚˚ 
(
˚˚ 
ok
˚˚ 
,
˚˚ 
error
˚˚ 
)
˚˚ 
=
˚˚ 
await
˚˚ 
ubicacionService
˚˚  0
.
˚˚0 1
ActualizarAsync
˚˚1 @
(
˚˚@ A
	UsuarioId
˚˚A J
,
˚˚J K
pedidoId
˚˚L T
,
˚˚T U
lat
˚˚V Y
,
˚˚Y Z
lng
˚˚[ ^
)
˚˚^ _
;
˚˚_ `
return
¸¸ 
Json
¸¸ 
(
¸¸ 
new
¸¸ 
{
¸¸ 
ok
¸¸ 
,
¸¸ 
error
¸¸ #
}
¸¸$ %
)
¸¸% &
;
¸¸& '
}
˝˝ 
[
ÇÇ 
HttpGet
ÇÇ 
]
ÇÇ 
[
ÉÉ 
	Authorize
ÉÉ 
(
ÉÉ 
Roles
ÉÉ 
=
ÉÉ 
$str
ÉÉ #
)
ÉÉ# $
]
ÉÉ$ %
public
ÑÑ 

async
ÑÑ 
Task
ÑÑ 
<
ÑÑ 
IActionResult
ÑÑ #
>
ÑÑ# $
Perfil
ÑÑ% +
(
ÑÑ+ ,
)
ÑÑ, -
{
ÖÖ 
var
ÜÜ 
perfil
ÜÜ 
=
ÜÜ 
await
ÜÜ 
perfilService
ÜÜ (
.
ÜÜ( ) 
ObtenerPerfilAsync
ÜÜ) ;
(
ÜÜ; <
	UsuarioId
ÜÜ< E
)
ÜÜE F
;
ÜÜF G
if
áá 

(
áá 
perfil
áá 
is
áá 
null
áá 
)
áá 
return
áá "
NotFound
áá# +
(
áá+ ,
)
áá, -
;
áá- .
return
àà 
View
àà 
(
àà 
perfil
àà 
)
àà 
;
àà 
}
ââ 
[
çç 
HttpPost
çç 
,
çç &
ValidateAntiForgeryToken
çç '
]
çç' (
[
éé 
	Authorize
éé 
(
éé 
Roles
éé 
=
éé 
$str
éé #
)
éé# $
]
éé$ %
public
èè 

async
èè 
Task
èè 
<
èè 
IActionResult
èè #
>
èè# $
EnviarCodigo
èè% 1
(
èè1 2
)
èè2 3
{
êê 
var
ëë 
(
ëë 
ok
ëë 
,
ëë 
error
ëë 
)
ëë 
=
ëë 
await
ëë 
perfilService
ëë  -
.
ëë- ."
SolicitarCodigoAsync
ëë. B
(
ëëB C
	UsuarioId
ëëC L
)
ëëL M
;
ëëM N
if
íí 

(
íí 
!
íí 
ok
íí 
)
íí 
{
ìì 	
TempData
îî 
[
îî 
$str
îî 
]
îî 
=
îî 
error
îî  %
;
îî% &
return
ññ 
error
ññ 
==
ññ %
PerfilRepartidorService
ññ 3
.
ññ3 4
MensajeConPedidos
ññ4 E
?
óó 
RedirectToAction
óó "
(
óó" #
$str
óó# *
,
óó* +
$str
óó, 2
)
óó2 3
:
òò 
RedirectToAction
òò "
(
òò" #
nameof
òò# )
(
òò) *
Perfil
òò* 0
)
òò0 1
)
òò1 2
;
òò2 3
}
ôô 	
TempData
õõ 
[
õõ 
$str
õõ 
]
õõ 
=
õõ 
$str
õõ Q
;
õõQ R
return
úú 
RedirectToAction
úú 
(
úú  
nameof
úú  &
(
úú& '
VerificarCodigo
úú' 6
)
úú6 7
)
úú7 8
;
úú8 9
}
ùù 
[
üü 
HttpGet
üü 
]
üü 
[
†† 
	Authorize
†† 
(
†† 
Roles
†† 
=
†† 
$str
†† #
)
††# $
]
††$ %
public
°° 

IActionResult
°° 
VerificarCodigo
°° (
(
°°( )
)
°°) *
=>
°°+ -
View
°°. 2
(
°°2 3
new
°°3 6 
VerificarCodigoDto
°°7 I
(
°°I J
)
°°J K
)
°°K L
;
°°L M
[
§§ 
HttpPost
§§ 
,
§§ &
ValidateAntiForgeryToken
§§ '
]
§§' (
[
•• 
	Authorize
•• 
(
•• 
Roles
•• 
=
•• 
$str
•• #
)
••# $
]
••$ %
public
¶¶ 

async
¶¶ 
Task
¶¶ 
<
¶¶ 
IActionResult
¶¶ #
>
¶¶# $
VerificarCodigo
¶¶% 4
(
¶¶4 5 
VerificarCodigoDto
¶¶5 G
dto
¶¶H K
)
¶¶K L
{
ßß 
if
®® 

(
®® 
!
®® 

ModelState
®® 
.
®® 
IsValid
®® 
)
®®  
return
®®! '
View
®®( ,
(
®®, -
dto
®®- 0
)
®®0 1
;
®®1 2
var
™™ 
(
™™ 
ok
™™ 
,
™™ 
error
™™ 
)
™™ 
=
™™ 
await
™™ 
perfilService
™™  -
.
™™- ."
VerificarCodigoAsync
™™. B
(
™™B C
	UsuarioId
™™C L
,
™™L M
dto
™™N Q
.
™™Q R
Codigo
™™R X
)
™™X Y
;
™™Y Z
if
´´ 

(
´´ 
!
´´ 
ok
´´ 
)
´´ 
{
¨¨ 	

ModelState
≠≠ 
.
≠≠ 
AddModelError
≠≠ $
(
≠≠$ %
$str
≠≠% '
,
≠≠' (
error
≠≠) .
!
≠≠. /
)
≠≠/ 0
;
≠≠0 1
return
ÆÆ 
View
ÆÆ 
(
ÆÆ 
dto
ÆÆ 
)
ÆÆ 
;
ÆÆ 
}
ØØ 	
return
±± 
RedirectToAction
±± 
(
±±  
nameof
±±  &
(
±±& '
Editar
±±' -
)
±±- .
)
±±. /
;
±±/ 0
}
≤≤ 
[
¥¥ 
HttpGet
¥¥ 
]
¥¥ 
[
µµ 
	Authorize
µµ 
(
µµ 
Roles
µµ 
=
µµ 
$str
µµ #
)
µµ# $
]
µµ$ %
public
∂∂ 

async
∂∂ 
Task
∂∂ 
<
∂∂ 
IActionResult
∂∂ #
>
∂∂# $
Editar
∂∂% +
(
∂∂+ ,
)
∂∂, -
{
∑∑ 
if
∏∏ 

(
∏∏ 
!
∏∏ 
await
∏∏ 
perfilService
∏∏  
.
∏∏  !$
EdicionAutorizadaAsync
∏∏! 7
(
∏∏7 8
	UsuarioId
∏∏8 A
)
∏∏A B
)
∏∏B C
{
ππ 	
TempData
∫∫ 
[
∫∫ 
$str
∫∫ 
]
∫∫ 
=
∫∫ %
PerfilRepartidorService
∫∫  7
.
∫∫7 8$
MensajeSinVerificacion
∫∫8 N
;
∫∫N O
return
ªª 
RedirectToAction
ªª #
(
ªª# $
nameof
ªª$ *
(
ªª* +
Perfil
ªª+ 1
)
ªª1 2
)
ªª2 3
;
ªª3 4
}
ºº 	
var
ææ 
dto
ææ 
=
ææ 
await
ææ 
perfilService
ææ %
.
ææ% &$
ObtenerParaEditarAsync
ææ& <
(
ææ< =
	UsuarioId
ææ= F
)
ææF G
;
ææG H
if
øø 

(
øø 
dto
øø 
is
øø 
null
øø 
)
øø 
return
øø 
NotFound
øø  (
(
øø( )
)
øø) *
;
øø* +
return
¿¿ 
View
¿¿ 
(
¿¿ 
dto
¿¿ 
)
¿¿ 
;
¿¿ 
}
¡¡ 
[
ƒƒ 
HttpPost
ƒƒ 
,
ƒƒ &
ValidateAntiForgeryToken
ƒƒ '
]
ƒƒ' (
[
≈≈ 
	Authorize
≈≈ 
(
≈≈ 
Roles
≈≈ 
=
≈≈ 
$str
≈≈ #
)
≈≈# $
]
≈≈$ %
public
∆∆ 

async
∆∆ 
Task
∆∆ 
<
∆∆ 
IActionResult
∆∆ #
>
∆∆# $
Editar
∆∆% +
(
∆∆+ ,!
EditarRepartidorDto
∆∆, ?
dto
∆∆@ C
)
∆∆C D
{
«« 
if
»» 

(
»» 
!
»» 

ModelState
»» 
.
»» 
IsValid
»» 
)
»»  
return
»»! '
View
»»( ,
(
»», -
dto
»»- 0
)
»»0 1
;
»»1 2
var
   
(
   
ok
   
,
   
error
   
)
   
=
   
await
   
perfilService
    -
.
  - .
EditarAsync
  . 9
(
  9 :
	UsuarioId
  : C
,
  C D
dto
  E H
)
  H I
;
  I J
if
ÀÀ 

(
ÀÀ 
!
ÀÀ 
ok
ÀÀ 
)
ÀÀ 
{
ÃÃ 	
if
ÕÕ 
(
ÕÕ 
error
ÕÕ 
==
ÕÕ %
PerfilRepartidorService
ÕÕ 0
.
ÕÕ0 1$
MensajeSinVerificacion
ÕÕ1 G
||
ÕÕH J
error
ÕÕK P
==
ÕÕQ S%
PerfilRepartidorService
ÕÕT k
.
ÕÕk l
MensajeSuspendido
ÕÕl }
)
ÕÕ} ~
{
ŒŒ 
TempData
œœ 
[
œœ 
$str
œœ  
]
œœ  !
=
œœ" #
error
œœ$ )
;
œœ) *
return
–– 
RedirectToAction
–– '
(
––' (
nameof
––( .
(
––. /
Perfil
––/ 5
)
––5 6
)
––6 7
;
––7 8
}
—— 
if
““ 
(
““ 
error
““ 
==
““ %
PerfilRepartidorService
““ 0
.
““0 1
MensajeConPedidos
““1 B
)
““B C
{
”” 
TempData
‘‘ 
[
‘‘ 
$str
‘‘  
]
‘‘  !
=
‘‘" #
error
‘‘$ )
;
‘‘) *
return
’’ 
RedirectToAction
’’ '
(
’’' (
$str
’’( /
,
’’/ 0
$str
’’1 7
)
’’7 8
;
’’8 9
}
÷÷ 

ModelState
ÿÿ 
.
ÿÿ 
AddModelError
ÿÿ $
(
ÿÿ$ %
$str
ÿÿ% '
,
ÿÿ' (
error
ÿÿ) .
!
ÿÿ. /
)
ÿÿ/ 0
;
ÿÿ0 1
return
ŸŸ 
View
ŸŸ 
(
ŸŸ 
dto
ŸŸ 
)
ŸŸ 
;
ŸŸ 
}
⁄⁄ 	
TempData
‹‹ 
[
‹‹ 
$str
‹‹ 
]
‹‹ 
=
‹‹ 
$str
‹‹ K
;
‹‹K L
return
›› 
RedirectToAction
›› 
(
››  
nameof
››  &
(
››& '
Perfil
››' -
)
››- .
)
››. /
;
››/ 0
}
ﬁﬁ 
[
‚‚ 
HttpPost
‚‚ 
,
‚‚ &
ValidateAntiForgeryToken
‚‚ '
]
‚‚' (
[
„„ 
	Authorize
„„ 
(
„„ 
Roles
„„ 
=
„„ 
$str
„„ #
)
„„# $
]
„„$ %
public
‰‰ 

async
‰‰ 
Task
‰‰ 
<
‰‰ 
IActionResult
‰‰ #
>
‰‰# $"
VerificarEliminacion
‰‰% 9
(
‰‰9 :
)
‰‰: ;
{
ÂÂ 
var
ÊÊ 
(
ÊÊ 
ok
ÊÊ 
,
ÊÊ 
error
ÊÊ 
)
ÊÊ 
=
ÊÊ 
await
ÊÊ 
perfilService
ÊÊ  -
.
ÊÊ- .+
ValidarEliminacionPropiaAsync
ÊÊ. K
(
ÊÊK L
	UsuarioId
ÊÊL U
)
ÊÊU V
;
ÊÊV W
return
ÁÁ 
Json
ÁÁ 
(
ÁÁ 
new
ÁÁ 
{
ÁÁ 
ok
ÁÁ 
,
ÁÁ 
error
ÁÁ #
}
ÁÁ$ %
)
ÁÁ% &
;
ÁÁ& '
}
ËË 
[
ÎÎ 
HttpPost
ÎÎ 
,
ÎÎ &
ValidateAntiForgeryToken
ÎÎ '
]
ÎÎ' (
[
ÏÏ 
	Authorize
ÏÏ 
(
ÏÏ 
Roles
ÏÏ 
=
ÏÏ 
$str
ÏÏ #
)
ÏÏ# $
]
ÏÏ$ %
public
ÌÌ 

async
ÌÌ 
Task
ÌÌ 
<
ÌÌ 
IActionResult
ÌÌ #
>
ÌÌ# $
EliminarCuenta
ÌÌ% 3
(
ÌÌ3 4
EliminarCuentaDto
ÌÌ4 E
dto
ÌÌF I
)
ÌÌI J
{
ÓÓ 
if
ÔÔ 

(
ÔÔ 
!
ÔÔ 

ModelState
ÔÔ 
.
ÔÔ 
IsValid
ÔÔ 
)
ÔÔ  
{
 	
TempData
ÒÒ 
[
ÒÒ 
$str
ÒÒ 
]
ÒÒ 
=
ÒÒ 
$str
ÒÒ  7
;
ÒÒ7 8
return
ÚÚ 
RedirectToAction
ÚÚ #
(
ÚÚ# $
nameof
ÚÚ$ *
(
ÚÚ* +
Perfil
ÚÚ+ 1
)
ÚÚ1 2
)
ÚÚ2 3
;
ÚÚ3 4
}
ÛÛ 	
var
ıı 
(
ıı 
ok
ıı 
,
ıı 
error
ıı 
)
ıı 
=
ıı 
await
ıı 
perfilService
ıı  -
.
ıı- .'
EliminarCuentaPropiaAsync
ıı. G
(
ııG H
	UsuarioId
ııH Q
,
ııQ R
dto
ııS V
.
ııV W
Password
ııW _
)
ıı_ `
;
ıı` a
if
ˆˆ 

(
ˆˆ 
!
ˆˆ 
ok
ˆˆ 
)
ˆˆ 
{
˜˜ 	
TempData
¯¯ 
[
¯¯ 
$str
¯¯ 
]
¯¯ 
=
¯¯ 
error
¯¯  %
;
¯¯% &
return
˘˘ 
RedirectToAction
˘˘ #
(
˘˘# $
nameof
˘˘$ *
(
˘˘* +
Perfil
˘˘+ 1
)
˘˘1 2
)
˘˘2 3
;
˘˘3 4
}
˙˙ 	
await
¸¸ 
HttpContext
¸¸ 
.
¸¸ 
SignOutAsync
¸¸ &
(
¸¸& '*
CookieAuthenticationDefaults
¸¸' C
.
¸¸C D"
AuthenticationScheme
¸¸D X
)
¸¸X Y
;
¸¸Y Z
TempData
˝˝ 
[
˝˝ 
$str
˝˝ 
]
˝˝ 
=
˝˝ 
$str
˝˝ ;
;
˝˝; <
return
˛˛ 
RedirectToAction
˛˛ 
(
˛˛  
$str
˛˛  '
,
˛˛' (
$str
˛˛) /
)
˛˛/ 0
;
˛˛0 1
}
ˇˇ 
[
ÇÇ 
HttpPost
ÇÇ 
,
ÇÇ &
ValidateAntiForgeryToken
ÇÇ '
]
ÇÇ' (
[
ÉÉ 
	Authorize
ÉÉ 
(
ÉÉ 
Roles
ÉÉ 
=
ÉÉ 
$str
ÉÉ  
)
ÉÉ  !
]
ÉÉ! "
public
ÑÑ 

async
ÑÑ 
Task
ÑÑ 
<
ÑÑ 
IActionResult
ÑÑ #
>
ÑÑ# $,
VerificarEliminacionRepartidor
ÑÑ% C
(
ÑÑC D
int
ÑÑD G
id
ÑÑH J
)
ÑÑJ K
{
ÖÖ 
var
ÜÜ 
(
ÜÜ 
ok
ÜÜ 
,
ÜÜ 
error
ÜÜ 
)
ÜÜ 
=
ÜÜ 
await
ÜÜ 
perfilService
ÜÜ  -
.
ÜÜ- ./
!ValidarEliminacionPorNegocioAsync
ÜÜ. O
(
ÜÜO P
	UsuarioId
ÜÜP Y
,
ÜÜY Z
id
ÜÜ[ ]
)
ÜÜ] ^
;
ÜÜ^ _
return
áá 
Json
áá 
(
áá 
new
áá 
{
áá 
ok
áá 
,
áá 
error
áá #
}
áá$ %
)
áá% &
;
áá& '
}
àà 
[
ää 
HttpPost
ää 
,
ää &
ValidateAntiForgeryToken
ää '
]
ää' (
[
ãã 
	Authorize
ãã 
(
ãã 
Roles
ãã 
=
ãã 
$str
ãã  
)
ãã  !
]
ãã! "
public
åå 

async
åå 
Task
åå 
<
åå 
IActionResult
åå #
>
åå# $ 
EliminarRepartidor
åå% 7
(
åå7 8
int
åå8 ;
id
åå< >
,
åå> ?
EliminarCuentaDto
åå@ Q
dto
ååR U
)
ååU V
{
çç 
if
éé 

(
éé 
!
éé 

ModelState
éé 
.
éé 
IsValid
éé 
)
éé  
{
èè 	
TempData
êê 
[
êê 
$str
êê 
]
êê 
=
êê 
$str
êê  U
;
êêU V
return
ëë 
RedirectToAction
ëë #
(
ëë# $
nameof
ëë$ *
(
ëë* +
Index
ëë+ 0
)
ëë0 1
)
ëë1 2
;
ëë2 3
}
íí 	
var
îî 
(
îî 
ok
îî 
,
îî 
error
îî 
,
îî 
nombre
îî 
)
îî 
=
îî  !
await
îî" '
perfilService
îî( 5
.
îî5 6%
EliminarPorNegocioAsync
îî6 M
(
îîM N
	UsuarioId
îîN W
,
îîW X
id
îîY [
,
îî[ \
dto
îî] `
.
îî` a
Password
îîa i
)
îîi j
;
îîj k
TempData
ïï 
[
ïï 
ok
ïï 
?
ïï 
$str
ïï 
:
ïï  !
$str
ïï" )
]
ïï) *
=
ïï+ ,
ok
ïï- /
?
ïï0 1
$"
ïï2 4
$str
ïï4 B
{
ïïB C
nombre
ïïC I
}
ïïI J
$str
ïïJ X
"
ïïX Y
:
ïïZ [
error
ïï\ a
;
ïïa b
return
ññ 
RedirectToAction
ññ 
(
ññ  
nameof
ññ  &
(
ññ& '
Index
ññ' ,
)
ññ, -
)
ññ- .
;
ññ. /
}
óó 
}òò üó
[C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Controllers\PedidoController.cs
	namespace 	
Gtrack
 
; 
[ 
	Authorize 

(
 
Roles 
= 
$str 
) 
] 
public		 
class		 
PedidoController		 
(		 
IPedidoService

 
pedidos

 
,

 
INegocioRepository 
negocios 
,  
AppDbContext 
context 
, 
IUbicacionService 
ubicaciones !
)! "
:# $

Controller% /
{ 
private 
int 
	UsuarioId 
=> 
int  
.  !
Parse! &
(& '
User' +
.+ ,
FindFirstValue, :
(: ;

ClaimTypes; E
.E F
NameIdentifierF T
)T U
!U V
)V W
;W X
[ 
HttpGet 
] 
public 

IActionResult 
	Registrar "
(" #
)# $
=>% '
View( ,
(, -
new- 0
RegistrarPedidoDto1 C
(C D
)D E
)E F
;F G
[ 
HttpPost 
, $
ValidateAntiForgeryToken '
]' (
public 

async 
Task 
< 
IActionResult #
># $
	Registrar% .
(. /
RegistrarPedidoDto/ A
dtoB E
)E F
{ 
if 

( 
! 

ModelState 
. 
IsValid 
)  
return! '
View( ,
(, -
dto- 0
)0 1
;1 2
var 
( 
ok 
, 
error 
, 
codigo 
) 
=  !
await" '
pedidos( /
./ 0
RegistrarAsync0 >
(> ?
	UsuarioId? H
,H I
dtoJ M
)M N
;N O
if 

( 
! 
ok 
) 
{ 	

ModelState 
. 
AddModelError $
($ %
$str% '
,' (
error) .
!. /
)/ 0
;0 1
return 
View 
( 
dto 
) 
; 
} 	
TempData   
[   
$str   
]   
=   
$"    
$str    @
{  @ A
codigo  A G
}  G H
"  H I
;  I J
return!! 
RedirectToAction!! 
(!!  
nameof!!  &
(!!& '
Activos!!' .
)!!. /
)!!/ 0
;!!0 1
}"" 
[$$ 
HttpGet$$ 
]$$ 
public%% 

async%% 
Task%% 
<%% 
IActionResult%% #
>%%# $
BuscarCliente%%% 2
(%%2 3
string%%3 9
telefono%%: B
)%%B C
{&& 
var'' 
cliente'' 
='' 
await'' 
pedidos'' #
.''# $'
BuscarClienteFrecuenteAsync''$ ?
(''? @
	UsuarioId''@ I
,''I J
telefono''K S
)''S T
;''T U
return(( 
Json(( 
((( 
cliente(( 
)(( 
;(( 
})) 
[++ 
HttpGet++ 
]++ 
public,, 

async,, 
Task,, 
<,, 
IActionResult,, #
>,,# $
Activos,,% ,
(,,, -
),,- .
{-- 
var.. 
negocio.. 
=.. 
await.. 
negocios.. $
...$ %$
ObtenerPorUsuarioIdAsync..% =
(..= >
	UsuarioId..> G
)..G H
;..H I
var// 
pedidosActivos// 
=// 
await// "
pedidos//# *
.//* +&
ObtenerPedidosActivosAsync//+ E
(//E F
	UsuarioId//F O
)//O P
;//P Q
List11 
<11 

Repartidor11 
>11 
listaRepartidores11 *
=11+ ,
[11- .
]11. /
;11/ 0
if22 

(22 
negocio22 
!=22 
null22 
)22 
{33 	
listaRepartidores44 
=44 
await44  %
context44& -
.44- .
Set44. 1
<441 2

Repartidor442 <
>44< =
(44= >
)44> ?
.55 
Include55 
(55 
r55 
=>55 
r55 
.55  
Usuario55  '
)55' (
.66 
Where66 
(66 
r66 
=>66 
r66 
.66 
	NegocioId66 '
==66( *
negocio66+ 2
.662 3
Id663 5
&&666 8
r669 :
.66: ;
Usuario66; B
!66B C
.66C D
Estado66D J
==66K M
EstadoCuenta66N Z
.66Z [
Activo66[ a
)66a b
.77 
ToListAsync77 
(77 
)77 
;77 
}88 	
ViewBag:: 
.:: 
Repartidores:: 
=:: 
listaRepartidores:: 0
;::0 1
return;; 
View;; 
(;; 
pedidosActivos;; "
);;" #
;;;# $
}<< 
[>> 
HttpGet>> 
]>> 
public?? 

async?? 
Task?? 
<?? 
IActionResult?? #
>??# $
	Historial??% .
(??. /
)??/ 0
{@@ 
varAA 
historialPedidosAA 
=AA 
awaitAA $
pedidosAA% ,
.AA, -(
ObtenerHistorialPedidosAsyncAA- I
(AAI J
	UsuarioIdAAJ S
)AAS T
;AAT U
returnBB 
ViewBB 
(BB 
historialPedidosBB $
)BB$ %
;BB% &
}CC 
[EE 
HttpPostEE 
,EE $
ValidateAntiForgeryTokenEE '
]EE' (
publicFF 

asyncFF 
TaskFF 
<FF 
IActionResultFF #
>FF# $
ActualizarEstadoFF% 5
(FF5 6
intFF6 9
idFF: <
,FF< =
intFF> A
nuevoEstadoIdFFB O
,FFO P
intFFQ T
?FFT U
repartidorIdFFV b
)FFb c
{GG 
varHH 
(HH 
okActualizacionHH 
,HH 
errorMsgHH &
)HH& '
=HH( )
awaitHH* /
pedidosHH0 7
.HH7 8!
ActualizarEstadoAsyncHH8 M
(HHM N
	UsuarioIdHHN W
,HHW X
idHHY [
,HH[ \
nuevoEstadoIdHH] j
,HHj k
repartidorIdHHl x
)HHx y
;HHy z
ifJJ 

(JJ 
!JJ 
okActualizacionJJ 
)JJ 
{KK 	
TempDataLL 
[LL 
$strLL 
]LL 
=LL 
errorMsgLL  (
??LL) +
$strLL, R
;LLR S
}MM 	
elseNN 
{OO 	
TempDataPP 
[PP 
$strPP 
]PP 
=PP  !
$strPP" Z
;PPZ [
}QQ 	
returnSS 
RedirectToActionSS 
(SS  
nameofSS  &
(SS& '
ActivosSS' .
)SS. /
)SS/ 0
;SS0 1
}TT 
[ZZ 
AllowAnonymousZZ 
]ZZ 
[[[ 
HttpGet[[ 
][[ 
public\\ 

IActionResult\\ 
	Consultar\\ "
(\\" #
)\\# $
{]] 
return^^ 
View^^ 
(^^ 
)^^ 
;^^ 
}__ 
[aa 
AllowAnonymousaa 
]aa 
[bb 
HttpPostbb 
,bb $
ValidateAntiForgeryTokenbb '
]bb' (
publiccc 

Taskcc 
<cc 
IActionResultcc 
>cc 
	Consultarcc (
(cc( )
stringcc) /
codigocc0 6
)cc6 7
=>cc8 :
MostrarPedidoAsynccc; M
(ccM N
codigoccN T
)ccT U
;ccU V
[gg 
AllowAnonymousgg 
]gg 
[hh 
HttpPosthh 
,hh $
ValidateAntiForgeryTokenhh '
]hh' (
publicii 

asyncii 
Taskii 
<ii 
IActionResultii #
>ii# $
Cancelarii% -
(ii- .
stringii. 4
codigoii5 ;
,ii; <
stringii= C
?iiC D
motivoiiE K
)iiK L
{jj 
varkk 
(kk 
okkk 
,kk 
errorkk 
)kk 
=kk 
awaitkk 
pedidoskk  '
.kk' (#
CancelarPorClienteAsynckk( ?
(kk? @
codigokk@ F
,kkF G
motivokkH N
)kkN O
;kkO P
ifmm 

(mm 
!mm 
okmm 
&&mm 
errormm 
==mm 
PedidoServicemm )
.mm) *%
MensajeCodigoNoEncontradomm* C
)mmC D
{nn 	

ModelStateoo 
.oo 
AddModelErroroo $
(oo$ %
$stroo% '
,oo' (
erroroo) .
)oo. /
;oo/ 0
returnpp 
Viewpp 
(pp 
nameofpp 
(pp 
	Consultarpp (
)pp( )
)pp) *
;pp* +
}qq 	
ifss 

(ss 
okss 
)ss 
ViewBagtt 
.tt 
MensajeCancelaciontt &
=tt' (
$strtt) H
;ttH I
elseuu 

ModelStatevv 
.vv 
AddModelErrorvv $
(vv$ %
$strvv% '
,vv' (
errorvv) .
!vv. /
)vv/ 0
;vv0 1
returnyy 
awaityy 
MostrarPedidoAsyncyy '
(yy' (
codigoyy( .
)yy. /
;yy/ 0
}zz 
private}} 
async}} 
Task}} 
<}} 
IActionResult}} $
>}}$ %
MostrarPedidoAsync}}& 8
(}}8 9
string}}9 ?
?}}? @
codigo}}A G
)}}G H
{~~ 
const 
string 
CodigoNoEncontrado '
=( )
$str* _
;_ `
var
ÇÇ 
codigoLimpio
ÇÇ 
=
ÇÇ 
codigo
ÇÇ !
?
ÇÇ! "
.
ÇÇ" #
Trim
ÇÇ# '
(
ÇÇ' (
)
ÇÇ( )
.
ÇÇ) *
ToUpperInvariant
ÇÇ* :
(
ÇÇ: ;
)
ÇÇ; <
??
ÇÇ= ?
$str
ÇÇ@ B
;
ÇÇB C
if
ÉÉ 

(
ÉÉ 
!
ÉÉ 
Patrones
ÉÉ 
.
ÉÉ 
CodigoPedido
ÉÉ "
(
ÉÉ" #
)
ÉÉ# $
.
ÉÉ$ %
IsMatch
ÉÉ% ,
(
ÉÉ, -
codigoLimpio
ÉÉ- 9
)
ÉÉ9 :
)
ÉÉ: ;
{
ÑÑ 	

ModelState
ÖÖ 
.
ÖÖ 
AddModelError
ÖÖ $
(
ÖÖ$ %
$str
ÖÖ% '
,
ÖÖ' ( 
CodigoNoEncontrado
ÖÖ) ;
)
ÖÖ; <
;
ÖÖ< =
return
ÜÜ 
View
ÜÜ 
(
ÜÜ 
nameof
ÜÜ 
(
ÜÜ 
	Consultar
ÜÜ (
)
ÜÜ( )
)
ÜÜ) *
;
ÜÜ* +
}
áá 	
try
ââ 
{
ää 	
var
ãã 
pedido
ãã 
=
ãã 
await
ãã 
context
ãã &
.
ãã& '
Pedidos
ãã' .
.
åå 
AsNoTracking
åå 
(
åå 
)
åå 
.
çç 
Include
çç 
(
çç 
p
çç 
=>
çç 
p
çç 
.
çç  
Items
çç  %
)
çç% &
.
éé 
Include
éé 
(
éé 
p
éé 
=>
éé 
p
éé 
.
éé  
Negocio
éé  '
)
éé' (
.
éé( )
ThenInclude
éé) 4
(
éé4 5
n
éé5 6
=>
éé7 9
n
éé: ;
!
éé; <
.
éé< =
Usuario
éé= D
)
ééD E
.
èè 
Include
èè 
(
èè 
p
èè 
=>
èè 
p
èè 
.
èè  

Repartidor
èè  *
)
èè* +
.
êê !
FirstOrDefaultAsync
êê $
(
êê$ %
p
êê% &
=>
êê' )
p
êê* +
.
êê+ ,
Codigo
êê, 2
==
êê3 5
codigoLimpio
êê6 B
)
êêB C
;
êêC D
if
íí 
(
íí 
pedido
íí 
==
íí 
null
íí 
)
íí 
{
ìì 

ModelState
îî 
.
îî 
AddModelError
îî (
(
îî( )
$str
îî) +
,
îî+ , 
CodigoNoEncontrado
îî- ?
)
îî? @
;
îî@ A
return
ïï 
View
ïï 
(
ïï 
nameof
ïï "
(
ïï" #
	Consultar
ïï# ,
)
ïï, -
)
ïï- .
;
ïï. /
}
ññ 
ViewBag
ôô 
.
ôô 
	Historial
ôô 
=
ôô 
await
ôô  %
context
ôô& -
.
ôô- .
Database
ôô. 6
.
öö 
SqlQuery
öö 
<
öö !
HistorialEstadoItem
öö -
>
öö- .
(
öö. /
$"
öö/ 1
$ströö1 Ñ
{ööÑ Ö
pedidoööÖ ã
.ööã å
Idööå é
}ööé è
$strööè §
"öö§ •
)öö• ¶
.
õõ 
ToListAsync
õõ 
(
õõ 
)
õõ 
;
õõ 
if
üü 
(
üü 
pedido
üü 
.
üü 
EstadoPedidoId
üü %
==
üü& (
(
üü) *
int
üü* -
)
üü- .
EstadoPedido
üü. :
.
üü: ;
	Cancelado
üü; D
)
üüD E
{
†† 
try
°° 
{
¢¢ 
ViewBag
££ 
.
££ 
Cancelacion
££ '
=
££( )
await
££* /
context
££0 7
.
££7 8$
SolicitudesCancelacion
££8 N
.
§§ 
AsNoTracking
§§ %
(
§§% &
)
§§& '
.
•• !
FirstOrDefaultAsync
•• ,
(
••, -
s
••- .
=>
••/ 1
s
••2 3
.
••3 4
PedidoId
••4 <
==
••= ?
pedido
••@ F
.
••F G
Id
••G I
)
••I J
;
••J K
}
¶¶ 
catch
ßß 
(
ßß 
	Exception
ßß  
)
ßß  !
{
®® 
ViewBag
©© 
.
©© 
Cancelacion
©© '
=
©©( )
null
©©* .
;
©©. /
}
™™ 
}
´´ 
return
≠≠ 
View
≠≠ 
(
≠≠ 
nameof
≠≠ 
(
≠≠ 
	Consultar
≠≠ (
)
≠≠( )
,
≠≠) *
pedido
≠≠+ 1
)
≠≠1 2
;
≠≠2 3
}
ÆÆ 	
catch
ØØ 
(
ØØ 
	Exception
ØØ 
)
ØØ 
{
∞∞ 	

ModelState
≤≤ 
.
≤≤ 
AddModelError
≤≤ $
(
≤≤$ %
$str
≤≤% '
,
≤≤' (
$str
≤≤) c
)
≤≤c d
;
≤≤d e
return
≥≥ 
View
≥≥ 
(
≥≥ 
nameof
≥≥ 
(
≥≥ 
	Consultar
≥≥ (
)
≥≥( )
)
≥≥) *
;
≥≥* +
}
¥¥ 	
}
µµ 
[
∑∑ 
AllowAnonymous
∑∑ 
]
∑∑ 
[
∏∏ 
HttpGet
∏∏ 
]
∏∏ 
public
ππ 

async
ππ 
Task
ππ 
<
ππ 
IActionResult
ππ #
>
ππ# $
	Ubicacion
ππ% .
(
ππ. /
string
ππ/ 5
codigo
ππ6 <
)
ππ< =
{
∫∫ 
if
ªª 

(
ªª 
string
ªª 
.
ªª  
IsNullOrWhiteSpace
ªª %
(
ªª% &
codigo
ªª& ,
)
ªª, -
||
ªª. 0
!
ªª1 2
Patrones
ªª2 :
.
ªª: ;1
#CodigoPedidoSinDistinguirMayusculas
ªª; ^
(
ªª^ _
)
ªª_ `
.
ªª` a
IsMatch
ªªa h
(
ªªh i
codigo
ªªi o
.
ªªo p
Trim
ªªp t
(
ªªt u
)
ªªu v
)
ªªv w
)
ªªw x
{
ºº 	
return
ΩΩ 
Json
ΩΩ 
(
ΩΩ 
new
ΩΩ 
{
ΩΩ 

disponible
ΩΩ (
=
ΩΩ) *
false
ΩΩ+ 0
}
ΩΩ1 2
)
ΩΩ2 3
;
ΩΩ3 4
}
ææ 	
var
¿¿ 
(
¿¿ 
ok
¿¿ 
,
¿¿ 
_
¿¿ 
,
¿¿ 
lat
¿¿ 
,
¿¿ 
lng
¿¿ 
,
¿¿ 
fechaUtc
¿¿ &
,
¿¿& '
estado
¿¿( .
)
¿¿. /
=
¿¿0 1
await
¿¿2 7
ubicaciones
¿¿8 C
.
¿¿C D#
ObtenerPorCodigoAsync
¿¿D Y
(
¿¿Y Z
codigo
¿¿Z `
.
¿¿` a
Trim
¿¿a e
(
¿¿e f
)
¿¿f g
.
¿¿g h
ToUpperInvariant
¿¿h x
(
¿¿x y
)
¿¿y z
)
¿¿z {
;
¿¿{ |
if
¬¬ 

(
¬¬ 
ok
¬¬ 
&&
¬¬ 
lat
¬¬ 
.
¬¬ 
HasValue
¬¬ 
&&
¬¬ !
lng
¬¬" %
.
¬¬% &
HasValue
¬¬& .
&&
¬¬/ 1
fechaUtc
¬¬2 :
.
¬¬: ;
HasValue
¬¬; C
)
¬¬C D
{
√√ 	
return
ƒƒ 
Json
ƒƒ 
(
ƒƒ 
new
ƒƒ 
{
≈≈ 

disponible
∆∆ 
=
∆∆ 
true
∆∆ !
,
∆∆! "
lat
«« 
=
«« 
lat
«« 
.
«« 
Value
«« 
,
««  
lng
»» 
=
»» 
lng
»» 
.
»» 
Value
»» 
,
»»  
fechaUtc
…… 
=
…… 
fechaUtc
…… #
.
……# $
Value
……$ )
.
……) *
ToString
……* 2
(
……2 3
$str
……3 K
)
……K L
,
……L M
estado
   
}
ÀÀ 
)
ÀÀ 
;
ÀÀ 
}
ÃÃ 	
return
ŒŒ 
Json
ŒŒ 
(
ŒŒ 
new
ŒŒ 
{
œœ 	

disponible
–– 
=
–– 
false
–– 
,
–– 
estado
—— 
}
““ 	
)
““	 

;
““
 
}
”” 
}‘‘ 
public◊◊ 
class
◊◊ !
HistorialEstadoItem
◊◊  
{ÿÿ 
public
ŸŸ 

int
ŸŸ 
EstadoPedidoId
ŸŸ 
{
ŸŸ 
get
ŸŸ  #
;
ŸŸ# $
set
ŸŸ% (
;
ŸŸ( )
}
ŸŸ* +
public
⁄⁄ 

DateTime
⁄⁄ 
FechaCambio
⁄⁄ 
{
⁄⁄  !
get
⁄⁄" %
;
⁄⁄% &
set
⁄⁄' *
;
⁄⁄* +
}
⁄⁄, -
}€€ çÄ
\C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Controllers\NegocioController.cs
	namespace 	
Gtrack
 
; 
[		 
	Authorize		 

(		
 
Roles		 
=		 
$str		 
)		 
]		 
public

 
class

 
NegocioController

 
(

 
INegocioService

 .
negocios

/ 7
)

7 8
:

9 :

Controller

; E
{ 
private 
int 
	UsuarioId 
=> 
int  
.  !
Parse! &
(& '
User' +
.+ ,
FindFirstValue, :
(: ;

ClaimTypes; E
.E F
NameIdentifierF T
)T U
!U V
)V W
;W X
[ 
AllowAnonymous 
, 
HttpGet 
] 
public 

IActionResult 
	Registrar "
(" #
)# $
{ 
if 

( 
User 
. 
Identity 
? 
. 
IsAuthenticated *
==+ -
true. 2
)2 3
return4 :
RedirectToAction; K
(K L
$strL S
,S T
$strU [
)[ \
;\ ]
return 
View 
( 
new 
RegistroNegocioDto *
(* +
)+ ,
), -
;- .
} 
[ 
AllowAnonymous 
, 
HttpPost 
, $
ValidateAntiForgeryToken 7
]7 8
public 

async 
Task 
< 
IActionResult #
># $
	Registrar% .
(. /
RegistroNegocioDto/ A
dtoB E
)E F
{ 
if 

( 
User 
. 
Identity 
? 
. 
IsAuthenticated *
==+ -
true. 2
)2 3
return4 :
RedirectToAction; K
(K L
$strL S
,S T
$strU [
)[ \
;\ ]
if 

( 
! 

ModelState 
. 
IsValid 
)  
{ 	
if 
( 

ModelState 
. 
Values !
.! "

SelectMany" ,
(, -
v- .
=>/ 1
v2 3
.3 4
Errors4 :
): ;
.; <
Any< ?
(? @
e@ A
=>B D
eE F
.F G
ErrorMessageG S
==T V
RegistroNegocioDtoW i
.i j
Obligatorioj u
)u v
)v w

ModelState 
. 
AddModelError (
(( )
$str) +
,+ ,
$str- P
)P Q
;Q R
return   
View   
(   
dto   
)   
;   
}!! 	
var## 
urlRevision## 
=## 
Url## 
.## 
Action## $
(##$ %
$str##% /
,##/ 0
$str##1 8
,##8 9
null##: >
,##> ?
Request##@ G
.##G H
Scheme##H N
)##N O
!##O P
;##P Q
var$$ 
($$ 
ok$$ 
,$$ 
error$$ 
,$$ 
correoEnviado$$ %
)$$% &
=$$' (
await$$) .
negocios$$/ 7
.$$7 8
RegistrarAsync$$8 F
($$F G
dto$$G J
,$$J K
urlRevision$$L W
)$$W X
;$$X Y
if%% 

(%% 
!%% 
ok%% 
)%% 
{&& 	

ModelState'' 
.'' 
AddModelError'' $
(''$ %
$str''% '
,''' (
error'') .
!''. /
)''/ 0
;''0 1
return(( 
View(( 
((( 
dto(( 
)(( 
;(( 
})) 	
var++ 
mensaje++ 
=++ 
$str++ V
;++V W
if,, 

(,, 
!,, 
correoEnviado,, 
),, 
mensaje-- 
+=-- 
$str-- c
;--c d
TempData// 
[// 
$str// 
]// 
=// 
mensaje// %
;//% &
return00 
RedirectToAction00 
(00  
$str00  '
,00' (
$str00) 2
)002 3
;003 4
}11 
[44 
HttpGet44 
]44 
public55 

async55 
Task55 
<55 
IActionResult55 #
>55# $
Perfil55% +
(55+ ,
)55, -
{66 
var77 
perfil77 
=77 
await77 
negocios77 #
.77# $
ObtenerPerfilAsync77$ 6
(776 7
	UsuarioId777 @
)77@ A
;77A B
if88 

(88 
perfil88 
is88 
null88 
)88 
return88 "
NotFound88# +
(88+ ,
)88, -
;88- .
return99 
View99 
(99 
perfil99 
)99 
;99 
}:: 
[== 
HttpPost== 
,== $
ValidateAntiForgeryToken== '
]==' (
public>> 

async>> 
Task>> 
<>> 
IActionResult>> #
>>># $
EnviarCodigo>>% 1
(>>1 2
)>>2 3
{?? 
var@@ 
(@@ 
ok@@ 
,@@ 
error@@ 
)@@ 
=@@ 
await@@ 
negocios@@  (
.@@( ) 
SolicitarCodigoAsync@@) =
(@@= >
	UsuarioId@@> G
)@@G H
;@@H I
ifAA 

(AA 
!AA 
okAA 
)AA 
{BB 	
TempDataCC 
[CC 
$strCC 
]CC 
=CC 
errorCC  %
;CC% &
returnDD 
RedirectToActionDD #
(DD# $
nameofDD$ *
(DD* +
PerfilDD+ 1
)DD1 2
)DD2 3
;DD3 4
}EE 	
TempDataGG 
[GG 
$strGG 
]GG 
=GG 
$strGG Q
;GGQ R
returnHH 
RedirectToActionHH 
(HH  
nameofHH  &
(HH& '
VerificarCodigoHH' 6
)HH6 7
)HH7 8
;HH8 9
}II 
[KK 
HttpGetKK 
]KK 
publicLL 

IActionResultLL 
VerificarCodigoLL (
(LL( )
)LL) *
=>LL+ -
ViewLL. 2
(LL2 3
newLL3 6
VerificarCodigoDtoLL7 I
(LLI J
)LLJ K
)LLK L
;LLL M
[NN 
HttpPostNN 
,NN $
ValidateAntiForgeryTokenNN '
]NN' (
publicOO 

asyncOO 
TaskOO 
<OO 
IActionResultOO #
>OO# $
VerificarCodigoOO% 4
(OO4 5
VerificarCodigoDtoOO5 G
dtoOOH K
)OOK L
{PP 
ifQQ 

(QQ 
!QQ 

ModelStateQQ 
.QQ 
IsValidQQ 
)QQ  
returnQQ! '
ViewQQ( ,
(QQ, -
dtoQQ- 0
)QQ0 1
;QQ1 2
varSS 
(SS 
okSS 
,SS 
errorSS 
)SS 
=SS 
awaitSS 
negociosSS  (
.SS( ) 
VerificarCodigoAsyncSS) =
(SS= >
	UsuarioIdSS> G
,SSG H
dtoSSI L
.SSL M
CodigoSSM S
)SSS T
;SST U
ifTT 

(TT 
!TT 
okTT 
)TT 
{UU 	

ModelStateVV 
.VV 
AddModelErrorVV $
(VV$ %
$strVV% '
,VV' (
errorVV) .
!VV. /
)VV/ 0
;VV0 1
returnWW 
ViewWW 
(WW 
dtoWW 
)WW 
;WW 
}XX 	
returnZZ 
RedirectToActionZZ 
(ZZ  
nameofZZ  &
(ZZ& '
EditarZZ' -
)ZZ- .
)ZZ. /
;ZZ/ 0
}[[ 
[]] 
HttpGet]] 
]]] 
public^^ 

async^^ 
Task^^ 
<^^ 
IActionResult^^ #
>^^# $
Editar^^% +
(^^+ ,
)^^, -
{__ 
if`` 

(`` 
!`` 
await`` 
negocios`` 
.`` "
EdicionAutorizadaAsync`` 2
(``2 3
	UsuarioId``3 <
)``< =
)``= >
{aa 	
TempDatabb 
[bb 
$strbb 
]bb 
=bb 
NegocioServicebb  .
.bb. /"
MensajeSinVerificacionbb/ E
;bbE F
returncc 
RedirectToActioncc #
(cc# $
nameofcc$ *
(cc* +
Perfilcc+ 1
)cc1 2
)cc2 3
;cc3 4
}dd 	
varff 
dtoff 
=ff 
awaitff 
negociosff  
.ff  !"
ObtenerParaEditarAsyncff! 7
(ff7 8
	UsuarioIdff8 A
)ffA B
;ffB C
ifgg 

(gg 
dtogg 
isgg 
nullgg 
)gg 
returngg 
NotFoundgg  (
(gg( )
)gg) *
;gg* +
returnhh 
Viewhh 
(hh 
dtohh 
)hh 
;hh 
}ii 
[kk 
HttpPostkk 
,kk $
ValidateAntiForgeryTokenkk '
]kk' (
publicll 

asyncll 
Taskll 
<ll 
IActionResultll #
>ll# $
Editarll% +
(ll+ ,
EditarNegocioDtoll, <
dtoll= @
)ll@ A
{mm 
ifnn 

(nn 
!nn 

ModelStatenn 
.nn 
IsValidnn 
)nn  
returnnn! '
Viewnn( ,
(nn, -
dtonn- 0
)nn0 1
;nn1 2
varpp 
(pp 
okpp 
,pp 
errorpp 
)pp 
=pp 
awaitpp 
negociospp  (
.pp( )
EditarAsyncpp) 4
(pp4 5
	UsuarioIdpp5 >
,pp> ?
dtopp@ C
)ppC D
;ppD E
ifqq 

(qq 
!qq 
okqq 
)qq 
{rr 	
ifss 
(ss 
errorss 
==ss 
NegocioServicess '
.ss' ("
MensajeSinVerificacionss( >
)ss> ?
{tt 
TempDatauu 
[uu 
$struu  
]uu  !
=uu" #
erroruu$ )
;uu) *
returnvv 
RedirectToActionvv '
(vv' (
nameofvv( .
(vv. /
Perfilvv/ 5
)vv5 6
)vv6 7
;vv7 8
}ww 

ModelStateyy 
.yy 
AddModelErroryy $
(yy$ %
$stryy% '
,yy' (
erroryy) .
!yy. /
)yy/ 0
;yy0 1
returnzz 
Viewzz 
(zz 
dtozz 
)zz 
;zz 
}{{ 	
TempData}} 
[}} 
$str}} 
]}} 
=}} 
$str}} K
;}}K L
return~~ 
RedirectToAction~~ 
(~~  
nameof~~  &
(~~& '
Perfil~~' -
)~~- .
)~~. /
;~~/ 0
} 
[
ÉÉ 
HttpPost
ÉÉ 
,
ÉÉ &
ValidateAntiForgeryToken
ÉÉ '
]
ÉÉ' (
public
ÑÑ 

async
ÑÑ 
Task
ÑÑ 
<
ÑÑ 
IActionResult
ÑÑ #
>
ÑÑ# $"
VerificarEliminacion
ÑÑ% 9
(
ÑÑ9 :
EliminarCuentaDto
ÑÑ: K
dto
ÑÑL O
)
ÑÑO P
{
ÖÖ 
if
ÜÜ 

(
ÜÜ 
!
ÜÜ 

ModelState
ÜÜ 
.
ÜÜ 
IsValid
ÜÜ 
)
ÜÜ  
return
ÜÜ! '
Json
ÜÜ( ,
(
ÜÜ, -
new
ÜÜ- 0
{
ÜÜ1 2
ok
ÜÜ3 5
=
ÜÜ6 7
false
ÜÜ8 =
,
ÜÜ= >
error
ÜÜ? D
=
ÜÜE F
$str
ÜÜG ^
}
ÜÜ_ `
)
ÜÜ` a
;
ÜÜa b
var
àà 
(
àà 
ok
àà 
,
àà 
error
àà 
)
àà 
=
àà 
await
àà 
negocios
àà  (
.
àà( )%
ValidarEliminacionAsync
àà) @
(
àà@ A
	UsuarioId
ààA J
,
ààJ K
dto
ààL O
.
ààO P
Password
ààP X
)
ààX Y
;
ààY Z
return
ââ 
Json
ââ 
(
ââ 
new
ââ 
{
ââ 
ok
ââ 
,
ââ 
error
ââ #
}
ââ$ %
)
ââ% &
;
ââ& '
}
ää 
[
çç 
HttpPost
çç 
,
çç &
ValidateAntiForgeryToken
çç '
]
çç' (
public
éé 

async
éé 
Task
éé 
<
éé 
IActionResult
éé #
>
éé# $
EliminarCuenta
éé% 3
(
éé3 4
EliminarCuentaDto
éé4 E
dto
ééF I
)
ééI J
{
èè 
if
êê 

(
êê 
!
êê 

ModelState
êê 
.
êê 
IsValid
êê 
)
êê  
{
ëë 	
TempData
íí 
[
íí 
$str
íí 
]
íí 
=
íí 
$str
íí  7
;
íí7 8
return
ìì 
RedirectToAction
ìì #
(
ìì# $
nameof
ìì$ *
(
ìì* +
Perfil
ìì+ 1
)
ìì1 2
)
ìì2 3
;
ìì3 4
}
îî 	
var
ññ 
(
ññ 
ok
ññ 
,
ññ 
error
ññ 
)
ññ 
=
ññ 
await
ññ 
negocios
ññ  (
.
ññ( )!
EliminarCuentaAsync
ññ) <
(
ññ< =
	UsuarioId
ññ= F
,
ññF G
dto
ññH K
.
ññK L
Password
ññL T
)
ññT U
;
ññU V
if
óó 

(
óó 
!
óó 
ok
óó 
)
óó 
{
òò 	
TempData
ôô 
[
ôô 
$str
ôô 
]
ôô 
=
ôô 
error
ôô  %
;
ôô% &
return
öö 
RedirectToAction
öö #
(
öö# $
nameof
öö$ *
(
öö* +
Perfil
öö+ 1
)
öö1 2
)
öö2 3
;
öö3 4
}
õõ 	
await
ùù 
HttpContext
ùù 
.
ùù 
SignOutAsync
ùù &
(
ùù& '*
CookieAuthenticationDefaults
ùù' C
.
ùùC D"
AuthenticationScheme
ùùD X
)
ùùX Y
;
ùùY Z
TempData
ûû 
[
ûû 
$str
ûû 
]
ûû 
=
ûû 
$str
ûû ;
;
ûû; <
return
üü 
RedirectToAction
üü 
(
üü  
$str
üü  '
,
üü' (
$str
üü) /
)
üü/ 0
;
üü0 1
}
†† 
[
££ 
AllowAnonymous
££ 
,
££ 
HttpGet
££ 
]
££ 
public
§§ 

async
§§ 
Task
§§ 
<
§§ 
IActionResult
§§ #
>
§§# $
Publico
§§% ,
(
§§, -
int
§§- 0
id
§§1 3
)
§§3 4
{
•• 
var
¶¶ 
perfil
¶¶ 
=
¶¶ 
await
¶¶ 
negocios
¶¶ #
.
¶¶# $'
ObtenerPerfilPublicoAsync
¶¶$ =
(
¶¶= >
id
¶¶> @
)
¶¶@ A
;
¶¶A B
if
ßß 

(
ßß 
perfil
ßß 
is
ßß 
null
ßß 
)
ßß 
return
ßß "
NotFound
ßß# +
(
ßß+ ,
)
ßß, -
;
ßß- .
return
®® 
View
®® 
(
®® 
perfil
®® 
)
®® 
;
®® 
}
©© 
}™™ á
YC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Controllers\HomeController.cs
	namespace 	
Gtrack
 
. 
Controllers 
{ 
public 

class 
HomeController 
:  !

Controller" ,
{ 
public 
IActionResult 
Index "
(" #
)# $
{		 	
return

 
View

 
(

 
)

 
;

 
} 	
public 
IActionResult 
Privacy $
($ %
)% &
{ 	
return 
View 
( 
) 
; 
} 	
[ 	
ResponseCache	 
( 
Duration 
=  !
$num" #
,# $
Location% -
=. /!
ResponseCacheLocation0 E
.E F
NoneF J
,J K
NoStoreL S
=T U
trueV Z
)Z [
][ \
public 
IActionResult 
Error "
(" #
)# $
{ 	
ViewData 
[ 
$str 
] 
=  
$num! $
;$ %
Response 
. 

StatusCode 
=  !
$num" %
;% &
return 
View 
( 
new 
ErrorViewModel *
{+ ,
	RequestId- 6
=7 8
Activity9 A
.A B
CurrentB I
?I J
.J K
IdK M
??N P
HttpContextQ \
.\ ]
TraceIdentifier] l
}m n
)n o
;o p
} 	
[ 	
Route	 
( 
$str  
)  !
]! "
[ 	
ResponseCache	 
( 
Duration 
=  !
$num" #
,# $
Location% -
=. /!
ResponseCacheLocation0 E
.E F
NoneF J
,J K
NoStoreL S
=T U
trueV Z
)Z [
][ \
public 
new 
IActionResult  

StatusCode! +
(+ ,
int, /
code0 4
)4 5
{ 	
ViewData   
[   
$str   
]   
=    
code  ! %
;  % &
Response!! 
.!! 

StatusCode!! 
=!!  !
code!!" &
;!!& '
return"" 
View"" 
("" 
$str"" 
,""  
new""! $
ErrorViewModel""% 3
{""4 5
	RequestId""6 ?
=""@ A
Activity""B J
.""J K
Current""K R
?""R S
.""S T
Id""T V
??""W Y
HttpContext""Z e
.""e f
TraceIdentifier""f u
}""v w
)""w x
;""x y
}## 	
}$$ 
}%% Íá
ZC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Controllers\AdminController.cs
	namespace 	
Gtrack
 
; 
[ 
	Authorize 

(
 
Roles 
= 
$str "
)" #
]# $
public 
class 
AdminController 
( "
IAdministracionService 
admin  
,  !
IReporteService		 
reportes		 
,		 
IExportadorReportes

 

exportador

 "
,

" #
ILogger 
< 
AdminController 
> 
logger #
)# $
:% &

Controller' 1
{ 
private 
string 
EnlaceActivacion #
(# $
string$ *
token+ 0
)0 1
=>2 4
Url 
. 
Action 
( 
$str "
," #
$str$ -
,- .
new/ 2
{3 4
token5 :
}; <
,< =
Request> E
.E F
SchemeF L
)L M
!M N
;N O
[ 
HttpGet 
] 
public 

async 
Task 
< 
IActionResult #
># $
Negocios% -
(- .
). /
=>0 2
View3 7
(7 8
await8 =
admin> C
.C D
ListarNegociosAsyncD W
(W X
)X Y
)Y Z
;Z [
[ 
HttpPost 
, $
ValidateAntiForgeryToken '
]' (
public 

async 
Task 
< 
IActionResult #
># $
AprobarNegocio% 3
(3 4
int4 7
id8 :
): ;
{ 
var 
urlLogin 
= 
Url 
. 
Action !
(! "
$str" )
,) *
$str+ 4
,4 5
new6 9
{: ;
rol< ?
=@ A
nameofB H
(H I

RolUsuarioI S
.S T
NegocioT [
)[ \
}] ^
,^ _
Request` g
.g h
Schemeh n
)n o
!o p
;p q
var 
( 
ok 
, 
correoEnviado 
) 
=  !
await" '
admin( -
.- .
AprobarNegocioAsync. A
(A B
idB D
,D E
urlLoginF N
)N O
;O P
if 

( 
! 
ok 
) 
{ 	
TempData 
[ 
$str 
] 
= 
$str  C
;C D
} 	
else 
if 
( 
correoEnviado 
) 
{   	
TempData!! 
[!! 
$str!! 
]!! 
=!!  !
$str!!" x
;!!x y
}"" 	
else## 
{$$ 	
TempData%% 
[%% 
$str%% 
]%% 
=%%  !
$str%%" B
;%%B C
TempData&& 
[&& 
$str&& 
]&& 
=&& 
$str&&  w
;&&w x
}'' 	
return)) 
RedirectToAction)) 
())  
nameof))  &
())& '
Negocios))' /
)))/ 0
)))0 1
;))1 2
}** 
[-- 
HttpGet-- 
]-- 
public.. 

async.. 
Task.. 
<.. 
IActionResult.. #
>..# $
Administradores..% 4
(..4 5
)..5 6
=>..7 9
View..: >
(..> ?
await..? D
admin..E J
...J K&
ListarAdministradoresAsync..K e
(..e f
)..f g
)..g h
;..h i
[00 
HttpGet00 
]00 
public11 

IActionResult11 "
RegistrarAdministrador11 /
(11/ 0
)110 1
=>112 4
View115 9
(119 :
new11: =$
RegistroAdministradorDto11> V
(11V W
)11W X
)11X Y
;11Y Z
[33 
HttpPost33 
,33 $
ValidateAntiForgeryToken33 '
]33' (
public44 

async44 
Task44 
<44 
IActionResult44 #
>44# $"
RegistrarAdministrador44% ;
(44; <$
RegistroAdministradorDto44< T
dto44U X
)44X Y
{55 
if66 

(66 
!66 

ModelState66 
.66 
IsValid66 
)66  
{77 	
if99 
(99 

ModelState99 
.99 
Values99 !
.99! "

SelectMany99" ,
(99, -
v99- .
=>99/ 1
v992 3
.993 4
Errors994 :
)99: ;
.99; <
Any99< ?
(99? @
e99@ A
=>99B D
e99E F
.99F G
ErrorMessage99G S
==99T V
RegistroNegocioDto99W i
.99i j
Obligatorio99j u
)99u v
)99v w

ModelState:: 
.:: 
AddModelError:: (
(::( )
$str::) +
,::+ ,
$str::- \
)::\ ]
;::] ^
return;; 
View;; 
(;; 
dto;; 
);; 
;;; 
}<< 	
var?? 
r?? 
=?? 
await?? 
admin?? 
.?? '
RegistrarAdministradorAsync?? 7
(??7 8
dto??8 ;
,??; <
EnlaceActivacion??= M
)??M N
;??N O
if@@ 

(@@ 
!@@ 
r@@ 
.@@ 
Ok@@ 
)@@ 
{AA 	

ModelStateBB 
.BB 
AddModelErrorBB $
(BB$ %
$strBB% '
,BB' (
rBB) *
.BB* +
ErrorBB+ 0
!BB0 1
)BB1 2
;BB2 3
returnCC 
ViewCC 
(CC 
dtoCC 
)CC 
;CC 
}DD 	
varFF 
correoFF 
=FF 
dtoFF 
.FF 
CorreoFF 
.FF  
TrimFF  $
(FF$ %
)FF% &
;FF& '
ifGG 

(GG 
rGG 
.GG 
CorreoEnviadoGG 
)GG 
TempDataHH 
[HH 
$strHH 
]HH 
=HH  !
$"HH" $
$strHH$ V
{HHV W
correoHHW ]
}HH] ^
$str	HH^ é
"
HHé è
;
HHè ê
elseII 
TempDataJJ 
[JJ 
$strJJ 
]JJ 
=JJ 
$"JJ  "
$strJJ" v
{JJv w
correoJJw }
}JJ} ~
$str	JJ~ ±
"
JJ± ≤
;
JJ≤ ≥
returnLL 
RedirectToActionLL 
(LL  
nameofLL  &
(LL& '
AdministradoresLL' 6
)LL6 7
)LL7 8
;LL8 9
}MM 
[OO 
HttpPostOO 
,OO $
ValidateAntiForgeryTokenOO '
]OO' (
publicPP 

asyncPP 
TaskPP 
<PP 
IActionResultPP #
>PP# $
ReenviarActivacionPP% 7
(PP7 8
intPP8 ;
idPP< >
)PP> ?
{QQ 
varRR 
(RR 
okRR 
,RR 
mensajeRR 
)RR 
=RR 
awaitRR !
adminRR" '
.RR' (#
ReenviarActivacionAsyncRR( ?
(RR? @
idRR@ B
,RRB C
EnlaceActivacionRRD T
)RRT U
;RRU V
TempDataSS 
[SS 
okSS 
?SS 
$strSS 
:SS  !
$strSS" )
]SS) *
=SS+ ,
mensajeSS- 4
;SS4 5
returnTT 
RedirectToActionTT 
(TT  
nameofTT  &
(TT& '
AdministradoresTT' 6
)TT6 7
)TT7 8
;TT8 9
}UU 
privateXX 
constXX 
stringXX 
	MimeExcelXX "
=XX# $
$strXX% h
;XXh i
privateYY 
constYY 
stringYY 
MimePdfYY  
=YY! "
$strYY# 4
;YY4 5
privateZZ 
constZZ 
stringZZ 
SinInformacionZZ '
=ZZ( )
$strZZ* o
;ZZo p
private\\ 
static\\ 
string\\ 
Dia\\ 
(\\ 
DateTime\\ &
?\\& '
d\\( )
)\\) *
=>\\+ -
d\\. /
!\\/ 0
.\\0 1
Value\\1 6
.\\6 7
ToString\\7 ?
(\\? @
$str\\@ L
)\\L M
;\\M N
[^^ 
HttpGet^^ 
]^^ 
public__ 

async__ 
Task__ 
<__ 
IActionResult__ #
>__# $
Reportes__% -
(__- .
DateTime__. 6
?__6 7
desde__8 =
,__= >
DateTime__? G
?__G H
hasta__I N
)__N O
{`` 
varaa 
hoyaa 
=aa 
DateTimeaa 
.aa 
Todayaa  
;aa  !
varbb 
vistabb 
=bb 
newbb 
ReporteAdminVistabb )
{cc 	
Desdedd 
=dd 
desdedd 
?dd 
.dd 
Datedd 
??dd  "
newdd# &
DateTimedd' /
(dd/ 0
hoydd0 3
.dd3 4
Yeardd4 8
,dd8 9
hoydd: =
.dd= >
Monthdd> C
,ddC D
$numddE F
)ddF G
,ddG H
Hastaee 
=ee 
hastaee 
?ee 
.ee 
Dateee 
??ee  "
hoyee# &
}ff 	
;ff	 

ifhh 

(hh 
desdehh 
ishh 
nullhh 
&&hh 
hastahh "
ishh# %
nullhh& *
)hh* +
returnhh, 2
Viewhh3 7
(hh7 8
vistahh8 =
)hh= >
;hh> ?
vistajj 
.jj 
Errorjj 
=jj 
RangoReportejj "
.jj" #
Validarjj# *
(jj* +
desdejj+ 0
,jj0 1
hastajj2 7
)jj7 8
;jj8 9
ifkk 

(kk 
vistakk 
.kk 
Errorkk 
iskk 
notkk 
nullkk #
)kk# $
returnkk% +
Viewkk, 0
(kk0 1
vistakk1 6
)kk6 7
;kk7 8
trymm 
{nn 	
varoo 
reporteoo 
=oo 
awaitoo 
reportesoo  (
.oo( )$
GenerarReporteAdminAsyncoo) A
(ooA B
desdeooB G
!ooG H
.ooH I
ValueooI N
,ooN O
hastaooP U
!ooU V
.ooV W
ValueooW \
)oo\ ]
;oo] ^
ifpp 
(pp 
reportepp 
.pp 
NegociosRegistradospp +
==pp, .
$numpp/ 0
&&pp1 3
reportepp4 ;
.pp; <#
RepartidoresRegistradospp< S
==ppT V
$numppW X
&&ppY [
reportepp\ c
.ppc d
TotalPedidosppd p
==ppq s
$numppt u
)ppu v
vistaqq 
.qq 
Avisoqq 
=qq 
SinInformacionqq ,
;qq, -
elserr 
vistass 
.ss 
Reportess 
=ss 
reportess  '
;ss' (
}tt 	
catchuu 
(uu 
	Exceptionuu 
exuu 
)uu 
{vv 	
loggerww 
.ww 
LogErrorww 
(ww 
exww 
,ww 
$strww  V
)wwV W
;wwW X
vistaxx 
.xx 
Errorxx 
=xx 
$strxx Q
;xxQ R
}yy 	
return{{ 
View{{ 
({{ 
vista{{ 
){{ 
;{{ 
}|| 
[~~ 
HttpGet~~ 
]~~ 
public 

async 
Task 
< 
IActionResult #
># $
DescargarReporte% 5
(5 6
DateTime6 >
?> ?
desde@ E
,E F
DateTimeG O
?O P
hastaQ V
,V W
stringX ^
formato_ f
=g h
$stri p
)p q
{
ÄÄ 
var
ÅÅ 
error
ÅÅ 
=
ÅÅ 
RangoReporte
ÅÅ  
.
ÅÅ  !
Validar
ÅÅ! (
(
ÅÅ( )
desde
ÅÅ) .
,
ÅÅ. /
hasta
ÅÅ0 5
)
ÅÅ5 6
;
ÅÅ6 7
if
ÇÇ 

(
ÇÇ 
error
ÇÇ 
is
ÇÇ 
not
ÇÇ 
null
ÇÇ 
)
ÇÇ 
{
ÉÉ 	
TempData
ÑÑ 
[
ÑÑ 
$str
ÑÑ 
]
ÑÑ 
=
ÑÑ 
error
ÑÑ  %
;
ÑÑ% &
return
ÖÖ 
RedirectToAction
ÖÖ #
(
ÖÖ# $
nameof
ÖÖ$ *
(
ÖÖ* +
Reportes
ÖÖ+ 3
)
ÖÖ3 4
)
ÖÖ4 5
;
ÖÖ5 6
}
ÜÜ 	
try
àà 
{
ââ 	
var
ää 
reporte
ää 
=
ää 
await
ää 
reportes
ää  (
.
ää( )&
GenerarReporteAdminAsync
ää) A
(
ääA B
desde
ääB G
!
ääG H
.
ääH I
Value
ääI N
,
ääN O
hasta
ääP U
!
ääU V
.
ääV W
Value
ääW \
)
ää\ ]
;
ää] ^
if
ãã 
(
ãã 
reporte
ãã 
.
ãã !
NegociosRegistrados
ãã +
==
ãã, .
$num
ãã/ 0
&&
ãã1 3
reporte
ãã4 ;
.
ãã; <%
RepartidoresRegistrados
ãã< S
==
ããT V
$num
ããW X
&&
ããY [
reporte
ãã\ c
.
ããc d
TotalPedidos
ããd p
==
ããq s
$num
ããt u
)
ããu v
{
åå 
TempData
çç 
[
çç 
$str
çç  
]
çç  !
=
çç" #
SinInformacion
çç$ 2
;
çç2 3
return
éé 
RedirectToAction
éé '
(
éé' (
nameof
éé( .
(
éé. /
Reportes
éé/ 7
)
éé7 8
,
éé8 9
new
éé: =
{
éé> ?
desde
éé@ E
=
ééF G
Dia
ééH K
(
ééK L
desde
ééL Q
)
ééQ R
,
ééR S
hasta
ééT Y
=
ééZ [
Dia
éé\ _
(
éé_ `
hasta
éé` e
)
éée f
}
éég h
)
ééh i
;
ééi j
}
èè 
var
ëë 
nombre
ëë 
=
ëë 
$"
ëë 
$str
ëë .
{
ëë. /
desde
ëë/ 4
.
ëë4 5
Value
ëë5 :
:
ëë: ;
$str
ëë; C
}
ëëC D
$str
ëëD E
{
ëëE F
hasta
ëëF K
.
ëëK L
Value
ëëL Q
:
ëëQ R
$str
ëëR Z
}
ëëZ [
"
ëë[ \
;
ëë\ ]
return
íí 
formato
íí 
.
íí 
Equals
íí !
(
íí! "
$str
íí" '
,
íí' (
StringComparison
íí) 9
.
íí9 :
OrdinalIgnoreCase
íí: K
)
ííK L
?
ìì 
File
ìì 
(
ìì 

exportador
ìì !
.
ìì! "
ReporteAdminPdf
ìì" 1
(
ìì1 2
reporte
ìì2 9
)
ìì9 :
,
ìì: ;
MimePdf
ìì< C
,
ììC D
nombre
ììE K
+
ììL M
$str
ììN T
)
ììT U
:
îî 
File
îî 
(
îî 

exportador
îî !
.
îî! "
ReporteAdminExcel
îî" 3
(
îî3 4
reporte
îî4 ;
)
îî; <
,
îî< =
	MimeExcel
îî> G
,
îîG H
nombre
îîI O
+
îîP Q
$str
îîR Y
)
îîY Z
;
îîZ [
}
ïï 	
catch
ññ 
(
ññ 
	Exception
ññ 
ex
ññ 
)
ññ 
{
óó 	
logger
òò 
.
òò 
LogError
òò 
(
òò 
ex
òò 
,
òò 
$str
òò  W
)
òòW X
;
òòX Y
TempData
ôô 
[
ôô 
$str
ôô 
]
ôô 
=
ôô 
$str
ôô  W
;
ôôW X
return
öö 
RedirectToAction
öö #
(
öö# $
nameof
öö$ *
(
öö* +
Reportes
öö+ 3
)
öö3 4
,
öö4 5
new
öö6 9
{
öö: ;
desde
öö< A
=
ööB C
Dia
ööD G
(
ööG H
desde
ööH M
)
ööM N
,
ööN O
hasta
ööP U
=
ööV W
Dia
ööX [
(
öö[ \
hasta
öö\ a
)
ööa b
}
ööc d
)
ööd e
;
ööe f
}
õõ 	
}
úú 
}ùù 
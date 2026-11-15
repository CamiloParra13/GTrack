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
} µ
ZC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Utilities\ValidadorPassword.cs
public 
static 
class 
ValidadorPassword %
{ 
public 

static 
bool 
EsValida 
(  
string  &
?& '
password( 0
)0 1
=>2 4
! 	
string	 
. 
IsNullOrEmpty 
( 
password &
)& '
&& 

password 
. 
Length 
>= 
$num 
&& 

password 
. 
Any 
( 
char 
. 
IsDigit $
)$ %
&& 

password 
. 
Any 
( 
char 
. 
IsLetter %
)% &
;& '
}		 ò
RC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Utilities\TokenUtil.cs
public 
static 
class 
	TokenUtil 
{ 
public 

static 
string 
Generar  
(  !
)! "
=># %
WebEncoders 
. 
Base64UrlEncode #
(# $!
RandomNumberGenerator$ 9
.9 :
GetBytes: B
(B C
$numC E
)E F
)F G
;G H
public

 

static

 
string

 
Hash

 
(

 
string

 $
token

% *
)

* +
=>

, .
Convert 
. 
ToHexString 
( 
SHA256 "
." #
HashData# +
(+ ,
Encoding, 4
.4 5
UTF85 9
.9 :
GetBytes: B
(B C
tokenC H
)H I
)I J
)J K
;K L
} ⁄ 
dC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Utilities\InvariantDecimalModelBinder.cs
public 
class '
InvariantDecimalModelBinder (
(( )
bool) -

admiteNulo. 8
)8 9
:: ;
IModelBinder< H
{ 
public		 

Task		 
BindModelAsync		 
(		 
ModelBindingContext		 2
bindingContext		3 A
)		A B
{

 
var 
	resultado 
= 
bindingContext &
.& '
ValueProvider' 4
.4 5
GetValue5 =
(= >
bindingContext> L
.L M
	ModelNameM V
)V W
;W X
if 

( 
	resultado 
== 
ValueProviderResult ,
., -
None- 1
)1 2
return3 9
Task: >
.> ?
CompletedTask? L
;L M
bindingContext 
. 

ModelState !
.! "
SetModelValue" /
(/ 0
bindingContext0 >
.> ?
	ModelName? H
,H I
	resultadoJ S
)S T
;T U
var 
texto 
= 
	resultado 
. 

FirstValue (
?( )
.) *
Trim* .
(. /
)/ 0
;0 1
if 

( 
string 
. 
IsNullOrEmpty  
(  !
texto! &
)& '
)' (
{ 	
if 
( 

admiteNulo 
) 
bindingContext *
.* +
Result+ 1
=2 3
ModelBindingResult4 F
.F G
SuccessG N
(N O
nullO S
)S T
;T U
else 
bindingContext 
.  

ModelState  *
.* +
TryAddModelError+ ;
(; <
bindingContext< J
.J K
	ModelNameK T
,T U
$strV i
)i j
;j k
return 
Task 
. 
CompletedTask %
;% &
} 	
if 

( 
decimal 
. 
TryParse 
( 
texto "
," #
NumberStyles$ 0
.0 1
AllowLeadingSign1 A
|B C
NumberStylesD P
.P Q
AllowDecimalPointQ b
,b c
CultureInfo 
. 
InvariantCulture ,
,, -
out. 1
var2 5
valor6 ;
); <
)< =
bindingContext 
. 
Result !
=" #
ModelBindingResult$ 6
.6 7
Success7 >
(> ?
valor? D
)D E
;E F
else 
bindingContext 
. 

ModelState %
.% &
TryAddModelError& 6
(6 7
bindingContext7 E
.E F
	ModelNameF O
,O P
$strQ k
)k l
;l m
return 
Task 
. 
CompletedTask !
;! "
} 
}   
public"" 
class"" /
#InvariantDecimalModelBinderProvider"" 0
:""1 2 
IModelBinderProvider""3 G
{## 
public$$ 

IModelBinder$$ 
?$$ 
	GetBinder$$ "
($$" #&
ModelBinderProviderContext$$# =
context$$> E
)$$E F
=>$$G I
context%% 
.%% 
Metadata%% 
.%% !
UnderlyingOrModelType%% .
==%%/ 1
typeof%%2 8
(%%8 9
decimal%%9 @
)%%@ A
?&& 
new&& '
InvariantDecimalModelBinder&& -
(&&- .
context&&. 5
.&&5 6
Metadata&&6 >
.&&> ?
IsNullableValueType&&? R
)&&R S
:'' 
null'' 
;'' 
}(( Î
ZC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Utilities\GeneradorPassword.cs
public 
static 
class 
GeneradorPassword %
{ 
private 
const 
string 
Letras 
=  !
$str" T
;T U
private 
const 
string 
Digitos  
=! "
$str# -
;- .
public		 

static		 
string		 
Temporal		 !
(		! "
int		" %
largo		& +
=		, -
$num		. 0
)		0 1
{

 
var 
todos 
= 
Letras 
+ 
Digitos $
;$ %
var 
chars 
= 
new 
List 
< 
char !
>! "
{ 	
Letras 
[ !
RandomNumberGenerator (
.( )
GetInt32) 1
(1 2
Letras2 8
.8 9
Length9 ?
)? @
]@ A
,A B
Digitos 
[ !
RandomNumberGenerator )
.) *
GetInt32* 2
(2 3
Digitos3 :
.: ;
Length; A
)A B
]B C
} 	
;	 

while 
( 
chars 
. 
Count 
< 
largo "
)" #
chars 
. 
Add 
( 
todos 
[ !
RandomNumberGenerator 1
.1 2
GetInt322 :
(: ;
todos; @
.@ A
LengthA G
)G H
]H I
)I J
;J K
return 
new 
string 
( 
chars 
.  
OrderBy  '
(' (
_( )
=>* ,!
RandomNumberGenerator- B
.B C
GetInt32C K
(K L
intL O
.O P
MaxValueP X
)X Y
)Y Z
.Z [
ToArray[ b
(b c
)c d
)d e
;e f
} 
} º!
YC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Utilities\EstadoPedidoInfo.cs
public 
static 
class 
EstadoPedidoInfo $
{ 
public 

static 
string 
Nombre 
(  
int  #
estadoId$ ,
), -
=>. 0
(1 2
EstadoPedido2 >
)> ?
estadoId? G
switchH N
{ 
EstadoPedido 
. 
Recibido 
=>  
$str! +
,+ ,
EstadoPedido 
. 
EnPreparacion "
=># %
$str& 6
,6 7
EstadoPedido 
. 
ListoParaEntrega %
=>& (
$str) =
,= >
EstadoPedido		 
.		 
Asignado		 
=>		  
$str		! +
,		+ ,
EstadoPedido

 
.

 
EnCamino

 
=>

  
$str

! ,
,

, -
EstadoPedido 
. 
	Entregado 
=> !
$str" -
,- .
EstadoPedido 
. 
	Cancelado 
=> !
$str" -
,- .
_ 	
=>
 
$str 
} 
; 
public 

static 
string 
Color 
( 
int "
estadoId# +
)+ ,
=>- /
(0 1
EstadoPedido1 =
)= >
estadoId> F
switchG M
{ 
EstadoPedido 
. 
Recibido 
=>  
$str! *
,* +
EstadoPedido 
. 
EnPreparacion "
=># %
$str& /
,/ 0
EstadoPedido 
. 
ListoParaEntrega %
=>& (
$str) 2
,2 3
EstadoPedido 
. 
Asignado 
=>  
$str! *
,* +
EstadoPedido 
. 
EnCamino 
=>  
$str! *
,* +
EstadoPedido 
. 
	Entregado 
=> !
$str" +
,+ ,
EstadoPedido 
. 
	Cancelado 
=> !
$str" +
,+ ,
_ 	
=>
 
$str 
} 
; 
public 

static 
string 
NombreCuenta %
(% &
EstadoCuenta& 2
e3 4
)4 5
=>6 8
e9 :
switch; A
{ 
EstadoCuenta 
. 
Activo 
=> 
$str '
,' (
EstadoCuenta 
. 
PendienteValidacion (
=>) +
$str, E
,E F
EstadoCuenta   
.   

Suspendido   
=>    "
$str  # /
,  / 0
EstadoCuenta!! 
.!! 
	Rechazado!! 
=>!! !
$str!!" -
,!!- .
EstadoCuenta"" 
."" 
PendienteActivacion"" (
=>"") +
$str"", E
,""E F
_## 	
=>##
 
$str## 
}$$ 
;$$ 
public&& 

static&& 
string&& 
ColorCuenta&& $
(&&$ %
EstadoCuenta&&% 1
e&&2 3
)&&3 4
=>&&5 7
e&&8 9
switch&&: @
{'' 
EstadoCuenta(( 
.(( 
Activo(( 
=>(( 
$str(( (
,((( )
EstadoCuenta)) 
.)) 
PendienteValidacion)) (
=>))) +
$str)), 5
,))5 6
EstadoCuenta** 
.** 

Suspendido** 
=>**  "
$str**# ,
,**, -
EstadoCuenta++ 
.++ 
	Rechazado++ 
=>++ !
$str++" +
,+++ ,
EstadoCuenta,, 
.,, 
PendienteActivacion,, (
=>,,) +
$str,,, 5
,,,5 6
_-- 	
=>--
 
$str-- 
}.. 
;.. 
}// ™$
]C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Utilities\BCryptPasswordHasher.cs
public 
class  
BCryptPasswordHasher !
:" #
IPasswordHasher$ 3
<3 4
Usuario4 ;
>; <
{ 
public 

const 
int 
FactorTrabajo "
=# $
$num% '
;' (
private 
readonly 
PasswordHasher #
<# $
Usuario$ +
>+ ,
hasherAnterior- ;
=< =
new> A
(A B
)B C
;C D
public 

string 
HashPassword 
( 
Usuario &
usuario' .
,. /
string0 6
password7 ?
)? @
=>A C
BCrypt 
. 
Net 
. 
BCrypt 
. 
HashPassword &
(& '
password' /
,/ 0
FactorTrabajo1 >
)> ?
;? @
public 
&
PasswordVerificationResult % 
VerifyHashedPassword& :
(: ;
Usuario; B
usuarioC J
,J K
stringL R
hashedPasswordS a
,a b
stringc i
providedPasswordj z
)z {
{ 
if 

( 
string 
. 
IsNullOrEmpty  
(  !
hashedPassword! /
)/ 0
||1 3
string4 :
.: ;
IsNullOrEmpty; H
(H I
providedPasswordI Y
)Y Z
)Z [
return &
PasswordVerificationResult -
.- .
Failed. 4
;4 5
if 

( 
EsHashBCrypt 
( 
hashedPassword '
)' (
)( )
{   	
try!! 
{"" 
if## 
(## 
!## 
BCrypt## 
.## 
Net## 
.##  
BCrypt##  &
.##& '
Verify##' -
(##- .
providedPassword##. >
,##> ?
hashedPassword##@ N
)##N O
)##O P
return$$ &
PasswordVerificationResult$$ 5
.$$5 6
Failed$$6 <
;$$< =
return&& 
BCrypt&& 
.&& 
Net&& !
.&&! "
BCrypt&&" (
.&&( )
PasswordNeedsRehash&&) <
(&&< =
hashedPassword&&= K
,&&K L
FactorTrabajo&&M Z
)&&Z [
?'' &
PasswordVerificationResult'' 0
.''0 1
SuccessRehashNeeded''1 D
:(( &
PasswordVerificationResult(( 0
.((0 1
Success((1 8
;((8 9
})) 
catch** 
(** 
BCrypt** 
.** 
Net** 
.** 
SaltParseException** 0
)**0 1
{++ 
return,, &
PasswordVerificationResult,, 1
.,,1 2
Failed,,2 8
;,,8 9
}-- 
}.. 	
try11 
{22 	
return33 
hasherAnterior33 !
.33! " 
VerifyHashedPassword33" 6
(336 7
usuario337 >
,33> ?
hashedPassword33@ N
,33N O
providedPassword33P `
)33` a
==44 &
PasswordVerificationResult44 0
.440 1
Failed441 7
?55 &
PasswordVerificationResult55 ,
.55, -
Failed55- 3
:66 &
PasswordVerificationResult66 ,
.66, -
SuccessRehashNeeded66- @
;66@ A
}77 	
catch88 
(88 
FormatException88 
)88 
{99 	
return;; &
PasswordVerificationResult;; -
.;;- .
Failed;;. 4
;;;4 5
}<< 	
}== 
private?? 
static?? 
bool?? 
EsHashBCrypt?? $
(??$ %
string??% +
hash??, 0
)??0 1
=>??2 4
hash@@ 
.@@ 
Length@@ 
==@@ 
$num@@ 
&&@@ 
(@@ 
hash@@ "
.@@" #

StartsWith@@# -
(@@- .
$str@@. 4
)@@4 5
||@@6 8
hash@@9 =
.@@= >

StartsWith@@> H
(@@H I
$str@@I O
)@@O P
||@@Q S
hash@@T X
.@@X Y

StartsWith@@Y c
(@@c d
$str@@d j
)@@j k
)@@k l
;@@l m
}AA ©
^C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Utilities\ActividadesEconomicas.cs
public 
static 
class !
ActividadesEconomicas )
{ 
public 

static 
readonly 
IReadOnlyList (
<( )
string) /
>/ 0
Lista1 6
=7 8
[ 
$str 
,  
$str 
, 
$str  
,  !
$str 
, 
$str		 
,		 
$str

 
,

 
$str "
," #
$str 
] 
; 
} öE
XC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\UbicacionService.cs
public 
class 
UbicacionService 
(  
IUbicacionRepository 
ubicaciones $
,$ %
IPedidoRepository 
pedidos 
, 
AppDbContext 
context 
, 
ILogger 
< 
UbicacionService 
> 
logger $
)$ %
:& '
IUbicacionService( 9
{ 
public		 

async		 
Task		 
<		 
(		 
bool		 
Ok		 
,		 
string		  &
?		& '
Error		( -
)		- .
>		. /
ActualizarAsync		0 ?
(		? @
int		@ C
repartidorUsuarioId		D W
,		W X
int		Y \
pedidoId		] e
,		e f
decimal		g n
lat		o r
,		r s
decimal		t {
lng		| 
)			 Ä
{

 
if 

( 
lat 
< 
- 
$num 
|| 
lat 
> 
$num  #
||$ &
lng' *
<+ ,
-- .
$num. 2
||3 5
lng6 9
>: ;
$num< @
)@ A
{ 	
return 
( 
false 
, 
$str y
)y z
;z {
} 	
var 
pedido 
= 
await 
pedidos "
." #
ObtenerPorIdAsync# 4
(4 5
pedidoId5 =
)= >
;> ?
if 

( 
pedido 
is 
null 
) 
{ 	
return 
( 
false 
, 
$str 9
)9 :
;: ;
} 	
if 

( 
pedido 
. 
EstadoPedidoId !
!=" $
(% &
int& )
)) *
EstadoPedido* 6
.6 7
EnCamino7 ?
)? @
{ 	
return 
( 
false 
, 
$str A
)A B
;B C
} 	
var 

repartidor 
= 
await 
context &
.& '
Repartidores' 3
.   
AsNoTracking   
(   
)   
.!! 
FirstOrDefaultAsync!!  
(!!  !
r!!! "
=>!!# %
r!!& '
.!!' (
	UsuarioId!!( 1
==!!2 4
repartidorUsuarioId!!5 H
)!!H I
;!!I J
if## 

(## 

repartidor## 
is## 
null## 
||## !
pedido##" (
.##( )
RepartidorId##) 5
!=##6 8

repartidor##9 C
.##C D
Id##D F
)##F G
{$$ 	
return%% 
(%% 
false%% 
,%% 
$str%% B
)%%B C
;%%C D
}&& 	
var)) 
actual)) 
=)) 
await)) 
ubicaciones)) &
.))& '
ObtenerAsync))' 3
())3 4
pedidoId))4 <
)))< =
;))= >
if** 

(** 
actual** 
is** 
not** 
null** 
)** 
{++ 	
var,, 

diferencia,, 
=,, 
DateTime,, %
.,,% &
UtcNow,,& ,
-,,- .
actual,,/ 5
.,,5 6
FechaActualizacion,,6 H
;,,H I
if-- 
(-- 

diferencia-- 
>=-- 
TimeSpan-- &
.--& '
Zero--' +
&&--, .

diferencia--/ 9
<--: ;
TimeSpan--< D
.--D E
FromSeconds--E P
(--P Q
$num--Q R
)--R S
)--S T
{.. 
return// 
(// 
true// 
,// 
null// "
)//" #
;//# $
}00 
}11 	
try33 
{44 	
await55 
ubicaciones55 
.55 
GuardarAsync55 *
(55* +
pedidoId55+ 3
,553 4
lat555 8
,558 9
lng55: =
)55= >
;55> ?
return66 
(66 
true66 
,66 
null66 
)66 
;66  
}77 	
catch88 
(88 
	Exception88 
ex88 
)88 
{99 	
logger:: 
.:: 
LogError:: 
(:: 
ex:: 
,:: 
$str::  U
,::U V
pedidoId::W _
)::_ `
;::` a
return;; 
(;; 
false;; 
,;; 
$str;; D
);;D E
;;;E F
}<< 	
}== 
public?? 

async?? 
Task?? 
<?? 
(?? 
bool?? 
Ok?? 
,?? 
string??  &
???& '
Error??( -
,??- .
decimal??/ 6
???6 7
Latitud??8 ?
,??? @
decimal??A H
???H I
Longitud??J R
,??R S
DateTime??T \
???\ ]
FechaUtc??^ f
,??f g
string??h n
???n o
Estado??p v
)??v w
>??w x"
ObtenerPorCodigoAsync	??y é
(
??é è
string
??è ï
codigoPedido
??ñ ¢
)
??¢ £
{@@ 
ifAA 

(AA 
stringAA 
.AA 
IsNullOrWhiteSpaceAA %
(AA% &
codigoPedidoAA& 2
)AA2 3
)AA3 4
{BB 	
returnCC 
(CC 
falseCC 
,CC 
$strCC ?
,CC? @
nullCCA E
,CCE F
nullCCG K
,CCK L
nullCCM Q
,CCQ R
nullCCS W
)CCW X
;CCX Y
}DD 	
varFF 
pedidoFF 
=FF 
awaitFF 
pedidosFF "
.FF" #!
ObtenerPorCodigoAsyncFF# 8
(FF8 9
codigoPedidoFF9 E
.FFE F
TrimFFF J
(FFJ K
)FFK L
)FFL M
;FFM N
ifGG 

(GG 
pedidoGG 
isGG 
nullGG 
)GG 
{HH 	
returnII 
(II 
falseII 
,II 
$strII 9
,II9 :
nullII; ?
,II? @
nullIIA E
,IIE F
nullIIG K
,IIK L
nullIIM Q
)IIQ R
;IIR S
}JJ 	
varLL 
estadoLL 
=LL 
(LL 
(LL 
EstadoPedidoLL #
)LL# $
pedidoLL$ *
.LL* +
EstadoPedidoIdLL+ 9
)LL9 :
.LL: ;
ToStringLL; C
(LLC D
)LLD E
;LLE F
ifPP 

(PP 
pedidoPP 
.PP 
EstadoPedidoIdPP !
!=PP" $
(PP% &
intPP& )
)PP) *
EstadoPedidoPP* 6
.PP6 7
EnCaminoPP7 ?
)PP? @
{QQ 	
returnRR 
(RR 
falseRR 
,RR 
$strRR J
,RRJ K
nullRRL P
,RRP Q
nullRRR V
,RRV W
nullRRX \
,RR\ ]
estadoRR^ d
)RRd e
;RRe f
}SS 	
varUU 
	ubicacionUU 
=UU 
awaitUU 
ubicacionesUU )
.UU) *
ObtenerAsyncUU* 6
(UU6 7
pedidoUU7 =
.UU= >
IdUU> @
)UU@ A
;UUA B
ifVV 

(VV 
	ubicacionVV 
isVV 
nullVV 
)VV 
{WW 	
returnXX 
(XX 
falseXX 
,XX 
$strXX J
,XXJ K
nullXXL P
,XXP Q
nullXXR V
,XXV W
nullXXX \
,XX\ ]
estadoXX^ d
)XXd e
;XXe f
}YY 	
var[[ 
fechaUtc[[ 
=[[ 
DateTime[[ 
.[[  
SpecifyKind[[  +
([[+ ,
	ubicacion[[, 5
.[[5 6
FechaActualizacion[[6 H
,[[H I
DateTimeKind[[J V
.[[V W
Utc[[W Z
)[[Z [
;[[[ \
return\\ 
(\\ 
true\\ 
,\\ 
null\\ 
,\\ 
	ubicacion\\ %
.\\% &
Latitud\\& -
,\\- .
	ubicacion\\/ 8
.\\8 9
Longitud\\9 A
,\\A B
fechaUtc\\C K
,\\K L
estado\\M S
)\\S T
;\\T U
}]] 
}^^ ≥√
VC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\ReporteService.cs
public 
class 
ReporteService 
( 
AppDbContext (
db) +
,+ ,
INegocioRepository- ?
negocios@ H
)H I
:J K
IReporteServiceL [
{ 
private 
static 
readonly 
CultureInfo '
Es( *
=+ ,
new- 0
(0 1
$str1 8
)8 9
;9 :
private 
static 
readonly 
string "
[" #
]# $
Paleta% +
=, -
[		 	
$str			 
,		 
$str		 
,		 
$str		 (
,		( )
$str		* 3
,		3 4
$str		5 >
,		> ?
$str		@ I
,		I J
$str		K T
,		T U
$str		V _
]		_ `
;		` a
private 
static 
DateTime 
InicioDiaUtc (
(( )
DateTime) 1
diaLocal2 :
): ;
=>< >
TimeZoneInfo 
. 
ConvertTimeToUtc %
(% &
DateTime 
. 
SpecifyKind  
(  !
diaLocal! )
.) *
Date* .
,. /
DateTimeKind0 <
.< =
Unspecified= H
)H I
,I J
TimeZoneInfoK W
.W X
LocalX ]
)] ^
;^ _
private 
static 
DateTime 
ALocal "
(" #
DateTime# +
fechaBd, 3
)3 4
=>5 7
DateTime 
. 
SpecifyKind 
( 
fechaBd $
,$ %
DateTimeKind& 2
.2 3
Utc3 6
)6 7
.7 8
ToLocalTime8 C
(C D
)D E
;E F
private 
static 
decimal 
Pct 
( 
int "
parte# (
,( )
int* -
total. 3
)3 4
=>5 7
total 
== 
$num 
? 
$num 
: 
Math 
. 
Round #
(# $
parte$ )
** +
$num, 0
/1 2
total3 8
,8 9
$num: ;
); <
;< =
private 
static 
string 
	NombreMes #
(# $
DateTime$ ,
f- .
). /
{ 
var 
mes 
= 
Es 
. 
DateTimeFormat #
.# $
GetMonthName$ 0
(0 1
f1 2
.2 3
Month3 8
)8 9
;9 :
return 
char 
. 
ToUpper 
( 
mes 
[  
$num  !
]! "
," #
Es$ &
)& '
+( )
mes* -
[- .
$num. /
../ 1
]1 2
+3 4
$str5 8
+9 :
f; <
.< =
Year= A
;A B
} 
private 
static 
List 
< 
DateTime  
>  !
MesesDelRango" /
(/ 0
DateTime0 8
desde9 >
,> ?
DateTime@ H
hastaI N
)N O
{   
var!! 
meses!! 
=!! 
new!! 
List!! 
<!! 
DateTime!! %
>!!% &
(!!& '
)!!' (
;!!( )
var"" 
actual"" 
="" 
new"" 
DateTime"" !
(""! "
desde""" '
.""' (
Year""( ,
,"", -
desde"". 3
.""3 4
Month""4 9
,""9 :
$num""; <
)""< =
;""= >
var## 
fin## 
=## 
new## 
DateTime## 
(## 
hasta## $
.##$ %
Year##% )
,##) *
hasta##+ 0
.##0 1
Month##1 6
,##6 7
$num##8 9
)##9 :
;##: ;
while$$ 
($$ 
actual$$ 
<=$$ 
fin$$ 
)$$ 
{%% 	
meses&& 
.&& 
Add&& 
(&& 
actual&& 
)&& 
;&& 
actual'' 
='' 
actual'' 
.'' 
	AddMonths'' %
(''% &
$num''& '
)''' (
;''( )
}(( 	
return)) 
meses)) 
;)) 
}** 
private,, 
static,, 
List,, 
<,, 
FilaEstadoReporte,, )
>,,) *
ContarPorEstado,,+ :
(,,: ;
IReadOnlyCollection,,; N
<,,N O
int,,O R
>,,R S
estados,,T [
),,[ \
{-- 
var.. 
total.. 
=.. 
estados.. 
... 
Count.. !
;..! "
return// 
Enum// 
.// 
	GetValues// 
<// 
EstadoPedido// *
>//* +
(//+ ,
)//, -
.00 
Select00 
(00 
e00 
=>00 
{11 
var22 
cantidad22 
=22 
estados22 &
.22& '
Count22' ,
(22, -
x22- .
=>22/ 1
x222 3
==224 6
(227 8
int228 ;
)22; <
e22< =
)22= >
;22> ?
return33 
new33 
FilaEstadoReporte33 ,
{44 
EstadoId55 
=55 
(55  
int55  #
)55# $
e55$ %
,55% &
Estado66 
=66 
EstadoPedidoInfo66 -
.66- .
Nombre66. 4
(664 5
(665 6
int666 9
)669 :
e66: ;
)66; <
,66< =
Color77 
=77 
EstadoPedidoInfo77 ,
.77, -
Color77- 2
(772 3
(773 4
int774 7
)777 8
e778 9
)779 :
,77: ;
Cantidad88 
=88 
cantidad88 '
,88' (

Porcentaje99 
=99  
Pct99! $
(99$ %
cantidad99% -
,99- .
total99/ 4
)994 5
}:: 
;:: 
};; 
);; 
.<< 
ToList<< 
(<< 
)<< 
;<< 
}== 
publicAA 

asyncAA 
TaskAA 
<AA 
ReporteNegocioDtoAA '
?AA' (
>AA( )&
GenerarReporteNegocioAsyncAA* D
(AAD E
intAAE H
usuarioNegocioIdAAI Y
,AAY Z
DateTimeAA[ c
desdeAAd i
,AAi j
DateTimeAAk s
hastaAAt y
)AAy z
{BB 
varCC 
negocioCC 
=CC 
awaitCC 
negociosCC $
.CC$ %$
ObtenerPorUsuarioIdAsyncCC% =
(CC= >
usuarioNegocioIdCC> N
)CCN O
;CCO P
ifDD 

(DD 
negocioDD 
isDD 
nullDD 
)DD 
returnDD #
nullDD$ (
;DD( )
varFF 
desdeUtcFF 
=FF 
InicioDiaUtcFF #
(FF# $
desdeFF$ )
)FF) *
;FF* +
varGG 
hastaUtcGG 
=GG 
InicioDiaUtcGG #
(GG# $
hastaGG$ )
.GG) *
DateGG* .
.GG. /
AddDaysGG/ 6
(GG6 7
$numGG7 8
)GG8 9
)GG9 :
;GG: ;
varJJ 
filasJJ 
=JJ 
awaitJJ 
dbJJ 
.JJ 
PedidosJJ $
.JJ$ %
AsNoTrackingJJ% 1
(JJ1 2
)JJ2 3
.KK 
WhereKK 
(KK 
pKK 
=>KK 
pKK 
.KK 
	NegocioIdKK #
==KK$ &
negocioKK' .
.KK. /
IdKK/ 1
&&KK2 4
pKK5 6
.KK6 7
FechaCreacionKK7 D
>=KKE G
desdeUtcKKH P
&&KKQ S
pKKT U
.KKU V
FechaCreacionKKV c
<KKd e
hastaUtcKKf n
)KKn o
.LL 
OrderByDescendingLL 
(LL 
pLL  
=>LL! #
pLL$ %
.LL% &
FechaCreacionLL& 3
)LL3 4
.MM 
SelectMM 
(MM 
pMM 
=>MM 
newMM 
{NN 
pOO 
.OO 
IdOO 
,OO 
pPP 
.PP 
CodigoPP 
,PP 
pQQ 
.QQ 
	ClienteIdQQ 
,QQ 
pRR 
.RR 
FechaCreacionRR 
,RR  
pSS 
.SS 
EstadoPedidoIdSS  
,SS  !
ClienteTT 
=TT 
pTT 
.TT 
ClienteTT #
!=TT$ &
nullTT' +
?TT, -
pTT. /
.TT/ 0
ClienteTT0 7
.TT7 8
NombreCompletoTT8 F
:TTG H
nullTTI M
,TTM N

RepartidorUU 
=UU 
pUU 
.UU 

RepartidorUU )
!=UU* ,
nullUU- 1
?UU2 3
pUU4 5
.UU5 6

RepartidorUU6 @
.UU@ A
NombreCompletoUUA O
:UUP Q
nullUUR V
,UUV W
TotalVV 
=VV 
pVV 
.VV 
ItemsVV 
.VV  
SumVV  #
(VV# $
iVV$ %
=>VV& (
iVV) *
.VV* +
CantidadVV+ 3
*VV4 5
iVV6 7
.VV7 8
PrecioUnitarioVV8 F
)VVF G
}WW 
)WW 
.XX 
ToListAsyncXX 
(XX 
)XX 
;XX 
varZZ 

entregadosZZ 
=ZZ 
filasZZ 
.ZZ 
WhereZZ $
(ZZ$ %
fZZ% &
=>ZZ' )
fZZ* +
.ZZ+ ,
EstadoPedidoIdZZ, :
==ZZ; =
(ZZ> ?
intZZ? B
)ZZB C
EstadoPedidoZZC O
.ZZO P
	EntregadoZZP Y
)ZZY Z
.ZZZ [
ToListZZ[ a
(ZZa b
)ZZb c
;ZZc d
var[[ 

cancelados[[ 
=[[ 
filas[[ 
.[[ 
Count[[ $
([[$ %
f[[% &
=>[[' )
f[[* +
.[[+ ,
EstadoPedidoId[[, :
==[[; =
([[> ?
int[[? B
)[[B C
EstadoPedido[[C O
.[[O P
	Cancelado[[P Y
)[[Y Z
;[[Z [
var]] 
reporte]] 
=]] 
new]] 
ReporteNegocioDto]] +
{^^ 	
NombreNegocio__ 
=__ 
negocio__ #
.__# $
Nombre__$ *
,__* +
Desde`` 
=`` 
desde`` 
.`` 
Date`` 
,`` 
Hastaaa 
=aa 
hastaaa 
.aa 
Dateaa 
,aa 

GeneradoEnbb 
=bb 
DateTimebb !
.bb! "
Nowbb" %
,bb% &
TotalPedidoscc 
=cc 
filascc  
.cc  !
Countcc! &
,cc& '

Entregadosdd 
=dd 

entregadosdd #
.dd# $
Countdd$ )
,dd) *

Canceladosee 
=ee 

canceladosee #
,ee# $
TasaEntregaff 
=ff 
Pctff 
(ff 

entregadosff (
.ff( )
Countff) .
,ff. /
filasff0 5
.ff5 6
Countff6 ;
)ff; <
,ff< =
ValorEntregadogg 
=gg 

entregadosgg '
.gg' (
Sumgg( +
(gg+ ,
fgg, -
=>gg. 0
fgg1 2
.gg2 3
Totalgg3 8
)gg8 9
,gg9 :
	PorEstadohh 
=hh 
ContarPorEstadohh '
(hh' (
filashh( -
.hh- .
Selecthh. 4
(hh4 5
fhh5 6
=>hh7 9
fhh: ;
.hh; <
EstadoPedidoIdhh< J
)hhJ K
.hhK L
ToListhhL R
(hhR S
)hhS T
)hhT U
,hhU V
Pedidosii 
=ii 
filasii 
.ii 
Selectii "
(ii" #
fii# $
=>ii% '
newii( +
FilaPedidoReporteii, =
{jj 
Codigokk 
=kk 
fkk 
.kk 
Codigokk !
,kk! "
Clientell 
=ll 
fll 
.ll 
Clientell #
??ll$ &
$"ll' )
$strll) 2
{ll2 3
fll3 4
.ll4 5
	ClienteIdll5 >
}ll> ?
"ll? @
,ll@ A
Fechamm 
=mm 
ALocalmm 
(mm 
fmm  
.mm  !
FechaCreacionmm! .
)mm. /
,mm/ 0
Estadonn 
=nn 
EstadoPedidoInfonn )
.nn) *
Nombrenn* 0
(nn0 1
fnn1 2
.nn2 3
EstadoPedidoIdnn3 A
)nnA B
,nnB C

Repartidoroo 
=oo 
foo 
.oo 

Repartidoroo )
??oo* ,
$stroo- :
,oo: ;

ValorTotalpp 
=pp 
fpp 
.pp 
Totalpp $
}qq 
)qq 
.qq 
ToListqq 
(qq 
)qq 
}rr 	
;rr	 

varuu 
localesuu 
=uu 
filasuu 
.uu 
Selectuu "
(uu" #
fuu# $
=>uu% '
newuu( +
{uu, -
Fechauu. 3
=uu4 5
ALocaluu6 <
(uu< =
fuu= >
.uu> ?
FechaCreacionuu? L
)uuL M
,uuM N
fuuO P
.uuP Q
EstadoPedidoIduuQ _
,uu_ `
fuua b
.uub c
Totaluuc h
}uui j
)uuj k
.uuk l
ToListuul r
(uur s
)uus t
;uut u
foreachvv 
(vv 
varvv 
mesvv 
invv 
MesesDelRangovv )
(vv) *
desdevv* /
,vv/ 0
hastavv1 6
)vv6 7
)vv7 8
{ww 	
varxx 
delMesxx 
=xx 
localesxx  
.xx  !
Wherexx! &
(xx& '
fxx' (
=>xx) +
fxx, -
.xx- .
Fechaxx. 3
.xx3 4
Yearxx4 8
==xx9 ;
mesxx< ?
.xx? @
Yearxx@ D
&&xxE G
fxxH I
.xxI J
FechaxxJ O
.xxO P
MonthxxP U
==xxV X
mesxxY \
.xx\ ]
Monthxx] b
)xxb c
.xxc d
ToListxxd j
(xxj k
)xxk l
;xxl m
reporteyy 
.yy 
PorMesyy 
.yy 
Addyy 
(yy 
newyy "
FilaMesReporteyy# 1
{zz 
Mes{{ 
={{ 
	NombreMes{{ 
({{  
mes{{  #
){{# $
,{{$ %
Total|| 
=|| 
delMes|| 
.|| 
Count|| $
,||$ %

Entregados}} 
=}} 
delMes}} #
.}}# $
Count}}$ )
(}}) *
f}}* +
=>}}, .
f}}/ 0
.}}0 1
EstadoPedidoId}}1 ?
==}}@ B
(}}C D
int}}D G
)}}G H
EstadoPedido}}H T
.}}T U
	Entregado}}U ^
)}}^ _
,}}_ `

Cancelados~~ 
=~~ 
delMes~~ #
.~~# $
Count~~$ )
(~~) *
f~~* +
=>~~, .
f~~/ 0
.~~0 1
EstadoPedidoId~~1 ?
==~~@ B
(~~C D
int~~D G
)~~G H
EstadoPedido~~H T
.~~T U
	Cancelado~~U ^
)~~^ _
,~~_ `
ValorEntregado 
=  
delMes! '
.' (
Where( -
(- .
f. /
=>0 2
f3 4
.4 5
EstadoPedidoId5 C
==D F
(G H
intH K
)K L
EstadoPedidoL X
.X Y
	EntregadoY b
)b c
.c d
Sumd g
(g h
fh i
=>j l
fm n
.n o
Totalo t
)t u
}
ÄÄ 
)
ÄÄ 
;
ÄÄ 
}
ÅÅ 	
return
ÉÉ 
reporte
ÉÉ 
;
ÉÉ 
}
ÑÑ 
public
àà 

async
àà 
Task
àà 
<
àà  
HistorialExportDto
àà (
?
àà( )
>
àà) *#
ObtenerHistorialAsync
àà+ @
(
àà@ A
int
ààA D
usuarioNegocioId
ààE U
,
ààU V
DateTime
ààW _
desde
àà` e
,
ààe f
DateTime
ààg o
hasta
ààp u
)
ààu v
{
ââ 
var
ää 
negocio
ää 
=
ää 
await
ää 
negocios
ää $
.
ää$ %&
ObtenerPorUsuarioIdAsync
ää% =
(
ää= >
usuarioNegocioId
ää> N
)
ääN O
;
ääO P
if
ãã 

(
ãã 
negocio
ãã 
is
ãã 
null
ãã 
)
ãã 
return
ãã #
null
ãã$ (
;
ãã( )
var
çç 
desdeUtc
çç 
=
çç 
InicioDiaUtc
çç #
(
çç# $
desde
çç$ )
)
çç) *
;
çç* +
var
éé 
hastaUtc
éé 
=
éé 
InicioDiaUtc
éé #
(
éé# $
hasta
éé$ )
.
éé) *
Date
éé* .
.
éé. /
AddDays
éé/ 6
(
éé6 7
$num
éé7 8
)
éé8 9
)
éé9 :
;
éé: ;
var
èè 
	entregado
èè 
=
èè 
(
èè 
int
èè 
)
èè 
EstadoPedido
èè )
.
èè) *
	Entregado
èè* 3
;
èè3 4
var
êê 
	cancelado
êê 
=
êê 
(
êê 
int
êê 
)
êê 
EstadoPedido
êê )
.
êê) *
	Cancelado
êê* 3
;
êê3 4
var
ìì 
filas
ìì 
=
ìì 
await
ìì 
db
ìì 
.
ìì 
Pedidos
ìì $
.
ìì$ %
AsNoTracking
ìì% 1
(
ìì1 2
)
ìì2 3
.
îî 
Where
îî 
(
îî 
p
îî 
=>
îî 
p
îî 
.
îî 
	NegocioId
îî #
==
îî$ &
negocio
îî' .
.
îî. /
Id
îî/ 1
&&
ïï 
p
ïï 
.
ïï 
FechaCreacion
ïï *
>=
ïï+ -
desdeUtc
ïï. 6
&&
ïï7 9
p
ïï: ;
.
ïï; <
FechaCreacion
ïï< I
<
ïïJ K
hastaUtc
ïïL T
&&
ññ 
(
ññ 
p
ññ 
.
ññ 
EstadoPedidoId
ññ ,
==
ññ- /
	entregado
ññ0 9
||
ññ: <
p
ññ= >
.
ññ> ?
EstadoPedidoId
ññ? M
==
ññN P
	cancelado
ññQ Z
)
ññZ [
)
ññ[ \
.
óó 
OrderByDescending
óó 
(
óó 
p
óó  
=>
óó! #
p
óó$ %
.
óó% &
FechaCreacion
óó& 3
)
óó3 4
.
òò 
Select
òò 
(
òò 
p
òò 
=>
òò 
new
òò 
{
ôô 
p
öö 
.
öö 
Codigo
öö 
,
öö 
p
õõ 
.
õõ 
	ClienteId
õõ 
,
õõ 
p
úú 
.
úú 
FechaCreacion
úú 
,
úú  
p
ùù 
.
ùù 
EstadoPedidoId
ùù  
,
ùù  !
Cliente
ûû 
=
ûû 
p
ûû 
.
ûû 
Cliente
ûû #
!=
ûû$ &
null
ûû' +
?
ûû, -
p
ûû. /
.
ûû/ 0
Cliente
ûû0 7
.
ûû7 8
NombreCompleto
ûû8 F
:
ûûG H
null
ûûI M
,
ûûM N

Repartidor
üü 
=
üü 
p
üü 
.
üü 

Repartidor
üü )
!=
üü* ,
null
üü- 1
?
üü2 3
p
üü4 5
.
üü5 6

Repartidor
üü6 @
.
üü@ A
NombreCompleto
üüA O
:
üüP Q
null
üüR V
,
üüV W
Total
†† 
=
†† 
p
†† 
.
†† 
Items
†† 
.
††  
Sum
††  #
(
††# $
i
††$ %
=>
††& (
i
††) *
.
††* +
Cantidad
††+ 3
*
††4 5
i
††6 7
.
††7 8
PrecioUnitario
††8 F
)
††F G
}
°° 
)
°° 
.
¢¢ 
ToListAsync
¢¢ 
(
¢¢ 
)
¢¢ 
;
¢¢ 
return
§§ 
new
§§  
HistorialExportDto
§§ %
{
•• 	
NombreNegocio
¶¶ 
=
¶¶ 
negocio
¶¶ #
.
¶¶# $
Nombre
¶¶$ *
,
¶¶* +
Desde
ßß 
=
ßß 
desde
ßß 
.
ßß 
Date
ßß 
,
ßß 
Hasta
®® 
=
®® 
hasta
®® 
.
®® 
Date
®® 
,
®® 

GeneradoEn
©© 
=
©© 
DateTime
©© !
.
©©! "
Now
©©" %
,
©©% &
Filas
™™ 
=
™™ 
filas
™™ 
.
™™ 
Select
™™  
(
™™  !
f
™™! "
=>
™™# %
new
™™& )
FilaPedidoReporte
™™* ;
{
´´ 
Codigo
¨¨ 
=
¨¨ 
f
¨¨ 
.
¨¨ 
Codigo
¨¨ !
,
¨¨! "
Cliente
≠≠ 
=
≠≠ 
f
≠≠ 
.
≠≠ 
Cliente
≠≠ #
??
≠≠$ &
$"
≠≠' )
$str
≠≠) 2
{
≠≠2 3
f
≠≠3 4
.
≠≠4 5
	ClienteId
≠≠5 >
}
≠≠> ?
"
≠≠? @
,
≠≠@ A
Fecha
ÆÆ 
=
ÆÆ 
ALocal
ÆÆ 
(
ÆÆ 
f
ÆÆ  
.
ÆÆ  !
FechaCreacion
ÆÆ! .
)
ÆÆ. /
,
ÆÆ/ 0
Estado
ØØ 
=
ØØ 
EstadoPedidoInfo
ØØ )
.
ØØ) *
Nombre
ØØ* 0
(
ØØ0 1
f
ØØ1 2
.
ØØ2 3
EstadoPedidoId
ØØ3 A
)
ØØA B
,
ØØB C

Repartidor
∞∞ 
=
∞∞ 
f
∞∞ 
.
∞∞ 

Repartidor
∞∞ )
??
∞∞* ,
$str
∞∞- :
,
∞∞: ;

ValorTotal
±± 
=
±± 
f
±± 
.
±± 
Total
±± $
}
≤≤ 
)
≤≤ 
.
≤≤ 
ToList
≤≤ 
(
≤≤ 
)
≤≤ 
}
≥≥ 	
;
≥≥	 

}
¥¥ 
public
∏∏ 

async
∏∏ 
Task
∏∏ 
<
∏∏ 
ReporteAdminDto
∏∏ %
>
∏∏% &&
GenerarReporteAdminAsync
∏∏' ?
(
∏∏? @
DateTime
∏∏@ H
desde
∏∏I N
,
∏∏N O
DateTime
∏∏P X
hasta
∏∏Y ^
)
∏∏^ _
{
ππ 
var
∫∫ 
desdeUtc
∫∫ 
=
∫∫ 
InicioDiaUtc
∫∫ #
(
∫∫# $
desde
∫∫$ )
)
∫∫) *
;
∫∫* +
var
ªª 
hastaUtc
ªª 
=
ªª 
InicioDiaUtc
ªª #
(
ªª# $
hasta
ªª$ )
.
ªª) *
Date
ªª* .
.
ªª. /
AddDays
ªª/ 6
(
ªª6 7
$num
ªª7 8
)
ªª8 9
)
ªª9 :
;
ªª: ;
var
ææ 
negociosRango
ææ 
=
ææ 
await
ææ !
db
ææ" $
.
ææ$ %
Negocios
ææ% -
.
ææ- .
AsNoTracking
ææ. :
(
ææ: ;
)
ææ; <
.
øø 
Where
øø 
(
øø 
n
øø 
=>
øø 
n
øø 
.
øø 
FechaRegistro
øø '
>=
øø( *
desdeUtc
øø+ 3
&&
øø4 6
n
øø7 8
.
øø8 9
FechaRegistro
øø9 F
<
øøG H
hastaUtc
øøI Q
)
øøQ R
.
¿¿ 
OrderByDescending
¿¿ 
(
¿¿ 
n
¿¿  
=>
¿¿! #
n
¿¿$ %
.
¿¿% &
FechaRegistro
¿¿& 3
)
¿¿3 4
.
¡¡ 
Select
¡¡ 
(
¡¡ 
n
¡¡ 
=>
¡¡ 
new
¡¡ 
{
¬¬ 
n
√√ 
.
√√ 
Nombre
√√ 
,
√√ 
n
ƒƒ 
.
ƒƒ 
TipoActividad
ƒƒ 
,
ƒƒ  
	Documento
≈≈ 
=
≈≈ 
n
≈≈ 
.
≈≈ 
Usuario
≈≈ %
!
≈≈% &
.
≈≈& '
	Documento
≈≈' 0
,
≈≈0 1
Correo
∆∆ 
=
∆∆ 
n
∆∆ 
.
∆∆ 
Usuario
∆∆ "
.
∆∆" #
Correo
∆∆# )
,
∆∆) *
n
«« 
.
«« 
FechaRegistro
«« 
,
««  
Estado
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
Estado
»»# )
}
…… 
)
…… 
.
   
ToListAsync
   
(
   
)
   
;
   
var
ÃÃ 
activosTotal
ÃÃ 
=
ÃÃ 
await
ÃÃ  
db
ÃÃ! #
.
ÃÃ# $
Negocios
ÃÃ$ ,
.
ÃÃ, -

CountAsync
ÃÃ- 7
(
ÃÃ7 8
n
ÃÃ8 9
=>
ÃÃ: <
n
ÃÃ= >
.
ÃÃ> ?
Usuario
ÃÃ? F
!
ÃÃF G
.
ÃÃG H
Estado
ÃÃH N
==
ÃÃO Q
EstadoCuenta
ÃÃR ^
.
ÃÃ^ _
Activo
ÃÃ_ e
)
ÃÃe f
;
ÃÃf g
var
ÕÕ 
repartidores
ÕÕ 
=
ÕÕ 
await
ÕÕ  
db
ÕÕ! #
.
ÕÕ# $
Repartidores
ÕÕ$ 0
.
ŒŒ 

CountAsync
ŒŒ 
(
ŒŒ 
r
ŒŒ 
=>
ŒŒ 
r
ŒŒ 
.
ŒŒ 
FechaRegistro
ŒŒ ,
>=
ŒŒ- /
desdeUtc
ŒŒ0 8
&&
ŒŒ9 ;
r
ŒŒ< =
.
ŒŒ= >
FechaRegistro
ŒŒ> K
<
ŒŒL M
hastaUtc
ŒŒN V
)
ŒŒV W
;
ŒŒW X
var
—— 
pedidos
—— 
=
—— 
await
—— 
db
—— 
.
—— 
Pedidos
—— &
.
——& '
AsNoTracking
——' 3
(
——3 4
)
——4 5
.
““ 
Where
““ 
(
““ 
p
““ 
=>
““ 
p
““ 
.
““ 
FechaCreacion
““ '
>=
““( *
desdeUtc
““+ 3
&&
““4 6
p
““7 8
.
““8 9
FechaCreacion
““9 F
<
““G H
hastaUtc
““I Q
)
““Q R
.
”” 
Select
”” 
(
”” 
p
”” 
=>
”” 
new
”” 
{
‘‘ 
p
’’ 
.
’’ 
	NegocioId
’’ 
,
’’ 
p
÷÷ 
.
÷÷ 
EstadoPedidoId
÷÷  
,
÷÷  !
Total
◊◊ 
=
◊◊ 
p
◊◊ 
.
◊◊ 
Items
◊◊ 
.
◊◊  
Sum
◊◊  #
(
◊◊# $
i
◊◊$ %
=>
◊◊& (
i
◊◊) *
.
◊◊* +
Cantidad
◊◊+ 3
*
◊◊4 5
i
◊◊6 7
.
◊◊7 8
PrecioUnitario
◊◊8 F
)
◊◊F G
}
ÿÿ 
)
ÿÿ 
.
ŸŸ 
ToListAsync
ŸŸ 
(
ŸŸ 
)
ŸŸ 
;
ŸŸ 
var
€€ 
entregadosPedidos
€€ 
=
€€ 
pedidos
€€  '
.
€€' (
Where
€€( -
(
€€- .
p
€€. /
=>
€€0 2
p
€€3 4
.
€€4 5
EstadoPedidoId
€€5 C
==
€€D F
(
€€G H
int
€€H K
)
€€K L
EstadoPedido
€€L X
.
€€X Y
	Entregado
€€Y b
)
€€b c
.
€€c d
ToList
€€d j
(
€€j k
)
€€k l
;
€€l m
var
›› 
reporte
›› 
=
›› 
new
›› 
ReporteAdminDto
›› )
{
ﬁﬁ 	
Desde
ﬂﬂ 
=
ﬂﬂ 
desde
ﬂﬂ 
.
ﬂﬂ 
Date
ﬂﬂ 
,
ﬂﬂ 
Hasta
‡‡ 
=
‡‡ 
hasta
‡‡ 
.
‡‡ 
Date
‡‡ 
,
‡‡ 

GeneradoEn
·· 
=
·· 
DateTime
·· !
.
··! "
Now
··" %
,
··% &!
NegociosRegistrados
‚‚ 
=
‚‚  !
negociosRango
‚‚" /
.
‚‚/ 0
Count
‚‚0 5
,
‚‚5 6"
NegociosActivosTotal
„„  
=
„„! "
activosTotal
„„# /
,
„„/ 0%
RepartidoresRegistrados
‰‰ #
=
‰‰$ %
repartidores
‰‰& 2
,
‰‰2 3
TotalPedidos
ÂÂ 
=
ÂÂ 
pedidos
ÂÂ "
.
ÂÂ" #
Count
ÂÂ# (
,
ÂÂ( )
PedidosEntregados
ÊÊ 
=
ÊÊ 
entregadosPedidos
ÊÊ  1
.
ÊÊ1 2
Count
ÊÊ2 7
,
ÊÊ7 8
ValorEntregado
ÁÁ 
=
ÁÁ 
entregadosPedidos
ÁÁ .
.
ÁÁ. /
Sum
ÁÁ/ 2
(
ÁÁ2 3
p
ÁÁ3 4
=>
ÁÁ5 7
p
ÁÁ8 9
.
ÁÁ9 :
Total
ÁÁ: ?
)
ÁÁ? @
,
ÁÁ@ A
PedidosPorEstado
ËË 
=
ËË 
ContarPorEstado
ËË .
(
ËË. /
pedidos
ËË/ 6
.
ËË6 7
Select
ËË7 =
(
ËË= >
p
ËË> ?
=>
ËË@ B
p
ËËC D
.
ËËD E
EstadoPedidoId
ËËE S
)
ËËS T
.
ËËT U
ToList
ËËU [
(
ËË[ \
)
ËË\ ]
)
ËË] ^
,
ËË^ _
Negocios
ÈÈ 
=
ÈÈ 
negociosRango
ÈÈ $
.
ÈÈ$ %
Select
ÈÈ% +
(
ÈÈ+ ,
n
ÈÈ, -
=>
ÈÈ. 0
new
ÈÈ1 4 
FilaNegocioReporte
ÈÈ5 G
{
ÍÍ 
Nombre
ÎÎ 
=
ÎÎ 
n
ÎÎ 
.
ÎÎ 
Nombre
ÎÎ !
,
ÎÎ! "
	Actividad
ÏÏ 
=
ÏÏ 
n
ÏÏ 
.
ÏÏ 
TipoActividad
ÏÏ +
,
ÏÏ+ ,
	Documento
ÌÌ 
=
ÌÌ 
n
ÌÌ 
.
ÌÌ 
	Documento
ÌÌ '
,
ÌÌ' (
Correo
ÓÓ 
=
ÓÓ 
n
ÓÓ 
.
ÓÓ 
Correo
ÓÓ !
,
ÓÓ! "
FechaRegistro
ÔÔ 
=
ÔÔ 
ALocal
ÔÔ  &
(
ÔÔ& '
n
ÔÔ' (
.
ÔÔ( )
FechaRegistro
ÔÔ) 6
)
ÔÔ6 7
,
ÔÔ7 8
Estado
 
=
 
EstadoPedidoInfo
 )
.
) *
NombreCuenta
* 6
(
6 7
n
7 8
.
8 9
Estado
9 ?
)
? @
}
ÒÒ 
)
ÒÒ 
.
ÒÒ 
ToList
ÒÒ 
(
ÒÒ 
)
ÒÒ 
}
ÚÚ 	
;
ÚÚ	 

var
ıı 
fechasLocales
ıı 
=
ıı 
negociosRango
ıı )
.
ıı) *
Select
ıı* 0
(
ıı0 1
n
ıı1 2
=>
ıı3 5
ALocal
ıı6 <
(
ıı< =
n
ıı= >
.
ıı> ?
FechaRegistro
ıı? L
)
ııL M
)
ııM N
.
ııN O
ToList
ııO U
(
ııU V
)
ııV W
;
ııW X
foreach
ˆˆ 
(
ˆˆ 
var
ˆˆ 
mes
ˆˆ 
in
ˆˆ 
MesesDelRango
ˆˆ )
(
ˆˆ) *
desde
ˆˆ* /
,
ˆˆ/ 0
hasta
ˆˆ1 6
)
ˆˆ6 7
)
ˆˆ7 8
{
˜˜ 	
reporte
¯¯ 
.
¯¯ 
NegociosPorMes
¯¯ "
.
¯¯" #
Add
¯¯# &
(
¯¯& '
new
¯¯' *
FilaMesReporte
¯¯+ 9
{
˘˘ 
Mes
˙˙ 
=
˙˙ 
	NombreMes
˙˙ 
(
˙˙  
mes
˙˙  #
)
˙˙# $
,
˙˙$ %
Total
˚˚ 
=
˚˚ 
fechasLocales
˚˚ %
.
˚˚% &
Count
˚˚& +
(
˚˚+ ,
f
˚˚, -
=>
˚˚. 0
f
˚˚1 2
.
˚˚2 3
Year
˚˚3 7
==
˚˚8 :
mes
˚˚; >
.
˚˚> ?
Year
˚˚? C
&&
˚˚D F
f
˚˚G H
.
˚˚H I
Month
˚˚I N
==
˚˚O Q
mes
˚˚R U
.
˚˚U V
Month
˚˚V [
)
˚˚[ \
}
¸¸ 
)
¸¸ 
;
¸¸ 
}
˝˝ 	
reporte
ÄÄ 
.
ÄÄ 
NegociosPorEstado
ÄÄ !
=
ÄÄ" #
Enum
ÄÄ$ (
.
ÄÄ( )
	GetValues
ÄÄ) 2
<
ÄÄ2 3
EstadoCuenta
ÄÄ3 ?
>
ÄÄ? @
(
ÄÄ@ A
)
ÄÄA B
.
ÅÅ 
Select
ÅÅ 
(
ÅÅ 
e
ÅÅ 
=>
ÅÅ 
{
ÇÇ 
var
ÉÉ 
cantidad
ÉÉ 
=
ÉÉ 
negociosRango
ÉÉ ,
.
ÉÉ, -
Count
ÉÉ- 2
(
ÉÉ2 3
n
ÉÉ3 4
=>
ÉÉ5 7
n
ÉÉ8 9
.
ÉÉ9 :
Estado
ÉÉ: @
==
ÉÉA C
e
ÉÉD E
)
ÉÉE F
;
ÉÉF G
return
ÑÑ 
new
ÑÑ 
FilaConteoReporte
ÑÑ ,
{
ÖÖ 
Etiqueta
ÜÜ 
=
ÜÜ 
EstadoPedidoInfo
ÜÜ /
.
ÜÜ/ 0
NombreCuenta
ÜÜ0 <
(
ÜÜ< =
e
ÜÜ= >
)
ÜÜ> ?
,
ÜÜ? @
Color
áá 
=
áá 
EstadoPedidoInfo
áá ,
.
áá, -
ColorCuenta
áá- 8
(
áá8 9
e
áá9 :
)
áá: ;
,
áá; <
Cantidad
àà 
=
àà 
cantidad
àà '
,
àà' (

Porcentaje
ââ 
=
ââ  
Pct
ââ! $
(
ââ$ %
cantidad
ââ% -
,
ââ- .
negociosRango
ââ/ <
.
ââ< =
Count
ââ= B
)
ââB C
}
ää 
;
ää 
}
ãã 
)
ãã 
.
åå 
Where
åå 
(
åå 
f
åå 
=>
åå 
f
åå 
.
åå 
Cantidad
åå "
>
åå# $
$num
åå% &
)
åå& '
.
çç 
ToList
çç 
(
çç 
)
çç 
;
çç 
reporte
êê 
.
êê "
NegociosPorActividad
êê $
=
êê% &
negociosRango
êê' 4
.
ëë 
GroupBy
ëë 
(
ëë 
n
ëë 
=>
ëë 
string
ëë  
.
ëë  ! 
IsNullOrWhiteSpace
ëë! 3
(
ëë3 4
n
ëë4 5
.
ëë5 6
TipoActividad
ëë6 C
)
ëëC D
?
ëëE F
$str
ëëG V
:
ëëW X
n
ëëY Z
.
ëëZ [
TipoActividad
ëë[ h
)
ëëh i
.
íí 
OrderByDescending
íí 
(
íí 
g
íí  
=>
íí! #
g
íí$ %
.
íí% &
Count
íí& +
(
íí+ ,
)
íí, -
)
íí- .
.
ìì 
ThenBy
ìì 
(
ìì 
g
ìì 
=>
ìì 
g
ìì 
.
ìì 
Key
ìì 
)
ìì 
.
îî 
Select
îî 
(
îî 
(
îî 
g
îî 
,
îî 
i
îî 
)
îî 
=>
îî 
new
îî !
FilaConteoReporte
îî" 3
{
ïï 
Etiqueta
ññ 
=
ññ 
g
ññ 
.
ññ 
Key
ññ  
,
ññ  !
Color
óó 
=
óó 
Paleta
óó 
[
óó 
i
óó  
%
óó! "
Paleta
óó# )
.
óó) *
Length
óó* 0
]
óó0 1
,
óó1 2
Cantidad
òò 
=
òò 
g
òò 
.
òò 
Count
òò "
(
òò" #
)
òò# $
,
òò$ %

Porcentaje
ôô 
=
ôô 
Pct
ôô  
(
ôô  !
g
ôô! "
.
ôô" #
Count
ôô# (
(
ôô( )
)
ôô) *
,
ôô* +
negociosRango
ôô, 9
.
ôô9 :
Count
ôô: ?
)
ôô? @
}
öö 
)
öö 
.
õõ 
ToList
õõ 
(
õõ 
)
õõ 
;
õõ 
var
ûû 
top
ûû 
=
ûû 
pedidos
ûû 
.
üü 
GroupBy
üü 
(
üü 
p
üü 
=>
üü 
p
üü 
.
üü 
	NegocioId
üü %
)
üü% &
.
†† 
Select
†† 
(
†† 
g
†† 
=>
†† 
new
†† 
{
°° 
	NegocioId
¢¢ 
=
¢¢ 
g
¢¢ 
.
¢¢ 
Key
¢¢ !
,
¢¢! "
Pedidos
££ 
=
££ 
g
££ 
.
££ 
Count
££ !
(
££! "
)
££" #
,
££# $

Entregados
§§ 
=
§§ 
g
§§ 
.
§§ 
Count
§§ $
(
§§$ %
p
§§% &
=>
§§' )
p
§§* +
.
§§+ ,
EstadoPedidoId
§§, :
==
§§; =
(
§§> ?
int
§§? B
)
§§B C
EstadoPedido
§§C O
.
§§O P
	Entregado
§§P Y
)
§§Y Z
,
§§Z [
Valor
•• 
=
•• 
g
•• 
.
•• 
Where
•• 
(
••  
p
••  !
=>
••" $
p
••% &
.
••& '
EstadoPedidoId
••' 5
==
••6 8
(
••9 :
int
••: =
)
••= >
EstadoPedido
••> J
.
••J K
	Entregado
••K T
)
••T U
.
••U V
Sum
••V Y
(
••Y Z
p
••Z [
=>
••\ ^
p
••_ `
.
••` a
Total
••a f
)
••f g
}
¶¶ 
)
¶¶ 
.
ßß 
OrderByDescending
ßß 
(
ßß 
x
ßß  
=>
ßß! #
x
ßß$ %
.
ßß% &
Pedidos
ßß& -
)
ßß- .
.
®® 
ThenBy
®® 
(
®® 
x
®® 
=>
®® 
x
®® 
.
®® 
	NegocioId
®® $
)
®®$ %
.
©© 
Take
©© 
(
©© 
$num
©© 
)
©© 
.
™™ 
ToList
™™ 
(
™™ 
)
™™ 
;
™™ 
if
¨¨ 

(
¨¨ 
top
¨¨ 
.
¨¨ 
Count
¨¨ 
>
¨¨ 
$num
¨¨ 
)
¨¨ 
{
≠≠ 	
var
ÆÆ 
ids
ÆÆ 
=
ÆÆ 
top
ÆÆ 
.
ÆÆ 
Select
ÆÆ  
(
ÆÆ  !
t
ÆÆ! "
=>
ÆÆ# %
t
ÆÆ& '
.
ÆÆ' (
	NegocioId
ÆÆ( 1
)
ÆÆ1 2
.
ÆÆ2 3
ToList
ÆÆ3 9
(
ÆÆ9 :
)
ÆÆ: ;
;
ÆÆ; <
var
ØØ 
nombres
ØØ 
=
ØØ 
await
ØØ 
db
ØØ  "
.
ØØ" #
Negocios
ØØ# +
.
ØØ+ ,
AsNoTracking
ØØ, 8
(
ØØ8 9
)
ØØ9 :
.
∞∞ 
Where
∞∞ 
(
∞∞ 
n
∞∞ 
=>
∞∞ 
ids
∞∞ 
.
∞∞  
Contains
∞∞  (
(
∞∞( )
n
∞∞) *
.
∞∞* +
Id
∞∞+ -
)
∞∞- .
)
∞∞. /
.
±± 
ToDictionaryAsync
±± "
(
±±" #
n
±±# $
=>
±±% '
n
±±( )
.
±±) *
Id
±±* ,
,
±±, -
n
±±. /
=>
±±0 2
n
±±3 4
.
±±4 5
Nombre
±±5 ;
)
±±; <
;
±±< =
reporte
≥≥ 
.
≥≥ 
TopNegocios
≥≥ 
=
≥≥  !
top
≥≥" %
.
≥≥% &
Select
≥≥& ,
(
≥≥, -
t
≥≥- .
=>
≥≥/ 1
new
≥≥2 5#
FilaTopNegocioReporte
≥≥6 K
{
¥¥ 
Nombre
µµ 
=
µµ 
nombres
µµ  
.
µµ  !
GetValueOrDefault
µµ! 2
(
µµ2 3
t
µµ3 4
.
µµ4 5
	NegocioId
µµ5 >
,
µµ> ?
$"
µµ@ B
$str
µµB K
{
µµK L
t
µµL M
.
µµM N
	NegocioId
µµN W
}
µµW X
"
µµX Y
)
µµY Z
,
µµZ [
Pedidos
∂∂ 
=
∂∂ 
t
∂∂ 
.
∂∂ 
Pedidos
∂∂ #
,
∂∂# $

Entregados
∑∑ 
=
∑∑ 
t
∑∑ 
.
∑∑ 

Entregados
∑∑ )
,
∑∑) *
ValorEntregado
∏∏ 
=
∏∏  
t
∏∏! "
.
∏∏" #
Valor
∏∏# (
}
ππ 
)
ππ 
.
ππ 
ToList
ππ 
(
ππ 
)
ππ 
;
ππ 
}
∫∫ 	
return
ºº 
reporte
ºº 
;
ºº 
}
ΩΩ 
}ææ Ìã
YC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\RepartidorService.cs
public 
	interface 
IRepartidorService #
{ 
Task 
< 	
ResultadoRegistro	 
> 
RegistrarAsync *
(* +
int+ .
usuarioNegocioId/ ?
,? @!
RegistroRepartidorDtoA V
dtoW Z
,Z [
Func\ `
<` a
stringa g
,g h
stringi o
>o p
construirEnlace	q Ä
)
Ä Å
;
Å Ç
Task		 
<		 	
(			 

bool		
 
Ok		 
,		 
string		 
Mensaje		 !
)		! "
>		" ##
ReenviarActivacionAsync		$ ;
(		; <
int		< ?
usuarioNegocioId		@ P
,		P Q
int		R U
repartidorId		V b
,		b c
Func		d h
<		h i
string		i o
,		o p
string		q w
>		w x
construirEnlace			y à
)
		à â
;
		â ä
Task 
< 	
List	 
< 

Repartidor 
> 
> 
ListarAsync &
(& '
int' *
usuarioNegocioId+ ;
); <
;< =
} 
public 
class 
RepartidorService 
( !
IRepartidorRepository 
repartidores &
,& '
INegocioRepository 
negocios 
,  
IUsuarioRepository 
usuarios 
,  $
IActivacionCuentaService 

activacion '
,' (
ILogger 
< 
RepartidorService 
> 
logger %
)% &
:' (
IRepartidorService) ;
{ 
private 
const 
int '
MaxCorreosActivacionPorHora 1
=2 3
$num4 5
;5 6
public 

async 
Task 
< 
List 
< 

Repartidor %
>% &
>& '
ListarAsync( 3
(3 4
int4 7
usuarioNegocioId8 H
)H I
{ 
var 
negocio 
= 
await 
negocios $
.$ %$
ObtenerPorUsuarioIdAsync% =
(= >
usuarioNegocioId> N
)N O
;O P
return 
negocio 
is 
null 
?  
[! "
]" #
:$ %
await& +
repartidores, 8
.8 9!
ListarPorNegocioAsync9 N
(N O
negocioO V
.V W
IdW Y
)Y Z
;Z [
} 
public 

async 
Task 
< 
ResultadoRegistro '
>' (
RegistrarAsync) 7
(7 8
int8 ;
usuarioNegocioId< L
,L M!
RegistroRepartidorDtoN c
dtod g
,g h
Funci m
<m n
stringn t
,t u
stringv |
>| }
construirEnlace	~ ç
)
ç é
{ 
var   
negocio   
=   
await   
negocios   $
.  $ %$
ObtenerPorUsuarioIdAsync  % =
(  = >
usuarioNegocioId  > N
)  N O
;  O P
if!! 

(!! 
negocio!! 
is!! 
null!! 
)!! 
return!! #
new!!$ '
(!!' (
false!!( -
,!!- .
$str!!/ V
,!!V W
false!!X ]
,!!] ^
null!!_ c
)!!c d
;!!d e
var## 
	documento## 
=## 
dto## 
.## 
	Documento## %
.##% &
Trim##& *
(##* +
)##+ ,
;##, -
var$$ 
correo$$ 
=$$ 
dto$$ 
.$$ 
Correo$$ 
.$$  
Trim$$  $
($$$ %
)$$% &
;$$& '
var%% 
telefono%% 
=%% 
dto%% 
.%% 
Telefono%% #
.%%# $
Trim%%$ (
(%%( )
)%%) *
;%%* +
var)) 
anterior)) 
=)) 
await)) 
repartidores)) )
.))) * 
BuscarEliminadoAsync))* >
())> ?
correo))? E
,))E F
	documento))G P
)))P Q
;))Q R
await,, 
usuarios,, 
.,, "
LiberarEliminadosAsync,, -
(,,- .
correo,,. 4
,,,4 5
	documento,,6 ?
),,? @
;,,@ A
if// 

(// 
await// 
negocios// 
.//  
ExisteDocumentoAsync// /
(/// 0
	documento//0 9
)//9 :
)//: ;
return00 
new00 
(00 
false00 
,00 
$str00 T
,00T U
false00V [
,00[ \
null00] a
,00a b
nameof00c i
(00i j
dto00j m
.00m n
	Documento00n w
)00w x
)00x y
;00y z
if11 

(11 
await11 
usuarios11 
.11 !
ObtenerPorCorreoAsync11 0
(110 1
correo111 7
)117 8
is119 ;
not11< ?
null11@ D
)11D E
return22 
new22 
(22 
false22 
,22 
$str22 S
,22S T
false22U Z
,22Z [
null22\ `
,22` a
nameof22b h
(22h i
dto22i l
.22l m
Correo22m s
)22s t
)22t u
;22u v
if33 

(33 
await33 
repartidores33 
.33 
TelefonoEnUsoAsync33 1
(331 2
telefono332 :
)33: ;
)33; <
return44 
new44 
(44 
false44 
,44 
$str44 I
,44I J
false44K P
,44P Q
null44R V
,44V W
nameof44X ^
(44^ _
dto44_ b
.44b c
Telefono44c k
)44k l
)44l m
;44m n
var66 
conPlaca66 
=66 
dto66 
.66 
Vehiculo66 #
is66$ &
TipoVehiculo66' 3
.663 4
Moto664 8
or669 ;
TipoVehiculo66< H
.66H I
Carro66I N
;66N O
if88 

(88 
anterior88 
?88 
.88 
Usuario88 
is88  
not88! $
null88% )
)88) *
return99 
await99 
ReactivarAsync99 '
(99' (
anterior99( 0
,990 1
negocio992 9
,999 :
dto99; >
,99> ?
correo99@ F
,99F G
	documento99H Q
,99Q R
telefono99S [
,99[ \
conPlaca99] e
,99e f
construirEnlace99g v
)99v w
;99w x
var<< 
usuario<< 
=<< 
new<< 
Usuario<< !
{== 	
Correo>> 
=>> 
correo>> 
,>> 
	Documento?? 
=?? 
	documento?? !
,??! "
PasswordHash@@ 
=@@ 
$str@@ 
,@@ 
RolAA 
=AA 

RolUsuarioAA 
.AA 

RepartidorAA '
,AA' (
EstadoBB 
=BB 
EstadoCuentaBB !
.BB! "
PendienteActivacionBB" 5
}CC 	
;CC	 

varEE 

repartidorEE 
=EE 
newEE 

RepartidorEE '
{FF 	
	NegocioIdGG 
=GG 
negocioGG 
.GG  
IdGG  "
,GG" #
NombreCompletoHH 
=HH 
dtoHH  
.HH  !
NombreCompletoHH! /
.HH/ 0
TrimHH0 4
(HH4 5
)HH5 6
,HH6 7
TelefonoII 
=II 
telefonoII 
,II  
VehiculoJJ 
=JJ 
dtoJJ 
.JJ 
VehiculoJJ #
!JJ# $
.JJ$ %
ValueJJ% *
,JJ* +
PlacaKK 
=KK 
conPlacaKK 
?KK 
ReglasValidacionKK /
.KK/ 0
NormalizarPlacaKK0 ?
(KK? @
dtoKK@ C
.KKC D
PlacaKKD I
)KKI J
:KKK L
nullKKM Q
}LL 	
;LL	 

tryNN 
{OO 	
awaitPP 
repartidoresPP 
.PP $
RegistrarRepartidorAsyncPP 7
(PP7 8
usuarioPP8 ?
,PP? @

repartidorPPA K
)PPK L
;PPL M
}QQ 	
catchRR 
(RR 
DbUpdateExceptionRR  
exRR! #
)RR# $
{SS 	
loggerTT 
.TT 
LogErrorTT 
(TT 
exTT 
,TT 
$strTT  K
,TTK L
correoTTM S
)TTS T
;TTT U
returnUU 
newUU 
(UU 
falseUU 
,UU 
$strUU Z
,UUZ [
falseUU\ a
,UUa b
nullUUc g
)UUg h
;UUh i
}VV 	
varYY 
enviadoYY 
=YY 
awaitYY 

activacionYY &
.YY& '
EnviarEnlaceAsyncYY' 8
(YY8 9
usuarioYY9 @
,YY@ A

repartidorYYB L
.YYL M
NombreCompletoYYM [
,YY[ \
negocioYY] d
.YYd e
NombreYYe k
,YYk l
construirEnlaceYYm |
)YY| }
;YY} ~
returnZZ 
newZZ 
(ZZ 
trueZZ 
,ZZ 
nullZZ 
,ZZ 
enviadoZZ &
,ZZ& '
nullZZ( ,
)ZZ, -
;ZZ- .
}[[ 
private]] 
async]] 
Task]] 
<]] 
ResultadoRegistro]] (
>]]( )
ReactivarAsync]]* 8
(]]8 9

Repartidor]]9 C
rep]]D G
,]]G H
Negocio]]I P
negocio]]Q X
,]]X Y!
RegistroRepartidorDto]]Z o
dto]]p s
,]]s t
string^^ 
correo^^ 
,^^ 
string^^ 
	documento^^ '
,^^' (
string^^) /
telefono^^0 8
,^^8 9
bool^^: >
conPlaca^^? G
,^^G H
Func^^I M
<^^M N
string^^N T
,^^T U
string^^V \
>^^\ ]
construirEnlace^^^ m
)^^m n
{__ 
var`` 
usuario`` 
=`` 
rep`` 
.`` 
Usuario`` !
!``! "
;``" #
usuarioaa 
.aa 
Correoaa 
=aa 
correoaa 
;aa  
usuariobb 
.bb 
	Documentobb 
=bb 
	documentobb %
;bb% &
usuariocc 
.cc 
PasswordHashcc 
=cc 
$strcc !
;cc! "
usuariodd 
.dd 
Estadodd 
=dd 
EstadoCuentadd %
.dd% &
PendienteActivaciondd& 9
;dd9 :
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
;ff% &
usuariogg 
.gg 
MotivoRechazogg 
=gg 
nullgg  $
;gg$ %
repii 
.ii 
	NegocioIdii 
=ii 
negocioii 
.ii  
Idii  "
;ii" #
repjj 
.jj 
NombreCompletojj 
=jj 
dtojj  
.jj  !
NombreCompletojj! /
.jj/ 0
Trimjj0 4
(jj4 5
)jj5 6
;jj6 7
repkk 
.kk 
Telefonokk 
=kk 
telefonokk 
;kk  
repll 
.ll 
Vehiculoll 
=ll 
dtoll 
.ll 
Vehiculoll #
!ll# $
.ll$ %
Valuell% *
;ll* +
repmm 
.mm 
Placamm 
=mm 
conPlacamm 
?mm 
ReglasValidacionmm /
.mm/ 0
NormalizarPlacamm0 ?
(mm? @
dtomm@ C
.mmC D
PlacammD I
)mmI J
:mmK L
nullmmM Q
;mmQ R
repnn 
.nn 
FechaRegistronn 
=nn 
DateTimenn $
.nn$ %
UtcNownn% +
;nn+ ,
trypp 
{qq 	
awaitrr 
repartidoresrr 
.rr 
ReactivarAsyncrr -
(rr- .
reprr. 1
)rr1 2
;rr2 3
}ss 	
catchtt 
(tt 
DbUpdateExceptiontt  
extt! #
)tt# $
{uu 	
loggervv 
.vv 
LogErrorvv 
(vv 
exvv 
,vv 
$strvv  M
,vvM N
correovvO U
)vvU V
;vvV W
returnww 
newww 
(ww 
falseww 
,ww 
$strww Z
,wwZ [
falseww\ a
,wwa b
nullwwc g
)wwg h
;wwh i
}xx 	
varzz 
enviadozz 
=zz 
awaitzz 

activacionzz &
.zz& '
EnviarEnlaceAsynczz' 8
(zz8 9
usuariozz9 @
,zz@ A
repzzB E
.zzE F
NombreCompletozzF T
,zzT U
negociozzV ]
.zz] ^
Nombrezz^ d
,zzd e
construirEnlacezzf u
)zzu v
;zzv w
return{{ 
new{{ 
({{ 
true{{ 
,{{ 
null{{ 
,{{ 
enviado{{ &
,{{& '
null{{( ,
){{, -
;{{- .
}|| 
public~~ 

async~~ 
Task~~ 
<~~ 
(~~ 
bool~~ 
Ok~~ 
,~~ 
string~~  &
Mensaje~~' .
)~~. /
>~~/ 0#
ReenviarActivacionAsync~~1 H
(~~H I
int~~I L
usuarioNegocioId~~M ]
,~~] ^
int~~_ b
repartidorId~~c o
,~~o p
Func~~q u
<~~u v
string~~v |
,~~| }
string	~~~ Ñ
>
~~Ñ Ö
construirEnlace
~~Ü ï
)
~~ï ñ
{ 
var
ÄÄ 
negocio
ÄÄ 
=
ÄÄ 
await
ÄÄ 
negocios
ÄÄ $
.
ÄÄ$ %&
ObtenerPorUsuarioIdAsync
ÄÄ% =
(
ÄÄ= >
usuarioNegocioId
ÄÄ> N
)
ÄÄN O
;
ÄÄO P
if
ÅÅ 

(
ÅÅ 
negocio
ÅÅ 
is
ÅÅ 
null
ÅÅ 
)
ÅÅ 
return
ÅÅ #
(
ÅÅ$ %
false
ÅÅ% *
,
ÅÅ* +
$str
ÅÅ, S
)
ÅÅS T
;
ÅÅT U
var
ÉÉ 

repartidor
ÉÉ 
=
ÉÉ 
await
ÉÉ 
repartidores
ÉÉ +
.
ÉÉ+ ,#
ObtenerDeNegocioAsync
ÉÉ, A
(
ÉÉA B
negocio
ÉÉB I
.
ÉÉI J
Id
ÉÉJ L
,
ÉÉL M
repartidorId
ÉÉN Z
)
ÉÉZ [
;
ÉÉ[ \
if
ÑÑ 

(
ÑÑ 

repartidor
ÑÑ 
?
ÑÑ 
.
ÑÑ 
Usuario
ÑÑ 
is
ÑÑ  "
null
ÑÑ# '
)
ÑÑ' (
return
ÑÑ) /
(
ÑÑ0 1
false
ÑÑ1 6
,
ÑÑ6 7
$str
ÑÑ8 n
)
ÑÑn o
;
ÑÑo p
var
ÜÜ 
usuario
ÜÜ 
=
ÜÜ 

repartidor
ÜÜ  
.
ÜÜ  !
Usuario
ÜÜ! (
;
ÜÜ( )
if
áá 

(
áá 
usuario
áá 
.
áá 
Estado
áá 
!=
áá 
EstadoCuenta
áá *
.
áá* +!
PendienteActivacion
áá+ >
)
áá> ?
return
àà 
(
àà 
false
àà 
,
àà 
$"
àà 
{
àà 

repartidor
àà (
.
àà( )
NombreCompleto
àà) 7
}
àà7 8
$str
àà8 M
"
ààM N
)
ààN O
;
ààO P
if
ää 

(
ää 
await
ää 

activacion
ää 
.
ää #
EnviosUltimaHoraAsync
ää 2
(
ää2 3
usuario
ää3 :
.
ää: ;
Id
ää; =
)
ää= >
>=
ää? A)
MaxCorreosActivacionPorHora
ääB ]
)
ää] ^
return
ãã 
(
ãã 
false
ãã 
,
ãã 
$str
ãã }
)
ãã} ~
;
ãã~ 
var
çç 
enviado
çç 
=
çç 
await
çç 

activacion
çç &
.
çç& '
EnviarEnlaceAsync
çç' 8
(
çç8 9
usuario
çç9 @
,
çç@ A

repartidor
ççB L
.
ççL M
NombreCompleto
ççM [
,
çç[ \
negocio
çç] d
.
ççd e
Nombre
ççe k
,
ççk l
construirEnlace
ççm |
)
çç| }
;
çç} ~
return
éé 
enviado
éé 
?
èè 
(
èè 
true
èè 
,
èè 
$"
èè 
$str
èè <
{
èè< =
usuario
èè= D
.
èèD E
Correo
èèE K
}
èèK L
$str
èèL M
"
èèM N
)
èèN O
:
êê 
(
êê 
false
êê 
,
êê 
$str
êê Z
)
êêZ [
;
êê[ \
}
ëë 
}íí èX
[C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\RecuperacionService.cs
public 
class 
RecuperacionService  
(  !
IUsuarioRepository 
usuarios 
,  (
ITokenRecuperacionRepository  
tokens! '
,' (
IPasswordHasher 
< 
Usuario 
> 
hasher #
,# $
IEmailService 
email 
, 
ILogger 
< 
RecuperacionService 
>  
logger! '
)' (
:) * 
IRecuperacionService+ ?
{		 
public

 

const

 
string

  
MensajeTokenInvalido

 ,
=

- .
$str

/ m
;

m n
private 
const 
int !
MaxSolicitudesPorHora +
=, -
$num. /
;/ 0
private 
const 
int 
MinutosVigencia %
=& '
$num( *
;* +
public 

async 
Task 
< 
ResultadoSolicitud (
>( )
SolicitarAsync* 8
(8 9
string9 ?
correo@ F
,F G
FuncH L
<L M
stringM S
,S T
stringU [
>[ \
construirEnlace] l
)l m
{ 
var 
usuario 
= 
await 
usuarios $
.$ %!
ObtenerPorCorreoAsync% :
(: ;
correo; A
.A B
TrimB F
(F G
)G H
)H I
;I J
if 

( 
usuario 
is 
null 
) 
return #
ResultadoSolicitud$ 6
.6 7
	Procesada7 @
;@ A
var 
desde 
= 
DateTime 
. 
UtcNow #
.# $
AddHours$ ,
(, -
-- .
$num. /
)/ 0
;0 1
if 

( 
await 
tokens 
. 
ContarDesdeAsync )
() *
usuario* 1
.1 2
Id2 4
,4 5
desde6 ;
); <
>== ?!
MaxSolicitudesPorHora@ U
)U V
return 
ResultadoSolicitud %
.% &
LimiteSuperado& 4
;4 5
var 
token 
= 
	TokenUtil 
. 
Generar %
(% &
)& '
;' (
await 
tokens 
. 
AgregarAsync !
(! "
new" %
TokenRecuperacion& 7
{ 	
	UsuarioId 
= 
usuario 
.  
Id  "
," #
	TokenHash 
= 
	TokenUtil !
.! "
Hash" &
(& '
token' ,
), -
,- .
Expira 
= 
DateTime 
. 
UtcNow $
.$ %

AddMinutes% /
(/ 0
MinutosVigencia0 ?
)? @
} 	
)	 

;
 
var 
enlace 
= 
construirEnlace $
($ %
token% *
)* +
;+ ,
await   
email   
.   
EnviarAsync   
(    
usuario    '
.  ' (
Correo  ( .
,  . /
$str  0 T
,  T U
PlantillaCorreo  V e
.  e f
Crear  f k
(  k l
etiqueta!! 
:!! 
$str!! 2
,!!2 3
titulo"" 
:"" 
$str"" .
,"". /
saludo## 
:## 
$str## 
,## 
parrafos$$ 
:$$ 
[%% 
$str&& `
,&&` a
$str'' G
](( 
,(( 

textoBoton)) 
:)) 
$str)) 0
,))0 1
urlBoton** 
:** 
enlace** 
,** 
nota++ 
:++ 
$"++ 
$str++ ,
{++, -
MinutosVigencia++- <
}++< =
$str	++= ∑
"
++∑ ∏
,
++∏ π
tipoNota,, 
:,, 
TipoNota,, 
.,, 
Aviso,, $
),,$ %
),,% &
;,,& '
return.. 
ResultadoSolicitud.. !
...! "
	Procesada.." +
;..+ ,
}// 
public11 

async11 
Task11 
<11 
bool11 
>11 
TokenVigenteAsync11 -
(11- .
string11. 4
token115 :
)11: ;
{22 
if33 

(33 
string33 
.33 
IsNullOrWhiteSpace33 %
(33% &
token33& +
)33+ ,
)33, -
return33. 4
false335 :
;33: ;
var44 
t44 
=44 
await44 
tokens44 
.44 
ObtenerPorHashAsync44 0
(440 1
	TokenUtil441 :
.44: ;
Hash44; ?
(44? @
token44@ E
)44E F
)44F G
;44G H
return55 
t55 
is55 
not55 
null55 
&&55 
!55  !
t55! "
.55" #
Usado55# (
&&55) +
t55, -
.55- .
Expira55. 4
>555 6
DateTime557 ?
.55? @
UtcNow55@ F
;55F G
}66 
public88 

async88 
Task88 
<88 
(88 
bool88 
Ok88 
,88 
string88  &
?88& '
Error88( -
)88- .
>88. /
RestablecerAsync880 @
(88@ A
string88A G
token88H M
,88M N
string88O U
nueva88V [
,88[ \
string88] c
confirmacion88d p
)88p q
{99 
var:: 
t:: 
=:: 
string:: 
.:: 
IsNullOrWhiteSpace:: )
(::) *
token::* /
)::/ 0
?::1 2
null::3 7
:::8 9
await::: ?
tokens::@ F
.::F G
ObtenerPorHashAsync::G Z
(::Z [
	TokenUtil::[ d
.::d e
Hash::e i
(::i j
token::j o
)::o p
)::p q
;::q r
if;; 

(;; 
t;; 
is;; 
null;; 
||;; 
t;; 
.;; 
Usado;;  
||;;! #
t;;$ %
.;;% &
Expira;;& ,
<=;;- /
DateTime;;0 8
.;;8 9
UtcNow;;9 ?
);;? @
return<< 
(<< 
false<< 
,<<  
MensajeTokenInvalido<< /
)<</ 0
;<<0 1
if?? 

(?? 
nueva?? 
!=?? 
confirmacion?? !
||??" $
!??% &
ValidadorPassword??& 7
.??7 8
EsValida??8 @
(??@ A
nueva??A F
)??F G
)??G H
return@@ 
(@@ 
false@@ 
,@@ 
$str@@ [
)@@[ \
;@@\ ]
varBB 
usuarioBB 
=BB 
awaitBB 
usuariosBB $
.BB$ %
ObtenerPorIdAsyncBB% 6
(BB6 7
tBB7 8
.BB8 9
	UsuarioIdBB9 B
)BBB C
;BBC D
ifCC 

(CC 
usuarioCC 
isCC 
nullCC 
)CC 
returnCC #
(CC$ %
falseCC% *
,CC* + 
MensajeTokenInvalidoCC, @
)CC@ A
;CCA B
ifFF 

(FF 
EsLaMismaContrasenaFF 
(FF  
usuarioFF  '
,FF' (
nuevaFF) .
)FF. /
)FF/ 0
returnGG 
(GG 
falseGG 
,GG 
$strGG Q
)GGQ R
;GGR S
usuarioII 
.II 
PasswordHashII 
=II 
hasherII %
.II% &
HashPasswordII& 2
(II2 3
usuarioII3 :
,II: ;
nuevaII< A
)IIA B
;IIB C
ifMM 

(MM 
usuarioMM 
.MM 
EstadoMM 
==MM 
EstadoCuentaMM *
.MM* +
PendienteActivacionMM+ >
)MM> ?
usuarioMM@ G
.MMG H
EstadoMMH N
=MMO P
EstadoCuentaMMQ ]
.MM] ^
ActivoMM^ d
;MMd e
awaitOO 
usuariosOO 
.OO 
ActualizarAsyncOO &
(OO& '
usuarioOO' .
)OO. /
;OO/ 0
awaitRR 
tokensRR 
.RR $
InvalidarPendientesAsyncRR -
(RR- .
usuarioRR. 5
.RR5 6
IdRR6 8
)RR8 9
;RR9 :
tryTT 
{UU 	
awaitVV 
emailVV 
.VV 
EnviarAsyncVV #
(VV# $
usuarioVV$ +
.VV+ ,
CorreoVV, 2
,VV2 3
$strVV4 T
,VVT U
PlantillaCorreoVVV e
.VVe f
CrearVVf k
(VVk l
etiquetaWW 
:WW 
$strWW 2
,WW2 3
tituloXX 
:XX 
$strXX 7
,XX7 8
saludoYY 
:YY 
$strYY 
,YY  
parrafosZZ 
:ZZ 
[ZZ 
$str	ZZ ë
]
ZZë í
,
ZZí ì
nota[[ 
:[[ 
$str[[ h
,[[h i
tipoNota\\ 
:\\ 
TipoNota\\ "
.\\" #
Aviso\\# (
)\\( )
)\\) *
;\\* +
}]] 	
catch^^ 
(^^ 
	Exception^^ 
ex^^ 
)^^ 
{__ 	
logger`` 
.`` 
LogError`` 
(`` 
ex`` 
,`` 
$str``  p
,``p q
usuario``r y
.``y z
Correo	``z Ä
)
``Ä Å
;
``Å Ç
}aa 	
returncc 
(cc 
truecc 
,cc 
nullcc 
)cc 
;cc 
}dd 
privatehh 
boolhh 
EsLaMismaContrasenahh $
(hh$ %
Usuariohh% ,
usuariohh- 4
,hh4 5
stringhh6 <
nuevahh= B
)hhB C
{ii 
tryjj 
{kk 	
returnll 
hasherll 
.ll  
VerifyHashedPasswordll .
(ll. /
usuarioll/ 6
,ll6 7
usuarioll8 ?
.ll? @
PasswordHashll@ L
,llL M
nuevallN S
)llS T
!=llU W&
PasswordVerificationResultllX r
.llr s
Failedlls y
;lly z
}mm 	
catchnn 
(nn 
FormatExceptionnn 
)nn 
{oo 	
returnpp 
falsepp 
;pp 
}qq 	
}rr 
}ss é≤
WC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\PlantillaCorreo.cs
public 
record 

CorreoHtml 
( 
string 
Html  $
,$ %
string& ,
Texto- 2
)2 3
;3 4
public

 
enum

 
TipoNota

 
{

 
Info

 
,

 
Aviso

 "
,

" #
Exito

$ )
}

* +
public 
static 
class 
PlantillaCorreo #
{ 
public 

const 
string 
ContentIdLogo %
=& '
$str( 5
;5 6
private 
const 
string 
Fuente 
=  !
$str" x
;x y
public 

static 

CorreoHtml 
Crear "
(" #
string 
titulo 
, 
string 
saludo 
, 
IEnumerable 
< 
string 
> 
parrafos $
,$ %
string 
? 
etiqueta 
= 
null 
,  
IEnumerable 
< 
( 
string 
Etiqueta $
,$ %
string& ,
Valor- 2
)2 3
>3 4
?4 5
datos6 ;
=< =
null> B
,B C
string 
? 
codigo 
= 
null 
, 
string 
? 

textoBoton 
= 
null !
,! "
string 
? 
urlBoton 
= 
null 
,  
string   
?   
nota   
=   
null   
,   
TipoNota!! 
tipoNota!! 
=!! 
TipoNota!! $
.!!$ %
Info!!% )
,!!) *
string"" 
?"" 
resumen"" 
="" 
null"" 
)"" 
{## 
var$$ 
listaParrafos$$ 
=$$ 
parrafos$$ $
.$$$ %
Where$$% *
($$* +
p$$+ ,
=>$$- /
!$$0 1
string$$1 7
.$$7 8
IsNullOrWhiteSpace$$8 J
($$J K
p$$K L
)$$L M
)$$M N
.$$N O
ToList$$O U
($$U V
)$$V W
;$$W X
var%% 
filas%% 
=%% 
datos%% 
?%% 
.%% 
Where%%  
(%%  !
d%%! "
=>%%# %
!%%& '
string%%' -
.%%- .
IsNullOrWhiteSpace%%. @
(%%@ A
d%%A B
.%%B C
Valor%%C H
)%%H I
)%%I J
.%%J K
ToList%%K Q
(%%Q R
)%%R S
??%%T V
[%%W X
]%%X Y
;%%Y Z
var&& 
hayBoton&& 
=&& 
!&& 
string&& 
.&& 
IsNullOrWhiteSpace&& 1
(&&1 2

textoBoton&&2 <
)&&< =
&&&&> @
!&&A B
string&&B H
.&&H I
IsNullOrWhiteSpace&&I [
(&&[ \
urlBoton&&\ d
)&&d e
;&&e f
var)) 
vistaPrevia)) 
=)) 
resumen)) !
??))" $
())% &
listaParrafos))& 3
.))3 4
Count))4 9
>)): ;
$num))< =
?))> ?

SinFormato))@ J
())J K
listaParrafos))K X
[))X Y
$num))Y Z
]))Z [
)))[ \
:))] ^
titulo))_ e
)))e f
;))f g
if** 

(** 
vistaPrevia** 
.** 
Length** 
>**  
$num**! $
)**$ %
vistaPrevia**& 1
=**2 3
vistaPrevia**4 ?
[**? @
..**@ B
$num**B E
]**E F
+**G H
$str**I L
;**L M
var,, 
html,, 
=,, 
new,, 
StringBuilder,, $
(,,$ %
),,% &
;,,& '
if-- 

(-- 
!-- 
string-- 
.-- 
IsNullOrWhiteSpace-- &
(--& '
etiqueta--' /
)--/ 0
)--0 1
html--2 6
.--6 7
Append--7 =
(--= >
Bloque--> D
(--D E
BloqueEtiqueta--E S
,--S T
(--U V
$str--V ]
,--] ^
E--_ `
(--` a
etiqueta--a i
)--i j
)--j k
)--k l
)--l m
;--m n
html.. 
... 
Append.. 
(.. 
Bloque.. 
(.. 
BloqueTitulo.. '
,..' (
(..) *
$str..* 1
,..1 2
E..3 4
(..4 5
titulo..5 ;
)..; <
)..< =
)..= >
)..> ?
;..? @
html// 
.// 
Append// 
(// 
Bloque// 
(// 
BloqueSaludo// '
,//' (
(//) *
$str//* 1
,//1 2
E//3 4
(//4 5
saludo//5 ;
)//; <
)//< =
)//= >
)//> ?
;//? @
foreach00 
(00 
var00 
p00 
in00 
listaParrafos00 '
)00' (
html00) -
.00- .
Append00. 4
(004 5
Bloque005 ;
(00; <
BloqueParrafo00< I
,00I J
(00K L
$str00L S
,00S T

ConFormato00U _
(00_ `
p00` a
)00a b
)00b c
)00c d
)00d e
;00e f
if22 

(22 
filas22 
.22 
Count22 
>22 
$num22 
)22 
{33 	
var44 
contenidoFilas44 
=44  
new44! $
StringBuilder44% 2
(442 3
)443 4
;444 5
for55 
(55 
var55 
i55 
=55 
$num55 
;55 
i55 
<55 
filas55  %
.55% &
Count55& +
;55+ ,
i55- .
++55. 0
)550 1
{66 
if77 
(77 
i77 
>77 
$num77 
)77 
contenidoFilas77 )
.77) *
Append77* 0
(770 1
BloqueSeparadorDato771 D
)77D E
;77E F
contenidoFilas88 
.88 
Append88 %
(88% &
Bloque88& ,
(88, -
BloqueFilaDato88- ;
,88; <
(88= >
$str88> H
,88H I
E88J K
(88K L
filas88L Q
[88Q R
i88R S
]88S T
.88T U
Etiqueta88U ]
)88] ^
)88^ _
,88_ `
(88a b
$str88b i
,88i j
E88k l
(88l m
filas88m r
[88r s
i88s t
]88t u
.88u v
Valor88v {
)88{ |
)88| }
)88} ~
)88~ 
;	88 Ä
}99 
html:: 
.:: 
Append:: 
(:: 
Bloque:: 
(:: 
BloqueDatos:: *
,::* +
(::, -
$str::- 4
,::4 5
contenidoFilas::6 D
.::D E
ToString::E M
(::M N
)::N O
)::O P
)::P Q
)::Q R
;::R S
};; 	
if== 

(== 
!== 
string== 
.== 
IsNullOrWhiteSpace== &
(==& '
codigo==' -
)==- .
)==. /
html==0 4
.==4 5
Append==5 ;
(==; <
Bloque==< B
(==B C
BloqueCodigo==C O
,==O P
(==Q R
$str==R Z
,==Z [
E==\ ]
(==] ^
codigo==^ d
)==d e
)==e f
)==f g
)==g h
;==h i
if?? 

(?? 
hayBoton?? 
)?? 
{@@ 	
htmlAA 
.AA 
AppendAA 
(AA 
BloqueAA 
(AA 
BloqueBotonAA *
,AA* +
(AA, -
$strAA- 2
,AA2 3
EAA4 5
(AA5 6
urlBotonAA6 >
)AA> ?
)AA? @
,AA@ A
(AAB C
$strAAC J
,AAJ K
EAAL M
(AAM N

textoBotonAAN X
)AAX Y
)AAY Z
)AAZ [
)AA[ \
;AA\ ]
htmlBB 
.BB 
AppendBB 
(BB 
BloqueBB 
(BB #
BloqueEnlaceAlternativoBB 6
,BB6 7
(BB8 9
$strBB9 >
,BB> ?
EBB@ A
(BBA B
urlBotonBBB J
)BBJ K
)BBK L
)BBL M
)BBM N
;BBN O
}CC 	
ifEE 

(EE 
!EE 
stringEE 
.EE 
IsNullOrWhiteSpaceEE &
(EE& '
notaEE' +
)EE+ ,
)EE, -
{FF 	
varGG 
(GG 
fondoGG 
,GG 
acentoGG 
,GG 
colorGG  %
)GG% &
=GG' (
tipoNotaGG) 1
switchGG2 8
{HH 
TipoNotaII 
.II 
AvisoII 
=>II !
(II" #
$strII# ,
,II, -
$strII. 7
,II7 8
$strII9 B
)IIB C
,IIC D
TipoNotaJJ 
.JJ 
ExitoJJ 
=>JJ !
(JJ" #
$strJJ# ,
,JJ, -
$strJJ. 7
,JJ7 8
$strJJ9 B
)JJB C
,JJC D
_KK 
=>KK 
(KK 
$strKK 
,KK  
$strKK! *
,KK* +
$strKK, 5
)KK5 6
}LL 
;LL 
htmlMM 
.MM 
AppendMM 
(MM 
BloqueMM 
(MM 

BloqueNotaMM )
,MM) *
(MM+ ,
$strMM, 3
,MM3 4
fondoMM5 :
)MM: ;
,MM; <
(MM= >
$strMM> F
,MMF G
acentoMMH N
)MMN O
,MMO P
(MMQ R
$strMMR Y
,MMY Z
colorMM[ `
)MM` a
,MMa b
(MMc d
$strMMd k
,MMk l

ConFormatoMMm w
(MMw x
notaMMx |
)MM| }
)MM} ~
)MM~ 
)	MM Ä
;
MMÄ Å
}NN 	
varPP 
	documentoPP 
=PP 
BloquePP 
(PP 
DisenoPP %
,PP% &
(QQ 
$strQQ 
,QQ 
FuenteQQ 
)QQ 
,QQ 
(RR 
$strRR 
,RR 
ERR 
(RR 
tituloRR 
)RR  
)RR  !
,RR! "
(SS 
$strSS 
,SS 
ESS 
(SS 
vistaPreviaSS '
)SS' (
)SS( )
,SS) *
(TT 
$strTT 
,TT 
ContentIdLogoTT "
)TT" #
,TT# $
(UU 
$strUU 
,UU 
DateTimeUU 
.UU 
UtcNowUU $
.UU$ %
YearUU% )
.UU) *
ToStringUU* 2
(UU2 3
)UU3 4
)UU4 5
,UU5 6
(VV 
$strVV 
,VV 
htmlVV 
.VV 
ToStringVV '
(VV' (
)VV( )
)VV) *
)VV* +
;VV+ ,
returnXX 
newXX 

CorreoHtmlXX 
(XX 
	documentoYY 
,YY 
ConstruirTextoZZ 
(ZZ 
tituloZZ !
,ZZ! "
saludoZZ# )
,ZZ) *
listaParrafosZZ+ 8
,ZZ8 9
etiquetaZZ: B
,ZZB C
filasZZD I
,ZZI J
codigoZZK Q
,ZZQ R
hayBoton[[ 
?[[ 

textoBoton[[ %
:[[& '
null[[( ,
,[[, -
hayBoton[[. 6
?[[7 8
urlBoton[[9 A
:[[B C
null[[D H
,[[H I
nota[[J N
)[[N O
)[[O P
;[[P Q
}\\ 
public__ 

static__ 

CorreoHtml__ 

DesdeTexto__ '
(__' (
string__( .
asunto__/ 5
,__5 6
string__7 =
texto__> C
)__C D
{`` 
varaa 
parrafosaa 
=aa 
textoaa 
.aa 
Replaceaa $
(aa$ %
$straa% +
,aa+ ,
$straa- 1
)aa1 2
.bb 
Splitbb 
(bb 
$charbb 
,bb 
StringSplitOptionsbb +
.bb+ ,
RemoveEmptyEntriesbb, >
|bb? @
StringSplitOptionsbbA S
.bbS T
TrimEntriesbbT _
)bb_ `
;bb` a
returncc 
Crearcc 
(cc 
titulocc 
:cc 
asuntocc #
,cc# $
saludocc% +
:cc+ ,
$strcc- 4
,cc4 5
parrafoscc6 >
:cc> ?
parrafoscc@ H
)ccH I
;ccI J
}dd 
privatejj 
staticjj 
stringjj 
Ejj 
(jj 
stringjj "
?jj" #
sjj$ %
)jj% &
=>jj' )

WebUtilitykk 
.kk 

HtmlEncodekk 
(kk 
skk 
??kk  "
$strkk# %
)kk% &
.kk& '
Replacekk' .
(kk. /
$strkk/ 2
,kk2 3
$strkk4 <
)kk< =
.kk= >
Replacekk> E
(kkE F
$strkkF I
,kkI J
$strkkK S
)kkS T
;kkT U
privatemm 
staticmm 
stringmm 

ConFormatomm $
(mm$ %
stringmm% +
textomm, 1
)mm1 2
=>mm3 5
Regexnn 
.nn 
Replacenn 
(nn 
Enn 
(nn 
textonn 
)nn 
,nn 
$strnn  0
,nn0 1
$strnn2 p
)nnp q
;nnq r
privatepp 
staticpp 
stringpp 

SinFormatopp $
(pp$ %
stringpp% +
textopp, 1
)pp1 2
=>pp3 5
textopp6 ;
.pp; <
Replacepp< C
(ppC D
$strppD H
,ppH I
$strppJ L
)ppL M
;ppM N
privaterr 
staticrr 
stringrr 
Bloquerr  
(rr  !
stringrr! '
	plantillarr( 1
,rr1 2
paramsrr3 9
(rr: ;
stringrr; A
ClaverrB G
,rrG H
stringrrI O
ValorrrP U
)rrU V
[rrV W
]rrW X
valoresrrY `
)rr` a
{ss 
vartt 
	resultadott 
=tt 
	plantillatt !
;tt! "
foreachuu 
(uu 
varuu 
(uu 
claveuu 
,uu 
valoruu "
)uu" #
inuu$ &
valoresuu' .
)uu. /
	resultadovv 
=vv 
	resultadovv !
.vv! "
Replacevv" )
(vv) *
$strvv* .
+vv/ 0
clavevv1 6
+vv7 8
$strvv9 =
,vv= >
valorvv? D
)vvD E
;vvE F
returnww 
	resultadoww 
;ww 
}xx 
privatezz 
staticzz 
stringzz 
ConstruirTextozz (
(zz( )
stringzz) /
titulozz0 6
,zz6 7
stringzz8 >
saludozz? E
,zzE F
ListzzG K
<zzK L
stringzzL R
>zzR S
parrafoszzT \
,zz\ ]
stringzz^ d
?zzd e
etiquetazzf n
,zzn o
List{{ 
<{{ 
({{ 
string{{ 
Etiqueta{{ 
,{{ 
string{{ %
Valor{{& +
){{+ ,
>{{, -
datos{{. 3
,{{3 4
string{{5 ;
?{{; <
codigo{{= C
,{{C D
string{{E K
?{{K L

textoBoton{{M W
,{{W X
string{{Y _
?{{_ `
urlBoton{{a i
,{{i j
string{{k q
?{{q r
nota{{s w
){{w x
{|| 
var}} 
t}} 
=}} 
new}} 
StringBuilder}} !
(}}! "
)}}" #
;}}# $
t~~ 	
.~~	 


AppendLine~~
 
(~~ 
$str~~ @
)~~@ A
;~~A B
t 	
.	 


AppendLine
 
( 
new 
string 
(  
$char  #
,# $
$num% '
)' (
)( )
.) *

AppendLine* 4
(4 5
)5 6
;6 7
if
ÄÄ 

(
ÄÄ 
!
ÄÄ 
string
ÄÄ 
.
ÄÄ  
IsNullOrWhiteSpace
ÄÄ &
(
ÄÄ& '
etiqueta
ÄÄ' /
)
ÄÄ/ 0
)
ÄÄ0 1
t
ÄÄ2 3
.
ÄÄ3 4

AppendLine
ÄÄ4 >
(
ÄÄ> ?
etiqueta
ÄÄ? G
.
ÄÄG H
ToUpperInvariant
ÄÄH X
(
ÄÄX Y
)
ÄÄY Z
)
ÄÄZ [
;
ÄÄ[ \
t
ÅÅ 	
.
ÅÅ	 


AppendLine
ÅÅ
 
(
ÅÅ 
titulo
ÅÅ 
)
ÅÅ 
.
ÅÅ 

AppendLine
ÅÅ '
(
ÅÅ' (
)
ÅÅ( )
;
ÅÅ) *
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
saludo
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
ÇÇ) *
foreach
ÉÉ 
(
ÉÉ 
var
ÉÉ 
p
ÉÉ 
in
ÉÉ 
parrafos
ÉÉ "
)
ÉÉ" #
t
ÉÉ$ %
.
ÉÉ% &

AppendLine
ÉÉ& 0
(
ÉÉ0 1

SinFormato
ÉÉ1 ;
(
ÉÉ; <
p
ÉÉ< =
)
ÉÉ= >
)
ÉÉ> ?
.
ÉÉ? @

AppendLine
ÉÉ@ J
(
ÉÉJ K
)
ÉÉK L
;
ÉÉL M
foreach
ÖÖ 
(
ÖÖ 
var
ÖÖ 
(
ÖÖ 
e
ÖÖ 
,
ÖÖ 
v
ÖÖ 
)
ÖÖ 
in
ÖÖ 
datos
ÖÖ $
)
ÖÖ$ %
t
ÖÖ& '
.
ÖÖ' (

AppendLine
ÖÖ( 2
(
ÖÖ2 3
$"
ÖÖ3 5
$str
ÖÖ5 9
{
ÖÖ9 :
e
ÖÖ: ;
}
ÖÖ; <
$str
ÖÖ< >
{
ÖÖ> ?
v
ÖÖ? @
}
ÖÖ@ A
"
ÖÖA B
)
ÖÖB C
;
ÖÖC D
if
ÜÜ 

(
ÜÜ 
datos
ÜÜ 
.
ÜÜ 
Count
ÜÜ 
>
ÜÜ 
$num
ÜÜ 
)
ÜÜ 
t
ÜÜ 
.
ÜÜ 

AppendLine
ÜÜ )
(
ÜÜ) *
)
ÜÜ* +
;
ÜÜ+ ,
if
àà 

(
àà 
!
àà 
string
àà 
.
àà  
IsNullOrWhiteSpace
àà &
(
àà& '
codigo
àà' -
)
àà- .
)
àà. /
t
àà0 1
.
àà1 2

AppendLine
àà2 <
(
àà< =
$"
àà= ?
$str
àà? J
{
ààJ K
codigo
ààK Q
}
ààQ R
"
ààR S
)
ààS T
.
ààT U

AppendLine
ààU _
(
àà_ `
)
àà` a
;
ààa b
if
ââ 

(
ââ 

textoBoton
ââ 
is
ââ 
not
ââ 
null
ââ "
&&
ââ# %
urlBoton
ââ& .
is
ââ/ 1
not
ââ2 5
null
ââ6 :
)
ââ: ;
t
ââ< =
.
ââ= >

AppendLine
ââ> H
(
ââH I
$"
ââI K
{
ââK L

textoBoton
ââL V
}
ââV W
$str
ââW Y
{
ââY Z
urlBoton
ââZ b
}
ââb c
"
ââc d
)
ââd e
.
ââe f

AppendLine
ââf p
(
ââp q
)
ââq r
;
ââr s
if
ää 

(
ää 
!
ää 
string
ää 
.
ää  
IsNullOrWhiteSpace
ää &
(
ää& '
nota
ää' +
)
ää+ ,
)
ää, -
t
ää. /
.
ää/ 0

AppendLine
ää0 :
(
ää: ;

SinFormato
ää; E
(
ääE F
nota
ääF J
)
ääJ K
)
ääK L
.
ääL M

AppendLine
ääM W
(
ääW X
)
ääX Y
;
ääY Z
t
åå 	
.
åå	 


AppendLine
åå
 
(
åå 
$str
åå 
)
åå 
;
åå 
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
çç r
)
ççr s
;
ççs t
return
éé 
t
éé 
.
éé 
ToString
éé 
(
éé 
)
éé 
;
éé 
}
èè 
private
îî 
const
îî 
string
îî 
Diseno
îî 
=
îî  !
$str
îÍ" 
;
ÍÍ 
private
ÏÏ 
const
ÏÏ 
string
ÏÏ 
BloqueEtiqueta
ÏÏ '
=
ÏÏ( )
$str
ÏÔ* 
;
ÔÔ 
private
ÒÒ 
const
ÒÒ 
string
ÒÒ 
BloqueTitulo
ÒÒ %
=
ÒÒ& '
$str
ÒÙ( 
;
ÙÙ 
private
ˆˆ 
const
ˆˆ 
string
ˆˆ 
BloqueSaludo
ˆˆ %
=
ˆˆ& '
$str
ˆ˘( 
;
˘˘ 
private
˚˚ 
const
˚˚ 
string
˚˚ 
BloqueParrafo
˚˚ &
=
˚˚' (
$str
˚˛) 
;
˛˛ 
private
ÄÄ 
const
ÄÄ 
string
ÄÄ 
BloqueDatos
ÄÄ $
=
ÄÄ% &
$str
ÄÑ' 
;
ÑÑ 
private
ÜÜ 
const
ÜÜ 
string
ÜÜ 
BloqueFilaDato
ÜÜ '
=
ÜÜ( )
$str
Üå* 
;
åå 
private
éé 
const
éé 
string
éé !
BloqueSeparadorDato
éé ,
=
éé- .
$str
éë/ 
;
ëë 
private
ìì 
const
ìì 
string
ìì 
BloqueCodigo
ìì %
=
ìì& '
$str
ìö( 
;
öö 
private
úú 
const
úú 
string
úú 
BloqueBoton
úú $
=
úú% &
$str
ú≠' 
;
≠≠ 
private
ØØ 
const
ØØ 
string
ØØ %
BloqueEnlaceAlternativo
ØØ 0
=
ØØ1 2
$str
Ø≤3 
;
≤≤ 
private
¥¥ 
const
¥¥ 
string
¥¥ 

BloqueNota
¥¥ #
=
¥¥$ %
$str
¥ª& 
;
ªª 
}ºº …ÿ
_C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\PerfilRepartidorService.cs
public 
	interface $
IPerfilRepartidorService )
{ 
Task 
< 	
PerfilRepartidorDto	 
? 
> 
ObtenerPerfilAsync 1
(1 2
int2 5
	usuarioId6 ?
)? @
;@ A
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
)  !
>! " 
SolicitarCodigoAsync# 7
(7 8
int8 ;
	usuarioId< E
)E F
;F G
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
>! " 
VerificarCodigoAsync# 7
(7 8
int8 ;
	usuarioId< E
,E F
stringG M
codigoN T
)T U
;U V
Task 
< 	
bool	 
> "
EdicionAutorizadaAsync %
(% &
int& )
	usuarioId* 3
)3 4
;4 5
Task 
< 	
EditarRepartidorDto	 
? 
> "
ObtenerParaEditarAsync 5
(5 6
int6 9
	usuarioId: C
)C D
;D E
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
>! "
EditarAsync# .
(. /
int/ 2
	usuarioId3 <
,< =
EditarRepartidorDto> Q
dtoR U
)U V
;V W
Task 
< 	
string	 
? 
> !
MotivoNoEditableAsync '
(' (
int( +
	usuarioId, 5
)5 6
;6 7
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
>! ")
ValidarEliminacionPropiaAsync# @
(@ A
intA D
	usuarioIdE N
)N O
;O P
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
)  !
>! "%
EliminarCuentaPropiaAsync# <
(< =
int= @
	usuarioIdA J
,J K
stringL R
passwordS [
)[ \
;\ ]
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
)  !
>! "-
!ValidarEliminacionPorNegocioAsync# D
(D E
intE H
usuarioNegocioIdI Y
,Y Z
int[ ^
repartidorId_ k
)k l
;l m
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
,  !
string" (
?( )
Nombre* 0
)0 1
>1 2#
EliminarPorNegocioAsync3 J
(J K
intK N
usuarioNegocioIdO _
,_ `
inta d
repartidorIde q
,q r
strings y
password	z Ç
)
Ç É
;
É Ñ
} 
public 
class #
PerfilRepartidorService $
($ %
AppDbContext 
db 
, !
IRepartidorRepository 
repartidores &
,& '
INegocioRepository   
negocios   
,    
IUsuarioRepository!! 
usuarios!! 
,!!  )
ICodigoVerificacionRepository"" !
codigos""" )
,"") *
IPasswordHasher## 
<## 
Usuario## 
>## 
hasher## #
,### $
IEmailService$$ 
email$$ 
,$$ 
ILogger%% 
<%% #
PerfilRepartidorService%% #
>%%# $
logger%%% +
)%%+ ,
:%%- .$
IPerfilRepartidorService%%/ G
{&& 
public'' 

const'' 
string'' "
MensajeSinVerificacion'' .
=''/ 0
$str''1 e
;''e f
public(( 

const(( 
string(( 
MensajeConPedidos(( )
=((* +
$str((, j
;((j k
public)) 

const)) 
string)) 
MensajeSuspendido)) )
=))* +
$str)), h
;))h i
public** 

const** 
string** 
MensajeSinPermisos** *
=**+ ,
$str**- [
;**[ \
private,, 
const,, 
string,, %
MensajeEntregasPendientes,, 2
=,,3 4
$str,,5 {
;,,{ |
private-- 
const-- 
string-- ,
 MensajeEntregasPendientesNegocio-- 9
=--: ;
$str	--< â
;
--â ä
private.. 
const.. 
string.. %
MensajePasswordIncorrecta.. 2
=..3 4
$str..5 L
;..L M
private11 
const11 
int11 
MaxIntentosCodigo11 '
=11( )
$num11* +
;11+ ,
private22 
const22 
int22 
MinutosBloqueo22 $
=22% &
$num22' )
;22) *
private33 
const33 
int33 !
MinutosVigenciaCodigo33 +
=33, -
$num33. 0
;330 1
private44 
const44 
int44 !
MinutosVentanaEdicion44 +
=44, -
$num44. 0
;440 1
private66 
const66 
string66 
MensajeErrorEnvio66 *
=66+ ,
$str66- b
;66b c
private77 
const77 
string77  
MensajeErrorGuardado77 -
=77. /
$str770 n
;77n o
private88 
const88 
string88 !
MensajeCodigoExpirado88 .
=88/ 0
$str881 i
;88i j
public;; 

async;; 
Task;; 
<;; 
PerfilRepartidorDto;; )
?;;) *
>;;* +
ObtenerPerfilAsync;;, >
(;;> ?
int;;? B
	usuarioId;;C L
);;L M
{<< 
var== 
rep== 
=== 
await== 
db== 
.== 
Repartidores== '
.>> 
AsNoTracking>> 
(>> 
)>> 
.?? 
Include?? 
(?? 
r?? 
=>?? 
r?? 
.?? 
Usuario?? #
)??# $
.@@ 
FirstOrDefaultAsync@@  
(@@  !
r@@! "
=>@@# %
r@@& '
.@@' (
	UsuarioId@@( 1
==@@2 4
	usuarioId@@5 >
)@@> ?
;@@? @
ifAA 

(AA 
repAA 
?AA 
.AA 
UsuarioAA 
isAA 
nullAA  
)AA  !
returnAA" (
nullAA) -
;AA- .
varCC 
negocioCC 
=CC 
awaitCC 
negociosCC $
.CC$ %
BuscarPorIdAsyncCC% 5
(CC5 6
repCC6 9
.CC9 :
	NegocioIdCC: C
)CCC D
;CCD E
returnEE 
newEE 
PerfilRepartidorDtoEE &
{FF 	
NombreCompletoGG 
=GG 
repGG  
.GG  !
NombreCompletoGG! /
,GG/ 0
	DocumentoHH 
=HH 
repHH 
.HH 
UsuarioHH #
.HH# $
	DocumentoHH$ -
,HH- .
TelefonoII 
=II 
repII 
.II 
TelefonoII #
,II# $
CorreoJJ 
=JJ 
repJJ 
.JJ 
UsuarioJJ  
.JJ  !
CorreoJJ! '
,JJ' (
VehiculoKK 
=KK 
repKK 
.KK 
VehiculoKK #
,KK# $
PlacaLL 
=LL 
repLL 
.LL 
PlacaLL 
,LL 
NegocioMM 
=MM 
negocioMM 
?MM 
.MM 
NombreMM %
??MM& (
$strMM) +
,MM+ ,
FechaRegistroNN 
=NN 
repNN 
.NN  
FechaRegistroNN  -
,NN- .
EstadoOO 
=OO 
repOO 
.OO 
UsuarioOO  
.OO  !
EstadoOO! '
,OO' (
PedidosPendientesPP 
=PP 
awaitPP  %(
ContarPedidosPendientesAsyncPP& B
(PPB C
repPPC F
.PPF G
IdPPG I
)PPI J
}QQ 	
;QQ	 

}RR 
privateUU 
TaskUU 
<UU 
intUU 
>UU (
ContarPedidosPendientesAsyncUU 2
(UU2 3
intUU3 6
repartidorIdUU7 C
)UUC D
=>UUE G
dbVV 

.VV
 
PedidosVV 
.VV 

CountAsyncVV 
(VV 
pVV 
=>VV  "
pVV# $
.VV$ %
RepartidorIdVV% 1
==VV2 4
repartidorIdVV5 A
&&VVB D
(WW 
pWW 
.WW 
EstadoPedidoIdWW 
==WW  
(WW! "
intWW" %
)WW% &
EstadoPedidoWW& 2
.WW2 3
AsignadoWW3 ;
||WW< >
pWW? @
.WW@ A
EstadoPedidoIdWWA O
==WWP R
(WWS T
intWWT W
)WWW X
EstadoPedidoWWX d
.WWd e
EnCaminoWWe m
)WWm n
)WWn o
;WWo p
publicZZ 

asyncZZ 
TaskZZ 
<ZZ 
stringZZ 
?ZZ 
>ZZ !
MotivoNoEditableAsyncZZ 4
(ZZ4 5
intZZ5 8
	usuarioIdZZ9 B
)ZZB C
{[[ 
var\\ 
rep\\ 
=\\ 
await\\ 
repartidores\\ $
.\\$ %$
ObtenerPorUsuarioIdAsync\\% =
(\\= >
	usuarioId\\> G
)\\G H
;\\H I
var]] 
usuario]] 
=]] 
await]] 
usuarios]] $
.]]$ %
ObtenerPorIdAsync]]% 6
(]]6 7
	usuarioId]]7 @
)]]@ A
;]]A B
if^^ 

(^^ 
rep^^ 
is^^ 
null^^ 
||^^ 
usuario^^ "
is^^# %
null^^& *
)^^* +
return^^, 2
MensajeSinPermisos^^3 E
;^^E F
if`` 

(`` 
usuario`` 
.`` 
Estado`` 
==`` 
EstadoCuenta`` *
.``* +

Suspendido``+ 5
)``5 6
return``7 =
MensajeSuspendido``> O
;``O P
ifaa 

(aa 
awaitaa (
ContarPedidosPendientesAsyncaa .
(aa. /
repaa/ 2
.aa2 3
Idaa3 5
)aa5 6
>aa7 8
$numaa9 :
)aa: ;
returnaa< B
MensajeConPedidosaaC T
;aaT U
returnbb 
nullbb 
;bb 
}cc 
publicee 

asyncee 
Taskee 
<ee 
(ee 
boolee 
Okee 
,ee 
stringee  &
?ee& '
Erroree( -
)ee- .
>ee. / 
SolicitarCodigoAsyncee0 D
(eeD E
inteeE H
	usuarioIdeeI R
)eeR S
{ff 
varhh 
motivohh 
=hh 
awaithh !
MotivoNoEditableAsynchh 0
(hh0 1
	usuarioIdhh1 :
)hh: ;
;hh; <
ifii 

(ii 
motivoii 
isii 
notii 
nullii 
)ii 
returnii  &
(ii' (
falseii( -
,ii- .
motivoii/ 5
)ii5 6
;ii6 7
varkk 
usuariokk 
=kk 
awaitkk 
usuarioskk $
.kk$ %
ObtenerPorIdAsynckk% 6
(kk6 7
	usuarioIdkk7 @
)kk@ A
;kkA B
ifll 

(ll 
usuarioll 
isll 
nullll 
)ll 
returnll #
(ll$ %
falsell% *
,ll* +
MensajeErrorEnvioll, =
)ll= >
;ll> ?
varnn 
ultimonn 
=nn 
awaitnn 
codigosnn "
.nn" #
ObtenerUltimoAsyncnn# 5
(nn5 6
	usuarioIdnn6 ?
)nn? @
;nn@ A
ifoo 

(oo 
ultimooo 
?oo 
.oo 
BloqueadoHastaoo "
isoo# %
{oo& '
}oo( )
hastaoo* /
&&oo0 2
hastaoo3 8
>oo9 :
DateTimeoo; C
.ooC D
UtcNowooD J
)ooJ K
returnpp 
(pp 
falsepp 
,pp 
MensajeBloqueopp )
(pp) *
hastapp* /
)pp/ 0
)pp0 1
;pp1 2
varrr 
codigorr 
=rr !
RandomNumberGeneratorrr *
.rr* +
GetInt32rr+ 3
(rr3 4
$numrr4 :
,rr: ;
$numrr< C
)rrC D
.rrD E
ToStringrrE M
(rrM N
)rrN O
;rrO P
trytt 
{uu 	
awaitvv 
codigosvv 
.vv 
AgregarAsyncvv &
(vv& '
newvv' *
CodigoVerificacionvv+ =
{ww 
	UsuarioIdxx 
=xx 
	usuarioIdxx %
,xx% &

CodigoHashyy 
=yy 
	TokenUtilyy &
.yy& '
Hashyy' +
(yy+ ,
codigoyy, 2
)yy2 3
,yy3 4
Expirazz 
=zz 
DateTimezz !
.zz! "
UtcNowzz" (
.zz( )

AddMinuteszz) 3
(zz3 4!
MinutosVigenciaCodigozz4 I
)zzI J
}{{ 
){{ 
;{{ 
await}} 
email}} 
.}} 
EnviarAsync}} #
(}}# $
usuario}}$ +
.}}+ ,
Correo}}, 2
,}}2 3
$str}}4 Y
,}}Y Z
PlantillaCorreo}}[ j
.}}j k
Crear}}k p
(}}p q
etiqueta~~ 
:~~ 
$str~~ 5
,~~5 6
titulo 
: 
$str .
,. /
saludo
ÄÄ 
:
ÄÄ 
$str
ÄÄ 
,
ÄÄ  
parrafos
ÅÅ 
:
ÅÅ 
[
ÅÅ 
$str
ÅÅ f
]
ÅÅf g
,
ÅÅg h
codigo
ÇÇ 
:
ÇÇ 
codigo
ÇÇ 
,
ÇÇ 
nota
ÉÉ 
:
ÉÉ 
$"
ÉÉ 
$str
ÉÉ 0
{
ÉÉ0 1#
MinutosVigenciaCodigo
ÉÉ1 F
}
ÉÉF G
$strÉÉG ¢
"ÉÉ¢ £
,ÉÉ£ §
tipoNota
ÑÑ 
:
ÑÑ 
TipoNota
ÑÑ "
.
ÑÑ" #
Aviso
ÑÑ# (
,
ÑÑ( )
resumen
ÖÖ 
:
ÖÖ 
$"
ÖÖ 
$str
ÖÖ 8
{
ÖÖ8 9
codigo
ÖÖ9 ?
}
ÖÖ? @
$str
ÖÖ@ K
{
ÖÖK L#
MinutosVigenciaCodigo
ÖÖL a
}
ÖÖa b
$str
ÖÖb k
"
ÖÖk l
)
ÖÖl m
)
ÖÖm n
;
ÖÖn o
return
ÜÜ 
(
ÜÜ 
true
ÜÜ 
,
ÜÜ 
null
ÜÜ 
)
ÜÜ 
;
ÜÜ  
}
áá 	
catch
àà 
(
àà 
	Exception
àà 
ex
àà 
)
àà 
{
ââ 	
logger
ää 
.
ää 
LogError
ää 
(
ää 
ex
ää 
,
ää 
$str
ää  q
,
ääq r
	usuarioId
ääs |
)
ää| }
;
ää} ~
return
ãã 
(
ãã 
false
ãã 
,
ãã 
MensajeErrorEnvio
ãã ,
)
ãã, -
;
ãã- .
}
åå 	
}
çç 
public
èè 

async
èè 
Task
èè 
<
èè 
(
èè 
bool
èè 
Ok
èè 
,
èè 
string
èè  &
?
èè& '
Error
èè( -
)
èè- .
>
èè. /"
VerificarCodigoAsync
èè0 D
(
èèD E
int
èèE H
	usuarioId
èèI R
,
èèR S
string
èèT Z
codigo
èè[ a
)
èèa b
{
êê 
var
ëë 
actual
ëë 
=
ëë 
await
ëë 
codigos
ëë "
.
ëë" # 
ObtenerUltimoAsync
ëë# 5
(
ëë5 6
	usuarioId
ëë6 ?
)
ëë? @
;
ëë@ A
var
íí 
ahora
íí 
=
íí 
DateTime
íí 
.
íí 
UtcNow
íí #
;
íí# $
if
îî 

(
îî 
actual
îî 
is
îî 
null
îî 
)
îî 
return
îî "
(
îî# $
false
îî$ )
,
îî) *#
MensajeCodigoExpirado
îî+ @
)
îî@ A
;
îîA B
if
ññ 

(
ññ 
actual
ññ 
.
ññ 
BloqueadoHasta
ññ !
is
ññ" $
{
ññ% &
}
ññ' (
hasta
ññ) .
&&
ññ/ 1
hasta
ññ2 7
>
ññ8 9
ahora
ññ: ?
)
ññ? @
return
óó 
(
óó 
false
óó 
,
óó 
MensajeBloqueo
óó )
(
óó) *
hasta
óó* /
)
óó/ 0
)
óó0 1
;
óó1 2
if
ôô 

(
ôô 
actual
ôô 
.
ôô 

Verificado
ôô 
||
ôô  
actual
ôô! '
.
ôô' (
Usado
ôô( -
||
ôô. 0
actual
ôô1 7
.
ôô7 8
Expira
ôô8 >
<=
ôô? A
ahora
ôôB G
)
ôôG H
return
öö 
(
öö 
false
öö 
,
öö #
MensajeCodigoExpirado
öö 0
)
öö0 1
;
öö1 2
if
úú 

(
úú 
actual
úú 
.
úú 

CodigoHash
úú 
!=
úú  
	TokenUtil
úú! *
.
úú* +
Hash
úú+ /
(
úú/ 0
codigo
úú0 6
.
úú6 7
Trim
úú7 ;
(
úú; <
)
úú< =
)
úú= >
)
úú> ?
{
ùù 	
actual
ûû 
.
ûû 
Intentos
ûû 
++
ûû 
;
ûû 
var
üü 
error
üü 
=
üü 
$str
üü ?
;
üü? @
if
°° 
(
°° 
actual
°° 
.
°° 
Intentos
°° 
>=
°°  "
MaxIntentosCodigo
°°# 4
)
°°4 5
{
¢¢ 
actual
££ 
.
££ 
BloqueadoHasta
££ %
=
££& '
ahora
££( -
.
££- .

AddMinutes
££. 8
(
££8 9
MinutosBloqueo
££9 G
)
££G H
;
££H I
error
§§ 
=
§§ 
$"
§§ 
$str
§§ $
{
§§$ %
MaxIntentosCodigo
§§% 6
}
§§6 7
$str
§§7 {
{
§§{ |
MinutosBloqueo§§| ä
}§§ä ã
$str§§ã î
"§§î ï
;§§ï ñ
}
•• 
await
ßß 
codigos
ßß 
.
ßß 
ActualizarAsync
ßß )
(
ßß) *
actual
ßß* 0
)
ßß0 1
;
ßß1 2
return
®® 
(
®® 
false
®® 
,
®® 
error
®®  
)
®®  !
;
®®! "
}
©© 	
actual
´´ 
.
´´ 

Verificado
´´ 
=
´´ 
true
´´  
;
´´  !
actual
¨¨ 
.
¨¨ 
Expira
¨¨ 
=
¨¨ 
ahora
¨¨ 
.
¨¨ 

AddMinutes
¨¨ (
(
¨¨( )#
MinutosVentanaEdicion
¨¨) >
)
¨¨> ?
;
¨¨? @
await
≠≠ 
codigos
≠≠ 
.
≠≠ 
ActualizarAsync
≠≠ %
(
≠≠% &
actual
≠≠& ,
)
≠≠, -
;
≠≠- .
return
ÆÆ 
(
ÆÆ 
true
ÆÆ 
,
ÆÆ 
null
ÆÆ 
)
ÆÆ 
;
ÆÆ 
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
±± 
bool
±± 
>
±± $
EdicionAutorizadaAsync
±± 2
(
±±2 3
int
±±3 6
	usuarioId
±±7 @
)
±±@ A
{
≤≤ 
var
≥≥ 
c
≥≥ 
=
≥≥ 
await
≥≥ 
codigos
≥≥ 
.
≥≥  
ObtenerUltimoAsync
≥≥ 0
(
≥≥0 1
	usuarioId
≥≥1 :
)
≥≥: ;
;
≥≥; <
return
¥¥ 
c
¥¥ 
is
¥¥ 
{
¥¥ 

Verificado
¥¥  
:
¥¥  !
true
¥¥" &
,
¥¥& '
Usado
¥¥( -
:
¥¥- .
false
¥¥/ 4
}
¥¥5 6
&&
¥¥7 9
c
¥¥: ;
.
¥¥; <
Expira
¥¥< B
>
¥¥C D
DateTime
¥¥E M
.
¥¥M N
UtcNow
¥¥N T
;
¥¥T U
}
µµ 
public
∑∑ 

async
∑∑ 
Task
∑∑ 
<
∑∑ !
EditarRepartidorDto
∑∑ )
?
∑∑) *
>
∑∑* +$
ObtenerParaEditarAsync
∑∑, B
(
∑∑B C
int
∑∑C F
	usuarioId
∑∑G P
)
∑∑P Q
{
∏∏ 
var
ππ 
rep
ππ 
=
ππ 
await
ππ 
db
ππ 
.
ππ 
Repartidores
ππ '
.
∫∫ 
AsNoTracking
∫∫ 
(
∫∫ 
)
∫∫ 
.
ªª 
Include
ªª 
(
ªª 
r
ªª 
=>
ªª 
r
ªª 
.
ªª 
Usuario
ªª #
)
ªª# $
.
ºº !
FirstOrDefaultAsync
ºº  
(
ºº  !
r
ºº! "
=>
ºº# %
r
ºº& '
.
ºº' (
	UsuarioId
ºº( 1
==
ºº2 4
	usuarioId
ºº5 >
)
ºº> ?
;
ºº? @
if
ΩΩ 

(
ΩΩ 
rep
ΩΩ 
?
ΩΩ 
.
ΩΩ 
Usuario
ΩΩ 
is
ΩΩ 
null
ΩΩ  
)
ΩΩ  !
return
ΩΩ" (
null
ΩΩ) -
;
ΩΩ- .
return
øø 
new
øø !
EditarRepartidorDto
øø &
{
¿¿ 	
NombreCompleto
¡¡ 
=
¡¡ 
rep
¡¡  
.
¡¡  !
NombreCompleto
¡¡! /
,
¡¡/ 0
Telefono
¬¬ 
=
¬¬ 
rep
¬¬ 
.
¬¬ 
Telefono
¬¬ #
,
¬¬# $
Correo
√√ 
=
√√ 
rep
√√ 
.
√√ 
Usuario
√√  
.
√√  !
Correo
√√! '
,
√√' (
Vehiculo
ƒƒ 
=
ƒƒ 
rep
ƒƒ 
.
ƒƒ 
Vehiculo
ƒƒ #
,
ƒƒ# $
Placa
≈≈ 
=
≈≈ 
rep
≈≈ 
.
≈≈ 
Placa
≈≈ 
}
∆∆ 	
;
∆∆	 

}
«« 
public
…… 

async
…… 
Task
…… 
<
…… 
(
…… 
bool
…… 
Ok
…… 
,
…… 
string
……  &
?
……& '
Error
……( -
)
……- .
>
……. /
EditarAsync
……0 ;
(
……; <
int
……< ?
	usuarioId
……@ I
,
……I J!
EditarRepartidorDto
……K ^
dto
……_ b
)
……b c
{
   
if
ÀÀ 

(
ÀÀ 
!
ÀÀ 
await
ÀÀ $
EdicionAutorizadaAsync
ÀÀ )
(
ÀÀ) *
	usuarioId
ÀÀ* 3
)
ÀÀ3 4
)
ÀÀ4 5
return
ÀÀ6 <
(
ÀÀ= >
false
ÀÀ> C
,
ÀÀC D$
MensajeSinVerificacion
ÀÀE [
)
ÀÀ[ \
;
ÀÀ\ ]
var
ŒŒ 
motivo
ŒŒ 
=
ŒŒ 
await
ŒŒ #
MotivoNoEditableAsync
ŒŒ 0
(
ŒŒ0 1
	usuarioId
ŒŒ1 :
)
ŒŒ: ;
;
ŒŒ; <
if
œœ 

(
œœ 
motivo
œœ 
is
œœ 
not
œœ 
null
œœ 
)
œœ 
return
œœ  &
(
œœ' (
false
œœ( -
,
œœ- .
motivo
œœ/ 5
)
œœ5 6
;
œœ6 7
try
—— 
{
““ 	
var
”” 
rep
”” 
=
”” 
await
”” 
db
”” 
.
”” 
Repartidores
”” +
.
‘‘ 
Include
‘‘ 
(
‘‘ 
r
‘‘ 
=>
‘‘ 
r
‘‘ 
.
‘‘  
Usuario
‘‘  '
)
‘‘' (
.
’’ !
FirstOrDefaultAsync
’’ $
(
’’$ %
r
’’% &
=>
’’' )
r
’’* +
.
’’+ ,
	UsuarioId
’’, 5
==
’’6 8
	usuarioId
’’9 B
)
’’B C
;
’’C D
if
÷÷ 
(
÷÷ 
rep
÷÷ 
?
÷÷ 
.
÷÷ 
Usuario
÷÷ 
is
÷÷ 
null
÷÷  $
)
÷÷$ %
return
÷÷& ,
(
÷÷- .
false
÷÷. 3
,
÷÷3 4"
MensajeErrorGuardado
÷÷5 I
)
÷÷I J
;
÷÷J K
var
ÿÿ 
correo
ÿÿ 
=
ÿÿ 
dto
ÿÿ 
.
ÿÿ 
Correo
ÿÿ #
.
ÿÿ# $
Trim
ÿÿ$ (
(
ÿÿ( )
)
ÿÿ) *
;
ÿÿ* +
var
ŸŸ 
telefono
ŸŸ 
=
ŸŸ 
dto
ŸŸ 
.
ŸŸ 
Telefono
ŸŸ '
.
ŸŸ' (
Trim
ŸŸ( ,
(
ŸŸ, -
)
ŸŸ- .
;
ŸŸ. /
var
€€ 
otroConCorreo
€€ 
=
€€ 
await
€€  %
db
€€& (
.
€€( )
Usuarios
€€) 1
.
€€1 2
AnyAsync
€€2 :
(
€€: ;
u
€€; <
=>
€€= ?
u
€€@ A
.
€€A B
Correo
€€B H
==
€€I K
correo
€€L R
&&
€€S U
u
€€V W
.
€€W X
Id
€€X Z
!=
€€[ ]
	usuarioId
€€^ g
)
€€g h
;
€€h i
if
‹‹ 
(
‹‹ 
otroConCorreo
‹‹ 
)
‹‹ 
return
›› 
(
›› 
false
›› 
,
›› 
$str
›› L
)
››L M
;
››M N
var
ﬂﬂ 
telefonoEnUso
ﬂﬂ 
=
ﬂﬂ 
await
‡‡ 
db
‡‡ 
.
‡‡ 
Negocios
‡‡ !
.
‡‡! "
AnyAsync
‡‡" *
(
‡‡* +
n
‡‡+ ,
=>
‡‡- /
n
‡‡0 1
.
‡‡1 2
Telefono
‡‡2 :
==
‡‡; =
telefono
‡‡> F
)
‡‡F G
||
‡‡H J
await
·· 
db
·· 
.
·· 
Repartidores
·· %
.
··% &
AnyAsync
··& .
(
··. /
r
··/ 0
=>
··1 3
r
··4 5
.
··5 6
Telefono
··6 >
==
··? A
telefono
··B J
&&
··K M
r
··N O
.
··O P
Id
··P R
!=
··S U
rep
··V Y
.
··Y Z
Id
··Z \
&&
‚‚ 
r
‚‚ 
.
‚‚ 
Usuario
‚‚  
!
‚‚  !
.
‚‚! "
Estado
‚‚" (
!=
‚‚) +
EstadoCuenta
‚‚, 8
.
‚‚8 9
	Eliminado
‚‚9 B
)
‚‚B C
||
‚‚D F
await
„„ 
db
„„ 
.
„„ 
Administradores
„„ (
.
„„( )
AnyAsync
„„) 1
(
„„1 2
a
„„2 3
=>
„„4 6
a
„„7 8
.
„„8 9
Telefono
„„9 A
==
„„B D
telefono
„„E M
)
„„M N
;
„„N O
if
‰‰ 
(
‰‰ 
telefonoEnUso
‰‰ 
)
‰‰ 
return
ÂÂ 
(
ÂÂ 
false
ÂÂ 
,
ÂÂ 
$str
ÂÂ N
)
ÂÂN O
;
ÂÂO P
var
ÁÁ 
conPlaca
ÁÁ 
=
ÁÁ 
dto
ÁÁ 
.
ÁÁ 
Vehiculo
ÁÁ '
is
ÁÁ( *
TipoVehiculo
ÁÁ+ 7
.
ÁÁ7 8
Moto
ÁÁ8 <
or
ÁÁ= ?
TipoVehiculo
ÁÁ@ L
.
ÁÁL M
Carro
ÁÁM R
;
ÁÁR S
rep
ÈÈ 
.
ÈÈ 
NombreCompleto
ÈÈ 
=
ÈÈ  
dto
ÈÈ! $
.
ÈÈ$ %
NombreCompleto
ÈÈ% 3
.
ÈÈ3 4
Trim
ÈÈ4 8
(
ÈÈ8 9
)
ÈÈ9 :
;
ÈÈ: ;
rep
ÍÍ 
.
ÍÍ 
Telefono
ÍÍ 
=
ÍÍ 
telefono
ÍÍ #
;
ÍÍ# $
rep
ÎÎ 
.
ÎÎ 
Vehiculo
ÎÎ 
=
ÎÎ 
dto
ÎÎ 
.
ÎÎ 
Vehiculo
ÎÎ '
!
ÎÎ' (
.
ÎÎ( )
Value
ÎÎ) .
;
ÎÎ. /
rep
ÏÏ 
.
ÏÏ 
Placa
ÏÏ 
=
ÏÏ 
conPlaca
ÏÏ  
?
ÏÏ! "
ReglasValidacion
ÏÏ# 3
.
ÏÏ3 4
NormalizarPlaca
ÏÏ4 C
(
ÏÏC D
dto
ÏÏD G
.
ÏÏG H
Placa
ÏÏH M
)
ÏÏM N
:
ÏÏO P
null
ÏÏQ U
;
ÏÏU V
rep
ÌÌ 
.
ÌÌ 
Usuario
ÌÌ 
.
ÌÌ 
Correo
ÌÌ 
=
ÌÌ  
correo
ÌÌ! '
;
ÌÌ' (
var
 
codigo
 
=
 
await
 
codigos
 &
.
& ' 
ObtenerUltimoAsync
' 9
(
9 :
	usuarioId
: C
)
C D
;
D E
if
ÒÒ 
(
ÒÒ 
codigo
ÒÒ 
is
ÒÒ 
not
ÒÒ 
null
ÒÒ "
)
ÒÒ" #
codigo
ÒÒ$ *
.
ÒÒ* +
Usado
ÒÒ+ 0
=
ÒÒ1 2
true
ÒÒ3 7
;
ÒÒ7 8
await
ÛÛ 
db
ÛÛ 
.
ÛÛ 
SaveChangesAsync
ÛÛ %
(
ÛÛ% &
)
ÛÛ& '
;
ÛÛ' (
return
ÙÙ 
(
ÙÙ 
true
ÙÙ 
,
ÙÙ 
null
ÙÙ 
)
ÙÙ 
;
ÙÙ  
}
ıı 	
catch
ˆˆ 
(
ˆˆ 
	Exception
ˆˆ 
ex
ˆˆ 
)
ˆˆ 
{
˜˜ 	
logger
¯¯ 
.
¯¯ 
LogError
¯¯ 
(
¯¯ 
ex
¯¯ 
,
¯¯ 
$str
¯¯  d
,
¯¯d e
	usuarioId
¯¯f o
)
¯¯o p
;
¯¯p q
return
˘˘ 
(
˘˘ 
false
˘˘ 
,
˘˘ "
MensajeErrorGuardado
˘˘ /
)
˘˘/ 0
;
˘˘0 1
}
˙˙ 	
}
˚˚ 
public
ˇˇ 

async
ˇˇ 
Task
ˇˇ 
<
ˇˇ 
(
ˇˇ 
bool
ˇˇ 
Ok
ˇˇ 
,
ˇˇ 
string
ˇˇ  &
?
ˇˇ& '
Error
ˇˇ( -
)
ˇˇ- .
>
ˇˇ. /+
ValidarEliminacionPropiaAsync
ˇˇ0 M
(
ˇˇM N
int
ˇˇN Q
	usuarioId
ˇˇR [
)
ˇˇ[ \
{
ÄÄ 
var
ÅÅ 
rep
ÅÅ 
=
ÅÅ 
await
ÅÅ 
repartidores
ÅÅ $
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
ÇÇ 
rep
ÇÇ 
is
ÇÇ 
null
ÇÇ 
)
ÇÇ 
return
ÇÇ 
(
ÇÇ  !
false
ÇÇ! &
,
ÇÇ& ' 
MensajeSinPermisos
ÇÇ( :
)
ÇÇ: ;
;
ÇÇ; <
if
ÑÑ 

(
ÑÑ 
await
ÑÑ *
ContarPedidosPendientesAsync
ÑÑ .
(
ÑÑ. /
rep
ÑÑ/ 2
.
ÑÑ2 3
Id
ÑÑ3 5
)
ÑÑ5 6
>
ÑÑ7 8
$num
ÑÑ9 :
)
ÑÑ: ;
return
ÖÖ 
(
ÖÖ 
false
ÖÖ 
,
ÖÖ '
MensajeEntregasPendientes
ÖÖ 4
)
ÖÖ4 5
;
ÖÖ5 6
return
áá 
(
áá 
true
áá 
,
áá 
null
áá 
)
áá 
;
áá 
}
àà 
public
ãã 

async
ãã 
Task
ãã 
<
ãã 
(
ãã 
bool
ãã 
Ok
ãã 
,
ãã 
string
ãã  &
?
ãã& '
Error
ãã( -
)
ãã- .
>
ãã. /'
EliminarCuentaPropiaAsync
ãã0 I
(
ããI J
int
ããJ M
	usuarioId
ããN W
,
ããW X
string
ããY _
password
ãã` h
)
ããh i
{
åå 
var
éé 
(
éé 
ok
éé 
,
éé 
error
éé 
)
éé 
=
éé 
await
éé +
ValidarEliminacionPropiaAsync
éé  =
(
éé= >
	usuarioId
éé> G
)
ééG H
;
ééH I
if
èè 

(
èè 
!
èè 
ok
èè 
)
èè 
return
èè 
(
èè 
false
èè 
,
èè 
error
èè  %
)
èè% &
;
èè& '
var
ëë 
usuario
ëë 
=
ëë 
await
ëë 
usuarios
ëë $
.
ëë$ %
ObtenerPorIdAsync
ëë% 6
(
ëë6 7
	usuarioId
ëë7 @
)
ëë@ A
;
ëëA B
if
íí 

(
íí 
usuario
íí 
is
íí 
null
íí 
)
íí 
return
íí #
(
íí$ %
false
íí% *
,
íí* + 
MensajeSinPermisos
íí, >
)
íí> ?
;
íí? @
if
îî 

(
îî 
!
îî 
PasswordCorrecta
îî 
(
îî 
usuario
îî %
,
îî% &
password
îî' /
)
îî/ 0
)
îî0 1
return
ïï 
(
ïï 
false
ïï 
,
ïï '
MensajePasswordIncorrecta
ïï 4
)
ïï4 5
;
ïï5 6
return
óó 
await
óó 
DarDeBajaAsync
óó #
(
óó# $
usuario
óó$ +
)
óó+ ,
;
óó, -
}
òò 
public
õõ 

async
õõ 
Task
õõ 
<
õõ 
(
õõ 
bool
õõ 
Ok
õõ 
,
õõ 
string
õõ  &
?
õõ& '
Error
õõ( -
)
õõ- .
>
õõ. //
!ValidarEliminacionPorNegocioAsync
õõ0 Q
(
õõQ R
int
õõR U
usuarioNegocioId
õõV f
,
õõf g
int
õõh k
repartidorId
õõl x
)
õõx y
{
úú 
var
ùù 
rep
ùù 
=
ùù 
await
ùù '
RepartidorDelNegocioAsync
ùù 1
(
ùù1 2
usuarioNegocioId
ùù2 B
,
ùùB C
repartidorId
ùùD P
)
ùùP Q
;
ùùQ R
if
ûû 

(
ûû 
rep
ûû 
is
ûû 
null
ûû 
)
ûû 
return
ûû 
(
ûû  !
false
ûû! &
,
ûû& ' 
MensajeSinPermisos
ûû( :
)
ûû: ;
;
ûû; <
if
†† 

(
†† 
await
†† *
ContarPedidosPendientesAsync
†† .
(
††. /
rep
††/ 2
.
††2 3
Id
††3 5
)
††5 6
>
††7 8
$num
††9 :
)
††: ;
return
°° 
(
°° 
false
°° 
,
°° .
 MensajeEntregasPendientesNegocio
°° ;
)
°°; <
;
°°< =
return
££ 
(
££ 
true
££ 
,
££ 
null
££ 
)
££ 
;
££ 
}
§§ 
public
ßß 

async
ßß 
Task
ßß 
<
ßß 
(
ßß 
bool
ßß 
Ok
ßß 
,
ßß 
string
ßß  &
?
ßß& '
Error
ßß( -
,
ßß- .
string
ßß/ 5
?
ßß5 6
Nombre
ßß7 =
)
ßß= >
>
ßß> ?%
EliminarPorNegocioAsync
ßß@ W
(
ßßW X
int
ßßX [
usuarioNegocioId
ßß\ l
,
ßßl m
int
ßßn q
repartidorId
ßßr ~
,
ßß~ 
stringßßÄ Ü
passwordßßá è
)ßßè ê
{
®® 
var
©© 
(
©© 
ok
©© 
,
©© 
error
©© 
)
©© 
=
©© 
await
©© /
!ValidarEliminacionPorNegocioAsync
©©  A
(
©©A B
usuarioNegocioId
©©B R
,
©©R S
repartidorId
©©T `
)
©©` a
;
©©a b
if
™™ 

(
™™ 
!
™™ 
ok
™™ 
)
™™ 
return
™™ 
(
™™ 
false
™™ 
,
™™ 
error
™™  %
,
™™% &
null
™™' +
)
™™+ ,
;
™™, -
var
¨¨ 
usuarioNegocio
¨¨ 
=
¨¨ 
await
¨¨ "
usuarios
¨¨# +
.
¨¨+ ,
ObtenerPorIdAsync
¨¨, =
(
¨¨= >
usuarioNegocioId
¨¨> N
)
¨¨N O
;
¨¨O P
if
≠≠ 

(
≠≠ 
usuarioNegocio
≠≠ 
is
≠≠ 
null
≠≠ "
)
≠≠" #
return
≠≠$ *
(
≠≠+ ,
false
≠≠, 1
,
≠≠1 2 
MensajeSinPermisos
≠≠3 E
,
≠≠E F
null
≠≠G K
)
≠≠K L
;
≠≠L M
if
ØØ 

(
ØØ 
!
ØØ 
PasswordCorrecta
ØØ 
(
ØØ 
usuarioNegocio
ØØ ,
,
ØØ, -
password
ØØ. 6
)
ØØ6 7
)
ØØ7 8
return
∞∞ 
(
∞∞ 
false
∞∞ 
,
∞∞ '
MensajePasswordIncorrecta
∞∞ 4
,
∞∞4 5
null
∞∞6 :
)
∞∞: ;
;
∞∞; <
var
≤≤ 
rep
≤≤ 
=
≤≤ 
await
≤≤ '
RepartidorDelNegocioAsync
≤≤ 1
(
≤≤1 2
usuarioNegocioId
≤≤2 B
,
≤≤B C
repartidorId
≤≤D P
)
≤≤P Q
;
≤≤Q R
if
≥≥ 

(
≥≥ 
rep
≥≥ 
?
≥≥ 
.
≥≥ 
Usuario
≥≥ 
is
≥≥ 
null
≥≥  
)
≥≥  !
return
≥≥" (
(
≥≥) *
false
≥≥* /
,
≥≥/ 0 
MensajeSinPermisos
≥≥1 C
,
≥≥C D
null
≥≥E I
)
≥≥I J
;
≥≥J K
var
µµ 
(
µµ 
	eliminado
µµ 
,
µµ 
	errorBaja
µµ !
)
µµ! "
=
µµ# $
await
µµ% *
DarDeBajaAsync
µµ+ 9
(
µµ9 :
rep
µµ: =
.
µµ= >
Usuario
µµ> E
)
µµE F
;
µµF G
return
∂∂ 
(
∂∂ 
	eliminado
∂∂ 
,
∂∂ 
	errorBaja
∂∂ $
,
∂∂$ %
rep
∂∂& )
.
∂∂) *
NombreCompleto
∂∂* 8
)
∂∂8 9
;
∂∂9 :
}
∑∑ 
private
ππ 
async
ππ 
Task
ππ 
<
ππ 

Repartidor
ππ !
?
ππ! "
>
ππ" #'
RepartidorDelNegocioAsync
ππ$ =
(
ππ= >
int
ππ> A
usuarioNegocioId
ππB R
,
ππR S
int
ππT W
repartidorId
ππX d
)
ππd e
{
∫∫ 
var
ªª 
negocio
ªª 
=
ªª 
await
ªª 
negocios
ªª $
.
ªª$ %&
ObtenerPorUsuarioIdAsync
ªª% =
(
ªª= >
usuarioNegocioId
ªª> N
)
ªªN O
;
ªªO P
if
ºº 

(
ºº 
negocio
ºº 
is
ºº 
null
ºº 
)
ºº 
return
ºº #
null
ºº$ (
;
ºº( )
var
ææ 
rep
ææ 
=
ææ 
await
ææ 
repartidores
ææ $
.
ææ$ %#
ObtenerDeNegocioAsync
ææ% :
(
ææ: ;
negocio
ææ; B
.
ææB C
Id
ææC E
,
ææE F
repartidorId
ææG S
)
ææS T
;
ææT U
return
øø 
rep
øø 
?
øø 
.
øø 
Usuario
øø 
is
øø 
null
øø #
||
øø$ &
rep
øø' *
.
øø* +
Usuario
øø+ 2
.
øø2 3
Estado
øø3 9
==
øø: <
EstadoCuenta
øø= I
.
øøI J
	Eliminado
øøJ S
?
øøT U
null
øøV Z
:
øø[ \
rep
øø] `
;
øø` a
}
¿¿ 
private
≈≈ 
async
≈≈ 
Task
≈≈ 
<
≈≈ 
(
≈≈ 
bool
≈≈ 
Ok
≈≈ 
,
≈≈  
string
≈≈! '
?
≈≈' (
Error
≈≈) .
)
≈≈. /
>
≈≈/ 0
DarDeBajaAsync
≈≈1 ?
(
≈≈? @
Usuario
≈≈@ G
usuario
≈≈H O
)
≈≈O P
{
∆∆ 
try
«« 
{
»» 	
usuario
…… 
.
…… 
Estado
…… 
=
…… 
EstadoCuenta
…… )
.
……) *
	Eliminado
……* 3
;
……3 4
usuario
ÀÀ 
.
ÀÀ $
LiberarIdentificadores
ÀÀ *
(
ÀÀ* +
)
ÀÀ+ ,
;
ÀÀ, -
await
ÃÃ 
usuarios
ÃÃ 
.
ÃÃ 
ActualizarAsync
ÃÃ *
(
ÃÃ* +
usuario
ÃÃ+ 2
)
ÃÃ2 3
;
ÃÃ3 4
return
ÕÕ 
(
ÕÕ 
true
ÕÕ 
,
ÕÕ 
null
ÕÕ 
)
ÕÕ 
;
ÕÕ  
}
ŒŒ 	
catch
œœ 
(
œœ 
	Exception
œœ 
ex
œœ 
)
œœ 
{
–– 	
logger
—— 
.
—— 
LogError
—— 
(
—— 
ex
—— 
,
—— 
$str
——  b
,
——b c
usuario
——d k
.
——k l
Id
——l n
)
——n o
;
——o p
return
““ 
(
““ 
false
““ 
,
““ 
$str
““ R
)
““R S
;
““S T
}
”” 	
}
‘‘ 
private
÷÷ 
bool
÷÷ 
PasswordCorrecta
÷÷ !
(
÷÷! "
Usuario
÷÷" )
usuario
÷÷* 1
,
÷÷1 2
string
÷÷3 9
password
÷÷: B
)
÷÷B C
{
◊◊ 
if
ÿÿ 

(
ÿÿ 
string
ÿÿ 
.
ÿÿ 
IsNullOrEmpty
ÿÿ  
(
ÿÿ  !
usuario
ÿÿ! (
.
ÿÿ( )
PasswordHash
ÿÿ) 5
)
ÿÿ5 6
||
ÿÿ7 9
string
ÿÿ: @
.
ÿÿ@ A
IsNullOrEmpty
ÿÿA N
(
ÿÿN O
password
ÿÿO W
)
ÿÿW X
)
ÿÿX Y
return
ÿÿZ `
false
ÿÿa f
;
ÿÿf g
try
ŸŸ 
{
⁄⁄ 	
return
€€ 
hasher
€€ 
.
€€ "
VerifyHashedPassword
€€ .
(
€€. /
usuario
€€/ 6
,
€€6 7
usuario
€€8 ?
.
€€? @
PasswordHash
€€@ L
,
€€L M
password
€€N V
)
€€V W
!=
€€X Z(
PasswordVerificationResult
€€[ u
.
€€u v
Failed
€€v |
;
€€| }
}
‹‹ 	
catch
›› 
(
›› 
FormatException
›› 
)
›› 
{
ﬁﬁ 	
return
ﬂﬂ 
false
ﬂﬂ 
;
ﬂﬂ 
}
‡‡ 	
}
·· 
private
„„ 
static
„„ 
string
„„ 
MensajeBloqueo
„„ (
(
„„( )
DateTime
„„) 1
hasta
„„2 7
)
„„7 8
{
‰‰ 
var
ÂÂ 
minutos
ÂÂ 
=
ÂÂ 
Math
ÂÂ 
.
ÂÂ 
Max
ÂÂ 
(
ÂÂ 
$num
ÂÂ  
,
ÂÂ  !
(
ÂÂ" #
int
ÂÂ# &
)
ÂÂ& '
Math
ÂÂ' +
.
ÂÂ+ ,
Ceiling
ÂÂ, 3
(
ÂÂ3 4
(
ÂÂ4 5
hasta
ÂÂ5 :
-
ÂÂ; <
DateTime
ÂÂ= E
.
ÂÂE F
UtcNow
ÂÂF L
)
ÂÂL M
.
ÂÂM N
TotalMinutes
ÂÂN Z
)
ÂÂZ [
)
ÂÂ[ \
;
ÂÂ\ ]
return
ÊÊ 
$"
ÊÊ 
$str
ÊÊ c
{
ÊÊc d
minutos
ÊÊd k
}
ÊÊk l
$str
ÊÊl w
"
ÊÊw x
;
ÊÊx y
}
ÁÁ 
}ËË Ô…
UC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\PedidoService.cs
public 
class 
PedidoService 
( 
IPedidoRepository 
pedidos 
, 
INegocioRepository 
negocios 
,  
AppDbContext 
context 
, 
IEmailService 
email 
, 
ILogger		 
<		 
PedidoService		 
>		 
logger		 !
)		! "
:		# $
IPedidoService		% 3
{

 
private 
const 
string 
AlfabetoCodigo '
=( )
$str* K
;K L
public 

async 
Task 
< #
ClienteAutocompletarDto -
?- .
>. /'
BuscarClienteFrecuenteAsync0 K
(K L
intL O
usuarioNegocioIdP `
,` a
stringb h
telefonoi q
)q r
{ 
var 
negocio 
= 
await 
negocios $
.$ %$
ObtenerPorUsuarioIdAsync% =
(= >
usuarioNegocioId> N
)N O
;O P
if 

( 
negocio 
is 
null 
) 
return #
null$ (
;( )
var 
ultimoPedido 
= 
await  
pedidos! (
.( ))
ObtenerUltimoPorTelefonoAsync) F
(F G
negocioG N
.N O
IdO Q
,Q R
telefonoS [
.[ \
Trim\ `
(` a
)a b
)b c
;c d
if 

( 
ultimoPedido 
is 
null  
||! #
ultimoPedido$ 0
.0 1
Cliente1 8
is9 ;
null< @
)@ A
returnB H
nullI M
;M N
return 
new #
ClienteAutocompletarDto *
{ 	
Nombre 
= 
ultimoPedido !
.! "
Cliente" )
.) *
NombreCompleto* 8
,8 9
	Direccion 
= 
ultimoPedido $
.$ %
DireccionEntrega% 5
} 	
;	 

} 
public 

const 
string %
MensajeCamposObligatorios 1
=2 3
$str4 n
;n o
public 

async 
Task 
< 
( 
bool 
Ok 
, 
string  &
?& '
Error( -
,- .
string/ 5
?5 6
Codigo7 =
)= >
>> ?
RegistrarAsync@ N
(N O
intO R
usuarioNegocioIdS c
,c d
RegistrarPedidoDtoe w
dtox {
){ |
{   
var!! 
negocio!! 
=!! 
await!! 
negocios!! $
.!!$ %$
ObtenerPorUsuarioIdAsync!!% =
(!!= >
usuarioNegocioId!!> N
)!!N O
;!!O P
if"" 

("" 
negocio"" 
is"" 
null"" 
)"" 
return## 
(## 
false## 
,## 
$str## B
,##B C
null##D H
)##H I
;##I J
var&& 
nombre&& 
=&& 
dto&& 
.&& 
ClienteNombre&& &
?&&& '
.&&' (
Trim&&( ,
(&&, -
)&&- .
??&&/ 1
$str&&2 4
;&&4 5
var'' 
telefono'' 
='' 
dto'' 
.'' 
ClienteTelefono'' *
?''* +
.''+ ,
Trim'', 0
(''0 1
)''1 2
??''3 5
$str''6 8
;''8 9
var(( 
	direccion(( 
=(( 
dto(( 
.(( 
DireccionEntrega(( ,
?((, -
.((- .
Trim((. 2
(((2 3
)((3 4
??((5 7
$str((8 :
;((: ;
var** 
items** 
=** 
(** 
dto** 
.** 
	Productos** "
??**# %
[**& '
]**' (
)**( )
.++ 
Where++ 
(++ 
p++ 
=>++ 
!++ 
string++ 
.++  
IsNullOrWhiteSpace++  2
(++2 3
p++3 4
.++4 5
Descripcion++5 @
)++@ A
)++A B
.,, 
Select,, 
(,, 
p,, 
=>,, 
new,, 

ItemPedido,, '
{-- 
Descripcion.. 
=.. 
p.. 
...  
Descripcion..  +
...+ ,
Trim.., 0
(..0 1
)..1 2
,..2 3
Cantidad// 
=// 
p// 
.// 
Cantidad// %
,//% &
PrecioUnitario00 
=00  
p00! "
.00" #
PrecioUnitario00# 1
}11 
)11 
.22 
ToList22 
(22 
)22 
;22 
if44 

(44 
nombre44 
.44 
Length44 
==44 
$num44 
||44 !
telefono44" *
.44* +
Length44+ 1
==442 4
$num445 6
||447 9
	direccion44: C
.44C D
Length44D J
==44K M
$num44N O
||44P R
dto55 
.55 

MetodoPago55 
is55 
not55 !
{55" #
}55$ %

metodoPago55& 0
||551 3
!554 5
Enum555 9
.559 :
	IsDefined55: C
(55C D

metodoPago55D N
)55N O
||55P R
items55S X
.55X Y
Count55Y ^
==55_ a
$num55b c
)55c d
return66 
(66 
false66 
,66 %
MensajeCamposObligatorios66 4
,664 5
null666 :
)66: ;
;66; <
if88 

(88 
items88 
.88 
Any88 
(88 
i88 
=>88 
i88 
.88 
Cantidad88 %
<88& '
$num88( )
||88* ,
i88- .
.88. /
PrecioUnitario88/ =
<=88> @
$num88A B
)88B C
)88C D
return99 
(99 
false99 
,99 
$str99 `
,99` a
null99b f
)99f g
;99g h
int?? 
	clienteId?? 
;?? 
try@@ 
{AA 	
varBB 
	clienteDbBB 
=BB 
awaitBB !
contextBB" )
.BB) *
SetBB* -
<BB- .
ClienteBB. 5
>BB5 6
(BB6 7
)BB7 8
.CC 
IgnoreQueryFiltersCC #
(CC# $
)CC$ %
.DD 
FirstOrDefaultAsyncDD $
(DD$ %
cDD% &
=>DD' )
cDD* +
.DD+ ,
	NegocioIdDD, 5
==DD6 8
negocioDD9 @
.DD@ A
IdDDA C
&&DDD F
cDDG H
.DDH I
TelefonoDDI Q
==DDR T
telefonoDDU ]
)DD] ^
;DD^ _
ifFF 
(FF 
	clienteDbFF 
!=FF 
nullFF !
)FF! "
{GG 
ifHH 
(HH 
	clienteDbHH 
.HH 
NombreCompletoHH ,
!=HH- /
nombreHH0 6
)HH6 7
	clienteDbHH8 A
.HHA B
NombreCompletoHHB P
=HHQ R
nombreHHS Y
;HHY Z
ifII 
(II 
	clienteDbII 
.II #
DireccionPredeterminadaII 5
!=II6 8
	direccionII9 B
)IIB C
	clienteDbIID M
.IIM N#
DireccionPredeterminadaIIN e
=IIf g
	direccionIIh q
;IIq r
awaitKK 
contextKK 
.KK 
SaveChangesAsyncKK .
(KK. /
)KK/ 0
;KK0 1
	clienteIdLL 
=LL 
	clienteDbLL %
.LL% &
IdLL& (
;LL( )
}MM 
elseNN 
{OO 
varPP 
nuevoClientePP  
=PP! "
newPP# &
ClientePP' .
{QQ 
NombreCompletoRR "
=RR# $
nombreRR% +
,RR+ ,
TelefonoSS 
=SS 
telefonoSS '
,SS' (#
DireccionPredeterminadaTT +
=TT, -
	direccionTT. 7
,TT7 8
FechaRegistroUU !
=UU" #
DateTimeUU$ ,
.UU, -
UtcNowUU- 3
,UU3 4
	NegocioIdVV 
=VV 
negocioVV  '
.VV' (
IdVV( *
}WW 
;WW 
contextYY 
.YY 
SetYY 
<YY 
ClienteYY #
>YY# $
(YY$ %
)YY% &
.YY& '
AddYY' *
(YY* +
nuevoClienteYY+ 7
)YY7 8
;YY8 9
awaitZZ 
contextZZ 
.ZZ 
SaveChangesAsyncZZ .
(ZZ. /
)ZZ/ 0
;ZZ0 1
	clienteId[[ 
=[[ 
nuevoCliente[[ (
.[[( )
Id[[) +
;[[+ ,
}\\ 
}]] 	
catch^^ 
(^^ 
	Exception^^ 
ex^^ 
)^^ 
{__ 	
context`` 
.`` 
ChangeTracker`` !
.``! "
Clear``" '
(``' (
)``( )
;``) *
loggeraa 
.aa 
LogErroraa 
(aa 
exaa 
,aa 
$straa  u
,aau v
negocioaaw ~
.aa~ 
Id	aa Å
)
aaÅ Ç
;
aaÇ É
returnbb 
(bb 
falsebb 
,bb 
$strbb S
,bbS T
nullbbU Y
)bbY Z
;bbZ [
}cc 	
stringee 
?ee 
codigoee 
=ee 
nullee 
;ee 
forff 
(ff 
varff 
intentoff 
=ff 
$numff 
;ff 
intentoff %
<ff& '
$numff( )
;ff) *
intentoff+ 2
++ff2 4
)ff4 5
{gg 	
varhh 
	candidatohh 
=hh !
RandomNumberGeneratorhh 1
.hh1 2
	GetStringhh2 ;
(hh; <
AlfabetoCodigohh< J
,hhJ K
$numhhL M
)hhM N
;hhN O
ifii 
(ii 
!ii 
awaitii 
pedidosii 
.ii 
ExisteCodigoAsyncii 0
(ii0 1
	candidatoii1 :
)ii: ;
)ii; <
{jj 
codigokk 
=kk 
	candidatokk "
;kk" #
breakll 
;ll 
}mm 
}nn 	
ifpp 

(pp 
codigopp 
ispp 
nullpp 
)pp 
{qq 	
loggerrr 
.rr 
LogErrorrr 
(rr 
$strrr z
,rrz {
negocio	rr| É
.
rrÉ Ñ
Id
rrÑ Ü
)
rrÜ á
;
rrá à
returnss 
(ss 
falsess 
,ss 
$strss S
,ssS T
nullssU Y
)ssY Z
;ssZ [
}tt 	
varvv 
pedidovv 
=vv 
newvv 
Pedidovv 
{ww 	
Codigoxx 
=xx 
codigoxx 
,xx 
	NegocioIdyy 
=yy 
negocioyy 
.yy  
Idyy  "
,yy" #
	ClienteIdzz 
=zz 
	clienteIdzz !
,zz! "
DireccionEntrega{{ 
={{ 
	direccion{{ (
,{{( )
MetodoPagoId|| 
=|| 
(|| 
int|| 
)||  

metodoPago||  *
,||* +
EstadoPedidoId}} 
=}} 
$num}} 
,}} 
FechaCreacion~~ 
=~~ 
DateTime~~ $
.~~$ %
UtcNow~~% +
,~~+ ,
Items 
= 
items 
}
ÄÄ 	
;
ÄÄ	 

try
ÇÇ 
{
ÉÉ 	
await
ÑÑ 
pedidos
ÑÑ 
.
ÑÑ 
AgregarAsync
ÑÑ &
(
ÑÑ& '
pedido
ÑÑ' -
)
ÑÑ- .
;
ÑÑ. /
await
ÖÖ %
RegistrarHistorialAsync
ÖÖ )
(
ÖÖ) *
pedido
ÖÖ* 0
.
ÖÖ0 1
Id
ÖÖ1 3
,
ÖÖ3 4
(
ÖÖ5 6
int
ÖÖ6 9
)
ÖÖ9 :
EstadoPedido
ÖÖ: F
.
ÖÖF G
Recibido
ÖÖG O
,
ÖÖO P
usuarioNegocioId
ÖÖQ a
,
ÖÖa b
$str
ÖÖc v
)
ÖÖv w
;
ÖÖw x
}
ÜÜ 	
catch
áá 
(
áá 
	Exception
áá 
ex
áá 
)
áá 
{
àà 	
logger
ââ 
.
ââ 
LogError
ââ 
(
ââ 
ex
ââ 
,
ââ 
$str
ââ  l
,
ââl m
codigo
âân t
,
âât u
negocio
ââv }
.
ââ} ~
Idââ~ Ä
)ââÄ Å
;ââÅ Ç
return
ää 
(
ää 
false
ää 
,
ää 
$str
ää S
,
ääS T
null
ääU Y
)
ääY Z
;
ääZ [
}
ãã 	
return
çç 
(
çç 
true
çç 
,
çç 
null
çç 
,
çç 
codigo
çç "
)
çç" #
;
çç# $
}
éé 
private
íí 
static
íí 
readonly
íí 
string
íí "
[
íí" #
]
íí# $
NombresEstado
íí% 2
=
íí3 4
[
ìì 	
$str
ìì	 
,
ìì 
$str
ìì %
,
ìì% &
$str
ìì' ;
,
ìì; <
$str
ìì= G
,
ììG H
$str
ììI T
,
ììT U
$str
ììV a
,
ììa b
$str
ììc n
]
ììn o
;
ììo p
private
ïï 
const
ïï 
string
ïï #
MensajeEstadoCambiado
ïï .
=
ïï/ 0
$strïï1 ç
;ïïç é
private
óó 
static
óó 
string
óó 
NombreEstado
óó &
(
óó& '
int
óó' *
estadoId
óó+ 3
)
óó3 4
=>
óó5 7
estadoId
òò 
>=
òò 
$num
òò 
&&
òò 
estadoId
òò !
<
òò" #
NombresEstado
òò$ 1
.
òò1 2
Length
òò2 8
?
òò9 :
NombresEstado
òò; H
[
òòH I
estadoId
òòI Q
]
òòQ R
:
òòS T
$str
òòU b
;
òòb c
public
ùù 

static
ùù 
string
ùù 
?
ùù !
ValidarCambioEstado
ùù -
(
ùù- .
int
ùù. 1
estadoActual
ùù2 >
,
ùù> ?
int
ùù@ C
nuevoEstadoId
ùùD Q
)
ùùQ R
{
ûû 
if
üü 

(
üü 
nuevoEstadoId
üü 
<
üü 
(
üü 
int
üü  
)
üü  !
EstadoPedido
üü! -
.
üü- .
Recibido
üü. 6
||
üü7 9
nuevoEstadoId
üü: G
>
üüH I
(
üüJ K
int
üüK N
)
üüN O
EstadoPedido
üüO [
.
üü[ \
	Cancelado
üü\ e
)
üüe f
return
†† 
$str
†† 8
;
††8 9
if
££ 

(
££ 
nuevoEstadoId
££ 
==
££ 
estadoActual
££ )
||
££* ,
nuevoEstadoId
££- :
==
££; =
(
££> ?
int
££? B
)
££B C
EstadoPedido
££C O
.
££O P
	Cancelado
££P Y
)
££Y Z
return
§§ 
null
§§ 
;
§§ 
if
¶¶ 

(
¶¶ 
nuevoEstadoId
¶¶ 
<
¶¶ 
estadoActual
¶¶ (
)
¶¶( )
return
ßß 
$"
ßß 
$str
ßß O
{
ßßO P
NombreEstado
ßßP \
(
ßß\ ]
estadoActual
ßß] i
)
ßßi j
}
ßßj k
$strßßk É
{ßßÉ Ñ
NombreEstadoßßÑ ê
(ßßê ë
nuevoEstadoIdßßë û
)ßßû ü
}ßßü †
$strßß† ¢
"ßß¢ £
;ßß£ §
if
©© 

(
©© 
nuevoEstadoId
©© 
>
©© 
estadoActual
©© (
+
©©) *
$num
©©+ ,
)
©©, -
return
™™ 
$"
™™ 
$str
™™ ?
{
™™? @
NombreEstado
™™@ L
(
™™L M
estadoActual
™™M Y
)
™™Y Z
}
™™Z [
$str
™™[ u
{
™™u v
NombreEstado™™v Ç
(™™Ç É
estadoActual™™É è
+™™ê ë
$num™™í ì
)™™ì î
}™™î ï
$str™™ï ó
"™™ó ò
;™™ò ô
return
¨¨ 
null
¨¨ 
;
¨¨ 
}
≠≠ 
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
ØØ. /#
ActualizarEstadoAsync
ØØ0 E
(
ØØE F
int
ØØF I
	usuarioId
ØØJ S
,
ØØS T
int
ØØU X
pedidoId
ØØY a
,
ØØa b
int
ØØc f
nuevoEstadoId
ØØg t
,
ØØt u
int
ØØv y
?
ØØy z
repartidorIdØØ{ á
=ØØà â
nullØØä é
)ØØé è
{
∞∞ 
var
±± 
negocio
±± 
=
±± 
await
±± 
negocios
±± $
.
±±$ %&
ObtenerPorUsuarioIdAsync
±±% =
(
±±= >
	usuarioId
±±> G
)
±±G H
;
±±H I
if
≤≤ 

(
≤≤ 
negocio
≤≤ 
is
≤≤ 
not
≤≤ 
null
≤≤ 
)
≤≤  
{
≥≥ 	
var
¥¥ 
pedido
¥¥ 
=
¥¥ 
await
¥¥ 
pedidos
¥¥ &
.
¥¥& '
ObtenerPorIdAsync
¥¥' 8
(
¥¥8 9
pedidoId
¥¥9 A
)
¥¥A B
;
¥¥B C
if
µµ 
(
µµ 
pedido
µµ 
is
µµ 
null
µµ 
||
µµ !
pedido
µµ" (
.
µµ( )
	NegocioId
µµ) 2
!=
µµ3 5
negocio
µµ6 =
.
µµ= >
Id
µµ> @
)
µµ@ A
return
∂∂ 
(
∂∂ 
false
∂∂ 
,
∂∂ 
$str
∂∂ X
)
∂∂X Y
;
∂∂Y Z
if
ππ 
(
ππ 
pedido
ππ 
.
ππ 
EstadoPedidoId
ππ %
==
ππ& (
(
ππ) *
int
ππ* -
)
ππ- .
EstadoPedido
ππ. :
.
ππ: ;
	Entregado
ππ; D
||
ππE G
pedido
ππH N
.
ππN O
EstadoPedidoId
ππO ]
==
ππ^ `
(
ππa b
int
ππb e
)
ππe f
EstadoPedido
ππf r
.
ππr s
	Cancelado
ππs |
)
ππ| }
{
∫∫ 
return
ªª 
(
ªª 
false
ªª 
,
ªª 
$str
ªª b
)
ªªb c
;
ªªc d
}
ºº 
var
¡¡ 
estadoActual
¡¡ 
=
¡¡ 
pedido
¡¡ %
.
¡¡% &
EstadoPedidoId
¡¡& 4
;
¡¡4 5
var
¬¬ 
errorTransicion
¬¬ 
=
¬¬  !!
ValidarCambioEstado
¬¬" 5
(
¬¬5 6
estadoActual
¬¬6 B
,
¬¬B C
nuevoEstadoId
¬¬D Q
)
¬¬Q R
;
¬¬R S
if
√√ 
(
√√ 
errorTransicion
√√ 
is
√√  "
not
√√# &
null
√√' +
)
√√+ ,
{
ƒƒ 
return
≈≈ 
(
≈≈ 
false
≈≈ 
,
≈≈ 
errorTransicion
≈≈ .
)
≈≈. /
;
≈≈/ 0
}
∆∆ 
int
»» 
?
»» 
nuevoRepartidorId
»» "
=
»»# $
null
»»% )
;
»») *
if
   
(
   
nuevoEstadoId
   
>=
    
(
  ! "
int
  " %
)
  % &
EstadoPedido
  & 2
.
  2 3
Asignado
  3 ;
&&
  < >
nuevoEstadoId
  ? L
<=
  M O
(
  P Q
int
  Q T
)
  T U
EstadoPedido
  U a
.
  a b
	Entregado
  b k
)
  k l
{
ÀÀ 
int
ÃÃ 
?
ÃÃ  
repartidorAValidar
ÃÃ '
=
ÃÃ( )
repartidorId
ÃÃ* 6
.
ÃÃ6 7
HasValue
ÃÃ7 ?
&&
ÃÃ@ B
repartidorId
ÃÃC O
.
ÃÃO P
Value
ÃÃP U
>
ÃÃV W
$num
ÃÃX Y
?
ÕÕ 
repartidorId
ÕÕ "
:
ŒŒ 
pedido
ŒŒ 
.
ŒŒ 
RepartidorId
ŒŒ )
;
ŒŒ) *
if
–– 
(
––  
repartidorAValidar
–– &
.
––& '
HasValue
––' /
&&
––0 2 
repartidorAValidar
––3 E
.
––E F
Value
––F K
>
––L M
$num
––N O
)
––O P
{
—— 
var
”” 
estaSuspendido
”” &
=
””' (
await
””) .
context
””/ 6
.
””6 7
Set
””7 :
<
””: ;"
SuspensionRepartidor
””; O
>
””O P
(
””P Q
)
””Q R
.
‘‘ 
AnyAsync
‘‘ !
(
‘‘! "
s
‘‘" #
=>
‘‘$ &
s
‘‘' (
.
‘‘( )
RepartidorId
‘‘) 5
==
‘‘6 8 
repartidorAValidar
‘‘9 K
.
‘‘K L
Value
‘‘L Q
&&
‘‘R T
s
‘‘U V
.
‘‘V W
FechaReactivacion
‘‘W h
==
‘‘i k
null
‘‘l p
)
‘‘p q
;
‘‘q r
if
÷÷ 
(
÷÷ 
estaSuspendido
÷÷ &
)
÷÷& '
{
◊◊ 
return
ÿÿ 
(
ÿÿ  
false
ÿÿ  %
,
ÿÿ% &
$strÿÿ' Ü
)ÿÿÜ á
;ÿÿá à
}
ŸŸ 
if
€€ 
(
€€ 
repartidorId
€€ $
.
€€$ %
HasValue
€€% -
&&
€€. 0
repartidorId
€€1 =
.
€€= >
Value
€€> C
>
€€D E
$num
€€F G
)
€€G H
{
‹‹ 
nuevoRepartidorId
›› )
=
››* +
repartidorId
››, 8
.
››8 9
Value
››9 >
;
››> ?
}
ﬁﬁ 
}
ﬂﬂ 
else
‡‡ 
if
‡‡ 
(
‡‡ 
pedido
‡‡ 
.
‡‡  
RepartidorId
‡‡  ,
is
‡‡- /
null
‡‡0 4
)
‡‡4 5
{
·· 
return
‚‚ 
(
‚‚ 
false
‚‚ !
,
‚‚! "
$str
‚‚# l
)
‚‚l m
;
‚‚m n
}
„„ 
}
‰‰ 
try
ÊÊ 
{
ÁÁ 
var
ÍÍ 
filas
ÍÍ 
=
ÍÍ 
await
ÍÍ !
context
ÍÍ" )
.
ÍÍ) *
Pedidos
ÍÍ* 1
.
ÎÎ 
Where
ÎÎ 
(
ÎÎ 
p
ÎÎ 
=>
ÎÎ 
p
ÎÎ  !
.
ÎÎ! "
Id
ÎÎ" $
==
ÎÎ% '
pedido
ÎÎ( .
.
ÎÎ. /
Id
ÎÎ/ 1
&&
ÎÎ2 4
p
ÎÎ5 6
.
ÎÎ6 7
EstadoPedidoId
ÎÎ7 E
==
ÎÎF H
estadoActual
ÎÎI U
)
ÎÎU V
.
ÏÏ  
ExecuteUpdateAsync
ÏÏ '
(
ÏÏ' (
s
ÏÏ( )
=>
ÏÏ* ,
s
ÏÏ- .
.
ÌÌ 
SetProperty
ÌÌ $
(
ÌÌ$ %
p
ÌÌ% &
=>
ÌÌ' )
p
ÌÌ* +
.
ÌÌ+ ,
EstadoPedidoId
ÌÌ, :
,
ÌÌ: ;
nuevoEstadoId
ÌÌ< I
)
ÌÌI J
.
ÓÓ 
SetProperty
ÓÓ $
(
ÓÓ$ %
p
ÓÓ% &
=>
ÓÓ' )
p
ÓÓ* +
.
ÓÓ+ ,
RepartidorId
ÓÓ, 8
,
ÓÓ8 9
p
ÓÓ: ;
=>
ÓÓ< >
nuevoRepartidorId
ÓÓ? P
??
ÓÓQ S
p
ÓÓT U
.
ÓÓU V
RepartidorId
ÓÓV b
)
ÓÓb c
)
ÓÓc d
;
ÓÓd e
if
 
(
 
filas
 
==
 
$num
 
)
 
{
ÒÒ 
return
ÚÚ 
(
ÚÚ 
false
ÚÚ !
,
ÚÚ! "#
MensajeEstadoCambiado
ÚÚ# 8
)
ÚÚ8 9
;
ÚÚ9 :
}
ÛÛ 
await
ıı %
RegistrarHistorialAsync
ıı -
(
ıı- .
pedido
ıı. 4
.
ıı4 5
Id
ıı5 7
,
ıı7 8
nuevoEstadoId
ıı9 F
,
ııF G
	usuarioId
ııH Q
,
ııQ R
null
ııS W
)
ııW X
;
ııX Y
}
ˆˆ 
catch
˜˜ 
(
˜˜ 
	Exception
˜˜ 
ex
˜˜ 
)
˜˜  
{
¯¯ 
logger
˘˘ 
.
˘˘ 
LogError
˘˘ 
(
˘˘  
ex
˘˘  "
,
˘˘" #
$str
˘˘$ u
,
˘˘u v
pedidoId
˘˘w 
,˘˘ Ä
negocio˘˘Å à
.˘˘à â
Id˘˘â ã
)˘˘ã å
;˘˘å ç
return
˙˙ 
(
˙˙ 
false
˙˙ 
,
˙˙ 
$str
˙˙ c
)
˙˙c d
;
˙˙d e
}
˚˚ 
return
˝˝ 
(
˝˝ 
true
˝˝ 
,
˝˝ 
null
˝˝ 
)
˝˝ 
;
˝˝  
}
˛˛ 	
var
ÅÅ 

repartidor
ÅÅ 
=
ÅÅ 
await
ÅÅ 
context
ÅÅ &
.
ÅÅ& '
Repartidores
ÅÅ' 3
.
ÇÇ 
AsNoTracking
ÇÇ 
(
ÇÇ 
)
ÇÇ 
.
ÉÉ !
FirstOrDefaultAsync
ÉÉ  
(
ÉÉ  !
r
ÉÉ! "
=>
ÉÉ# %
r
ÉÉ& '
.
ÉÉ' (
	UsuarioId
ÉÉ( 1
==
ÉÉ2 4
	usuarioId
ÉÉ5 >
)
ÉÉ> ?
;
ÉÉ? @
if
ÖÖ 

(
ÖÖ 

repartidor
ÖÖ 
is
ÖÖ 
not
ÖÖ 
null
ÖÖ "
)
ÖÖ" #
{
ÜÜ 	
var
áá 
estaSuspendido
áá 
=
áá  
await
áá! &
context
áá' .
.
áá. /
Set
áá/ 2
<
áá2 3"
SuspensionRepartidor
áá3 G
>
ááG H
(
ááH I
)
ááI J
.
àà 
AnyAsync
àà 
(
àà 
s
àà 
=>
àà 
s
àà  
.
àà  !
RepartidorId
àà! -
==
àà. 0

repartidor
àà1 ;
.
àà; <
Id
àà< >
&&
àà? A
s
ààB C
.
ààC D
FechaReactivacion
ààD U
==
ààV X
null
ààY ]
)
àà] ^
;
àà^ _
if
ää 
(
ää 
estaSuspendido
ää 
)
ää 
{
ãã 
return
åå 
(
åå 
false
åå 
,
åå 
$str
åå ]
)
åå] ^
;
åå^ _
}
çç 
var
èè 
pedido
èè 
=
èè 
await
èè 
pedidos
èè &
.
èè& '
ObtenerPorIdAsync
èè' 8
(
èè8 9
pedidoId
èè9 A
)
èèA B
;
èèB C
if
êê 
(
êê 
pedido
êê 
is
êê 
null
êê 
||
êê !
pedido
êê" (
.
êê( )
RepartidorId
êê) 5
!=
êê6 8

repartidor
êê9 C
.
êêC D
Id
êêD F
)
êêF G
{
ëë 
return
íí 
(
íí 
false
íí 
,
íí 
$str
íí \
)
íí\ ]
;
íí] ^
}
ìì 
bool
ññ 
transicionValida
ññ !
=
ññ" #
(
ññ$ %
pedido
ññ% +
.
ññ+ ,
EstadoPedidoId
ññ, :
==
ññ; =
(
ññ> ?
int
ññ? B
)
ññB C
EstadoPedido
ññC O
.
ññO P
Asignado
ññP X
&&
ññY [
nuevoEstadoId
ññ\ i
==
ññj l
(
ññm n
int
ññn q
)
ññq r
EstadoPedido
ññr ~
.
ññ~ 
EnCaminoññ á
)ññá à
||
óó! #
(
óó$ %
pedido
óó% +
.
óó+ ,
EstadoPedidoId
óó, :
==
óó; =
(
óó> ?
int
óó? B
)
óóB C
EstadoPedido
óóC O
.
óóO P
EnCamino
óóP X
&&
óóY [
nuevoEstadoId
óó\ i
==
óój l
(
óóm n
int
óón q
)
óóq r
EstadoPedido
óór ~
.
óó~ 
	Entregadoóó à
)óóà â
;óóâ ä
if
ôô 
(
ôô 
!
ôô 
transicionValida
ôô !
)
ôô! "
{
öö 
return
õõ 
(
õõ 
false
õõ 
,
õõ 
$str
õõ F
)
õõF G
;
õõG H
}
úú 
try
ûû 
{
üü 
var
°° 
estadoActual
°°  
=
°°! "
pedido
°°# )
.
°°) *
EstadoPedidoId
°°* 8
;
°°8 9
var
¢¢ 
filas
¢¢ 
=
¢¢ 
await
¢¢ !
context
¢¢" )
.
¢¢) *
Pedidos
¢¢* 1
.
££ 
Where
££ 
(
££ 
p
££ 
=>
££ 
p
££  !
.
££! "
Id
££" $
==
££% '
pedido
££( .
.
££. /
Id
££/ 1
&&
££2 4
p
££5 6
.
££6 7
EstadoPedidoId
££7 E
==
££F H
estadoActual
££I U
&&
££V X
p
££Y Z
.
££Z [
RepartidorId
££[ g
==
££h j

repartidor
££k u
.
££u v
Id
££v x
)
££x y
.
§§  
ExecuteUpdateAsync
§§ '
(
§§' (
s
§§( )
=>
§§* ,
s
§§- .
.
§§. /
SetProperty
§§/ :
(
§§: ;
p
§§; <
=>
§§= ?
p
§§@ A
.
§§A B
EstadoPedidoId
§§B P
,
§§P Q
nuevoEstadoId
§§R _
)
§§_ `
)
§§` a
;
§§a b
if
¶¶ 
(
¶¶ 
filas
¶¶ 
==
¶¶ 
$num
¶¶ 
)
¶¶ 
{
ßß 
return
®® 
(
®® 
false
®® !
,
®®! "
$str
®®# J
)
®®J K
;
®®K L
}
©© 
await
´´ %
RegistrarHistorialAsync
´´ -
(
´´- .
pedido
´´. 4
.
´´4 5
Id
´´5 7
,
´´7 8
nuevoEstadoId
´´9 F
,
´´F G
	usuarioId
´´H Q
,
´´Q R
null
´´S W
)
´´W X
;
´´X Y
}
¨¨ 
catch
≠≠ 
(
≠≠ 
	Exception
≠≠ 
ex
≠≠ 
)
≠≠  
{
ÆÆ 
logger
ØØ 
.
ØØ 
LogError
ØØ 
(
ØØ  
ex
ØØ  "
,
ØØ" #
$str
ØØ$ {
,
ØØ{ |
pedidoIdØØ} Ö
,ØØÖ Ü

repartidorØØá ë
.ØØë í
IdØØí î
)ØØî ï
;ØØï ñ
return
∞∞ 
(
∞∞ 
false
∞∞ 
,
∞∞ 
$str
∞∞ c
)
∞∞c d
;
∞∞d e
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
¥¥ 	
return
∂∂ 
(
∂∂ 
false
∂∂ 
,
∂∂ 
$str
∂∂ H
)
∂∂H I
;
∂∂I J
}
∑∑ 
private
ªª 
async
ªª 
Task
ªª %
RegistrarHistorialAsync
ªª .
(
ªª. /
int
ªª/ 2
pedidoId
ªª3 ;
,
ªª; <
int
ªª= @
estadoId
ªªA I
,
ªªI J
int
ªªK N
?
ªªN O
	usuarioId
ªªP Y
,
ªªY Z
string
ªª[ a
?
ªªa b
observacion
ªªc n
)
ªªn o
{
ºº 
try
ΩΩ 
{
ææ 	
var
øø 
fecha
øø 
=
øø 
DateTime
øø  
.
øø  !
UtcNow
øø! '
;
øø' (
await
¿¿ 
context
¿¿ 
.
¿¿ 
Database
¿¿ "
.
¿¿" #)
ExecuteSqlInterpolatedAsync
¿¿# >
(
¿¿> ?
$"
¡¡ 
$str¡¡ Ä
{¡¡Ä Å
pedidoId¡¡Å â
}¡¡â ä
$str¡¡ä å
{¡¡å ç
estadoId¡¡ç ï
}¡¡ï ñ
$str¡¡ñ ò
{¡¡ò ô
	usuarioId¡¡ô ¢
}¡¡¢ £
$str¡¡£ •
{¡¡• ¶
observacion¡¡¶ ±
}¡¡± ≤
$str¡¡≤ ¥
{¡¡¥ µ
fecha¡¡µ ∫
}¡¡∫ ª
$str¡¡ª º
"¡¡º Ω
)¡¡Ω æ
;¡¡æ ø
}
¬¬ 	
catch
√√ 
(
√√ 
	Exception
√√ 
ex
√√ 
)
√√ 
{
ƒƒ 	
logger
≈≈ 
.
≈≈ 

LogWarning
≈≈ 
(
≈≈ 
ex
≈≈  
,
≈≈  !
$str
≈≈" o
,
≈≈o p
pedidoId
≈≈q y
,
≈≈y z
estadoId≈≈{ É
)≈≈É Ñ
;≈≈Ñ Ö
}
∆∆ 	
}
«« 
public
…… 

async
…… 
Task
…… 
<
…… 
List
…… 
<
…… 
Pedido
…… !
>
……! "
>
……" #(
ObtenerPedidosActivosAsync
……$ >
(
……> ?
int
……? B
usuarioNegocioId
……C S
)
……S T
{
   
var
ÀÀ 
negocio
ÀÀ 
=
ÀÀ 
await
ÀÀ 
negocios
ÀÀ $
.
ÀÀ$ %&
ObtenerPorUsuarioIdAsync
ÀÀ% =
(
ÀÀ= >
usuarioNegocioId
ÀÀ> N
)
ÀÀN O
;
ÀÀO P
if
ÃÃ 

(
ÃÃ 
negocio
ÃÃ 
is
ÃÃ 
null
ÃÃ 
)
ÃÃ 
return
ÃÃ #
[
ÃÃ$ %
]
ÃÃ% &
;
ÃÃ& '
var
ŒŒ 
listaPedidos
ŒŒ 
=
ŒŒ 
await
ŒŒ  
pedidos
ŒŒ! (
.
ŒŒ( )$
ObtenerPorNegocioAsync
ŒŒ) ?
(
ŒŒ? @
negocio
ŒŒ@ G
.
ŒŒG H
Id
ŒŒH J
)
ŒŒJ K
;
ŒŒK L
return
–– 
listaPedidos
–– 
.
—— 
Where
—— 
(
—— 
p
—— 
=>
—— 
p
—— 
.
—— 
EstadoPedidoId
—— (
!=
——) +
(
——, -
int
——- 0
)
——0 1
EstadoPedido
——1 =
.
——= >
	Entregado
——> G
&&
——H J
p
——K L
.
——L M
EstadoPedidoId
——M [
!=
——\ ^
(
——_ `
int
——` c
)
——c d
EstadoPedido
——d p
.
——p q
	Cancelado
——q z
)
——z {
.
““ 
ToList
““ 
(
““ 
)
““ 
;
““ 
}
”” 
public
’’ 

async
’’ 
Task
’’ 
<
’’ 
List
’’ 
<
’’ 
Pedido
’’ !
>
’’! "
>
’’" #*
ObtenerHistorialPedidosAsync
’’$ @
(
’’@ A
int
’’A D
usuarioNegocioId
’’E U
)
’’U V
{
÷÷ 
var
◊◊ 
negocio
◊◊ 
=
◊◊ 
await
◊◊ 
negocios
◊◊ $
.
◊◊$ %&
ObtenerPorUsuarioIdAsync
◊◊% =
(
◊◊= >
usuarioNegocioId
◊◊> N
)
◊◊N O
;
◊◊O P
if
ÿÿ 

(
ÿÿ 
negocio
ÿÿ 
is
ÿÿ 
null
ÿÿ 
)
ÿÿ 
return
ÿÿ #
[
ÿÿ$ %
]
ÿÿ% &
;
ÿÿ& '
var
⁄⁄ 
listaPedidos
⁄⁄ 
=
⁄⁄ 
await
⁄⁄  
pedidos
⁄⁄! (
.
⁄⁄( )$
ObtenerPorNegocioAsync
⁄⁄) ?
(
⁄⁄? @
negocio
⁄⁄@ G
.
⁄⁄G H
Id
⁄⁄H J
)
⁄⁄J K
;
⁄⁄K L
return
‹‹ 
listaPedidos
‹‹ 
.
›› 
Where
›› 
(
›› 
p
›› 
=>
›› 
p
›› 
.
›› 
EstadoPedidoId
›› (
==
››) +
(
››, -
int
››- 0
)
››0 1
EstadoPedido
››1 =
.
››= >
	Entregado
››> G
||
››H J
p
››K L
.
››L M
EstadoPedidoId
››M [
==
››\ ^
(
››_ `
int
››` c
)
››c d
EstadoPedido
››d p
.
››p q
	Cancelado
››q z
)
››z {
.
ﬁﬁ 
ToList
ﬁﬁ 
(
ﬁﬁ 
)
ﬁﬁ 
;
ﬁﬁ 
}
ﬂﬂ 
public
‚‚ 

const
‚‚ 
string
‚‚ '
MensajeCodigoNoEncontrado
‚‚ 1
=
‚‚2 3
$str
‚‚4 i
;
‚‚i j
public
„„ 

const
„„ 
int
„„ !
MaxCaracteresMotivo
„„ (
=
„„) *
$num
„„+ .
;
„„. /
private
ÂÂ 
const
ÂÂ 
string
ÂÂ !
MensajeNoCancelable
ÂÂ ,
=
ÂÂ- .
$str
ÂÂ/ V
;
ÂÂV W
private
ÊÊ 
const
ÊÊ 
string
ÊÊ '
MensajeSolicitudDuplicada
ÊÊ 2
=
ÊÊ3 4
$str
ÊÊ5 n
;
ÊÊn o
private
ÁÁ 
const
ÁÁ 
string
ÁÁ %
MensajeErrorCancelacion
ÁÁ 0
=
ÁÁ1 2
$str
ÁÁ3 j
;
ÁÁj k
public
ÍÍ 

static
ÍÍ 
bool
ÍÍ $
EsCancelablePorCliente
ÍÍ -
(
ÍÍ- .
int
ÍÍ. 1
estadoId
ÍÍ2 :
)
ÍÍ: ;
=>
ÍÍ< >
estadoId
ÎÎ 
>=
ÎÎ 
(
ÎÎ 
int
ÎÎ 
)
ÎÎ 
EstadoPedido
ÎÎ %
.
ÎÎ% &
Recibido
ÎÎ& .
&&
ÎÎ/ 1
estadoId
ÎÎ2 :
<=
ÎÎ; =
(
ÎÎ> ?
int
ÎÎ? B
)
ÎÎB C
EstadoPedido
ÎÎC O
.
ÎÎO P
Asignado
ÎÎP X
;
ÎÎX Y
public
ÌÌ 

async
ÌÌ 
Task
ÌÌ 
<
ÌÌ 
(
ÌÌ 
bool
ÌÌ 
Ok
ÌÌ 
,
ÌÌ 
string
ÌÌ  &
?
ÌÌ& '
Error
ÌÌ( -
)
ÌÌ- .
>
ÌÌ. /%
CancelarPorClienteAsync
ÌÌ0 G
(
ÌÌG H
string
ÌÌH N
?
ÌÌN O
codigo
ÌÌP V
,
ÌÌV W
string
ÌÌX ^
?
ÌÌ^ _
motivo
ÌÌ` f
)
ÌÌf g
{
ÓÓ 
var
ÔÔ 
codigoLimpio
ÔÔ 
=
ÔÔ 
codigo
ÔÔ !
?
ÔÔ! "
.
ÔÔ" #
Trim
ÔÔ# '
(
ÔÔ' (
)
ÔÔ( )
.
ÔÔ) *
ToUpperInvariant
ÔÔ* :
(
ÔÔ: ;
)
ÔÔ; <
??
ÔÔ= ?
$str
ÔÔ@ B
;
ÔÔB C
if
 

(
 
!
 
System
 
.
 
Text
 
.
  
RegularExpressions
 +
.
+ ,
Regex
, 1
.
1 2
IsMatch
2 9
(
9 :
codigoLimpio
: F
,
F G
$str
H W
)
W X
)
X Y
return
ÒÒ 
(
ÒÒ 
false
ÒÒ 
,
ÒÒ '
MensajeCodigoNoEncontrado
ÒÒ 4
)
ÒÒ4 5
;
ÒÒ5 6
var
ÛÛ 
motivoLimpio
ÛÛ 
=
ÛÛ 
motivo
ÛÛ !
?
ÛÛ! "
.
ÛÛ" #
Trim
ÛÛ# '
(
ÛÛ' (
)
ÛÛ( )
??
ÛÛ* ,
$str
ÛÛ- /
;
ÛÛ/ 0
if
ÙÙ 

(
ÙÙ 
motivoLimpio
ÙÙ 
.
ÙÙ 
Length
ÙÙ 
==
ÙÙ  "
$num
ÙÙ# $
)
ÙÙ$ %
return
ıı 
(
ıı 
false
ıı 
,
ıı 
$str
ıı @
)
ıı@ A
;
ııA B
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
ˆˆ 
>
ˆˆ  !!
MaxCaracteresMotivo
ˆˆ" 5
)
ˆˆ5 6
return
˜˜ 
(
˜˜ 
false
˜˜ 
,
˜˜ 
$"
˜˜ 
$str
˜˜ :
{
˜˜: ;!
MaxCaracteresMotivo
˜˜; N
}
˜˜N O
$str
˜˜O Z
"
˜˜Z [
)
˜˜[ \
;
˜˜\ ]
try
˘˘ 
{
˙˙ 	
var
˚˚ 
pedido
˚˚ 
=
˚˚ 
await
˚˚ 
context
˚˚ &
.
˚˚& '
Pedidos
˚˚' .
.
¸¸ 
AsNoTracking
¸¸ 
(
¸¸ 
)
¸¸ 
.
˝˝ 
Include
˝˝ 
(
˝˝ 
p
˝˝ 
=>
˝˝ 
p
˝˝ 
.
˝˝  
Cliente
˝˝  '
)
˝˝' (
.
˛˛ 
Include
˛˛ 
(
˛˛ 
p
˛˛ 
=>
˛˛ 
p
˛˛ 
.
˛˛  
Negocio
˛˛  '
)
˛˛' (
.
˛˛( )
ThenInclude
˛˛) 4
(
˛˛4 5
n
˛˛5 6
=>
˛˛7 9
n
˛˛: ;
!
˛˛; <
.
˛˛< =
Usuario
˛˛= D
)
˛˛D E
.
ˇˇ !
FirstOrDefaultAsync
ˇˇ $
(
ˇˇ$ %
p
ˇˇ% &
=>
ˇˇ' )
p
ˇˇ* +
.
ˇˇ+ ,
Codigo
ˇˇ, 2
==
ˇˇ3 5
codigoLimpio
ˇˇ6 B
)
ˇˇB C
;
ˇˇC D
if
ÅÅ 
(
ÅÅ 
pedido
ÅÅ 
is
ÅÅ 
null
ÅÅ 
)
ÅÅ 
return
ÅÅ  &
(
ÅÅ' (
false
ÅÅ( -
,
ÅÅ- .'
MensajeCodigoNoEncontrado
ÅÅ/ H
)
ÅÅH I
;
ÅÅI J
if
ÑÑ 
(
ÑÑ 
await
ÑÑ 
context
ÑÑ 
.
ÑÑ $
SolicitudesCancelacion
ÑÑ 4
.
ÑÑ4 5
AnyAsync
ÑÑ5 =
(
ÑÑ= >
s
ÑÑ> ?
=>
ÑÑ@ B
s
ÑÑC D
.
ÑÑD E
PedidoId
ÑÑE M
==
ÑÑN P
pedido
ÑÑQ W
.
ÑÑW X
Id
ÑÑX Z
)
ÑÑZ [
)
ÑÑ[ \
return
ÖÖ 
(
ÖÖ 
false
ÖÖ 
,
ÖÖ '
MensajeSolicitudDuplicada
ÖÖ 8
)
ÖÖ8 9
;
ÖÖ9 :
if
àà 
(
àà 
!
àà $
EsCancelablePorCliente
àà '
(
àà' (
pedido
àà( .
.
àà. /
EstadoPedidoId
àà/ =
)
àà= >
)
àà> ?
return
ââ 
(
ââ 
false
ââ 
,
ââ !
MensajeNoCancelable
ââ 2
)
ââ2 3
;
ââ3 4
var
ãã 
ahora
ãã 
=
ãã 
DateTime
ãã  
.
ãã  !
UtcNow
ãã! '
;
ãã' (
await
åå 
using
åå 
(
åå 
var
åå 
tx
åå 
=
åå  !
await
åå" '
context
åå( /
.
åå/ 0
Database
åå0 8
.
åå8 9#
BeginTransactionAsync
åå9 N
(
ååN O
)
ååO P
)
ååP Q
{
çç 
var
êê 
filas
êê 
=
êê 
await
êê !
context
êê" )
.
êê) *
Pedidos
êê* 1
.
ëë 
Where
ëë 
(
ëë 
p
ëë 
=>
ëë 
p
ëë  !
.
ëë! "
Id
ëë" $
==
ëë% '
pedido
ëë( .
.
ëë. /
Id
ëë/ 1
&&
ëë2 4
p
íí  !
.
íí! "
EstadoPedidoId
íí" 0
>=
íí1 3
(
íí4 5
int
íí5 8
)
íí8 9
EstadoPedido
íí9 E
.
ííE F
Recibido
ííF N
&&
ííO Q
p
ìì  !
.
ìì! "
EstadoPedidoId
ìì" 0
<=
ìì1 3
(
ìì4 5
int
ìì5 8
)
ìì8 9
EstadoPedido
ìì9 E
.
ììE F
Asignado
ììF N
)
ììN O
.
îî  
ExecuteUpdateAsync
îî '
(
îî' (
s
îî( )
=>
îî* ,
s
îî- .
.
îî. /
SetProperty
îî/ :
(
îî: ;
p
îî; <
=>
îî= ?
p
îî@ A
.
îîA B
EstadoPedidoId
îîB P
,
îîP Q
(
îîR S
int
îîS V
)
îîV W
EstadoPedido
îîW c
.
îîc d
	Cancelado
îîd m
)
îîm n
)
îîn o
;
îîo p
if
ññ 
(
ññ 
filas
ññ 
==
ññ 
$num
ññ 
)
ññ 
{
óó 
await
òò 
tx
òò 
.
òò 
RollbackAsync
òò *
(
òò* +
)
òò+ ,
;
òò, -
return
ôô 
(
ôô 
false
ôô !
,
ôô! "!
MensajeNoCancelable
ôô# 6
)
ôô6 7
;
ôô7 8
}
öö 
context
úú 
.
úú $
SolicitudesCancelacion
úú .
.
úú. /
Add
úú/ 2
(
úú2 3
new
úú3 6"
SolicitudCancelacion
úú7 K
{
ùù 
PedidoId
ûû 
=
ûû 
pedido
ûû %
.
ûû% &
Id
ûû& (
,
ûû( )
Motivo
üü 
=
üü 
motivoLimpio
üü )
,
üü) *
FechaSolicitud
†† "
=
††# $
ahora
††% *
}
°° 
)
°° 
;
°° 
await
¢¢ 
context
¢¢ 
.
¢¢ 
SaveChangesAsync
¢¢ .
(
¢¢. /
)
¢¢/ 0
;
¢¢0 1
await
££ 
tx
££ 
.
££ 
CommitAsync
££ $
(
££$ %
)
££% &
;
££& '
}
§§ 
await
ßß %
RegistrarHistorialAsync
ßß )
(
ßß) *
pedido
ßß* 0
.
ßß0 1
Id
ßß1 3
,
ßß3 4
(
ßß5 6
int
ßß6 9
)
ßß9 :
EstadoPedido
ßß: F
.
ßßF G
	Cancelado
ßßG P
,
ßßP Q
null
ßßR V
,
ßßV W
$str
ßßX r
)
ßßr s
;
ßßs t
await
©© '
NotificarCancelacionAsync
©© +
(
©©+ ,
pedido
©©, 2
,
©©2 3
motivoLimpio
©©4 @
,
©©@ A
ahora
©©B G
)
©©G H
;
©©H I
return
™™ 
(
™™ 
true
™™ 
,
™™ 
null
™™ 
)
™™ 
;
™™  
}
´´ 	
catch
¨¨ 
(
¨¨ 
DbUpdateException
¨¨  
ex
¨¨! #
)
¨¨# $
{
≠≠ 	
context
ØØ 
.
ØØ 
ChangeTracker
ØØ !
.
ØØ! "
Clear
ØØ" '
(
ØØ' (
)
ØØ( )
;
ØØ) *
logger
∞∞ 
.
∞∞ 

LogWarning
∞∞ 
(
∞∞ 
ex
∞∞  
,
∞∞  !
$str
∞∞" f
,
∞∞f g
codigoLimpio
∞∞h t
)
∞∞t u
;
∞∞u v
return
±± 
(
±± 
false
±± 
,
±± '
MensajeSolicitudDuplicada
±± 4
)
±±4 5
;
±±5 6
}
≤≤ 	
catch
≥≥ 
(
≥≥ 
	Exception
≥≥ 
ex
≥≥ 
)
≥≥ 
{
¥¥ 	
context
µµ 
.
µµ 
ChangeTracker
µµ !
.
µµ! "
Clear
µµ" '
(
µµ' (
)
µµ( )
;
µµ) *
logger
∂∂ 
.
∂∂ 
LogError
∂∂ 
(
∂∂ 
ex
∂∂ 
,
∂∂ 
$str
∂∂  \
,
∂∂\ ]
codigoLimpio
∂∂^ j
)
∂∂j k
;
∂∂k l
return
∑∑ 
(
∑∑ 
false
∑∑ 
,
∑∑ %
MensajeErrorCancelacion
∑∑ 2
)
∑∑2 3
;
∑∑3 4
}
∏∏ 	
}
ππ 
private
ºº 
async
ºº 
Task
ºº '
NotificarCancelacionAsync
ºº 0
(
ºº0 1
Pedido
ºº1 7
pedido
ºº8 >
,
ºº> ?
string
ºº@ F
motivo
ººG M
,
ººM N
DateTime
ººO W
fechaUtc
ººX `
)
ºº` a
{
ΩΩ 
var
ææ 
correo
ææ 
=
ææ 
pedido
ææ 
.
ææ 
Negocio
ææ #
?
ææ# $
.
ææ$ %
Usuario
ææ% ,
?
ææ, -
.
ææ- .
Correo
ææ. 4
;
ææ4 5
if
øø 

(
øø 
string
øø 
.
øø  
IsNullOrWhiteSpace
øø %
(
øø% &
correo
øø& ,
)
øø, -
)
øø- .
return
øø/ 5
;
øø5 6
try
¡¡ 
{
¬¬ 	
var
√√ 
fecha
√√ 
=
√√ 
fechaUtc
√√  
.
√√  !
AddHours
√√! )
(
√√) *
-
√√* +
$num
√√+ ,
)
√√, -
.
√√- .
ToString
√√. 6
(
√√6 7
$str
√√7 L
,
√√L M
new
√√N Q
System
√√R X
.
√√X Y
Globalization
√√Y f
.
√√f g
CultureInfo
√√g r
(
√√r s
$str
√√s z
)
√√z {
)
√√{ |
;
√√| }
await
ƒƒ 
email
ƒƒ 
.
ƒƒ 
EnviarAsync
ƒƒ #
(
ƒƒ# $
correo
ƒƒ$ *
,
ƒƒ* +
$"
ƒƒ, .
$str
ƒƒ. 5
{
ƒƒ5 6
pedido
ƒƒ6 <
.
ƒƒ< =
Codigo
ƒƒ= C
}
ƒƒC D
$str
ƒƒD ]
"
ƒƒ] ^
,
ƒƒ^ _
PlantillaCorreo
ƒƒ` o
.
ƒƒo p
Crear
ƒƒp u
(
ƒƒu v
etiqueta
≈≈ 
:
≈≈ 
$str
≈≈ ,
,
≈≈, -
titulo
∆∆ 
:
∆∆ 
$str
∆∆ 6
,
∆∆6 7
saludo
«« 
:
«« 
$"
«« 
$str
««  
{
««  !
pedido
««! '
.
««' (
Negocio
««( /
!
««/ 0
.
««0 1
Nombre
««1 7
}
««7 8
$str
««8 9
"
««9 :
,
««: ;
parrafos
»» 
:
»» 
[
»» 
$"
»» 
$str
»» <
{
»»< =
pedido
»»= C
.
»»C D
Codigo
»»D J
}
»»J K
$str»»K £
"»»£ §
]»»§ •
,»»• ¶
datos
…… 
:
…… 
[
   
(
ÀÀ 
$str
ÀÀ 
,
ÀÀ 
pedido
ÀÀ %
.
ÀÀ% &
Codigo
ÀÀ& ,
)
ÀÀ, -
,
ÀÀ- .
(
ÃÃ 
$str
ÃÃ 
,
ÃÃ 
pedido
ÃÃ  &
.
ÃÃ& '
Cliente
ÃÃ' .
?
ÃÃ. /
.
ÃÃ/ 0
NombreCompleto
ÃÃ0 >
??
ÃÃ? A
$str
ÃÃB D
)
ÃÃD E
,
ÃÃE F
(
ÕÕ 
$str
ÕÕ +
,
ÕÕ+ ,
pedido
ÕÕ- 3
.
ÕÕ3 4
DireccionEntrega
ÕÕ4 D
)
ÕÕD E
,
ÕÕE F
(
ŒŒ 
$str
ŒŒ 
,
ŒŒ 
motivo
ŒŒ %
)
ŒŒ% &
,
ŒŒ& '
(
œœ 
$str
œœ 
,
œœ 
fecha
œœ #
)
œœ# $
]
–– 
,
–– 
nota
—— 
:
—— 
$str
—— J
,
——J K
tipoNota
““ 
:
““ 
TipoNota
““ "
.
““" #
Aviso
““# (
,
““( )
resumen
”” 
:
”” 
$"
”” 
$str
”” 8
{
””8 9
pedido
””9 ?
.
””? @
Codigo
””@ F
}
””F G
$str
””G Q
{
””Q R
motivo
””R X
}
””X Y
"
””Y Z
)
””Z [
)
””[ \
;
””\ ]
}
‘‘ 	
catch
’’ 
(
’’ 
	Exception
’’ 
ex
’’ 
)
’’ 
{
÷÷ 	
logger
◊◊ 
.
◊◊ 
LogError
◊◊ 
(
◊◊ 
ex
◊◊ 
,
◊◊ 
$str
◊◊  a
,
◊◊a b
pedido
◊◊c i
.
◊◊i j
Codigo
◊◊j p
)
◊◊p q
;
◊◊q r
}
ÿÿ 	
}
ŸŸ 
public
‹‹ 

const
‹‹ 
int
‹‹ (
MaxCaracteresObservaciones
‹‹ /
=
‹‹0 1
$num
‹‹2 5
;
‹‹5 6
private
ﬁﬁ 
const
ﬁﬁ 
string
ﬁﬁ  
MensajeTipoNovedad
ﬁﬁ +
=
ﬁﬁ, -
$str
ﬁﬁ. T
;
ﬁﬁT U
private
ﬂﬂ 
const
ﬂﬂ 
string
ﬂﬂ '
MensajeNovedadNoPermitida
ﬂﬂ 2
=
ﬂﬂ3 4
$str
ﬂﬂ5 h
;
ﬂﬂh i
private
‡‡ 
const
‡‡ 
string
‡‡ !
MensajeErrorNovedad
‡‡ ,
=
‡‡- .
$str
‡‡/ h
;
‡‡h i
public
‚‚ 

async
‚‚ 
Task
‚‚ 
<
‚‚ 
(
‚‚ 
bool
‚‚ 
Ok
‚‚ 
,
‚‚ 
string
‚‚  &
?
‚‚& '
Error
‚‚( -
)
‚‚- .
>
‚‚. /#
RegistrarNovedadAsync
‚‚0 E
(
‚‚E F
int
‚‚F I!
usuarioRepartidorId
‚‚J ]
,
‚‚] ^
int
‚‚_ b
pedidoId
‚‚c k
,
‚‚k l
int
‚‚m p
?
‚‚p q
tipoNovedadId
‚‚r 
,‚‚ Ä
string‚‚Å á
?‚‚á à
observaciones‚‚â ñ
)‚‚ñ ó
{
„„ 
if
‰‰ 

(
‰‰ 
tipoNovedadId
‰‰ 
is
‰‰ 
null
‰‰ !
||
‰‰" $
!
‰‰% &
Enum
‰‰& *
.
‰‰* +
	IsDefined
‰‰+ 4
(
‰‰4 5
typeof
‰‰5 ;
(
‰‰; <
TipoNovedad
‰‰< G
)
‰‰G H
,
‰‰H I
tipoNovedadId
‰‰J W
.
‰‰W X
Value
‰‰X ]
)
‰‰] ^
)
‰‰^ _
return
ÂÂ 
(
ÂÂ 
false
ÂÂ 
,
ÂÂ  
MensajeTipoNovedad
ÂÂ -
)
ÂÂ- .
;
ÂÂ. /
var
ÁÁ 
texto
ÁÁ 
=
ÁÁ 
observaciones
ÁÁ !
?
ÁÁ! "
.
ÁÁ" #
Trim
ÁÁ# '
(
ÁÁ' (
)
ÁÁ( )
??
ÁÁ* ,
$str
ÁÁ- /
;
ÁÁ/ 0
if
ËË 

(
ËË 
texto
ËË 
.
ËË 
Length
ËË 
>
ËË (
MaxCaracteresObservaciones
ËË 5
)
ËË5 6
return
ÈÈ 
(
ÈÈ 
false
ÈÈ 
,
ÈÈ 
$"
ÈÈ 
$str
ÈÈ C
{
ÈÈC D(
MaxCaracteresObservaciones
ÈÈD ^
}
ÈÈ^ _
$str
ÈÈ_ j
"
ÈÈj k
)
ÈÈk l
;
ÈÈl m
try
ÎÎ 
{
ÏÏ 	
var
ÌÌ 

repartidor
ÌÌ 
=
ÌÌ 
await
ÌÌ "
context
ÌÌ# *
.
ÌÌ* +
Repartidores
ÌÌ+ 7
.
ÓÓ 
AsNoTracking
ÓÓ 
(
ÓÓ 
)
ÓÓ 
.
ÔÔ !
FirstOrDefaultAsync
ÔÔ $
(
ÔÔ$ %
r
ÔÔ% &
=>
ÔÔ' )
r
ÔÔ* +
.
ÔÔ+ ,
	UsuarioId
ÔÔ, 5
==
ÔÔ6 8!
usuarioRepartidorId
ÔÔ9 L
)
ÔÔL M
;
ÔÔM N
if
ÒÒ 
(
ÒÒ 

repartidor
ÒÒ 
is
ÒÒ 
null
ÒÒ "
)
ÒÒ" #
return
ÚÚ 
(
ÚÚ 
false
ÚÚ 
,
ÚÚ 
$str
ÚÚ W
)
ÚÚW X
;
ÚÚX Y
var
ÙÙ 
pedido
ÙÙ 
=
ÙÙ 
await
ÙÙ 
context
ÙÙ &
.
ÙÙ& '
Pedidos
ÙÙ' .
.
ıı 
AsNoTracking
ıı 
(
ıı 
)
ıı 
.
ˆˆ !
FirstOrDefaultAsync
ˆˆ $
(
ˆˆ$ %
p
ˆˆ% &
=>
ˆˆ' )
p
ˆˆ* +
.
ˆˆ+ ,
Id
ˆˆ, .
==
ˆˆ/ 1
pedidoId
ˆˆ2 :
&&
ˆˆ; =
p
ˆˆ> ?
.
ˆˆ? @
RepartidorId
ˆˆ@ L
==
ˆˆM O

repartidor
ˆˆP Z
.
ˆˆZ [
Id
ˆˆ[ ]
)
ˆˆ] ^
;
ˆˆ^ _
if
¯¯ 
(
¯¯ 
pedido
¯¯ 
is
¯¯ 
null
¯¯ 
)
¯¯ 
return
˘˘ 
(
˘˘ 
false
˘˘ 
,
˘˘ 
$str
˘˘ \
)
˘˘\ ]
;
˘˘] ^
if
¸¸ 
(
¸¸ 
pedido
¸¸ 
.
¸¸ 
EstadoPedidoId
¸¸ %
==
¸¸& (
(
¸¸) *
int
¸¸* -
)
¸¸- .
EstadoPedido
¸¸. :
.
¸¸: ;
	Entregado
¸¸; D
||
¸¸E G
pedido
¸¸H N
.
¸¸N O
EstadoPedidoId
¸¸O ]
==
¸¸^ `
(
¸¸a b
int
¸¸b e
)
¸¸e f
EstadoPedido
¸¸f r
.
¸¸r s
	Cancelado
¸¸s |
)
¸¸| }
return
˝˝ 
(
˝˝ 
false
˝˝ 
,
˝˝ '
MensajeNovedadNoPermitida
˝˝ 8
)
˝˝8 9
;
˝˝9 :
context
ÄÄ 
.
ÄÄ 
NovedadesPedido
ÄÄ #
.
ÄÄ# $
Add
ÄÄ$ '
(
ÄÄ' (
new
ÄÄ( +
NovedadPedido
ÄÄ, 9
{
ÅÅ 
PedidoId
ÇÇ 
=
ÇÇ 
pedido
ÇÇ !
.
ÇÇ! "
Id
ÇÇ" $
,
ÇÇ$ %
TipoNovedadId
ÉÉ 
=
ÉÉ 
tipoNovedadId
ÉÉ  -
.
ÉÉ- .
Value
ÉÉ. 3
,
ÉÉ3 4
Observaciones
ÑÑ 
=
ÑÑ 
texto
ÑÑ  %
.
ÑÑ% &
Length
ÑÑ& ,
==
ÑÑ- /
$num
ÑÑ0 1
?
ÑÑ2 3
null
ÑÑ4 8
:
ÑÑ9 :
texto
ÑÑ; @
,
ÑÑ@ A
Fecha
ÖÖ 
=
ÖÖ 
DateTime
ÖÖ  
.
ÖÖ  !
UtcNow
ÖÖ! '
}
ÜÜ 
)
ÜÜ 
;
ÜÜ 
await
áá 
context
áá 
.
áá 
SaveChangesAsync
áá *
(
áá* +
)
áá+ ,
;
áá, -
return
àà 
(
àà 
true
àà 
,
àà 
null
àà 
)
àà 
;
àà  
}
ââ 	
catch
ää 
(
ää 
	Exception
ää 
ex
ää 
)
ää 
{
ãã 	
context
åå 
.
åå 
ChangeTracker
åå !
.
åå! "
Clear
åå" '
(
åå' (
)
åå( )
;
åå) *
logger
çç 
.
çç 
LogError
çç 
(
çç 
ex
çç 
,
çç 
$str
çç  U
,
ççU V
pedidoId
ççW _
)
çç_ `
;
çç` a
return
éé 
(
éé 
false
éé 
,
éé !
MensajeErrorNovedad
éé .
)
éé. /
;
éé/ 0
}
èè 	
}
êê 
}ëë „∞
VC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\NegocioService.cs
public 
class 
NegocioService 
( 
INegocioRepository 
negocios 
,  
IUsuarioRepository 
usuarios 
,  )
ICodigoVerificacionRepository !
codigos" )
,) *
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
 
NegocioService

 
>

 
logger

 "
)

" #
:

$ %
INegocioService

& 5
{ 
public 

const 
string "
MensajeSinVerificacion .
=/ 0
$str1 e
;e f
private 
const 
int 
MaxIntentosCodigo '
=( )
$num* +
;+ ,
private 
const 
int 
MinutosBloqueo $
=% &
$num' )
;) *
private 
const 
int !
MinutosVigenciaCodigo +
=, -
$num. 0
;0 1
private 
const 
int !
MinutosVentanaEdicion +
=, -
$num. 0
;0 1
private 
const 
string 
MensajeErrorEnvio *
=+ ,
$str- b
;b c
private 
const 
string  
MensajeErrorGuardado -
=. /
$str0 n
;n o
private 
const 
string !
MensajeCodigoExpirado .
=/ 0
$str1 i
;i j
public 

async 
Task 
< 
( 
bool 
Ok 
, 
string  &
?& '
Error( -
,- .
bool/ 3
CorreoEnviado4 A
)A B
>B C
RegistrarAsyncD R
(R S
RegistroNegocioDtoS e
dtof i
,i j
stringk q
urlRevisionr }
)} ~
{ 
var 
nombre 
= 
dto 
. 
Nombre 
.  
Trim  $
($ %
)% &
;& '
var 
	documento 
= 
dto 
. 
	Documento %
.% &
Trim& *
(* +
)+ ,
;, -
var 
correo 
= 
dto 
. 
Correo 
.  
Trim  $
($ %
)% &
;& '
var 
telefono 
= 
dto 
. 
Telefono #
.# $
Trim$ (
(( )
)) *
;* +
if   

(   
await   
negocios   
.    
ExisteDocumentoAsync   /
(  / 0
	documento  0 9
)  9 :
||  ; =
await  > C
usuarios  D L
.  L M!
ObtenerPorCorreoAsync  M b
(  b c
correo  c i
)  i j
is  k m
not  n q
null  r v
)  v w
return!! 
(!! 
false!! 
,!! 
$str!! m
,!!m n
false!!o t
)!!t u
;!!u v
if## 

(## 
await## 
negocios## 
.## 
ExisteTelefonoAsync## .
(##. /
telefono##/ 7
)##7 8
)##8 9
return$$ 
($$ 
false$$ 
,$$ 
$str$$ ;
,$$; <
false$$= B
)$$B C
;$$C D
if&& 

(&& 
dto&& 
.&& 
Password&& 
!=&& 
dto&& 
.&&  
ConfirmarPassword&&  1
||&&2 4
!&&5 6
ValidadorPassword&&6 G
.&&G H
EsValida&&H P
(&&P Q
dto&&Q T
.&&T U
Password&&U ]
)&&] ^
)&&^ _
return'' 
('' 
false'' 
,'' 
$str'' [
,''[ \
false''] b
)''b c
;''c d
var)) 
usuario)) 
=)) 
new)) 
Usuario)) !
{** 	
Correo++ 
=++ 
correo++ 
,++ 
	Documento,, 
=,, 
	documento,, !
,,,! "
Rol-- 
=-- 

RolUsuario-- 
.-- 
Negocio-- $
,--$ %
Estado.. 
=.. 
EstadoCuenta.. !
...! "
PendienteValidacion.." 5
}// 	
;//	 

usuario00 
.00 
PasswordHash00 
=00 
hasher00 %
.00% &
HashPassword00& 2
(002 3
usuario003 :
,00: ;
dto00< ?
.00? @
Password00@ H
)00H I
;00I J
var22 
negocio22 
=22 
new22 
Negocio22 !
{33 	
Nombre44 
=44 
nombre44 
,44 
TipoActividad55 
=55 
dto55 
.55  
TipoActividad55  -
.55- .
Trim55. 2
(552 3
)553 4
,554 5
Telefono66 
=66 
telefono66 
,66  
	Direccion77 
=77 
dto77 
.77 
	Direccion77 %
.77% &
Trim77& *
(77* +
)77+ ,
,77, -
FechaRegistro88 
=88 
DateTime88 $
.88$ %
UtcNow88% +
}99 	
;99	 

await;; 
negocios;; 
.;; 
RegistrarAsync;; %
(;;% &
usuario;;& -
,;;- .
negocio;;/ 6
);;6 7
;;;7 8
await>> &
AvisarAdministradoresAsync>> (
(>>( )
negocio>>) 0
,>>0 1
	documento>>2 ;
,>>; <
correo>>= C
,>>C D
urlRevision>>E P
)>>P Q
;>>Q R
tryAA 
{BB 	
awaitCC 
emailCC 
.CC 
EnviarAsyncCC #
(CC# $
correoCC$ *
,CC* +
$strCC, A
,CCA B
PlantillaCorreoCCC R
.CCR S
CrearCCS X
(CCX Y
etiquetaDD 
:DD 
$strDD -
,DD- .
tituloEE 
:EE 
$strEE /
,EE/ 0
saludoFF 
:FF 
$"FF 
$strFF  
{FF  !
nombreFF! '
}FF' (
"FF( )
,FF) *
parrafosGG 
:GG 
[HH 
$strII D
,IID E
$strJJ f
]KK 
,KK 
datosLL 
:LL 
[LL 
(LL 
$strLL "
,LL" #
nombreLL$ *
)LL* +
,LL+ ,
(LL- .
$strLL. 9
,LL9 :
	documentoLL; D
)LLD E
,LLE F
(LLG H
$strLLH P
,LLP Q
correoLLR X
)LLX Y
,LLY Z
(LL[ \
$strLL\ d
,LLd e
$strLLf 
)	LL Ä
]
LLÄ Å
,
LLÅ Ç
notaMM 
:MM 
$strMM T
,MMT U
tipoNotaNN 
:NN 
TipoNotaNN "
.NN" #
InfoNN# '
)NN' (
)NN( )
;NN) *
returnOO 
(OO 
trueOO 
,OO 
nullOO 
,OO 
trueOO  $
)OO$ %
;OO% &
}PP 	
catchQQ 
(QQ 
	ExceptionQQ 
exQQ 
)QQ 
{RR 	
loggerSS 
.SS 
LogErrorSS 
(SS 
exSS 
,SS 
$strSS  d
,SSd e
correoSSf l
)SSl m
;SSm n
returnTT 
(TT 
trueTT 
,TT 
nullTT 
,TT 
falseTT  %
)TT% &
;TT& '
}UU 	
}VV 
privateYY 
asyncYY 
TaskYY &
AvisarAdministradoresAsyncYY 1
(YY1 2
NegocioYY2 9
negocioYY: A
,YYA B
stringYYC I
	documentoYYJ S
,YYS T
stringYYU [
correoYY\ b
,YYb c
stringYYd j
urlRevisionYYk v
)YYv w
{ZZ 
try[[ 
{\\ 	
var]] 
administradores]] 
=]]  !
await]]" '
usuarios]]( 0
.]]0 1.
"CorreosAdministradoresActivosAsync]]1 S
(]]S T
)]]T U
;]]U V
if^^ 
(^^ 
administradores^^ 
.^^  
Count^^  %
==^^& (
$num^^) *
)^^* +
return^^, 2
;^^2 3
var`` 
aviso`` 
=`` 
PlantillaCorreo`` '
.``' (
Crear``( -
(``- .
etiquetaaa 
:aa 
$straa 0
,aa0 1
titulobb 
:bb 
$strbb @
,bb@ A
saludocc 
:cc 
$strcc 
,cc  
parrafosdd 
:dd 
[ee 
$"ff 
$strff 
{ff 
negocioff  
.ff  !
Nombreff! '
}ff' (
$strff( i
"ffi j
,ffj k
$strgg V
]hh 
,hh 
datosii 
:ii 
[jj 
(kk 
$strkk 
,kk 
negociokk  '
.kk' (
Nombrekk( .
)kk. /
,kk/ 0
(kk1 2
$strkk2 =
,kk= >
negociokk? F
.kkF G
TipoActividadkkG T
)kkT U
,kkU V
(kkW X
$strkkX c
,kkc d
	documentokke n
)kkn o
,kko p
(ll 
$strll 
,ll 
correoll %
)ll% &
,ll& '
(ll( )
$strll) 3
,ll3 4
negocioll5 <
.ll< =
Telefonoll= E
)llE F
,llF G
(llH I
$strllI T
,llT U
negociollV ]
.ll] ^
	Direccionll^ g
)llg h
]mm 
,mm 

textoBotonnn 
:nn 
$strnn /
,nn/ 0
urlBotonoo 
:oo 
urlRevisionoo %
,oo% &
notapp 
:pp 
$strpp [
,pp[ \
tipoNotaqq 
:qq 
TipoNotaqq "
.qq" #
Infoqq# '
,qq' (
resumenrr 
:rr 
$"rr 
{rr 
negociorr #
.rr# $
Nombrerr$ *
}rr* +
$strrr+ O
"rrO P
)rrP Q
;rrQ R
awaituu 
Taskuu 
.uu 
WhenAlluu 
(uu 
administradoresuu .
.uu. /
Selectuu/ 5
(uu5 6
asyncuu6 ;
parauu< @
=>uuA C
{vv 
tryww 
{xx 
awaityy 
emailyy 
.yy  
EnviarAsyncyy  +
(yy+ ,
parayy, 0
,yy0 1
$stryy2 c
,yyc d
avisoyye j
)yyj k
;yyk l
}zz 
catch{{ 
({{ 
	Exception{{  
ex{{! #
){{# $
{|| 
logger}} 
.}} 

LogWarning}} %
(}}% &
ex}}& (
,}}( )
$str}}* m
,}}m n
para}}o s
,}}s t
negocio}}u |
.}}| }
Nombre	}}} É
)
}}É Ñ
;
}}Ñ Ö
}~~ 
} 
) 
) 
; 
}
ÄÄ 	
catch
ÅÅ 
(
ÅÅ 
	Exception
ÅÅ 
ex
ÅÅ 
)
ÅÅ 
{
ÇÇ 	
logger
ÉÉ 
.
ÉÉ 
LogError
ÉÉ 
(
ÉÉ 
ex
ÉÉ 
,
ÉÉ 
$str
ÉÉ  _
,
ÉÉ_ `
negocio
ÉÉa h
.
ÉÉh i
Nombre
ÉÉi o
)
ÉÉo p
;
ÉÉp q
}
ÑÑ 	
}
ÖÖ 
public
àà 

async
àà 
Task
àà 
<
àà 
PerfilNegocioDto
àà &
?
àà& '
>
àà' ( 
ObtenerPerfilAsync
àà) ;
(
àà; <
int
àà< ?
	usuarioId
àà@ I
)
ààI J
{
ââ 
var
ää 
usuario
ää 
=
ää 
await
ää 
usuarios
ää $
.
ää$ %
ObtenerPorIdAsync
ää% 6
(
ää6 7
	usuarioId
ää7 @
)
ää@ A
;
ääA B
var
ãã 
negocio
ãã 
=
ãã 
await
ãã 
negocios
ãã $
.
ãã$ %&
ObtenerPorUsuarioIdAsync
ãã% =
(
ãã= >
	usuarioId
ãã> G
)
ããG H
;
ããH I
if
åå 

(
åå 
usuario
åå 
is
åå 
null
åå 
||
åå 
negocio
åå &
is
åå' )
null
åå* .
)
åå. /
return
åå0 6
null
åå7 ;
;
åå; <
return
éé 
new
éé 
PerfilNegocioDto
éé #
{
èè 	
Id
êê 
=
êê 
negocio
êê 
.
êê 
Id
êê 
,
êê 
Nombre
ëë 
=
ëë 
negocio
ëë 
.
ëë 
Nombre
ëë #
,
ëë# $
TipoActividad
íí 
=
íí 
negocio
íí #
.
íí# $
TipoActividad
íí$ 1
,
íí1 2
	Documento
ìì 
=
ìì 
usuario
ìì 
.
ìì  
	Documento
ìì  )
,
ìì) *
Correo
îî 
=
îî 
usuario
îî 
.
îî 
Correo
îî #
,
îî# $
Telefono
ïï 
=
ïï 
negocio
ïï 
.
ïï 
Telefono
ïï '
,
ïï' (
	Direccion
ññ 
=
ññ 
negocio
ññ 
.
ññ  
	Direccion
ññ  )
,
ññ) *
FechaRegistro
óó 
=
óó 
negocio
óó #
.
óó# $
FechaRegistro
óó$ 1
,
óó1 2
Estado
òò 
=
òò 
usuario
òò 
.
òò 
Estado
òò #
}
ôô 	
;
ôô	 

}
öö 
public
ùù 

async
ùù 
Task
ùù 
<
ùù %
PerfilPublicoNegocioDto
ùù -
?
ùù- .
>
ùù. /'
ObtenerPerfilPublicoAsync
ùù0 I
(
ùùI J
int
ùùJ M
	negocioId
ùùN W
)
ùùW X
{
ûû 
var
üü 
negocio
üü 
=
üü 
await
üü 
negocios
üü $
.
üü$ %
BuscarPorIdAsync
üü% 5
(
üü5 6
	negocioId
üü6 ?
)
üü? @
;
üü@ A
if
†† 

(
†† 
negocio
†† 
is
†† 
null
†† 
)
†† 
return
†† #
null
††$ (
;
††( )
return
¢¢ 
new
¢¢ %
PerfilPublicoNegocioDto
¢¢ *
{
££ 	
Nombre
§§ 
=
§§ 
negocio
§§ 
.
§§ 
Nombre
§§ #
,
§§# $
TipoActividad
•• 
=
•• 
negocio
•• #
.
••# $
TipoActividad
••$ 1
,
••1 2
	Direccion
¶¶ 
=
¶¶ 
negocio
¶¶ 
.
¶¶  
	Direccion
¶¶  )
,
¶¶) *
Telefono
ßß 
=
ßß 
negocio
ßß 
.
ßß 
Telefono
ßß '
,
ßß' (
FechaRegistro
®® 
=
®® 
negocio
®® #
.
®®# $
FechaRegistro
®®$ 1
}
©© 	
;
©©	 

}
™™ 
public
≠≠ 

async
≠≠ 
Task
≠≠ 
<
≠≠ 
(
≠≠ 
bool
≠≠ 
Ok
≠≠ 
,
≠≠ 
string
≠≠  &
?
≠≠& '
Error
≠≠( -
)
≠≠- .
>
≠≠. /"
SolicitarCodigoAsync
≠≠0 D
(
≠≠D E
int
≠≠E H
	usuarioId
≠≠I R
)
≠≠R S
{
ÆÆ 
var
ØØ 
usuario
ØØ 
=
ØØ 
await
ØØ 
usuarios
ØØ $
.
ØØ$ %
ObtenerPorIdAsync
ØØ% 6
(
ØØ6 7
	usuarioId
ØØ7 @
)
ØØ@ A
;
ØØA B
if
∞∞ 

(
∞∞ 
usuario
∞∞ 
is
∞∞ 
null
∞∞ 
)
∞∞ 
return
∞∞ #
(
∞∞$ %
false
∞∞% *
,
∞∞* +
MensajeErrorEnvio
∞∞, =
)
∞∞= >
;
∞∞> ?
var
≥≥ 
ultimo
≥≥ 
=
≥≥ 
await
≥≥ 
codigos
≥≥ "
.
≥≥" # 
ObtenerUltimoAsync
≥≥# 5
(
≥≥5 6
	usuarioId
≥≥6 ?
)
≥≥? @
;
≥≥@ A
if
¥¥ 

(
¥¥ 
ultimo
¥¥ 
?
¥¥ 
.
¥¥ 
BloqueadoHasta
¥¥ "
is
¥¥# %
{
¥¥& '
}
¥¥( )
hasta
¥¥* /
&&
¥¥0 2
hasta
¥¥3 8
>
¥¥9 :
DateTime
¥¥; C
.
¥¥C D
UtcNow
¥¥D J
)
¥¥J K
return
µµ 
(
µµ 
false
µµ 
,
µµ 
MensajeBloqueo
µµ )
(
µµ) *
hasta
µµ* /
)
µµ/ 0
)
µµ0 1
;
µµ1 2
var
∑∑ 
codigo
∑∑ 
=
∑∑ #
RandomNumberGenerator
∑∑ *
.
∑∑* +
GetInt32
∑∑+ 3
(
∑∑3 4
$num
∑∑4 :
,
∑∑: ;
$num
∑∑< C
)
∑∑C D
.
∑∑D E
ToString
∑∑E M
(
∑∑M N
)
∑∑N O
;
∑∑O P
try
ππ 
{
∫∫ 	
await
ªª 
codigos
ªª 
.
ªª 
AgregarAsync
ªª &
(
ªª& '
new
ªª' * 
CodigoVerificacion
ªª+ =
{
ºº 
	UsuarioId
ΩΩ 
=
ΩΩ 
	usuarioId
ΩΩ %
,
ΩΩ% &

CodigoHash
ææ 
=
ææ 
	TokenUtil
ææ &
.
ææ& '
Hash
ææ' +
(
ææ+ ,
codigo
ææ, 2
)
ææ2 3
,
ææ3 4
Expira
øø 
=
øø 
DateTime
øø !
.
øø! "
UtcNow
øø" (
.
øø( )

AddMinutes
øø) 3
(
øø3 4#
MinutosVigenciaCodigo
øø4 I
)
øøI J
}
¿¿ 
)
¿¿ 
;
¿¿ 
await
¬¬ 
email
¬¬ 
.
¬¬ 
EnviarAsync
¬¬ #
(
¬¬# $
usuario
¬¬$ +
.
¬¬+ ,
Correo
¬¬, 2
,
¬¬2 3
$str
¬¬4 Y
,
¬¬Y Z
PlantillaCorreo
¬¬[ j
.
¬¬j k
Crear
¬¬k p
(
¬¬p q
etiqueta
√√ 
:
√√ 
$str
√√ 5
,
√√5 6
titulo
ƒƒ 
:
ƒƒ 
$str
ƒƒ .
,
ƒƒ. /
saludo
≈≈ 
:
≈≈ 
$str
≈≈ 
,
≈≈  
parrafos
∆∆ 
:
∆∆ 
[
∆∆ 
$str
∆∆ d
]
∆∆d e
,
∆∆e f
codigo
«« 
:
«« 
codigo
«« 
,
«« 
nota
»» 
:
»» 
$"
»» 
$str
»» 0
{
»»0 1#
MinutosVigenciaCodigo
»»1 F
}
»»F G
$str»»G ¢
"»»¢ £
,»»£ §
tipoNota
…… 
:
…… 
TipoNota
…… "
.
……" #
Aviso
……# (
,
……( )
resumen
   
:
   
$"
   
$str
   8
{
  8 9
codigo
  9 ?
}
  ? @
$str
  @ K
{
  K L#
MinutosVigenciaCodigo
  L a
}
  a b
$str
  b k
"
  k l
)
  l m
)
  m n
;
  n o
return
ÀÀ 
(
ÀÀ 
true
ÀÀ 
,
ÀÀ 
null
ÀÀ 
)
ÀÀ 
;
ÀÀ  
}
ÃÃ 	
catch
ÕÕ 
(
ÕÕ 
	Exception
ÕÕ 
ex
ÕÕ 
)
ÕÕ 
{
ŒŒ 	
logger
œœ 
.
œœ 
LogError
œœ 
(
œœ 
ex
œœ 
,
œœ 
$str
œœ  d
,
œœd e
	usuarioId
œœf o
)
œœo p
;
œœp q
return
–– 
(
–– 
false
–– 
,
–– 
MensajeErrorEnvio
–– ,
)
––, -
;
––- .
}
—— 	
}
““ 
public
‘‘ 

async
‘‘ 
Task
‘‘ 
<
‘‘ 
(
‘‘ 
bool
‘‘ 
Ok
‘‘ 
,
‘‘ 
string
‘‘  &
?
‘‘& '
Error
‘‘( -
)
‘‘- .
>
‘‘. /"
VerificarCodigoAsync
‘‘0 D
(
‘‘D E
int
‘‘E H
	usuarioId
‘‘I R
,
‘‘R S
string
‘‘T Z
codigo
‘‘[ a
)
‘‘a b
{
’’ 
var
÷÷ 
actual
÷÷ 
=
÷÷ 
await
÷÷ 
codigos
÷÷ "
.
÷÷" # 
ObtenerUltimoAsync
÷÷# 5
(
÷÷5 6
	usuarioId
÷÷6 ?
)
÷÷? @
;
÷÷@ A
var
◊◊ 
ahora
◊◊ 
=
◊◊ 
DateTime
◊◊ 
.
◊◊ 
UtcNow
◊◊ #
;
◊◊# $
if
ŸŸ 

(
ŸŸ 
actual
ŸŸ 
is
ŸŸ 
null
ŸŸ 
)
ŸŸ 
return
ŸŸ "
(
ŸŸ# $
false
ŸŸ$ )
,
ŸŸ) *#
MensajeCodigoExpirado
ŸŸ+ @
)
ŸŸ@ A
;
ŸŸA B
if
€€ 

(
€€ 
actual
€€ 
.
€€ 
BloqueadoHasta
€€ !
is
€€" $
{
€€% &
}
€€' (
hasta
€€) .
&&
€€/ 1
hasta
€€2 7
>
€€8 9
ahora
€€: ?
)
€€? @
return
‹‹ 
(
‹‹ 
false
‹‹ 
,
‹‹ 
MensajeBloqueo
‹‹ )
(
‹‹) *
hasta
‹‹* /
)
‹‹/ 0
)
‹‹0 1
;
‹‹1 2
if
ﬁﬁ 

(
ﬁﬁ 
actual
ﬁﬁ 
.
ﬁﬁ 

Verificado
ﬁﬁ 
||
ﬁﬁ  
actual
ﬁﬁ! '
.
ﬁﬁ' (
Usado
ﬁﬁ( -
||
ﬁﬁ. 0
actual
ﬁﬁ1 7
.
ﬁﬁ7 8
Expira
ﬁﬁ8 >
<=
ﬁﬁ? A
ahora
ﬁﬁB G
)
ﬁﬁG H
return
ﬂﬂ 
(
ﬂﬂ 
false
ﬂﬂ 
,
ﬂﬂ #
MensajeCodigoExpirado
ﬂﬂ 0
)
ﬂﬂ0 1
;
ﬂﬂ1 2
if
·· 

(
·· 
actual
·· 
.
·· 

CodigoHash
·· 
!=
··  
	TokenUtil
··! *
.
··* +
Hash
··+ /
(
··/ 0
codigo
··0 6
.
··6 7
Trim
··7 ;
(
··; <
)
··< =
)
··= >
)
··> ?
{
‚‚ 	
actual
„„ 
.
„„ 
Intentos
„„ 
++
„„ 
;
„„ 
var
‰‰ 
error
‰‰ 
=
‰‰ 
$str
‰‰ ?
;
‰‰? @
if
ÊÊ 
(
ÊÊ 
actual
ÊÊ 
.
ÊÊ 
Intentos
ÊÊ 
>=
ÊÊ  "
MaxIntentosCodigo
ÊÊ# 4
)
ÊÊ4 5
{
ÁÁ 
actual
ËË 
.
ËË 
BloqueadoHasta
ËË %
=
ËË& '
ahora
ËË( -
.
ËË- .

AddMinutes
ËË. 8
(
ËË8 9
MinutosBloqueo
ËË9 G
)
ËËG H
;
ËËH I
error
ÈÈ 
=
ÈÈ 
$"
ÈÈ 
$str
ÈÈ $
{
ÈÈ$ %
MaxIntentosCodigo
ÈÈ% 6
}
ÈÈ6 7
$str
ÈÈ7 {
{
ÈÈ{ |
MinutosBloqueoÈÈ| ä
}ÈÈä ã
$strÈÈã î
"ÈÈî ï
;ÈÈï ñ
}
ÍÍ 
await
ÏÏ 
codigos
ÏÏ 
.
ÏÏ 
ActualizarAsync
ÏÏ )
(
ÏÏ) *
actual
ÏÏ* 0
)
ÏÏ0 1
;
ÏÏ1 2
return
ÌÌ 
(
ÌÌ 
false
ÌÌ 
,
ÌÌ 
error
ÌÌ  
)
ÌÌ  !
;
ÌÌ! "
}
ÓÓ 	
actual
 
.
 

Verificado
 
=
 
true
  
;
  !
actual
ÒÒ 
.
ÒÒ 
Expira
ÒÒ 
=
ÒÒ 
ahora
ÒÒ 
.
ÒÒ 

AddMinutes
ÒÒ (
(
ÒÒ( )#
MinutosVentanaEdicion
ÒÒ) >
)
ÒÒ> ?
;
ÒÒ? @
await
ÚÚ 
codigos
ÚÚ 
.
ÚÚ 
ActualizarAsync
ÚÚ %
(
ÚÚ% &
actual
ÚÚ& ,
)
ÚÚ, -
;
ÚÚ- .
return
ÛÛ 
(
ÛÛ 
true
ÛÛ 
,
ÛÛ 
null
ÛÛ 
)
ÛÛ 
;
ÛÛ 
}
ÙÙ 
public
ˆˆ 

async
ˆˆ 
Task
ˆˆ 
<
ˆˆ 
bool
ˆˆ 
>
ˆˆ $
EdicionAutorizadaAsync
ˆˆ 2
(
ˆˆ2 3
int
ˆˆ3 6
	usuarioId
ˆˆ7 @
)
ˆˆ@ A
{
˜˜ 
var
¯¯ 
c
¯¯ 
=
¯¯ 
await
¯¯ 
codigos
¯¯ 
.
¯¯  
ObtenerUltimoAsync
¯¯ 0
(
¯¯0 1
	usuarioId
¯¯1 :
)
¯¯: ;
;
¯¯; <
return
˘˘ 
c
˘˘ 
is
˘˘ 
{
˘˘ 

Verificado
˘˘  
:
˘˘  !
true
˘˘" &
,
˘˘& '
Usado
˘˘( -
:
˘˘- .
false
˘˘/ 4
}
˘˘5 6
&&
˘˘7 9
c
˘˘: ;
.
˘˘; <
Expira
˘˘< B
>
˘˘C D
DateTime
˘˘E M
.
˘˘M N
UtcNow
˘˘N T
;
˘˘T U
}
˙˙ 
public
¸¸ 

async
¸¸ 
Task
¸¸ 
<
¸¸ 
EditarNegocioDto
¸¸ &
?
¸¸& '
>
¸¸' ($
ObtenerParaEditarAsync
¸¸) ?
(
¸¸? @
int
¸¸@ C
	usuarioId
¸¸D M
)
¸¸M N
{
˝˝ 
var
˛˛ 
usuario
˛˛ 
=
˛˛ 
await
˛˛ 
usuarios
˛˛ $
.
˛˛$ %
ObtenerPorIdAsync
˛˛% 6
(
˛˛6 7
	usuarioId
˛˛7 @
)
˛˛@ A
;
˛˛A B
var
ˇˇ 
negocio
ˇˇ 
=
ˇˇ 
await
ˇˇ 
negocios
ˇˇ $
.
ˇˇ$ %&
ObtenerPorUsuarioIdAsync
ˇˇ% =
(
ˇˇ= >
	usuarioId
ˇˇ> G
)
ˇˇG H
;
ˇˇH I
if
ÄÄ 

(
ÄÄ 
usuario
ÄÄ 
is
ÄÄ 
null
ÄÄ 
||
ÄÄ 
negocio
ÄÄ &
is
ÄÄ' )
null
ÄÄ* .
)
ÄÄ. /
return
ÄÄ0 6
null
ÄÄ7 ;
;
ÄÄ; <
return
ÇÇ 
new
ÇÇ 
EditarNegocioDto
ÇÇ #
{
ÉÉ 	
Nombre
ÑÑ 
=
ÑÑ 
negocio
ÑÑ 
.
ÑÑ 
Nombre
ÑÑ #
,
ÑÑ# $
TipoActividad
ÖÖ 
=
ÖÖ 
negocio
ÖÖ #
.
ÖÖ# $
TipoActividad
ÖÖ$ 1
,
ÖÖ1 2
Correo
ÜÜ 
=
ÜÜ 
usuario
ÜÜ 
.
ÜÜ 
Correo
ÜÜ #
,
ÜÜ# $
Telefono
áá 
=
áá 
negocio
áá 
.
áá 
Telefono
áá '
,
áá' (
	Direccion
àà 
=
àà 
negocio
àà 
.
àà  
	Direccion
àà  )
}
ââ 	
;
ââ	 

}
ää 
public
åå 

async
åå 
Task
åå 
<
åå 
(
åå 
bool
åå 
Ok
åå 
,
åå 
string
åå  &
?
åå& '
Error
åå( -
)
åå- .
>
åå. /
EditarAsync
åå0 ;
(
åå; <
int
åå< ?
	usuarioId
åå@ I
,
ååI J
EditarNegocioDto
ååK [
dto
åå\ _
)
åå_ `
{
çç 
if
éé 

(
éé 
!
éé 
await
éé $
EdicionAutorizadaAsync
éé )
(
éé) *
	usuarioId
éé* 3
)
éé3 4
)
éé4 5
return
éé6 <
(
éé= >
false
éé> C
,
ééC D$
MensajeSinVerificacion
ééE [
)
éé[ \
;
éé\ ]
try
êê 
{
ëë 	
var
íí 
usuario
íí 
=
íí 
await
íí 
usuarios
íí  (
.
íí( )
ObtenerPorIdAsync
íí) :
(
íí: ;
	usuarioId
íí; D
)
ííD E
;
ííE F
var
ìì 
negocio
ìì 
=
ìì 
await
ìì 
negocios
ìì  (
.
ìì( )&
ObtenerPorUsuarioIdAsync
ìì) A
(
ììA B
	usuarioId
ììB K
)
ììK L
;
ììL M
if
îî 
(
îî 
usuario
îî 
is
îî 
null
îî 
||
îî  "
negocio
îî# *
is
îî+ -
null
îî. 2
)
îî2 3
return
îî4 :
(
îî; <
false
îî< A
,
îîA B"
MensajeErrorGuardado
îîC W
)
îîW X
;
îîX Y
var
ññ 
correo
ññ 
=
ññ 
dto
ññ 
.
ññ 
Correo
ññ #
.
ññ# $
Trim
ññ$ (
(
ññ( )
)
ññ) *
;
ññ* +
var
óó 
telefono
óó 
=
óó 
dto
óó 
.
óó 
Telefono
óó '
.
óó' (
Trim
óó( ,
(
óó, -
)
óó- .
;
óó. /
var
ôô 
otroConCorreo
ôô 
=
ôô 
await
ôô  %
usuarios
ôô& .
.
ôô. /#
ObtenerPorCorreoAsync
ôô/ D
(
ôôD E
correo
ôôE K
)
ôôK L
;
ôôL M
if
öö 
(
öö 
otroConCorreo
öö 
is
öö  
not
öö! $
null
öö% )
&&
öö* ,
otroConCorreo
öö- :
.
öö: ;
Id
öö; =
!=
öö> @
usuario
ööA H
.
ööH I
Id
ööI K
)
ööK L
return
õõ 
(
õõ 
false
õõ 
,
õõ 
$str
õõ L
)
õõL M
;
õõM N
if
ùù 
(
ùù 
await
ùù 
negocios
ùù 
.
ùù !
ExisteTelefonoAsync
ùù 2
(
ùù2 3
telefono
ùù3 ;
,
ùù; <
negocio
ùù= D
.
ùùD E
Id
ùùE G
)
ùùG H
)
ùùH I
return
ûû 
(
ûû 
false
ûû 
,
ûû 
$str
ûû O
)
ûûO P
;
ûûP Q
negocio
†† 
.
†† 
Nombre
†† 
=
†† 
dto
††  
.
††  !
Nombre
††! '
.
††' (
Trim
††( ,
(
††, -
)
††- .
;
††. /
negocio
°° 
.
°° 
TipoActividad
°° !
=
°°" #
dto
°°$ '
.
°°' (
TipoActividad
°°( 5
.
°°5 6
Trim
°°6 :
(
°°: ;
)
°°; <
;
°°< =
negocio
¢¢ 
.
¢¢ 
Telefono
¢¢ 
=
¢¢ 
telefono
¢¢ '
;
¢¢' (
negocio
££ 
.
££ 
	Direccion
££ 
=
££ 
dto
££  #
.
££# $
	Direccion
££$ -
.
££- .
Trim
££. 2
(
££2 3
)
££3 4
;
££4 5
usuario
§§ 
.
§§ 
Correo
§§ 
=
§§ 
correo
§§ #
;
§§# $
await
¶¶ 
negocios
¶¶ 
.
¶¶ 
ActualizarAsync
¶¶ *
(
¶¶* +
negocio
¶¶+ 2
)
¶¶2 3
;
¶¶3 4
await
ßß 
usuarios
ßß 
.
ßß 
ActualizarAsync
ßß *
(
ßß* +
usuario
ßß+ 2
)
ßß2 3
;
ßß3 4
var
™™ 
codigo
™™ 
=
™™ 
await
™™ 
codigos
™™ &
.
™™& ' 
ObtenerUltimoAsync
™™' 9
(
™™9 :
	usuarioId
™™: C
)
™™C D
;
™™D E
if
´´ 
(
´´ 
codigo
´´ 
is
´´ 
not
´´ 
null
´´ "
)
´´" #
{
¨¨ 
codigo
≠≠ 
.
≠≠ 
Usado
≠≠ 
=
≠≠ 
true
≠≠ #
;
≠≠# $
await
ÆÆ 
codigos
ÆÆ 
.
ÆÆ 
ActualizarAsync
ÆÆ -
(
ÆÆ- .
codigo
ÆÆ. 4
)
ÆÆ4 5
;
ÆÆ5 6
}
ØØ 
return
±± 
(
±± 
true
±± 
,
±± 
null
±± 
)
±± 
;
±±  
}
≤≤ 	
catch
≥≥ 
(
≥≥ 
	Exception
≥≥ 
ex
≥≥ 
)
≥≥ 
{
¥¥ 	
logger
µµ 
.
µµ 
LogError
µµ 
(
µµ 
ex
µµ 
,
µµ 
$str
µµ  W
,
µµW X
	usuarioId
µµY b
)
µµb c
;
µµc d
return
∂∂ 
(
∂∂ 
false
∂∂ 
,
∂∂ "
MensajeErrorGuardado
∂∂ /
)
∂∂/ 0
;
∂∂0 1
}
∑∑ 	
}
∏∏ 
public
ªª 

async
ªª 
Task
ªª 
<
ªª 
(
ªª 
bool
ªª 
Ok
ªª 
,
ªª 
string
ªª  &
?
ªª& '
Error
ªª( -
)
ªª- .
>
ªª. /%
ValidarEliminacionAsync
ªª0 G
(
ªªG H
int
ªªH K
	usuarioId
ªªL U
,
ªªU V
string
ªªW ]
password
ªª^ f
)
ªªf g
{
ºº 
var
ΩΩ 
usuario
ΩΩ 
=
ΩΩ 
await
ΩΩ 
usuarios
ΩΩ $
.
ΩΩ$ %
ObtenerPorIdAsync
ΩΩ% 6
(
ΩΩ6 7
	usuarioId
ΩΩ7 @
)
ΩΩ@ A
;
ΩΩA B
if
ææ 

(
ææ 
usuario
ææ 
is
ææ 
null
ææ 
)
ææ 
return
ææ #
(
ææ$ %
false
ææ% *
,
ææ* +
$str
ææ, N
)
ææN O
;
ææO P
if
¿¿ 

(
¿¿ 
hasher
¿¿ 
.
¿¿ "
VerifyHashedPassword
¿¿ '
(
¿¿' (
usuario
¿¿( /
,
¿¿/ 0
usuario
¿¿1 8
.
¿¿8 9
PasswordHash
¿¿9 E
,
¿¿E F
password
¿¿G O
)
¿¿O P
==
¿¿Q S(
PasswordVerificationResult
¿¿T n
.
¿¿n o
Failed
¿¿o u
)
¿¿u v
return
¡¡ 
(
¡¡ 
false
¡¡ 
,
¡¡ 
$str
¡¡ 2
)
¡¡2 3
;
¡¡3 4
var
√√ 
negocio
√√ 
=
√√ 
await
√√ 
negocios
√√ $
.
√√$ %&
ObtenerPorUsuarioIdAsync
√√% =
(
√√= >
	usuarioId
√√> G
)
√√G H
;
√√H I
if
ƒƒ 

(
ƒƒ 
negocio
ƒƒ 
is
ƒƒ 
null
ƒƒ 
)
ƒƒ 
return
ƒƒ #
(
ƒƒ$ %
false
ƒƒ% *
,
ƒƒ* +
$str
ƒƒ, N
)
ƒƒN O
;
ƒƒO P
if
∆∆ 

(
∆∆ 
await
∆∆ 
negocios
∆∆ 
.
∆∆ &
TienePedidosActivosAsync
∆∆ 3
(
∆∆3 4
negocio
∆∆4 ;
.
∆∆; <
Id
∆∆< >
)
∆∆> ?
)
∆∆? @
return
«« 
(
«« 
false
«« 
,
«« 
$str
«« Z
)
««Z [
;
««[ \
if
…… 

(
…… 
await
…… 
negocios
…… 
.
…… .
 TieneRepartidoresVinculadosAsync
…… ;
(
……; <
negocio
……< C
.
……C D
Id
……D F
)
……F G
)
……G H
return
   
(
   
false
   
,
   
$str
   d
)
  d e
;
  e f
return
ÃÃ 
(
ÃÃ 
true
ÃÃ 
,
ÃÃ 
null
ÃÃ 
)
ÃÃ 
;
ÃÃ 
}
ÕÕ 
public
œœ 

async
œœ 
Task
œœ 
<
œœ 
(
œœ 
bool
œœ 
Ok
œœ 
,
œœ 
string
œœ  &
?
œœ& '
Error
œœ( -
)
œœ- .
>
œœ. /!
EliminarCuentaAsync
œœ0 C
(
œœC D
int
œœD G
	usuarioId
œœH Q
,
œœQ R
string
œœS Y
password
œœZ b
)
œœb c
{
–– 
var
““ 
(
““ 
ok
““ 
,
““ 
error
““ 
)
““ 
=
““ 
await
““ %
ValidarEliminacionAsync
““  7
(
““7 8
	usuarioId
““8 A
,
““A B
password
““C K
)
““K L
;
““L M
if
”” 

(
”” 
!
”” 
ok
”” 
)
”” 
return
”” 
(
”” 
false
”” 
,
”” 
error
””  %
)
””% &
;
””& '
var
’’ 
usuario
’’ 
=
’’ 
await
’’ 
usuarios
’’ $
.
’’$ %
ObtenerPorIdAsync
’’% 6
(
’’6 7
	usuarioId
’’7 @
)
’’@ A
;
’’A B
if
÷÷ 

(
÷÷ 
usuario
÷÷ 
is
÷÷ 
null
÷÷ 
)
÷÷ 
return
÷÷ #
(
÷÷$ %
false
÷÷% *
,
÷÷* +
$str
÷÷, N
)
÷÷N O
;
÷÷O P
usuario
ŸŸ 
.
ŸŸ 
Estado
ŸŸ 
=
ŸŸ 
EstadoCuenta
ŸŸ %
.
ŸŸ% &
	Eliminado
ŸŸ& /
;
ŸŸ/ 0
await
⁄⁄ 
usuarios
⁄⁄ 
.
⁄⁄ 
ActualizarAsync
⁄⁄ &
(
⁄⁄& '
usuario
⁄⁄' .
)
⁄⁄. /
;
⁄⁄/ 0
return
€€ 
(
€€ 
true
€€ 
,
€€ 
null
€€ 
)
€€ 
;
€€ 
}
‹‹ 
private
ﬁﬁ 
static
ﬁﬁ 
string
ﬁﬁ 
MensajeBloqueo
ﬁﬁ (
(
ﬁﬁ( )
DateTime
ﬁﬁ) 1
hasta
ﬁﬁ2 7
)
ﬁﬁ7 8
{
ﬂﬂ 
var
‡‡ 
minutos
‡‡ 
=
‡‡ 
Math
‡‡ 
.
‡‡ 
Max
‡‡ 
(
‡‡ 
$num
‡‡  
,
‡‡  !
(
‡‡" #
int
‡‡# &
)
‡‡& '
Math
‡‡' +
.
‡‡+ ,
Ceiling
‡‡, 3
(
‡‡3 4
(
‡‡4 5
hasta
‡‡5 :
-
‡‡; <
DateTime
‡‡= E
.
‡‡E F
UtcNow
‡‡F L
)
‡‡L M
.
‡‡M N
TotalMinutes
‡‡N Z
)
‡‡Z [
)
‡‡[ \
;
‡‡\ ]
return
·· 
$"
·· 
$str
·· c
{
··c d
minutos
··d k
}
··k l
$str
··l w
"
··w x
;
··x y
}
‚‚ 
}„„ Ì	
YC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\IUbicacionService.cs
public 
	interface 
IUbicacionService "
{ 
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
)  !
>! "
ActualizarAsync# 2
(2 3
int3 6
repartidorUsuarioId7 J
,J K
intL O
pedidoIdP X
,X Y
decimalZ a
latb e
,e f
decimalg n
lngo r
)r s
;s t
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
,  !
decimal" )
?) *
Latitud+ 2
,2 3
decimal4 ;
?; <
Longitud= E
,E F
DateTimeG O
?O P
FechaUtcQ Y
,Y Z
string[ a
?a b
Estadoc i
)i j
>j k"
ObtenerPorCodigoAsync	l Å
(
Å Ç
string
Ç à
codigoPedido
â ï
)
ï ñ
;
ñ ó
} º
WC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\IReporteService.cs
public 
	interface 
IReporteService  
{ 
Task 
< 	
ReporteNegocioDto	 
? 
> &
GenerarReporteNegocioAsync 7
(7 8
int8 ;
usuarioNegocioId< L
,L M
DateTimeN V
desdeW \
,\ ]
DateTime^ f
hastag l
)l m
;m n
Task 
< 	
HistorialExportDto	 
? 
> !
ObtenerHistorialAsync 3
(3 4
int4 7
usuarioNegocioId8 H
,H I
DateTimeJ R
desdeS X
,X Y
DateTimeZ b
hastac h
)h i
;i j
Task

 
<

 	
ReporteAdminDto

	 
>

 $
GenerarReporteAdminAsync

 2
(

2 3
DateTime

3 ;
desde

< A
,

A B
DateTime

C K
hasta

L Q
)

Q R
;

R S
} 
public 
static 
class 
RangoReporte  
{ 
public 

const 
string 
MensajeInvalido '
=( )
$str* j
;j k
public 

static 
string 
? 
Validar !
(! "
DateTime" *
?* +
desde, 1
,1 2
DateTime3 ;
?; <
hasta= B
)B C
{ 
if 

( 
desde 
is 
null 
|| 
hasta "
is# %
null& *
)* +
return, 2
MensajeInvalido3 B
;B C
var 
d 
= 
desde 
. 
Value 
. 
Date  
;  !
var 
h 
= 
hasta 
. 
Value 
. 
Date  
;  !
if 

( 
d 
> 
h 
) 
return 
MensajeInvalido )
;) *
if 

( 
h 
>= 
d 
. 
	AddMonths 
( 
$num 
)  
)  !
return" (
MensajeInvalido) 8
;8 9
return 
null 
; 
} 
} ä

\C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\IRecuperacionService.cs
public 
enum 
ResultadoSolicitud 
{  
	Procesada! *
,* +
LimiteSuperado, :
}; <
public 
	interface  
IRecuperacionService %
{ 
Task 
< 	
ResultadoSolicitud	 
> 
SolicitarAsync +
(+ ,
string, 2
correo3 9
,9 :
Func; ?
<? @
string@ F
,F G
stringH N
>N O
construirEnlaceP _
)_ `
;` a
Task 
< 	
bool	 
> 
TokenVigenteAsync  
(  !
string! '
token( -
)- .
;. /
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
>! "
RestablecerAsync# 3
(3 4
string4 :
token; @
,@ A
stringB H
nuevaI N
,N O
stringP V
confirmacionW c
)c d
;d e
} ò
VC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\IPedidoService.cs
public 
	interface 
IPedidoService 
{ 
Task 
< 	#
ClienteAutocompletarDto	  
?  !
>! "'
BuscarClienteFrecuenteAsync# >
(> ?
int? B
usuarioNegocioIdC S
,S T
stringU [
telefono\ d
)d e
;e f
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
,  !
string" (
?( )
Codigo* 0
)0 1
>1 2
RegistrarAsync3 A
(A B
intB E
usuarioNegocioIdF V
,V W
RegistrarPedidoDtoX j
dtok n
)n o
;o p
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
>! "!
ActualizarEstadoAsync# 8
(8 9
int9 <
	usuarioId= F
,F G
intH K
pedidoIdL T
,T U
intV Y
nuevoEstadoIdZ g
,g h
inti l
?l m
repartidorIdn z
={ |
null	} Å
)
Å Ç
;
Ç É
Task 
< 	
List	 
< 
Pedido 
> 
> &
ObtenerPedidosActivosAsync 1
(1 2
int2 5
usuarioNegocioId6 F
)F G
;G H
Task 
< 	
List	 
< 
Pedido 
> 
> (
ObtenerHistorialPedidosAsync 3
(3 4
int4 7
usuarioNegocioId8 H
)H I
;I J
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
 
string

 
?

 
Error

  
)

  !
>

! "#
CancelarPorClienteAsync

# :
(

: ;
string

; A
?

A B
codigo

C I
,

I J
string

K Q
?

Q R
motivo

S Y
)

Y Z
;

Z [
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
>! "!
RegistrarNovedadAsync# 8
(8 9
int9 <
usuarioRepartidorId= P
,P Q
intR U
pedidoIdV ^
,^ _
int` c
?c d
tipoNovedadIde r
,r s
stringt z
?z {
observaciones	| â
)
â ä
;
ä ã
} ﬂ
WC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\INegocioService.cs
public 
	interface 
INegocioService  
{ 
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
,  !
bool" &
CorreoEnviado' 4
)4 5
>5 6
RegistrarAsync7 E
(E F
RegistroNegocioDtoF X
dtoY \
,\ ]
string^ d
urlRevisione p
)p q
;q r
Task 
< 	
PerfilNegocioDto	 
? 
> 
ObtenerPerfilAsync .
(. /
int/ 2
	usuarioId3 <
)< =
;= >
Task 
< 	#
PerfilPublicoNegocioDto	  
?  !
>! "%
ObtenerPerfilPublicoAsync# <
(< =
int= @
	negocioIdA J
)J K
;K L
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
)  !
>! " 
SolicitarCodigoAsync# 7
(7 8
int8 ;
	usuarioId< E
)E F
;F G
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
>! " 
VerificarCodigoAsync# 7
(7 8
int8 ;
	usuarioId< E
,E F
stringG M
codigoN T
)T U
;U V
Task 
< 	
bool	 
> "
EdicionAutorizadaAsync %
(% &
int& )
	usuarioId* 3
)3 4
;4 5
Task 
< 	
EditarNegocioDto	 
? 
> "
ObtenerParaEditarAsync 2
(2 3
int3 6
	usuarioId7 @
)@ A
;A B
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
>! "
EditarAsync# .
(. /
int/ 2
	usuarioId3 <
,< =
EditarNegocioDto> N
dtoO R
)R S
;S T
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
)  !
>! "#
ValidarEliminacionAsync# :
(: ;
int; >
	usuarioId? H
,H I
stringJ P
passwordQ Y
)Y Z
;Z [
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
)  !
>! "
EliminarCuentaAsync# 6
(6 7
int7 :
	usuarioId; D
,D E
stringF L
passwordM U
)U V
;V W
} Ÿ

[C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\IExportadorReportes.cs
public 
	interface 
IExportadorReportes $
{ 
byte 
[ 	
]	 

ReporteNegocioExcel 
( 
ReporteNegocioDto 0
r1 2
)2 3
;3 4
byte 
[ 	
]	 

ReporteNegocioPdf 
( 
ReporteNegocioDto .
r/ 0
)0 1
;1 2
byte 
[ 	
]	 

HistorialExcel 
( 
HistorialExportDto ,
h- .
). /
;/ 0
byte 
[ 	
]	 

HistorialCsv 
( 
HistorialExportDto *
h+ ,
), -
;- .
byte 
[ 	
]	 

HistorialPdf 
( 
HistorialExportDto *
h+ ,
), -
;- .
byte

 
[

 	
]

	 

ReporteAdminExcel

 
(

 
ReporteAdminDto

 ,
r

- .
)

. /
;

/ 0
byte 
[ 	
]	 

ReporteAdminPdf 
( 
ReporteAdminDto *
r+ ,
), -
;- .
} ë
UC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\IEmailService.cs
public 
	interface 
IEmailService 
{ 
Task 
EnviarAsync	 
( 
string 
para  
,  !
string" (
asunto) /
,/ 0
string1 7
cuerpo8 >
)> ?
;? @
Task 
EnviarAsync	 
( 
string 
para  
,  !
string" (
asunto) /
,/ 0

CorreoHtml1 ;
correo< B
)B C
;C D
} Û
TC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\IAuthService.cs
public 
	interface 
IAuthService 
{ 
Task 
< 	
(	 

Usuario
 
? 
Usuario 
, 
string "
?" #
Error$ )
)) *
>* +
IniciarSesionAsync, >
(> ?
LoginDto? G
dtoH K
)K L
;L M
} Åü
ZC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\ExportadorReportes.cs
public		 
class		 
ExportadorReportes		 
:		  !
IExportadorReportes		" 5
{

 
private 
static 
readonly 
CultureInfo '
Es( *
=+ ,
new- 0
(0 1
$str1 8
)8 9
;9 :
private 
static 
readonly 
XLColor #
Azul$ (
=) *
XLColor+ 2
.2 3
FromHtml3 ;
(; <
$str< E
)E F
;F G
private 
const 
string 
AzulHex  
=! "
$str# ,
;, -
private 
const 
string 
FormatoMoneda &
=' (
$str) 2
;2 3
private 
const 
string 
FormatoFechaHora )
=* +
$str, >
;> ?
private 
static 
string 
Moneda  
(  !
decimal! (
v) *
)* +
=>, .
v/ 0
.0 1
ToString1 9
(9 :
$str: >
,> ?
Es@ B
)B C
;C D
private 
static 
string 
Fecha 
(  
DateTime  (
d) *
)* +
=>, .
d/ 0
.0 1
ToString1 9
(9 :
$str: F
,F G
EsH J
)J K
;K L
private 
static 
string 
	FechaHora #
(# $
DateTime$ ,
d- .
). /
=>0 2
d3 4
.4 5
ToString5 =
(= >
$str> P
,P Q
EsR T
)T U
;U V
private 
static 
string 
Rango 
(  
DateTime  (
d) *
,* +
DateTime, 4
h5 6
)6 7
=>8 :
$"; =
{= >
Fecha> C
(C D
dD E
)E F
}F G
$strG K
{K L
FechaL Q
(Q R
hR S
)S T
}T U
"U V
;V W
private 
static 
void 
Poner 
( 
IXLCell %
c& '
,' (
object) /
?/ 0
v1 2
)2 3
{ 
switch 
( 
v 
) 
{ 	
case 
null 
: 
c 
. 
Value 
=  
$str! #
;# $
break% *
;* +
case 
string 
s 
: 
c 
. 
Value "
=# $
s% &
;& '
break( -
;- .
case   
int   
i   
:   
c   
.   
Value   
=    !
i  " #
;  # $
break  % *
;  * +
case!! 
decimal!! 
d!! 
:!! 
c!! 
.!! 
Value!! #
=!!$ %
(!!& '
double!!' -
)!!- .
d!!. /
;!!/ 0
break!!1 6
;!!6 7
case"" 
DateTime"" 
dt"" 
:"" 
c"" 
.""  
Value""  %
=""& '
dt""( *
;""* +
break"", 1
;""1 2
default## 
:## 
c## 
.## 
Value## 
=## 
v##  
.##  !
ToString##! )
(##) *
)##* +
??##, .
$str##/ 1
;##1 2
break##3 8
;##8 9
}$$ 	
}%% 
private'' 
static'' 
void'' 

TituloHoja'' "
(''" #
IXLWorksheet''# /
ws''0 2
,''2 3
string''4 :
titulo''; A
,''A B
params''C I
string''J P
[''P Q
]''Q R
lineas''S Y
)''Y Z
{(( 
ws)) 

.))
 
Cell)) 
()) 
$num)) 
,)) 
$num)) 
))) 
.)) 
Value)) 
=)) 
titulo)) $
;))$ %
ws** 

.**
 
Cell** 
(** 
$num** 
,** 
$num** 
)** 
.** 
Style** 
.** 
Font**  
.**  !
Bold**! %
=**& '
true**( ,
;**, -
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
Style++ 
.++ 
Font++  
.++  !
FontSize++! )
=++* +
$num++, .
;++. /
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
.,,  !
	FontColor,,! *
=,,+ ,
Azul,,- 1
;,,1 2
for-- 
(-- 
var-- 
i-- 
=-- 
$num-- 
;-- 
i-- 
<-- 
lineas-- "
.--" #
Length--# )
;--) *
i--+ ,
++--, .
)--. /
ws.. 
... 
Cell.. 
(.. 
$num.. 
+.. 
i.. 
,.. 
$num.. 
).. 
... 
Value.. #
=..$ %
lineas..& ,
[.., -
i..- .
]... /
;../ 0
}// 
private11 
static11 
void11 
	Subtitulo11 !
(11! "
IXLWorksheet11" .
ws11/ 1
,111 2
int113 6
fila117 ;
,11; <
string11= C
texto11D I
)11I J
{22 
ws33 

.33
 
Cell33 
(33 
fila33 
,33 
$num33 
)33 
.33 
Value33 
=33  
texto33! &
;33& '
ws44 

.44
 
Cell44 
(44 
fila44 
,44 
$num44 
)44 
.44 
Style44 
.44 
Font44 #
.44# $
Bold44$ (
=44) *
true44+ /
;44/ 0
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
Style55 
.55 
Font55 #
.55# $
FontSize55$ ,
=55- .
$num55/ 1
;551 2
}66 
private99 
static99 
int99 
Tabla99 
(99 
IXLWorksheet99 )
ws99* ,
,99, -
int99. 1
fila992 6
,996 7
string998 >
[99> ?
]99? @
	cabeceras99A J
,99J K
List99L P
<99P Q
object99Q W
?99W X
[99X Y
]99Y Z
>99Z [
datos99\ a
,99a b
string99c i
?99i j
[99j k
]99k l
formatos99m u
)99u v
{:: 
for;; 
(;; 
var;; 
c;; 
=;; 
$num;; 
;;; 
c;; 
<;; 
	cabeceras;; %
.;;% &
Length;;& ,
;;;, -
c;;. /
++;;/ 1
);;1 2
ws<< 
.<< 
Cell<< 
(<< 
fila<< 
,<< 
c<< 
+<< 
$num<< 
)<<  
.<<  !
Value<<! &
=<<' (
	cabeceras<<) 2
[<<2 3
c<<3 4
]<<4 5
;<<5 6
var>> 
enc>> 
=>> 
ws>> 
.>> 
Range>> 
(>> 
fila>> 
,>>  
$num>>! "
,>>" #
fila>>$ (
,>>( )
	cabeceras>>* 3
.>>3 4
Length>>4 :
)>>: ;
;>>; <
enc?? 
.?? 
Style?? 
.?? 
Font?? 
.?? 
Bold?? 
=?? 
true?? "
;??" #
enc@@ 
.@@ 
Style@@ 
.@@ 
Font@@ 
.@@ 
	FontColor@@  
=@@! "
XLColor@@# *
.@@* +
White@@+ 0
;@@0 1
encAA 
.AA 
StyleAA 
.AA 
FillAA 
.AA 
BackgroundColorAA &
=AA' (
AzulAA) -
;AA- .
encBB 
.BB 
StyleBB 
.BB 
	AlignmentBB 
.BB 

HorizontalBB &
=BB' ('
XLAlignmentHorizontalValuesBB) D
.BBD E
CenterBBE K
;BBK L
varDD 
fDD 
=DD 
filaDD 
+DD 
$numDD 
;DD 
foreachEE 
(EE 
varEE 
dEE 
inEE 
datosEE 
)EE  
{FF 	
forGG 
(GG 
varGG 
cGG 
=GG 
$numGG 
;GG 
cGG 
<GG 
	cabecerasGG  )
.GG) *
LengthGG* 0
;GG0 1
cGG2 3
++GG3 5
)GG5 6
{HH 
varII 
celdaII 
=II 
wsII 
.II 
CellII #
(II# $
fII$ %
,II% &
cII' (
+II) *
$numII+ ,
)II, -
;II- .
PonerJJ 
(JJ 
celdaJJ 
,JJ 
dJJ 
[JJ 
cJJ  
]JJ  !
)JJ! "
;JJ" #
ifKK 
(KK 
formatosKK 
[KK 
cKK 
]KK 
isKK  "
stringKK# )
fmtKK* -
)KK- .
celdaKK/ 4
.KK4 5
StyleKK5 :
.KK: ;
NumberFormatKK; G
.KKG H
FormatKKH N
=KKO P
fmtKKQ T
;KKT U
}LL 
fMM 
++MM 
;MM 
}NN 	
varPP 
cuerpoPP 
=PP 
wsPP 
.PP 
RangePP 
(PP 
filaPP "
,PP" #
$numPP$ %
,PP% &
MathPP' +
.PP+ ,
MaxPP, /
(PP/ 0
fPP0 1
-PP2 3
$numPP4 5
,PP5 6
filaPP7 ;
)PP; <
,PP< =
	cabecerasPP> G
.PPG H
LengthPPH N
)PPN O
;PPO P
cuerpoQQ 
.QQ 
StyleQQ 
.QQ 
BorderQQ 
.QQ 
OutsideBorderQQ )
=QQ* +
XLBorderStyleValuesQQ, ?
.QQ? @
ThinQQ@ D
;QQD E
cuerpoRR 
.RR 
StyleRR 
.RR 
BorderRR 
.RR 
InsideBorderRR (
=RR) *
XLBorderStyleValuesRR+ >
.RR> ?
HairRR? C
;RRC D
returnSS 
fSS 
+SS 
$numSS 
;SS 
}TT 
privateVV 
staticVV 
byteVV 
[VV 
]VV 
GuardarVV !
(VV! "

XLWorkbookVV" ,
wbVV- /
)VV/ 0
{WW 
usingXX 
varXX 
msXX 
=XX 
newXX 
MemoryStreamXX '
(XX' (
)XX( )
;XX) *
wbYY 

.YY
 
SaveAsYY 
(YY 
msYY 
)YY 
;YY 
returnZZ 
msZZ 
.ZZ 
ToArrayZZ 
(ZZ 
)ZZ 
;ZZ 
}[[ 
private]] 
static]] 
void]] 
HojaPedidos]] #
(]]# $

XLWorkbook]]$ .
wb]]/ 1
,]]1 2
string]]3 9

nombreHoja]]: D
,]]D E
List]]F J
<]]J K
FilaPedidoReporte]]K \
>]]\ ]
filas]]^ c
,]]c d
string]]e k
tituloEstado]]l x
)]]x y
{^^ 
var__ 
ws__ 
=__ 
wb__ 
.__ 

Worksheets__ 
.__ 
Add__ "
(__" #

nombreHoja__# -
)__- .
;__. /
Tabla`` 
(`` 
ws`` 
,`` 
$num`` 
,`` 
[aa 
$straa 
,aa 
$straa  
,aa  !
$straa" )
,aa) *
tituloEstadoaa+ 7
,aa7 8
$straa9 E
,aaE F
$straaG T
]aaT U
,aaU V
filasbb 
.bb 
Selectbb 
(bb 
fbb 
=>bb 
newbb !
objectbb" (
?bb( )
[bb) *
]bb* +
{bb, -
fbb. /
.bb/ 0
Codigobb0 6
,bb6 7
fbb8 9
.bb9 :
Clientebb: A
,bbA B
fbbC D
.bbD E
FechabbE J
,bbJ K
fbbL M
.bbM N
EstadobbN T
,bbT U
fbbV W
.bbW X

RepartidorbbX b
,bbb c
fbbd e
.bbe f

ValorTotalbbf p
}bbq r
)bbr s
.bbs t
ToListbbt z
(bbz {
)bb{ |
,bb| }
[cc 
nullcc 
,cc 
nullcc 
,cc 
FormatoFechaHoracc )
,cc) *
nullcc+ /
,cc/ 0
nullcc1 5
,cc5 6
FormatoMonedacc7 D
]ccD E
)ccE F
;ccF G
doubleee 
[ee 
]ee 
anchosee 
=ee 
[ee 
$numee 
,ee 
$numee !
,ee! "
$numee# %
,ee% &
$numee' )
,ee) *
$numee+ -
,ee- .
$numee/ 1
]ee1 2
;ee2 3
forff 
(ff 
varff 
iff 
=ff 
$numff 
;ff 
iff 
<ff 
anchosff "
.ff" #
Lengthff# )
;ff) *
iff+ ,
++ff, .
)ff. /
wsff0 2
.ff2 3
Columnff3 9
(ff9 :
iff: ;
+ff< =
$numff> ?
)ff? @
.ff@ A
WidthffA F
=ffG H
anchosffI O
[ffO P
iffP Q
]ffQ R
;ffR S
wsgg 

.gg
 
	SheetViewgg 
.gg 

FreezeRowsgg 
(gg  
$numgg  !
)gg! "
;gg" #
}hh 
publicjj 

bytejj 
[jj 
]jj 
ReporteNegocioExceljj %
(jj% &
ReporteNegocioDtojj& 7
rjj8 9
)jj9 :
{kk 
usingll 
varll 
wbll 
=ll 
newll 

XLWorkbookll %
(ll% &
)ll& '
;ll' (
varmm 
wsmm 
=mm 
wbmm 
.mm 

Worksheetsmm 
.mm 
Addmm "
(mm" #
$strmm# ,
)mm, -
;mm- .

TituloHojaoo 
(oo 
wsoo 
,oo 
$stroo 4
,oo4 5
$"pp 
$strpp 
{pp 
rpp 
.pp 
NombreNegociopp '
}pp' (
"pp( )
,pp) *
$"qq 
$strqq 
{qq 
Rangoqq 
(qq 
rqq 
.qq 
Desdeqq #
,qq# $
rqq% &
.qq& '
Hastaqq' ,
)qq, -
}qq- .
"qq. /
,qq/ 0
$"rr 
$strrr 
{rr 
	FechaHorarr "
(rr" #
rrr# $
.rr$ %

GeneradoEnrr% /
)rr/ 0
}rr0 1
"rr1 2
)rr2 3
;rr3 4
vartt 
filatt 
=tt 
$numtt 
;tt 
	Subtitulouu 
(uu 
wsuu 
,uu 
filauu 
++uu 
,uu 
$struu +
)uu+ ,
;uu, -
filavv 
=vv 
Tablavv 
(vv 
wsvv 
,vv 
filavv 
,vv 
[vv  
$strvv  +
,vv+ ,
$strvv- 4
]vv4 5
,vv5 6
[ww 	
[xx 
$strxx 
,xx  
rxx! "
.xx" #
TotalPedidosxx# /
]xx/ 0
,xx0 1
[yy 
$stryy !
,yy! "
ryy# $
.yy$ %

Entregadosyy% /
]yy/ 0
,yy0 1
[zz 
$strzz !
,zz! "
rzz# $
.zz$ %

Canceladoszz% /
]zz/ 0
,zz0 1
[{{ 
$str{{ "
,{{" #
r{{$ %
.{{% &
TasaEntrega{{& 1
]{{1 2
,{{2 3
[|| 
$str|| $
,||$ %
r||& '
.||' (
ValorEntregado||( 6
]||6 7
]}} 	
,}}	 

[}} 
null}} 
,}} 
null}} 
]}} 
)}} 
;}} 
ws 

.
 
Cell 
( 
fila 
- 
$num 
, 
$num 
) 
. 
Style "
." #
NumberFormat# /
./ 0
Format0 6
=7 8
$str9 C
;C D
ws
ÄÄ 

.
ÄÄ
 
Cell
ÄÄ 
(
ÄÄ 
fila
ÄÄ 
-
ÄÄ 
$num
ÄÄ 
,
ÄÄ 
$num
ÄÄ 
)
ÄÄ 
.
ÄÄ 
Style
ÄÄ "
.
ÄÄ" #
NumberFormat
ÄÄ# /
.
ÄÄ/ 0
Format
ÄÄ0 6
=
ÄÄ7 8
FormatoMoneda
ÄÄ9 F
;
ÄÄF G
	Subtitulo
ÇÇ 
(
ÇÇ 
ws
ÇÇ 
,
ÇÇ 
fila
ÇÇ 
++
ÇÇ 
,
ÇÇ 
$str
ÇÇ 2
)
ÇÇ2 3
;
ÇÇ3 4
fila
ÉÉ 
=
ÉÉ 
Tabla
ÉÉ 
(
ÉÉ 
ws
ÉÉ 
,
ÉÉ 
fila
ÉÉ 
,
ÉÉ 
[
ÉÉ  
$str
ÉÉ  (
,
ÉÉ( )
$str
ÉÉ* 4
,
ÉÉ4 5
$str
ÉÉ6 B
]
ÉÉB C
,
ÉÉC D
r
ÑÑ 
.
ÑÑ 
	PorEstado
ÑÑ 
.
ÑÑ 
Select
ÑÑ 
(
ÑÑ 
e
ÑÑ  
=>
ÑÑ! #
new
ÑÑ$ '
object
ÑÑ( .
?
ÑÑ. /
[
ÑÑ/ 0
]
ÑÑ0 1
{
ÑÑ2 3
e
ÑÑ4 5
.
ÑÑ5 6
Estado
ÑÑ6 <
,
ÑÑ< =
e
ÑÑ> ?
.
ÑÑ? @
Cantidad
ÑÑ@ H
,
ÑÑH I
e
ÑÑJ K
.
ÑÑK L

Porcentaje
ÑÑL V
}
ÑÑW X
)
ÑÑX Y
.
ÑÑY Z
ToList
ÑÑZ `
(
ÑÑ` a
)
ÑÑa b
,
ÑÑb c
[
ÖÖ 
null
ÖÖ 
,
ÖÖ 
null
ÖÖ 
,
ÖÖ 
$str
ÖÖ #
]
ÖÖ# $
)
ÖÖ$ %
;
ÖÖ% &
	Subtitulo
áá 
(
áá 
ws
áá 
,
áá 
fila
áá 
++
áá 
,
áá 
$str
áá /
)
áá/ 0
;
áá0 1
var
àà 
porMes
àà 
=
àà 
r
àà 
.
àà 
PorMes
àà 
.
ââ 
Select
ââ 
(
ââ 
m
ââ 
=>
ââ 
new
ââ 
object
ââ #
?
ââ# $
[
ââ$ %
]
ââ% &
{
ââ' (
m
ââ) *
.
ââ* +
Mes
ââ+ .
,
ââ. /
m
ââ0 1
.
ââ1 2
Total
ââ2 7
,
ââ7 8
m
ââ9 :
.
ââ: ;

Entregados
ââ; E
,
ââE F
m
ââG H
.
ââH I

Cancelados
ââI S
,
ââS T
m
ââU V
.
ââV W
ValorEntregado
ââW e
}
ââf g
)
ââg h
.
ää 
ToList
ää 
(
ää 
)
ää 
;
ää 
porMes
ãã 
.
ãã 
Add
ãã 
(
ãã 
[
ãã 
$str
ãã 
,
ãã 
r
ãã 
.
ãã 
PorMes
ãã %
.
ãã% &
Sum
ãã& )
(
ãã) *
m
ãã* +
=>
ãã, .
m
ãã/ 0
.
ãã0 1
Total
ãã1 6
)
ãã6 7
,
ãã7 8
r
ãã9 :
.
ãã: ;
PorMes
ãã; A
.
ããA B
Sum
ããB E
(
ããE F
m
ããF G
=>
ããH J
m
ããK L
.
ããL M

Entregados
ããM W
)
ããW X
,
ããX Y
r
åå 
.
åå 
PorMes
åå 
.
åå 
Sum
åå  
(
åå  !
m
åå! "
=>
åå# %
m
åå& '
.
åå' (

Cancelados
åå( 2
)
åå2 3
,
åå3 4
r
åå5 6
.
åå6 7
PorMes
åå7 =
.
åå= >
Sum
åå> A
(
ååA B
m
ååB C
=>
ååD F
m
ååG H
.
ååH I
ValorEntregado
ååI W
)
ååW X
]
ååX Y
)
ååY Z
;
ååZ [
var
çç 
	inicioMes
çç 
=
çç 
fila
çç 
;
çç 
fila
éé 
=
éé 
Tabla
éé 
(
éé 
ws
éé 
,
éé 
fila
éé 
,
éé 
[
éé  
$str
éé  %
,
éé% &
$str
éé' 0
,
éé0 1
$str
éé2 >
,
éé> ?
$str
éé@ L
,
ééL M
$str
ééN _
]
éé_ `
,
éé` a
porMes
èè 
,
èè 
[
èè 
null
èè 
,
èè 
null
èè 
,
èè  
null
èè! %
,
èè% &
null
èè' +
,
èè+ ,
FormatoMoneda
èè- :
]
èè: ;
)
èè; <
;
èè< =
ws
êê 

.
êê
 
Range
êê 
(
êê 
	inicioMes
êê 
+
êê 
porMes
êê #
.
êê# $
Count
êê$ )
,
êê) *
$num
êê+ ,
,
êê, -
	inicioMes
êê. 7
+
êê8 9
porMes
êê: @
.
êê@ A
Count
êêA F
,
êêF G
$num
êêH I
)
êêI J
.
êêJ K
Style
êêK P
.
êêP Q
Font
êêQ U
.
êêU V
Bold
êêV Z
=
êê[ \
true
êê] a
;
êêa b
double
íí 
[
íí 
]
íí 
anchos
íí 
=
íí 
[
íí 
$num
íí 
,
íí 
$num
íí !
,
íí! "
$num
íí# %
,
íí% &
$num
íí' )
,
íí) *
$num
íí+ -
]
íí- .
;
íí. /
for
ìì 
(
ìì 
var
ìì 
i
ìì 
=
ìì 
$num
ìì 
;
ìì 
i
ìì 
<
ìì 
anchos
ìì "
.
ìì" #
Length
ìì# )
;
ìì) *
i
ìì+ ,
++
ìì, .
)
ìì. /
ws
ìì0 2
.
ìì2 3
Column
ìì3 9
(
ìì9 :
i
ìì: ;
+
ìì< =
$num
ìì> ?
)
ìì? @
.
ìì@ A
Width
ììA F
=
ììG H
anchos
ììI O
[
ììO P
i
ììP Q
]
ììQ R
;
ììR S
HojaPedidos
ïï 
(
ïï 
wb
ïï 
,
ïï 
$str
ïï !
,
ïï! "
r
ïï# $
.
ïï$ %
Pedidos
ïï% ,
,
ïï, -
$str
ïï. 6
)
ïï6 7
;
ïï7 8
return
ññ 
Guardar
ññ 
(
ññ 
wb
ññ 
)
ññ 
;
ññ 
}
óó 
public
ôô 

byte
ôô 
[
ôô 
]
ôô 
HistorialExcel
ôô  
(
ôô  ! 
HistorialExportDto
ôô! 3
h
ôô4 5
)
ôô5 6
{
öö 
using
õõ 
var
õõ 
wb
õõ 
=
õõ 
new
õõ 

XLWorkbook
õõ %
(
õõ% &
)
õõ& '
;
õõ' (
HojaPedidos
úú 
(
úú 
wb
úú 
,
úú 
$str
úú #
,
úú# $
h
úú% &
.
úú& '
Filas
úú' ,
,
úú, -
$str
úú. <
)
úú< =
;
úú= >
return
ùù 
Guardar
ùù 
(
ùù 
wb
ùù 
)
ùù 
;
ùù 
}
ûû 
public
†† 

byte
†† 
[
†† 
]
†† 
ReporteAdminExcel
†† #
(
††# $
ReporteAdminDto
††$ 3
r
††4 5
)
††5 6
{
°° 
using
¢¢ 
var
¢¢ 
wb
¢¢ 
=
¢¢ 
new
¢¢ 

XLWorkbook
¢¢ %
(
¢¢% &
)
¢¢& '
;
¢¢' (
var
££ 
ws
££ 
=
££ 
wb
££ 
.
££ 

Worksheets
££ 
.
££ 
Add
££ "
(
££" #
$str
££# ,
)
££, -
;
££- .

TituloHoja
•• 
(
•• 
ws
•• 
,
•• 
$str
•• B
,
••B C
$"
¶¶ 
$str
¶¶ 
{
¶¶ 
Rango
¶¶ 
(
¶¶ 
r
¶¶ 
.
¶¶ 
Desde
¶¶ #
,
¶¶# $
r
¶¶% &
.
¶¶& '
Hasta
¶¶' ,
)
¶¶, -
}
¶¶- .
"
¶¶. /
,
¶¶/ 0
$"
ßß 
$str
ßß 
{
ßß 
	FechaHora
ßß "
(
ßß" #
r
ßß# $
.
ßß$ %

GeneradoEn
ßß% /
)
ßß/ 0
}
ßß0 1
"
ßß1 2
)
ßß2 3
;
ßß3 4
var
©© 
fila
©© 
=
©© 
$num
©© 
;
©© 
	Subtitulo
™™ 
(
™™ 
ws
™™ 
,
™™ 
fila
™™ 
++
™™ 
,
™™ 
$str
™™ +
)
™™+ ,
;
™™, -
fila
´´ 
=
´´ 
Tabla
´´ 
(
´´ 
ws
´´ 
,
´´ 
fila
´´ 
,
´´ 
[
´´  
$str
´´  +
,
´´+ ,
$str
´´- 4
]
´´4 5
,
´´5 6
[
¨¨ 	
[
≠≠ 
$str
≠≠ 2
,
≠≠2 3
r
≠≠4 5
.
≠≠5 6!
NegociosRegistrados
≠≠6 I
]
≠≠I J
,
≠≠J K
[
ÆÆ 
$str
ÆÆ 6
,
ÆÆ6 7
r
ÆÆ8 9
.
ÆÆ9 :"
NegociosActivosTotal
ÆÆ: N
]
ÆÆN O
,
ÆÆO P
[
ØØ 
$str
ØØ 3
,
ØØ3 4
r
ØØ5 6
.
ØØ6 7%
RepartidoresRegistrados
ØØ7 N
]
ØØN O
,
ØØO P
[
∞∞ 
$str
∞∞ *
,
∞∞* +
r
∞∞, -
.
∞∞- .
TotalPedidos
∞∞. :
]
∞∞: ;
,
∞∞; <
[
±± 
$str
±± !
,
±±! "
r
±±# $
.
±±$ %
PedidosEntregados
±±% 6
]
±±6 7
,
±±7 8
[
≤≤ 
$str
≤≤ $
,
≤≤$ %
r
≤≤& '
.
≤≤' (
ValorEntregado
≤≤( 6
]
≤≤6 7
]
≥≥ 	
,
≥≥	 

[
≥≥ 
null
≥≥ 
,
≥≥ 
null
≥≥ 
]
≥≥ 
)
≥≥ 
;
≥≥ 
ws
¥¥ 

.
¥¥
 
Cell
¥¥ 
(
¥¥ 
fila
¥¥ 
-
¥¥ 
$num
¥¥ 
,
¥¥ 
$num
¥¥ 
)
¥¥ 
.
¥¥ 
Style
¥¥ "
.
¥¥" #
NumberFormat
¥¥# /
.
¥¥/ 0
Format
¥¥0 6
=
¥¥7 8
FormatoMoneda
¥¥9 F
;
¥¥F G
	Subtitulo
∂∂ 
(
∂∂ 
ws
∂∂ 
,
∂∂ 
fila
∂∂ 
++
∂∂ 
,
∂∂ 
$str
∂∂ 7
)
∂∂7 8
;
∂∂8 9
fila
∑∑ 
=
∑∑ 
Tabla
∑∑ 
(
∑∑ 
ws
∑∑ 
,
∑∑ 
fila
∑∑ 
,
∑∑ 
[
∑∑  
$str
∑∑  %
,
∑∑% &
$str
∑∑' 1
]
∑∑1 2
,
∑∑2 3
r
∏∏ 
.
∏∏ 
NegociosPorMes
∏∏ 
.
∏∏ 
Select
∏∏ #
(
∏∏# $
m
∏∏$ %
=>
∏∏& (
new
∏∏) ,
object
∏∏- 3
?
∏∏3 4
[
∏∏4 5
]
∏∏5 6
{
∏∏7 8
m
∏∏9 :
.
∏∏: ;
Mes
∏∏; >
,
∏∏> ?
m
∏∏@ A
.
∏∏A B
Total
∏∏B G
}
∏∏H I
)
∏∏I J
.
∏∏J K
ToList
∏∏K Q
(
∏∏Q R
)
∏∏R S
,
∏∏S T
[
∏∏U V
null
∏∏V Z
,
∏∏Z [
null
∏∏\ `
]
∏∏` a
)
∏∏a b
;
∏∏b c
	Subtitulo
∫∫ 
(
∫∫ 
ws
∫∫ 
,
∫∫ 
fila
∫∫ 
++
∫∫ 
,
∫∫ 
$str
∫∫ D
)
∫∫D E
;
∫∫E F
fila
ªª 
=
ªª 
Tabla
ªª 
(
ªª 
ws
ªª 
,
ªª 
fila
ªª 
,
ªª 
[
ªª  
$str
ªª  (
,
ªª( )
$str
ªª* 4
,
ªª4 5
$str
ªª6 B
]
ªªB C
,
ªªC D
r
ºº 
.
ºº 
NegociosPorEstado
ºº 
.
ºº  
Select
ºº  &
(
ºº& '
e
ºº' (
=>
ºº) +
new
ºº, /
object
ºº0 6
?
ºº6 7
[
ºº7 8
]
ºº8 9
{
ºº: ;
e
ºº< =
.
ºº= >
Etiqueta
ºº> F
,
ººF G
e
ººH I
.
ººI J
Cantidad
ººJ R
,
ººR S
e
ººT U
.
ººU V

Porcentaje
ººV `
}
ººa b
)
ººb c
.
ººc d
ToList
ººd j
(
ººj k
)
ººk l
,
ººl m
[
ΩΩ 
null
ΩΩ 
,
ΩΩ 
null
ΩΩ 
,
ΩΩ 
$str
ΩΩ #
]
ΩΩ# $
)
ΩΩ$ %
;
ΩΩ% &
	Subtitulo
øø 
(
øø 
ws
øø 
,
øø 
fila
øø 
++
øø 
,
øø 
$str
øø E
)
øøE F
;
øøF G
fila
¿¿ 
=
¿¿ 
Tabla
¿¿ 
(
¿¿ 
ws
¿¿ 
,
¿¿ 
fila
¿¿ 
,
¿¿ 
[
¿¿  
$str
¿¿  +
,
¿¿+ ,
$str
¿¿- 7
,
¿¿7 8
$str
¿¿9 E
]
¿¿E F
,
¿¿F G
r
¡¡ 
.
¡¡ "
NegociosPorActividad
¡¡ "
.
¡¡" #
Select
¡¡# )
(
¡¡) *
e
¡¡* +
=>
¡¡, .
new
¡¡/ 2
object
¡¡3 9
?
¡¡9 :
[
¡¡: ;
]
¡¡; <
{
¡¡= >
e
¡¡? @
.
¡¡@ A
Etiqueta
¡¡A I
,
¡¡I J
e
¡¡K L
.
¡¡L M
Cantidad
¡¡M U
,
¡¡U V
e
¡¡W X
.
¡¡X Y

Porcentaje
¡¡Y c
}
¡¡d e
)
¡¡e f
.
¡¡f g
ToList
¡¡g m
(
¡¡m n
)
¡¡n o
,
¡¡o p
[
¬¬ 
null
¬¬ 
,
¬¬ 
null
¬¬ 
,
¬¬ 
$str
¬¬ #
]
¬¬# $
)
¬¬$ %
;
¬¬% &
	Subtitulo
ƒƒ 
(
ƒƒ 
ws
ƒƒ 
,
ƒƒ 
fila
ƒƒ 
++
ƒƒ 
,
ƒƒ 
$str
ƒƒ C
)
ƒƒC D
;
ƒƒD E
fila
≈≈ 
=
≈≈ 
Tabla
≈≈ 
(
≈≈ 
ws
≈≈ 
,
≈≈ 
fila
≈≈ 
,
≈≈ 
[
≈≈  
$str
≈≈  (
,
≈≈( )
$str
≈≈* 4
,
≈≈4 5
$str
≈≈6 B
]
≈≈B C
,
≈≈C D
r
∆∆ 
.
∆∆ 
PedidosPorEstado
∆∆ 
.
∆∆ 
Select
∆∆ %
(
∆∆% &
e
∆∆& '
=>
∆∆( *
new
∆∆+ .
object
∆∆/ 5
?
∆∆5 6
[
∆∆6 7
]
∆∆7 8
{
∆∆9 :
e
∆∆; <
.
∆∆< =
Estado
∆∆= C
,
∆∆C D
e
∆∆E F
.
∆∆F G
Cantidad
∆∆G O
,
∆∆O P
e
∆∆Q R
.
∆∆R S

Porcentaje
∆∆S ]
}
∆∆^ _
)
∆∆_ `
.
∆∆` a
ToList
∆∆a g
(
∆∆g h
)
∆∆h i
,
∆∆i j
[
«« 
null
«« 
,
«« 
null
«« 
,
«« 
$str
«« #
]
««# $
)
««$ %
;
««% &
	Subtitulo
…… 
(
…… 
ws
…… 
,
…… 
fila
…… 
++
…… 
,
…… 
$str
…… ?
)
……? @
;
……@ A
Tabla
   
(
   
ws
   
,
   
fila
   
,
   
[
   
$str
   "
,
  " #
$str
  $ -
,
  - .
$str
  / ;
,
  ; <
$str
  = N
]
  N O
,
  O P
r
ÀÀ 
.
ÀÀ 
TopNegocios
ÀÀ 
.
ÀÀ 
Select
ÀÀ  
(
ÀÀ  !
t
ÀÀ! "
=>
ÀÀ# %
new
ÀÀ& )
object
ÀÀ* 0
?
ÀÀ0 1
[
ÀÀ1 2
]
ÀÀ2 3
{
ÀÀ4 5
t
ÀÀ6 7
.
ÀÀ7 8
Nombre
ÀÀ8 >
,
ÀÀ> ?
t
ÀÀ@ A
.
ÀÀA B
Pedidos
ÀÀB I
,
ÀÀI J
t
ÀÀK L
.
ÀÀL M

Entregados
ÀÀM W
,
ÀÀW X
t
ÀÀY Z
.
ÀÀZ [
ValorEntregado
ÀÀ[ i
}
ÀÀj k
)
ÀÀk l
.
ÀÀl m
ToList
ÀÀm s
(
ÀÀs t
)
ÀÀt u
,
ÀÀu v
[
ÃÃ 
null
ÃÃ 
,
ÃÃ 
null
ÃÃ 
,
ÃÃ 
null
ÃÃ 
,
ÃÃ 
FormatoMoneda
ÃÃ ,
]
ÃÃ, -
)
ÃÃ- .
;
ÃÃ. /
double
ŒŒ 
[
ŒŒ 
]
ŒŒ 
anchos
ŒŒ 
=
ŒŒ 
[
ŒŒ 
$num
ŒŒ 
,
ŒŒ 
$num
ŒŒ !
,
ŒŒ! "
$num
ŒŒ# %
,
ŒŒ% &
$num
ŒŒ' )
]
ŒŒ) *
;
ŒŒ* +
for
œœ 
(
œœ 
var
œœ 
i
œœ 
=
œœ 
$num
œœ 
;
œœ 
i
œœ 
<
œœ 
anchos
œœ "
.
œœ" #
Length
œœ# )
;
œœ) *
i
œœ+ ,
++
œœ, .
)
œœ. /
ws
œœ0 2
.
œœ2 3
Column
œœ3 9
(
œœ9 :
i
œœ: ;
+
œœ< =
$num
œœ> ?
)
œœ? @
.
œœ@ A
Width
œœA F
=
œœG H
anchos
œœI O
[
œœO P
i
œœP Q
]
œœQ R
;
œœR S
var
““ 
wn
““ 
=
““ 
wb
““ 
.
““ 

Worksheets
““ 
.
““ 
Add
““ "
(
““" #
$str
““# 4
)
““4 5
;
““5 6
Tabla
”” 
(
”” 
wn
”” 
,
”” 
$num
”” 
,
”” 
[
”” 
$str
”” 
,
””  
$str
””! ,
,
””, -
$str
””. 8
,
””8 9
$str
””: B
,
””B C
$str
””D W
,
””W X
$str
””Y a
]
””a b
,
””b c
r
‘‘ 
.
‘‘ 
Negocios
‘‘ 
.
‘‘ 
Select
‘‘ 
(
‘‘ 
n
‘‘ 
=>
‘‘  "
new
‘‘# &
object
‘‘' -
?
‘‘- .
[
‘‘. /
]
‘‘/ 0
{
‘‘1 2
n
‘‘3 4
.
‘‘4 5
Nombre
‘‘5 ;
,
‘‘; <
n
‘‘= >
.
‘‘> ?
	Actividad
‘‘? H
,
‘‘H I
n
‘‘J K
.
‘‘K L
	Documento
‘‘L U
,
‘‘U V
n
‘‘W X
.
‘‘X Y
Correo
‘‘Y _
,
‘‘_ `
n
‘‘a b
.
‘‘b c
FechaRegistro
‘‘c p
,
‘‘p q
n
‘‘r s
.
‘‘s t
Estado
‘‘t z
}
‘‘{ |
)
‘‘| }
.
‘‘} ~
ToList‘‘~ Ñ
(‘‘Ñ Ö
)‘‘Ö Ü
,‘‘Ü á
[
’’ 
null
’’ 
,
’’ 
null
’’ 
,
’’ 
null
’’ 
,
’’ 
null
’’ #
,
’’# $
FormatoFechaHora
’’% 5
,
’’5 6
null
’’7 ;
]
’’; <
)
’’< =
;
’’= >
double
÷÷ 
[
÷÷ 
]
÷÷ 
anchosN
÷÷ 
=
÷÷ 
[
÷÷ 
$num
÷÷ 
,
÷÷ 
$num
÷÷  "
,
÷÷" #
$num
÷÷$ &
,
÷÷& '
$num
÷÷( *
,
÷÷* +
$num
÷÷, .
,
÷÷. /
$num
÷÷0 2
]
÷÷2 3
;
÷÷3 4
for
◊◊ 
(
◊◊ 
var
◊◊ 
i
◊◊ 
=
◊◊ 
$num
◊◊ 
;
◊◊ 
i
◊◊ 
<
◊◊ 
anchosN
◊◊ #
.
◊◊# $
Length
◊◊$ *
;
◊◊* +
i
◊◊, -
++
◊◊- /
)
◊◊/ 0
wn
◊◊1 3
.
◊◊3 4
Column
◊◊4 :
(
◊◊: ;
i
◊◊; <
+
◊◊= >
$num
◊◊? @
)
◊◊@ A
.
◊◊A B
Width
◊◊B G
=
◊◊H I
anchosN
◊◊J Q
[
◊◊Q R
i
◊◊R S
]
◊◊S T
;
◊◊T U
wn
ÿÿ 

.
ÿÿ
 
	SheetView
ÿÿ 
.
ÿÿ 

FreezeRows
ÿÿ 
(
ÿÿ  
$num
ÿÿ  !
)
ÿÿ! "
;
ÿÿ" #
return
⁄⁄ 
Guardar
⁄⁄ 
(
⁄⁄ 
wb
⁄⁄ 
)
⁄⁄ 
;
⁄⁄ 
}
€€ 
private
·· 
static
·· 
string
·· 
Csv
·· 
(
·· 
string
·· $
valor
··% *
)
··* +
{
‚‚ 
if
‰‰ 

(
‰‰ 
valor
‰‰ 
.
‰‰ 
Length
‰‰ 
>
‰‰ 
$num
‰‰ 
&&
‰‰ 
$str
‰‰  &
.
‰‰& '
Contains
‰‰' /
(
‰‰/ 0
valor
‰‰0 5
[
‰‰5 6
$num
‰‰6 7
]
‰‰7 8
)
‰‰8 9
)
‰‰9 :
valor
‰‰; @
=
‰‰A B
$str
‰‰C F
+
‰‰G H
valor
‰‰I N
;
‰‰N O
return
ÂÂ 
$str
ÂÂ 
+
ÂÂ 
valor
ÂÂ 
.
ÂÂ 
Replace
ÂÂ #
(
ÂÂ# $
$str
ÂÂ$ (
,
ÂÂ( )
$str
ÂÂ* 0
)
ÂÂ0 1
+
ÂÂ2 3
$str
ÂÂ4 8
;
ÂÂ8 9
}
ÊÊ 
public
ËË 

byte
ËË 
[
ËË 
]
ËË 
HistorialCsv
ËË 
(
ËË  
HistorialExportDto
ËË 1
h
ËË2 3
)
ËË3 4
{
ÈÈ 
var
ÍÍ 
sb
ÍÍ 
=
ÍÍ 
new
ÍÍ 
StringBuilder
ÍÍ "
(
ÍÍ" #
)
ÍÍ# $
;
ÍÍ$ %
sb
ÏÏ 

.
ÏÏ
 

AppendLine
ÏÏ 
(
ÏÏ 
$str
ÏÏ P
)
ÏÏP Q
;
ÏÏQ R
foreach
ÌÌ 
(
ÌÌ 
var
ÌÌ 
f
ÌÌ 
in
ÌÌ 
h
ÌÌ 
.
ÌÌ 
Filas
ÌÌ !
)
ÌÌ! "
{
ÓÓ 	
sb
ÔÔ 
.
ÔÔ 

AppendLine
ÔÔ 
(
ÔÔ 
string
ÔÔ  
.
ÔÔ  !
Join
ÔÔ! %
(
ÔÔ% &
$char
ÔÔ& )
,
ÔÔ) *
Csv
 
(
 
f
 
.
 
Codigo
 
)
 
,
 
Csv
ÒÒ 
(
ÒÒ 
f
ÒÒ 
.
ÒÒ 
Cliente
ÒÒ 
)
ÒÒ 
,
ÒÒ 
Csv
ÚÚ 
(
ÚÚ 
f
ÚÚ 
.
ÚÚ 
Fecha
ÚÚ 
.
ÚÚ 
ToString
ÚÚ $
(
ÚÚ$ %
$str
ÚÚ% 7
,
ÚÚ7 8
CultureInfo
ÚÚ9 D
.
ÚÚD E
InvariantCulture
ÚÚE U
)
ÚÚU V
)
ÚÚV W
,
ÚÚW X
Csv
ÛÛ 
(
ÛÛ 
f
ÛÛ 
.
ÛÛ 
Estado
ÛÛ 
)
ÛÛ 
,
ÛÛ 
Csv
ÙÙ 
(
ÙÙ 
f
ÙÙ 
.
ÙÙ 

Repartidor
ÙÙ  
)
ÙÙ  !
,
ÙÙ! "
f
ıı 
.
ıı 

ValorTotal
ıı 
.
ıı 
ToString
ıı %
(
ıı% &
$str
ıı& ,
,
ıı, -
CultureInfo
ıı. 9
.
ıı9 :
InvariantCulture
ıı: J
)
ııJ K
)
ııK L
)
ııL M
;
ııM N
}
ˆˆ 	
var
¯¯ 
bom
¯¯ 
=
¯¯ 
new
¯¯ 
UTF8Encoding
¯¯ "
(
¯¯" #
true
¯¯# '
)
¯¯' (
.
¯¯( )
GetPreamble
¯¯) 4
(
¯¯4 5
)
¯¯5 6
;
¯¯6 7
var
˘˘ 
cuerpo
˘˘ 
=
˘˘ 
Encoding
˘˘ 
.
˘˘ 
UTF8
˘˘ "
.
˘˘" #
GetBytes
˘˘# +
(
˘˘+ ,
sb
˘˘, .
.
˘˘. /
ToString
˘˘/ 7
(
˘˘7 8
)
˘˘8 9
)
˘˘9 :
;
˘˘: ;
return
˙˙ 
[
˙˙ 
..
˙˙ 
bom
˙˙ 
,
˙˙ 
..
˙˙ 
cuerpo
˙˙ !
]
˙˙! "
;
˙˙" #
}
˚˚ 
private
ÅÅ 
static
ÅÅ 

IContainer
ÅÅ 
CeldaCab
ÅÅ &
(
ÅÅ& '

IContainer
ÅÅ' 1
c
ÅÅ2 3
)
ÅÅ3 4
=>
ÅÅ5 7
c
ÅÅ8 9
.
ÅÅ9 :

Background
ÅÅ: D
(
ÅÅD E
AzulHex
ÅÅE L
)
ÅÅL M
.
ÅÅM N
Padding
ÅÅN U
(
ÅÅU V
$num
ÅÅV W
)
ÅÅW X
;
ÅÅX Y
private
ÇÇ 
static
ÇÇ 

IContainer
ÇÇ 
Celda
ÇÇ #
(
ÇÇ# $

IContainer
ÇÇ$ .
c
ÇÇ/ 0
)
ÇÇ0 1
=>
ÇÇ2 4
c
ÇÇ5 6
.
ÇÇ6 7
BorderBottom
ÇÇ7 C
(
ÇÇC D
$num
ÇÇD H
)
ÇÇH I
.
ÇÇI J
BorderColor
ÇÇJ U
(
ÇÇU V
$str
ÇÇV _
)
ÇÇ_ `
.
ÇÇ` a
Padding
ÇÇa h
(
ÇÇh i
$num
ÇÇi j
)
ÇÇj k
;
ÇÇk l
private
ÑÑ 
static
ÑÑ 
void
ÑÑ 
Cabecera
ÑÑ  
(
ÑÑ  !
PageDescriptor
ÑÑ! /
page
ÑÑ0 4
,
ÑÑ4 5
string
ÑÑ6 <
titulo
ÑÑ= C
,
ÑÑC D
params
ÑÑE K
string
ÑÑL R
[
ÑÑR S
]
ÑÑS T
lineas
ÑÑU [
)
ÑÑ[ \
{
ÖÖ 
page
ÜÜ 
.
ÜÜ 
Header
ÜÜ 
(
ÜÜ 
)
ÜÜ 
.
ÜÜ 
Column
ÜÜ 
(
ÜÜ 
col
ÜÜ  
=>
ÜÜ! #
{
áá 	
col
àà 
.
àà 
Item
àà 
(
àà 
)
àà 
.
àà 
Row
àà 
(
àà 
row
àà 
=>
àà !
{
ââ 
row
ää 
.
ää 
RelativeItem
ää  
(
ää  !
)
ää! "
.
ää" #
Text
ää# '
(
ää' (
$str
ää( 0
)
ää0 1
.
ää1 2
FontSize
ää2 :
(
ää: ;
$num
ää; =
)
ää= >
.
ää> ?
Bold
ää? C
(
ääC D
)
ääD E
.
ääE F
	FontColor
ääF O
(
ääO P
AzulHex
ääP W
)
ääW X
;
ääX Y
row
ãã 
.
ãã 
RelativeItem
ãã  
(
ãã  !
)
ãã! "
.
ãã" #

AlignRight
ãã# -
(
ãã- .
)
ãã. /
.
ãã/ 0
AlignMiddle
ãã0 ;
(
ãã; <
)
ãã< =
.
ãã= >
Text
ãã> B
(
ããB C
titulo
ããC I
)
ããI J
.
ããJ K
FontSize
ããK S
(
ããS T
$num
ããT V
)
ããV W
.
ããW X
SemiBold
ããX `
(
ãã` a
)
ããa b
;
ããb c
}
åå 
)
åå 
;
åå 
foreach
çç 
(
çç 
var
çç 
l
çç 
in
çç 
lineas
çç $
)
çç$ %
col
éé 
.
éé 
Item
éé 
(
éé 
)
éé 
.
éé 
Text
éé 
(
éé  
l
éé  !
)
éé! "
.
éé" #
FontSize
éé# +
(
éé+ ,
$num
éé, -
)
éé- .
.
éé. /
	FontColor
éé/ 8
(
éé8 9
$str
éé9 B
)
ééB C
;
ééC D
col
èè 
.
èè 
Item
èè 
(
èè 
)
èè 
.
èè 

PaddingTop
èè !
(
èè! "
$num
èè" #
)
èè# $
.
èè$ %
LineHorizontal
èè% 3
(
èè3 4
$num
èè4 5
)
èè5 6
.
èè6 7
	LineColor
èè7 @
(
èè@ A
AzulHex
èèA H
)
èèH I
;
èèI J
}
êê 	
)
êê	 

;
êê
 
}
ëë 
private
ìì 
static
ìì 
void
ìì 
Pie
ìì 
(
ìì 
PageDescriptor
ìì *
page
ìì+ /
)
ìì/ 0
{
îî 
page
ïï 
.
ïï 
Footer
ïï 
(
ïï 
)
ïï 
.
ïï 
AlignCenter
ïï !
(
ïï! "
)
ïï" #
.
ïï# $
DefaultTextStyle
ïï$ 4
(
ïï4 5
x
ïï5 6
=>
ïï7 9
x
ïï: ;
.
ïï; <
FontSize
ïï< D
(
ïïD E
$num
ïïE F
)
ïïF G
.
ïïG H
	FontColor
ïïH Q
(
ïïQ R
$str
ïïR [
)
ïï[ \
)
ïï\ ]
.
ïï] ^
Text
ïï^ b
(
ïïb c
t
ïïc d
=>
ïïe g
{
ññ 	
t
óó 
.
óó 
Span
óó 
(
óó 
$str
óó %
)
óó% &
;
óó& '
t
òò 
.
òò 
CurrentPageNumber
òò 
(
òò  
)
òò  !
;
òò! "
t
ôô 
.
ôô 
Span
ôô 
(
ôô 
$str
ôô 
)
ôô 
;
ôô 
t
öö 
.
öö 

TotalPages
öö 
(
öö 
)
öö 
;
öö 
}
õõ 	
)
õõ	 

;
õõ
 
}
úú 
private
ûû 
static
ûû 
void
ûû 
Seccion
ûû 
(
ûû  
ColumnDescriptor
ûû  0
col
ûû1 4
,
ûû4 5
string
ûû6 <
titulo
ûû= C
)
ûûC D
{
üü 
col
†† 
.
†† 
Item
†† 
(
†† 
)
†† 
.
†† 

PaddingTop
†† 
(
†† 
$num
††  
)
††  !
.
††! "
PaddingBottom
††" /
(
††/ 0
$num
††0 1
)
††1 2
.
††2 3
Text
††3 7
(
††7 8
titulo
††8 >
)
††> ?
.
††? @
FontSize
††@ H
(
††H I
$num
††I K
)
††K L
.
††L M
SemiBold
††M U
(
††U V
)
††V W
.
††W X
	FontColor
††X a
(
††a b
AzulHex
††b i
)
††i j
;
††j k
}
°° 
private
££ 
static
££ 
void
££ 
Indicadores
££ #
(
££# $
ColumnDescriptor
££$ 4
col
££5 8
,
££8 9
params
££: @
(
££A B
string
££B H
Etiqueta
££I Q
,
££Q R
string
££S Y
Valor
££Z _
)
££_ `
[
££` a
]
££a b
kpis
££c g
)
££g h
{
§§ 
col
•• 
.
•• 
Item
•• 
(
•• 
)
•• 
.
•• 

PaddingTop
•• 
(
•• 
$num
••  
)
••  !
.
••! "
Row
••" %
(
••% &
row
••& )
=>
••* ,
{
¶¶ 	
row
ßß 
.
ßß 
Spacing
ßß 
(
ßß 
$num
ßß 
)
ßß 
;
ßß 
foreach
®® 
(
®® 
var
®® 
k
®® 
in
®® 
kpis
®® "
)
®®" #
{
©© 
row
™™ 
.
™™ 
RelativeItem
™™  
(
™™  !
)
™™! "
.
™™" #
Border
™™# )
(
™™) *
$num
™™* +
)
™™+ ,
.
™™, -
BorderColor
™™- 8
(
™™8 9
$str
™™9 B
)
™™B C
.
™™C D
Padding
™™D K
(
™™K L
$num
™™L M
)
™™M N
.
™™N O
Column
™™O U
(
™™U V
c
™™V W
=>
™™X Z
{
´´ 
c
¨¨ 
.
¨¨ 
Item
¨¨ 
(
¨¨ 
)
¨¨ 
.
¨¨ 
Text
¨¨ !
(
¨¨! "
k
¨¨" #
.
¨¨# $
Etiqueta
¨¨$ ,
)
¨¨, -
.
¨¨- .
FontSize
¨¨. 6
(
¨¨6 7
$num
¨¨7 8
)
¨¨8 9
.
¨¨9 :
	FontColor
¨¨: C
(
¨¨C D
$str
¨¨D M
)
¨¨M N
;
¨¨N O
c
≠≠ 
.
≠≠ 
Item
≠≠ 
(
≠≠ 
)
≠≠ 
.
≠≠ 
Text
≠≠ !
(
≠≠! "
k
≠≠" #
.
≠≠# $
Valor
≠≠$ )
)
≠≠) *
.
≠≠* +
FontSize
≠≠+ 3
(
≠≠3 4
$num
≠≠4 6
)
≠≠6 7
.
≠≠7 8
SemiBold
≠≠8 @
(
≠≠@ A
)
≠≠A B
;
≠≠B C
}
ÆÆ 
)
ÆÆ 
;
ÆÆ 
}
ØØ 
}
∞∞ 	
)
∞∞	 

;
∞∞
 
}
±± 
private
¥¥ 
static
¥¥ 
void
¥¥ 
Barras
¥¥ 
(
¥¥ 
ColumnDescriptor
¥¥ /
col
¥¥0 3
,
¥¥3 4
List
¥¥5 9
<
¥¥9 :
(
¥¥: ;
string
¥¥; A
Etiqueta
¥¥B J
,
¥¥J K
int
¥¥L O
Cantidad
¥¥P X
,
¥¥X Y
string
¥¥Z `
Color
¥¥a f
,
¥¥f g
string
¥¥h n
Detalle
¥¥o v
)
¥¥v w
>
¥¥w x
items
¥¥y ~
)
¥¥~ 
{
µµ 
var
∂∂ 
max
∂∂ 
=
∂∂ 
items
∂∂ 
.
∂∂ 
Count
∂∂ 
==
∂∂  
$num
∂∂! "
?
∂∂# $
$num
∂∂% &
:
∂∂' (
items
∂∂) .
.
∂∂. /
Max
∂∂/ 2
(
∂∂2 3
i
∂∂3 4
=>
∂∂5 7
i
∂∂8 9
.
∂∂9 :
Cantidad
∂∂: B
)
∂∂B C
;
∂∂C D
foreach
∑∑ 
(
∑∑ 
var
∑∑ 
it
∑∑ 
in
∑∑ 
items
∑∑  
)
∑∑  !
{
∏∏ 	
col
ππ 
.
ππ 
Item
ππ 
(
ππ 
)
ππ 
.
ππ 
PaddingVertical
ππ &
(
ππ& '
$num
ππ' (
)
ππ( )
.
ππ) *
Row
ππ* -
(
ππ- .
row
ππ. 1
=>
ππ2 4
{
∫∫ 
row
ªª 
.
ªª 
ConstantItem
ªª  
(
ªª  !
$num
ªª! $
)
ªª$ %
.
ªª% &
AlignMiddle
ªª& 1
(
ªª1 2
)
ªª2 3
.
ªª3 4
Text
ªª4 8
(
ªª8 9
it
ªª9 ;
.
ªª; <
Etiqueta
ªª< D
)
ªªD E
.
ªªE F
FontSize
ªªF N
(
ªªN O
$num
ªªO P
)
ªªP Q
;
ªªQ R
row
ºº 
.
ºº 
RelativeItem
ºº  
(
ºº  !
)
ºº! "
.
ºº" #
AlignMiddle
ºº# .
(
ºº. /
)
ºº/ 0
.
ºº0 1
Row
ºº1 4
(
ºº4 5
barra
ºº5 :
=>
ºº; =
{
ΩΩ 
var
ææ 
p
ææ 
=
ææ 
max
ææ 
==
ææ  "
$num
ææ# $
?
ææ% &
$num
ææ' )
:
ææ* +
it
ææ, .
.
ææ. /
Cantidad
ææ/ 7
*
ææ8 9
$num
ææ: >
/
ææ? @
max
ææA D
;
ææD E
if
øø 
(
øø 
p
øø 
>
øø 
$num
øø 
)
øø 
barra
øø $
.
øø$ %
RelativeItem
øø% 1
(
øø1 2
p
øø2 3
)
øø3 4
.
øø4 5
Height
øø5 ;
(
øø; <
$num
øø< >
)
øø> ?
.
øø? @

Background
øø@ J
(
øøJ K
it
øøK M
.
øøM N
Color
øøN S
)
øøS T
;
øøT U
if
¿¿ 
(
¿¿ 
p
¿¿ 
<
¿¿ 
$num
¿¿ 
)
¿¿  
barra
¿¿! &
.
¿¿& '
RelativeItem
¿¿' 3
(
¿¿3 4
$num
¿¿4 8
-
¿¿9 :
p
¿¿; <
)
¿¿< =
.
¿¿= >
Height
¿¿> D
(
¿¿D E
$num
¿¿E G
)
¿¿G H
;
¿¿H I
}
¡¡ 
)
¡¡ 
;
¡¡ 
row
¬¬ 
.
¬¬ 
ConstantItem
¬¬  
(
¬¬  !
$num
¬¬! #
)
¬¬# $
.
¬¬$ %

AlignRight
¬¬% /
(
¬¬/ 0
)
¬¬0 1
.
¬¬1 2
AlignMiddle
¬¬2 =
(
¬¬= >
)
¬¬> ?
.
¬¬? @
Text
¬¬@ D
(
¬¬D E
it
¬¬E G
.
¬¬G H
Detalle
¬¬H O
)
¬¬O P
.
¬¬P Q
FontSize
¬¬Q Y
(
¬¬Y Z
$num
¬¬Z [
)
¬¬[ \
;
¬¬\ ]
}
√√ 
)
√√ 
;
√√ 
}
ƒƒ 	
}
≈≈ 
private
«« 
static
«« 
void
«« 
TablaSimple
«« #
(
««# $
ColumnDescriptor
««$ 4
col
««5 8
,
««8 9
string
««: @
[
««@ A
]
««A B
	cabeceras
««C L
,
««L M
float
««N S
[
««S T
]
««T U
anchos
««V \
,
««\ ]
List
««^ b
<
««b c
string
««c i
[
««i j
]
««j k
>
««k l
filas
««m r
,
««r s
int
««t w
[
««w x
]
««x y
?
««y z
alineadasDerecha««{ ã
=««å ç
null««é í
)««í ì
{
»» 
col
…… 
.
…… 
Item
…… 
(
…… 
)
…… 
.
…… 
Table
…… 
(
…… 
t
…… 
=>
…… 
{
   	
t
ÀÀ 
.
ÀÀ 
ColumnsDefinition
ÀÀ 
(
ÀÀ  
c
ÀÀ  !
=>
ÀÀ" $
{
ÀÀ% &
foreach
ÀÀ' .
(
ÀÀ/ 0
var
ÀÀ0 3
a
ÀÀ4 5
in
ÀÀ6 8
anchos
ÀÀ9 ?
)
ÀÀ? @
c
ÀÀA B
.
ÀÀB C
RelativeColumn
ÀÀC Q
(
ÀÀQ R
a
ÀÀR S
)
ÀÀS T
;
ÀÀT U
}
ÀÀV W
)
ÀÀW X
;
ÀÀX Y
t
ÕÕ 
.
ÕÕ 
Header
ÕÕ 
(
ÕÕ 
h
ÕÕ 
=>
ÕÕ 
{
ŒŒ 
for
œœ 
(
œœ 
var
œœ 
i
œœ 
=
œœ 
$num
œœ 
;
œœ 
i
œœ  !
<
œœ" #
	cabeceras
œœ$ -
.
œœ- .
Length
œœ. 4
;
œœ4 5
i
œœ6 7
++
œœ7 9
)
œœ9 :
{
–– 
var
—— 
cel
—— 
=
—— 
h
—— 
.
——  
Cell
——  $
(
——$ %
)
——% &
.
——& '
Element
——' .
(
——. /
CeldaCab
——/ 7
)
——7 8
;
——8 9
if
““ 
(
““ 
alineadasDerecha
““ (
?
““( )
.
““) *
Contains
““* 2
(
““2 3
i
““3 4
)
““4 5
==
““6 8
true
““9 =
)
““= >
cel
““? B
=
““C D
cel
““E H
.
““H I

AlignRight
““I S
(
““S T
)
““T U
;
““U V
cel
”” 
.
”” 
Text
”” 
(
”” 
	cabeceras
”” &
[
””& '
i
””' (
]
””( )
)
””) *
.
””* +
	FontColor
””+ 4
(
””4 5
$str
””5 >
)
””> ?
.
””? @
SemiBold
””@ H
(
””H I
)
””I J
.
””J K
FontSize
””K S
(
””S T
$num
””T U
)
””U V
;
””V W
}
‘‘ 
}
’’ 
)
’’ 
;
’’ 
foreach
◊◊ 
(
◊◊ 
var
◊◊ 
fila
◊◊ 
in
◊◊  
filas
◊◊! &
)
◊◊& '
{
ÿÿ 
for
ŸŸ 
(
ŸŸ 
var
ŸŸ 
i
ŸŸ 
=
ŸŸ 
$num
ŸŸ 
;
ŸŸ 
i
ŸŸ  !
<
ŸŸ" #
fila
ŸŸ$ (
.
ŸŸ( )
Length
ŸŸ) /
;
ŸŸ/ 0
i
ŸŸ1 2
++
ŸŸ2 4
)
ŸŸ4 5
{
⁄⁄ 
var
€€ 
cel
€€ 
=
€€ 
t
€€ 
.
€€  
Cell
€€  $
(
€€$ %
)
€€% &
.
€€& '
Element
€€' .
(
€€. /
Celda
€€/ 4
)
€€4 5
;
€€5 6
if
‹‹ 
(
‹‹ 
alineadasDerecha
‹‹ (
?
‹‹( )
.
‹‹) *
Contains
‹‹* 2
(
‹‹2 3
i
‹‹3 4
)
‹‹4 5
==
‹‹6 8
true
‹‹9 =
)
‹‹= >
cel
‹‹? B
=
‹‹C D
cel
‹‹E H
.
‹‹H I

AlignRight
‹‹I S
(
‹‹S T
)
‹‹T U
;
‹‹U V
cel
›› 
.
›› 
Text
›› 
(
›› 
fila
›› !
[
››! "
i
››" #
]
››# $
)
››$ %
.
››% &
FontSize
››& .
(
››. /
$num
››/ 0
)
››0 1
;
››1 2
}
ﬁﬁ 
}
ﬂﬂ 
}
‡‡ 	
)
‡‡	 

;
‡‡
 
}
·· 
private
„„ 
static
„„ 
void
„„ 
TablaPedidos
„„ $
(
„„$ %
ColumnDescriptor
„„% 5
col
„„6 9
,
„„9 :
List
„„; ?
<
„„? @
FilaPedidoReporte
„„@ Q
>
„„Q R
filas
„„S X
,
„„X Y
string
„„Z `
tituloEstado
„„a m
)
„„m n
{
‰‰ 
TablaSimple
ÂÂ 
(
ÂÂ 
col
ÂÂ 
,
ÂÂ 
[
ÊÊ 
$str
ÊÊ 
,
ÊÊ 
$str
ÊÊ  
,
ÊÊ  !
$str
ÊÊ" )
,
ÊÊ) *
tituloEstado
ÊÊ+ 7
,
ÊÊ7 8
$str
ÊÊ9 E
,
ÊÊE F
$str
ÊÊG T
]
ÊÊT U
,
ÊÊU V
[
ÁÁ 
$num
ÁÁ 
,
ÁÁ 
$num
ÁÁ 
,
ÁÁ 
$num
ÁÁ 
,
ÁÁ 
$num
ÁÁ #
,
ÁÁ# $
$num
ÁÁ% )
,
ÁÁ) *
$num
ÁÁ+ /
]
ÁÁ/ 0
,
ÁÁ0 1
filas
ËË 
.
ËË 
Select
ËË 
(
ËË 
f
ËË 
=>
ËË 
new
ËË !
[
ËË! "
]
ËË" #
{
ËË$ %
f
ËË& '
.
ËË' (
Codigo
ËË( .
,
ËË. /
f
ËË0 1
.
ËË1 2
Cliente
ËË2 9
,
ËË9 :
	FechaHora
ËË; D
(
ËËD E
f
ËËE F
.
ËËF G
Fecha
ËËG L
)
ËËL M
,
ËËM N
f
ËËO P
.
ËËP Q
Estado
ËËQ W
,
ËËW X
f
ËËY Z
.
ËËZ [

Repartidor
ËË[ e
,
ËËe f
Moneda
ËËg m
(
ËËm n
f
ËËn o
.
ËËo p

ValorTotal
ËËp z
)
ËËz {
}
ËË| }
)
ËË} ~
.
ËË~ 
ToListËË Ö
(ËËÖ Ü
)ËËÜ á
,ËËá à
[
ÈÈ 
$num
ÈÈ 
]
ÈÈ 
)
ÈÈ 
;
ÈÈ 
}
ÍÍ 
private
ÏÏ 
static
ÏÏ 
void
ÏÏ 
SinDatos
ÏÏ  
(
ÏÏ  !
ColumnDescriptor
ÏÏ! 1
col
ÏÏ2 5
,
ÏÏ5 6
string
ÏÏ7 =
mensaje
ÏÏ> E
)
ÏÏE F
{
ÌÌ 
col
ÓÓ 
.
ÓÓ 
Item
ÓÓ 
(
ÓÓ 
)
ÓÓ 
.
ÓÓ 
PaddingVertical
ÓÓ "
(
ÓÓ" #
$num
ÓÓ# $
)
ÓÓ$ %
.
ÓÓ% &
Text
ÓÓ& *
(
ÓÓ* +
mensaje
ÓÓ+ 2
)
ÓÓ2 3
.
ÓÓ3 4
FontSize
ÓÓ4 <
(
ÓÓ< =
$num
ÓÓ= >
)
ÓÓ> ?
.
ÓÓ? @
Italic
ÓÓ@ F
(
ÓÓF G
)
ÓÓG H
.
ÓÓH I
	FontColor
ÓÓI R
(
ÓÓR S
$str
ÓÓS \
)
ÓÓ\ ]
;
ÓÓ] ^
}
ÔÔ 
private
ÒÒ 
static
ÒÒ 
byte
ÒÒ 
[
ÒÒ 
]
ÒÒ 
CrearPdf
ÒÒ "
(
ÒÒ" #
Action
ÒÒ# )
<
ÒÒ) *
PageDescriptor
ÒÒ* 8
>
ÒÒ8 9

configurar
ÒÒ: D
)
ÒÒD E
=>
ÒÒF H
Document
ÚÚ 
.
ÚÚ 
Create
ÚÚ 
(
ÚÚ 
doc
ÚÚ 
=>
ÚÚ 
{
ÛÛ 	
doc
ÙÙ 
.
ÙÙ 
Page
ÙÙ 
(
ÙÙ 
page
ÙÙ 
=>
ÙÙ 
{
ıı 
page
ˆˆ 
.
ˆˆ 
Size
ˆˆ 
(
ˆˆ 
	PageSizes
ˆˆ #
.
ˆˆ# $
A4
ˆˆ$ &
)
ˆˆ& '
;
ˆˆ' (
page
˜˜ 
.
˜˜ 
Margin
˜˜ 
(
˜˜ 
$num
˜˜ 
)
˜˜ 
;
˜˜  
page
¯¯ 
.
¯¯ 
DefaultTextStyle
¯¯ %
(
¯¯% &
x
¯¯& '
=>
¯¯( *
x
¯¯+ ,
.
¯¯, -
FontSize
¯¯- 5
(
¯¯5 6
$num
¯¯6 8
)
¯¯8 9
)
¯¯9 :
;
¯¯: ;

configurar
˘˘ 
(
˘˘ 
page
˘˘ 
)
˘˘  
;
˘˘  !
Pie
˙˙ 
(
˙˙ 
page
˙˙ 
)
˙˙ 
;
˙˙ 
}
˚˚ 
)
˚˚ 
;
˚˚ 
}
¸¸ 	
)
¸¸	 

.
¸¸
 
GeneratePdf
¸¸ 
(
¸¸ 
)
¸¸ 
;
¸¸ 
public
˛˛ 

byte
˛˛ 
[
˛˛ 
]
˛˛ 
ReporteNegocioPdf
˛˛ #
(
˛˛# $
ReporteNegocioDto
˛˛$ 5
r
˛˛6 7
)
˛˛7 8
=>
˛˛9 ;
CrearPdf
˛˛< D
(
˛˛D E
page
˛˛E I
=>
˛˛J L
{
ˇˇ 
Cabecera
ÄÄ 
(
ÄÄ 
page
ÄÄ 
,
ÄÄ 
$str
ÄÄ +
,
ÄÄ+ ,
$"
ÅÅ 
$str
ÅÅ 
{
ÅÅ 
r
ÅÅ 
.
ÅÅ 
NombreNegocio
ÅÅ '
}
ÅÅ' (
"
ÅÅ( )
,
ÅÅ) *
$"
ÇÇ 
$str
ÇÇ 
{
ÇÇ 
Rango
ÇÇ 
(
ÇÇ 
r
ÇÇ 
.
ÇÇ 
Desde
ÇÇ #
,
ÇÇ# $
r
ÇÇ% &
.
ÇÇ& '
Hasta
ÇÇ' ,
)
ÇÇ, -
}
ÇÇ- .
$str
ÇÇ. ?
{
ÇÇ? @
	FechaHora
ÇÇ@ I
(
ÇÇI J
r
ÇÇJ K
.
ÇÇK L

GeneradoEn
ÇÇL V
)
ÇÇV W
}
ÇÇW X
"
ÇÇX Y
)
ÇÇY Z
;
ÇÇZ [
page
ÑÑ 
.
ÑÑ 
Content
ÑÑ 
(
ÑÑ 
)
ÑÑ 
.
ÑÑ 
Column
ÑÑ 
(
ÑÑ 
col
ÑÑ !
=>
ÑÑ" $
{
ÖÖ 	
Indicadores
ÜÜ 
(
ÜÜ 
col
ÜÜ 
,
ÜÜ 
(
áá 
$str
áá #
,
áá# $
r
áá% &
.
áá& '
TotalPedidos
áá' 3
.
áá3 4
ToString
áá4 <
(
áá< =
Es
áá= ?
)
áá? @
)
áá@ A
,
ááA B
(
àà 
$str
àà 
,
àà 
r
àà  
.
àà  !

Entregados
àà! +
.
àà+ ,
ToString
àà, 4
(
àà4 5
Es
àà5 7
)
àà7 8
)
àà8 9
,
àà9 :
(
ââ 
$str
ââ 
,
ââ 
r
ââ  
.
ââ  !

Cancelados
ââ! +
.
ââ+ ,
ToString
ââ, 4
(
ââ4 5
Es
ââ5 7
)
ââ7 8
)
ââ8 9
,
ââ9 :
(
ää 
$str
ää "
,
ää" #
r
ää$ %
.
ää% &
TasaEntrega
ää& 1
.
ää1 2
ToString
ää2 :
(
ää: ;
$str
ää; @
,
ää@ A
Es
ääB D
)
ääD E
+
ääF G
$str
ääH L
)
ääL M
,
ääM N
(
ãã 
$str
ãã "
,
ãã" #
Moneda
ãã$ *
(
ãã* +
r
ãã+ ,
.
ãã, -
ValorEntregado
ãã- ;
)
ãã; <
)
ãã< =
)
ãã= >
;
ãã> ?
Seccion
çç 
(
çç 
col
çç 
,
çç 
$str
çç -
)
çç- .
;
çç. /
Barras
éé 
(
éé 
col
éé 
,
éé 
r
éé 
.
éé 
	PorEstado
éé #
.
èè 
Select
èè 
(
èè 
e
èè 
=>
èè 
(
èè 
e
èè 
.
èè  
Estado
èè  &
,
èè& '
e
èè( )
.
èè) *
Cantidad
èè* 2
,
èè2 3
e
èè4 5
.
èè5 6
Color
èè6 ;
,
èè; <
$"
èè= ?
{
èè? @
e
èè@ A
.
èèA B
Cantidad
èèB J
}
èèJ K
$str
èèK M
{
èèM N
e
èèN O
.
èèO P

Porcentaje
èèP Z
.
èèZ [
ToString
èè[ c
(
èèc d
$str
èèd i
,
èèi j
Es
èèk m
)
èèm n
}
èèn o
$str
èèo r
"
èèr s
)
èès t
)
èèt u
.
êê 
ToList
êê 
(
êê 
)
êê 
)
êê 
;
êê 
Seccion
íí 
(
íí 
col
íí 
,
íí 
$str
íí *
)
íí* +
;
íí+ ,
var
ìì 
meses
ìì 
=
ìì 
r
ìì 
.
ìì 
PorMes
ìì  
.
îî 
Select
îî 
(
îî 
m
îî 
=>
îî 
new
îî  
[
îî  !
]
îî! "
{
îî# $
m
îî% &
.
îî& '
Mes
îî' *
,
îî* +
m
îî, -
.
îî- .
Total
îî. 3
.
îî3 4
ToString
îî4 <
(
îî< =
Es
îî= ?
)
îî? @
,
îî@ A
m
îîB C
.
îîC D

Entregados
îîD N
.
îîN O
ToString
îîO W
(
îîW X
Es
îîX Z
)
îîZ [
,
îî[ \
m
îî] ^
.
îî^ _

Cancelados
îî_ i
.
îîi j
ToString
îîj r
(
îîr s
Es
îîs u
)
îîu v
,
îîv w
Moneda
îîx ~
(
îî~ 
mîî Ä
.îîÄ Å
ValorEntregadoîîÅ è
)îîè ê
}îîë í
)îîí ì
.
ïï 
ToList
ïï 
(
ïï 
)
ïï 
;
ïï 
meses
ññ 
.
ññ 
Add
ññ 
(
ññ 
[
ññ 
$str
ññ 
,
ññ 
r
ññ  !
.
ññ! "
PorMes
ññ" (
.
ññ( )
Sum
ññ) ,
(
ññ, -
m
ññ- .
=>
ññ/ 1
m
ññ2 3
.
ññ3 4
Total
ññ4 9
)
ññ9 :
.
ññ: ;
ToString
ññ; C
(
ññC D
Es
ññD F
)
ññF G
,
ññG H
r
ññI J
.
ññJ K
PorMes
ññK Q
.
ññQ R
Sum
ññR U
(
ññU V
m
ññV W
=>
ññX Z
m
ññ[ \
.
ññ\ ]

Entregados
ññ] g
)
ññg h
.
ññh i
ToString
ññi q
(
ññq r
Es
ññr t
)
ññt u
,
ññu v
r
óó 
.
óó 
PorMes
óó 
.
óó  
Sum
óó  #
(
óó# $
m
óó$ %
=>
óó& (
m
óó) *
.
óó* +

Cancelados
óó+ 5
)
óó5 6
.
óó6 7
ToString
óó7 ?
(
óó? @
Es
óó@ B
)
óóB C
,
óóC D
Moneda
óóE K
(
óóK L
r
óóL M
.
óóM N
PorMes
óóN T
.
óóT U
Sum
óóU X
(
óóX Y
m
óóY Z
=>
óó[ ]
m
óó^ _
.
óó_ `
ValorEntregado
óó` n
)
óón o
)
óóo p
]
óóp q
)
óóq r
;
óór s
TablaSimple
òò 
(
òò 
col
òò 
,
òò 
[
òò 
$str
òò #
,
òò# $
$str
òò% .
,
òò. /
$str
òò0 <
,
òò< =
$str
òò> J
,
òòJ K
$str
òòL ]
]
òò] ^
,
òò^ _
[
ôô 
$num
ôô 
,
ôô 
$num
ôô 
,
ôô 
$num
ôô 
,
ôô  
$num
ôô! %
,
ôô% &
$num
ôô' )
]
ôô) *
,
ôô* +
meses
ôô, 1
,
ôô1 2
[
ôô3 4
$num
ôô4 5
,
ôô5 6
$num
ôô7 8
,
ôô8 9
$num
ôô: ;
,
ôô; <
$num
ôô= >
]
ôô> ?
)
ôô? @
;
ôô@ A
Seccion
õõ 
(
õõ 
col
õõ 
,
õõ 
$str
õõ -
)
õõ- .
;
õõ. /
if
úú 
(
úú 
r
úú 
.
úú 
Pedidos
úú 
.
úú 
Count
úú 
==
úú  "
$num
úú# $
)
úú$ %
SinDatos
úú& .
(
úú. /
col
úú/ 2
,
úú2 3
$str
úú4 ^
)
úú^ _
;
úú_ `
else
ùù 
TablaPedidos
ùù 
(
ùù 
col
ùù !
,
ùù! "
r
ùù# $
.
ùù$ %
Pedidos
ùù% ,
,
ùù, -
$str
ùù. 6
)
ùù6 7
;
ùù7 8
}
ûû 	
)
ûû	 

;
ûû
 
}
üü 
)
üü 
;
üü 
public
°° 

byte
°° 
[
°° 
]
°° 
HistorialPdf
°° 
(
°°  
HistorialExportDto
°° 1
h
°°2 3
)
°°3 4
=>
°°5 7
CrearPdf
°°8 @
(
°°@ A
page
°°A E
=>
°°F H
{
¢¢ 
Cabecera
££ 
(
££ 
page
££ 
,
££ 
$str
££ -
,
££- .
$"
§§ 
$str
§§ 
{
§§ 
h
§§ 
.
§§ 
NombreNegocio
§§ '
}
§§' (
"
§§( )
,
§§) *
$"
•• 
$str
•• 
{
•• 
Rango
•• 
(
•• 
h
•• 
.
•• 
Desde
•• #
,
••# $
h
••% &
.
••& '
Hasta
••' ,
)
••, -
}
••- .
$str
••. ?
{
••? @
	FechaHora
••@ I
(
••I J
h
••J K
.
••K L

GeneradoEn
••L V
)
••V W
}
••W X
"
••X Y
)
••Y Z
;
••Z [
page
ßß 
.
ßß 
Content
ßß 
(
ßß 
)
ßß 
.
ßß 
Column
ßß 
(
ßß 
col
ßß !
=>
ßß" $
{
®® 	
var
©© 

entregados
©© 
=
©© 
h
©© 
.
©© 
Filas
©© $
.
©©$ %
Count
©©% *
(
©©* +
f
©©+ ,
=>
©©- /
f
©©0 1
.
©©1 2
Estado
©©2 8
==
©©9 ;
EstadoPedidoInfo
©©< L
.
©©L M
Nombre
©©M S
(
©©S T
(
©©T U
int
©©U X
)
©©X Y
EstadoPedido
©©Y e
.
©©e f
	Entregado
©©f o
)
©©o p
)
©©p q
;
©©q r
Indicadores
™™ 
(
™™ 
col
™™ 
,
™™ 
(
´´ 
$str
´´ &
,
´´& '
h
´´( )
.
´´) *
Filas
´´* /
.
´´/ 0
Count
´´0 5
.
´´5 6
ToString
´´6 >
(
´´> ?
Es
´´? A
)
´´A B
)
´´B C
,
´´C D
(
¨¨ 
$str
¨¨ 
,
¨¨ 

entregados
¨¨ )
.
¨¨) *
ToString
¨¨* 2
(
¨¨2 3
Es
¨¨3 5
)
¨¨5 6
)
¨¨6 7
,
¨¨7 8
(
≠≠ 
$str
≠≠ 
,
≠≠ 
(
≠≠  
h
≠≠  !
.
≠≠! "
Filas
≠≠" '
.
≠≠' (
Count
≠≠( -
-
≠≠. /

entregados
≠≠0 :
)
≠≠: ;
.
≠≠; <
ToString
≠≠< D
(
≠≠D E
Es
≠≠E G
)
≠≠G H
)
≠≠H I
)
≠≠I J
;
≠≠J K
Seccion
ØØ 
(
ØØ 
col
ØØ 
,
ØØ 
$str
ØØ .
)
ØØ. /
;
ØØ/ 0
if
∞∞ 
(
∞∞ 
h
∞∞ 
.
∞∞ 
Filas
∞∞ 
.
∞∞ 
Count
∞∞ 
==
∞∞  
$num
∞∞! "
)
∞∞" #
SinDatos
∞∞$ ,
(
∞∞, -
col
∞∞- 0
,
∞∞0 1
$str
∞∞2 h
)
∞∞h i
;
∞∞i j
else
±± 
TablaPedidos
±± 
(
±± 
col
±± !
,
±±! "
h
±±# $
.
±±$ %
Filas
±±% *
,
±±* +
$str
±±, :
)
±±: ;
;
±±; <
}
≤≤ 	
)
≤≤	 

;
≤≤
 
}
≥≥ 
)
≥≥ 
;
≥≥ 
public
µµ 

byte
µµ 
[
µµ 
]
µµ 
ReporteAdminPdf
µµ !
(
µµ! "
ReporteAdminDto
µµ" 1
r
µµ2 3
)
µµ3 4
=>
µµ5 7
CrearPdf
µµ8 @
(
µµ@ A
page
µµA E
=>
µµF H
{
∂∂ 
Cabecera
∑∑ 
(
∑∑ 
page
∑∑ 
,
∑∑ 
$str
∑∑ 9
,
∑∑9 :
$"
∏∏ 
$str
∏∏ 
{
∏∏ 
Rango
∏∏ 
(
∏∏ 
r
∏∏ 
.
∏∏ 
Desde
∏∏ #
,
∏∏# $
r
∏∏% &
.
∏∏& '
Hasta
∏∏' ,
)
∏∏, -
}
∏∏- .
$str
∏∏. ?
{
∏∏? @
	FechaHora
∏∏@ I
(
∏∏I J
r
∏∏J K
.
∏∏K L

GeneradoEn
∏∏L V
)
∏∏V W
}
∏∏W X
"
∏∏X Y
)
∏∏Y Z
;
∏∏Z [
page
∫∫ 
.
∫∫ 
Content
∫∫ 
(
∫∫ 
)
∫∫ 
.
∫∫ 
Column
∫∫ 
(
∫∫ 
col
∫∫ !
=>
∫∫" $
{
ªª 	
Indicadores
ºº 
(
ºº 
col
ºº 
,
ºº 
(
ΩΩ 
$str
ΩΩ "
,
ΩΩ" #
r
ΩΩ$ %
.
ΩΩ% &!
NegociosRegistrados
ΩΩ& 9
.
ΩΩ9 :
ToString
ΩΩ: B
(
ΩΩB C
Es
ΩΩC E
)
ΩΩE F
)
ΩΩF G
,
ΩΩG H
(
ææ 
$str
ææ )
,
ææ) *
r
ææ+ ,
.
ææ, -"
NegociosActivosTotal
ææ- A
.
ææA B
ToString
ææB J
(
ææJ K
Es
ææK M
)
ææM N
)
ææN O
,
ææO P
(
øø 
$str
øø &
,
øø& '
r
øø( )
.
øø) *%
RepartidoresRegistrados
øø* A
.
øøA B
ToString
øøB J
(
øøJ K
Es
øøK M
)
øøM N
)
øøN O
)
øøO P
;
øøP Q
Indicadores
¿¿ 
(
¿¿ 
col
¿¿ 
,
¿¿ 
(
¡¡ 
$str
¡¡ "
,
¡¡" #
r
¡¡$ %
.
¡¡% &
TotalPedidos
¡¡& 2
.
¡¡2 3
ToString
¡¡3 ;
(
¡¡; <
Es
¡¡< >
)
¡¡> ?
)
¡¡? @
,
¡¡@ A
(
¬¬ 
$str
¬¬ %
,
¬¬% &
r
¬¬' (
.
¬¬( )
PedidosEntregados
¬¬) :
.
¬¬: ;
ToString
¬¬; C
(
¬¬C D
Es
¬¬D F
)
¬¬F G
)
¬¬G H
,
¬¬H I
(
√√ 
$str
√√ "
,
√√" #
Moneda
√√$ *
(
√√* +
r
√√+ ,
.
√√, -
ValorEntregado
√√- ;
)
√√; <
)
√√< =
)
√√= >
;
√√> ?
Seccion
≈≈ 
(
≈≈ 
col
≈≈ 
,
≈≈ 
$str
≈≈ 2
)
≈≈2 3
;
≈≈3 4
Barras
∆∆ 
(
∆∆ 
col
∆∆ 
,
∆∆ 
r
∆∆ 
.
∆∆ 
NegociosPorMes
∆∆ (
.
∆∆( )
Select
∆∆) /
(
∆∆/ 0
m
∆∆0 1
=>
∆∆2 4
(
∆∆5 6
m
∆∆6 7
.
∆∆7 8
Mes
∆∆8 ;
,
∆∆; <
m
∆∆= >
.
∆∆> ?
Total
∆∆? D
,
∆∆D E
AzulHex
∆∆F M
,
∆∆M N
m
∆∆O P
.
∆∆P Q
Total
∆∆Q V
.
∆∆V W
ToString
∆∆W _
(
∆∆_ `
Es
∆∆` b
)
∆∆b c
)
∆∆c d
)
∆∆d e
.
∆∆e f
ToList
∆∆f l
(
∆∆l m
)
∆∆m n
)
∆∆n o
;
∆∆o p
Seccion
»» 
(
»» 
col
»» 
,
»» 
$str
»» ?
)
»»? @
;
»»@ A
if
…… 
(
…… 
r
…… 
.
…… 
NegociosPorEstado
…… #
.
……# $
Count
……$ )
==
……* ,
$num
……- .
)
……. /
SinDatos
……0 8
(
……8 9
col
……9 <
,
……< =
$str
……> c
)
……c d
;
……d e
else
   
Barras
   
(
   
col
   
,
   
r
   
.
   
NegociosPorEstado
   0
.
ÀÀ 
Select
ÀÀ 
(
ÀÀ 
e
ÀÀ 
=>
ÀÀ 
(
ÀÀ 
e
ÀÀ 
.
ÀÀ  
Etiqueta
ÀÀ  (
,
ÀÀ( )
e
ÀÀ* +
.
ÀÀ+ ,
Cantidad
ÀÀ, 4
,
ÀÀ4 5
e
ÀÀ6 7
.
ÀÀ7 8
Color
ÀÀ8 =
,
ÀÀ= >
$"
ÀÀ? A
{
ÀÀA B
e
ÀÀB C
.
ÀÀC D
Cantidad
ÀÀD L
}
ÀÀL M
$str
ÀÀM O
{
ÀÀO P
e
ÀÀP Q
.
ÀÀQ R

Porcentaje
ÀÀR \
.
ÀÀ\ ]
ToString
ÀÀ] e
(
ÀÀe f
$str
ÀÀf k
,
ÀÀk l
Es
ÀÀm o
)
ÀÀo p
}
ÀÀp q
$str
ÀÀq t
"
ÀÀt u
)
ÀÀu v
)
ÀÀv w
.
ÃÃ 
ToList
ÃÃ 
(
ÃÃ 
)
ÃÃ 
)
ÃÃ 
;
ÃÃ 
Seccion
ŒŒ 
(
ŒŒ 
col
ŒŒ 
,
ŒŒ 
$str
ŒŒ @
)
ŒŒ@ A
;
ŒŒA B
if
œœ 
(
œœ 
r
œœ 
.
œœ "
NegociosPorActividad
œœ &
.
œœ& '
Count
œœ' ,
==
œœ- /
$num
œœ0 1
)
œœ1 2
SinDatos
œœ3 ;
(
œœ; <
col
œœ< ?
,
œœ? @
$str
œœA f
)
œœf g
;
œœg h
else
–– 
Barras
–– 
(
–– 
col
–– 
,
–– 
r
–– 
.
–– "
NegociosPorActividad
–– 3
.
—— 
Select
—— 
(
—— 
e
—— 
=>
—— 
(
—— 
e
—— 
.
——  
Etiqueta
——  (
,
——( )
e
——* +
.
——+ ,
Cantidad
——, 4
,
——4 5
e
——6 7
.
——7 8
Color
——8 =
,
——= >
$"
——? A
{
——A B
e
——B C
.
——C D
Cantidad
——D L
}
——L M
$str
——M O
{
——O P
e
——P Q
.
——Q R

Porcentaje
——R \
.
——\ ]
ToString
——] e
(
——e f
$str
——f k
,
——k l
Es
——m o
)
——o p
}
——p q
$str
——q t
"
——t u
)
——u v
)
——v w
.
““ 
ToList
““ 
(
““ 
)
““ 
)
““ 
;
““ 
Seccion
‘‘ 
(
‘‘ 
col
‘‘ 
,
‘‘ 
$str
‘‘ >
)
‘‘> ?
;
‘‘? @
Barras
’’ 
(
’’ 
col
’’ 
,
’’ 
r
’’ 
.
’’ 
PedidosPorEstado
’’ *
.
÷÷ 
Select
÷÷ 
(
÷÷ 
e
÷÷ 
=>
÷÷ 
(
÷÷ 
e
÷÷ 
.
÷÷  
Estado
÷÷  &
,
÷÷& '
e
÷÷( )
.
÷÷) *
Cantidad
÷÷* 2
,
÷÷2 3
e
÷÷4 5
.
÷÷5 6
Color
÷÷6 ;
,
÷÷; <
$"
÷÷= ?
{
÷÷? @
e
÷÷@ A
.
÷÷A B
Cantidad
÷÷B J
}
÷÷J K
$str
÷÷K M
{
÷÷M N
e
÷÷N O
.
÷÷O P

Porcentaje
÷÷P Z
.
÷÷Z [
ToString
÷÷[ c
(
÷÷c d
$str
÷÷d i
,
÷÷i j
Es
÷÷k m
)
÷÷m n
}
÷÷n o
$str
÷÷o r
"
÷÷r s
)
÷÷s t
)
÷÷t u
.
◊◊ 
ToList
◊◊ 
(
◊◊ 
)
◊◊ 
)
◊◊ 
;
◊◊ 
Seccion
ŸŸ 
(
ŸŸ 
col
ŸŸ 
,
ŸŸ 
$str
ŸŸ :
)
ŸŸ: ;
;
ŸŸ; <
if
⁄⁄ 
(
⁄⁄ 
r
⁄⁄ 
.
⁄⁄ 
TopNegocios
⁄⁄ 
.
⁄⁄ 
Count
⁄⁄ #
==
⁄⁄$ &
$num
⁄⁄' (
)
⁄⁄( )
SinDatos
⁄⁄* 2
(
⁄⁄2 3
col
⁄⁄3 6
,
⁄⁄6 7
$str
⁄⁄8 b
)
⁄⁄b c
;
⁄⁄c d
else
€€ 
TablaSimple
€€ 
(
€€ 
col
€€  
,
€€  !
[
€€" #
$str
€€# ,
,
€€, -
$str
€€. 7
,
€€7 8
$str
€€9 E
,
€€E F
$str
€€G X
]
€€X Y
,
€€Y Z
[
€€[ \
$num
€€\ ^
,
€€^ _
$num
€€` b
,
€€b c
$num
€€d h
,
€€h i
$num
€€j l
]
€€l m
,
€€m n
r
‹‹ 
.
‹‹ 
TopNegocios
‹‹ 
.
‹‹ 
Select
‹‹ $
(
‹‹$ %
t
‹‹% &
=>
‹‹' )
new
‹‹* -
[
‹‹- .
]
‹‹. /
{
‹‹0 1
t
‹‹2 3
.
‹‹3 4
Nombre
‹‹4 :
,
‹‹: ;
t
‹‹< =
.
‹‹= >
Pedidos
‹‹> E
.
‹‹E F
ToString
‹‹F N
(
‹‹N O
Es
‹‹O Q
)
‹‹Q R
,
‹‹R S
t
‹‹T U
.
‹‹U V

Entregados
‹‹V `
.
‹‹` a
ToString
‹‹a i
(
‹‹i j
Es
‹‹j l
)
‹‹l m
,
‹‹m n
Moneda
‹‹o u
(
‹‹u v
t
‹‹v w
.
‹‹w x
ValorEntregado‹‹x Ü
)‹‹Ü á
}‹‹à â
)‹‹â ä
.‹‹ä ã
ToList‹‹ã ë
(‹‹ë í
)‹‹í ì
,‹‹ì î
[
›› 
$num
›› 
,
›› 
$num
›› 
,
›› 
$num
›› 
]
›› 
)
›› 
;
›› 
Seccion
ﬂﬂ 
(
ﬂﬂ 
col
ﬂﬂ 
,
ﬂﬂ 
$str
ﬂﬂ >
)
ﬂﬂ> ?
;
ﬂﬂ? @
if
‡‡ 
(
‡‡ 
r
‡‡ 
.
‡‡ 
Negocios
‡‡ 
.
‡‡ 
Count
‡‡  
==
‡‡! #
$num
‡‡$ %
)
‡‡% &
SinDatos
‡‡' /
(
‡‡/ 0
col
‡‡0 3
,
‡‡3 4
$str
‡‡5 Z
)
‡‡Z [
;
‡‡[ \
else
·· 
TablaSimple
·· 
(
·· 
col
··  
,
··  !
[
··" #
$str
··# ,
,
··, -
$str
··. 9
,
··9 :
$str
··; E
,
··E F
$str
··G Q
,
··Q R
$str
··S [
]
··[ \
,
··\ ]
[
··^ _
$num
··_ c
,
··c d
$num
··e g
,
··g h
$num
··i m
,
··m n
$num
··o s
,
··s t
$num
··u y
]
··y z
,
··z {
r
‚‚ 
.
‚‚ 
Negocios
‚‚ 
.
‚‚ 
Select
‚‚ !
(
‚‚! "
n
‚‚" #
=>
‚‚$ &
new
‚‚' *
[
‚‚* +
]
‚‚+ ,
{
‚‚- .
n
‚‚/ 0
.
‚‚0 1
Nombre
‚‚1 7
,
‚‚7 8
n
‚‚9 :
.
‚‚: ;
	Actividad
‚‚; D
,
‚‚D E
n
‚‚F G
.
‚‚G H
	Documento
‚‚H Q
,
‚‚Q R
Fecha
‚‚S X
(
‚‚X Y
n
‚‚Y Z
.
‚‚Z [
FechaRegistro
‚‚[ h
)
‚‚h i
,
‚‚i j
n
‚‚k l
.
‚‚l m
Estado
‚‚m s
}
‚‚t u
)
‚‚u v
.
‚‚v w
ToList
‚‚w }
(
‚‚} ~
)
‚‚~ 
)‚‚ Ä
;‚‚Ä Å
}
„„ 	
)
„„	 

;
„„
 
}
‰‰ 
)
‰‰ 
;
‰‰ 
}ÂÂ ∂A
XC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\EmailSmtpService.cs
public 
class 
EmailSmtpService 
( 
IConfiguration 
config 
, 
IWebHostEnvironment 
entorno 
,  
ILogger		 
<		 
EmailSmtpService		 
>		 
logger		 $
)		$ %
:		& '
IEmailService		( 5
{

 
public 

Task 
EnviarAsync 
( 
string "
para# '
,' (
string) /
asunto0 6
,6 7
string8 >
cuerpo? E
)E F
=>G I
EnviarAsync 
( 
para 
, 
asunto  
,  !
PlantillaCorreo" 1
.1 2

DesdeTexto2 <
(< =
asunto= C
,C D
cuerpoE K
)K L
)L M
;M N
public 

async 
Task 
EnviarAsync !
(! "
string" (
para) -
,- .
string/ 5
asunto6 <
,< =

CorreoHtml> H
correoI O
)O P
{ 
var 
host 
= 
config 
[ 
$str &
]& '
??( *
$str+ ;
;; <
var 
port 
= 
int 
. 
TryParse 
(  
config  &
[& '
$str' 3
]3 4
,4 5
out6 9
var: =
puerto> D
)D E
?F G
puertoH N
:O P
$numQ T
;T U
var 
user 
= 
config 
[ 
$str &
]& '
??( *
config+ 1
[1 2
$str2 A
]A B
??C E
throwF K
newL O%
InvalidOperationExceptionP i
(i j
$strj |
)| }
;} ~
var 
pass 
= 
config 
[ 
$str *
]* +
??, .
throw/ 4
new5 8%
InvalidOperationException9 R
(R S
$strS i
)i j
;j k
var 
from 
= 
config 
[ 
$str &
]& '
??( *
user+ /
;/ 0
var 
	remitente 
= 
config 
[ 
$str 6
]6 7
??8 :
$str; C
;C D
using 
var 
msg 
= 
new 
MailMessage '
{ 	
From 
= 
new 
MailAddress "
(" #
from# '
,' (
	remitente) 2
,2 3
Encoding4 <
.< =
UTF8= A
)A B
,B C
Subject 
= 
asunto 
, 
SubjectEncoding 
= 
Encoding &
.& '
UTF8' +
,+ ,
BodyEncoding 
= 
Encoding #
.# $
UTF8$ (
} 	
;	 

msg 
. 
To 
. 
Add 
( 
new 
MailAddress "
(" #
para# '
)' (
)( )
;) *
msg"" 
."" 
AlternateViews"" 
."" 
Add"" 
("" 
AlternateView"" ,
."", -)
CreateAlternateViewFromString""- J
(""J K
correo""K Q
.""Q R
Texto""R W
,""W X
Encoding""Y a
.""a b
UTF8""b f
,""f g
MediaTypeNames""h v
.""v w
Text""w {
.""{ |
Plain	""| Å
)
""Å Ç
)
""Ç É
;
""É Ñ
var$$ 
	vistaHtml$$ 
=$$ 
AlternateView$$ %
.$$% &)
CreateAlternateViewFromString$$& C
($$C D
correo$$D J
.$$J K
Html$$K O
,$$O P
Encoding$$Q Y
.$$Y Z
UTF8$$Z ^
,$$^ _
MediaTypeNames$$` n
.$$n o
Text$$o s
.$$s t
Html$$t x
)$$x y
;$$y z
var%% 
logo%% 
=%% 
await%% 
LeerLogoAsync%% &
(%%& '
)%%' (
;%%( )
if&& 

(&& 
logo&& 
is&& 
not&& 
null&& 
)&& 
{'' 	
	vistaHtml(( 
.(( 
LinkedResources(( %
.((% &
Add((& )
((() *
new((* -
LinkedResource((. <
(((< =
new((= @
MemoryStream((A M
(((M N
logo((N R
)((R S
,((S T
$str((U `
)((` a
{)) 
	ContentId** 
=** 
PlantillaCorreo** +
.**+ ,
ContentIdLogo**, 9
,**9 :
TransferEncoding++  
=++! "
TransferEncoding++# 3
.++3 4
Base64++4 :
},, 
),, 
;,, 
}-- 	
msg.. 
... 
AlternateViews.. 
... 
Add.. 
(.. 
	vistaHtml.. (
)..( )
;..) *
using00 
var00 
smtp00 
=00 
new00 

SmtpClient00 '
(00' (
host00( ,
,00, -
port00. 2
)002 3
{11 	
	EnableSsl22 
=22 
true22 
,22 
DeliveryMethod33 
=33 
SmtpDeliveryMethod33 /
.33/ 0
Network330 7
,337 8!
UseDefaultCredentials44 !
=44" #
false44$ )
,44) *
Credentials55 
=55 
new55 
NetworkCredential55 /
(55/ 0
user550 4
,554 5
pass556 :
)55: ;
}66 	
;66	 

await88 
smtp88 
.88 
SendMailAsync88  
(88  !
msg88! $
)88$ %
;88% &
logger99 
.99 
LogInformation99 
(99 
$str99 A
,99A B
para99C G
,99G H
asunto99I O
)99O P
;99P Q
}:: 
private== 
async== 
Task== 
<== 
byte== 
[== 
]== 
?== 
>== 
LeerLogoAsync==  -
(==- .
)==. /
{>> 
var?? 
carpeta?? 
=?? 
Path?? 
.?? 
Combine?? "
(??" #
entorno??# *
.??* +
WebRootPath??+ 6
????7 9
Path??: >
.??> ?
Combine??? F
(??F G
entorno??G N
.??N O
ContentRootPath??O ^
,??^ _
$str??` i
)??i j
,??j k
$str??l t
)??t u
;??u v
foreach@@ 
(@@ 
var@@ 
archivo@@ 
in@@ 
new@@  #
[@@# $
]@@$ %
{@@& '
$str@@( @
,@@@ A
$str@@B S
}@@T U
)@@U V
{AA 	
varBB 
rutaBB 
=BB 
PathBB 
.BB 
CombineBB #
(BB# $
carpetaBB$ +
,BB+ ,
archivoBB- 4
)BB4 5
;BB5 6
ifCC 
(CC 
FileCC 
.CC 
ExistsCC 
(CC 
rutaCC  
)CC  !
)CC! "
returnCC# )
awaitCC* /
FileCC0 4
.CC4 5
ReadAllBytesAsyncCC5 F
(CCF G
rutaCCG K
)CCK L
;CCL M
}DD 	
loggerFF 
.FF 

LogWarningFF 
(FF 
$strFF Z
,FFZ [
carpetaFF\ c
)FFc d
;FFd e
returnGG 
nullGG 
;GG 
}HH 
}II ﬂ
^C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\EmailDesarrolloService.cs
public 
class "
EmailDesarrolloService #
(# $
ILogger$ +
<+ ,"
EmailDesarrolloService, B
>B C
loggerD J
)J K
:L M
IEmailServiceN [
{ 
public 

Task 
EnviarAsync 
( 
string "
para# '
,' (
string) /
asunto0 6
,6 7
string8 >
cuerpo? E
)E F
=>G I
EnviarAsync 
( 
para 
, 
asunto  
,  !
PlantillaCorreo" 1
.1 2

DesdeTexto2 <
(< =
asunto= C
,C D
cuerpoE K
)K L
)L M
;M N
public 

Task 
EnviarAsync 
( 
string "
para# '
,' (
string) /
asunto0 6
,6 7

CorreoHtml8 B
correoC I
)I J
{ 
logger		 
.		 
LogInformation		 
(		 
$str		 L
,		L M
para		N R
,		R S
asunto		T Z
,		Z [
Environment		\ g
.		g h
NewLine		h o
,		o p
correo		q w
.		w x
Texto		x }
)		} ~
;		~ 
return

 
Task

 
.

 
CompletedTask

 !
;

! "
} 
} ∂;
SC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\AuthService.cs
public 
class 
AuthService 
( 
IUsuarioRepository +
repo, 0
,0 1
IPasswordHasher2 A
<A B
UsuarioB I
>I J
hasherK Q
)Q R
:S T
IAuthServiceU a
{ 
private 
const 
int 
MaxIntentos !
=" #
$num$ %
;% &
private 
const 
int 
MinutosBloqueo $
=% &
$num' )
;) *
private 
const 
string 
MsgGenerico $
=% &
$str' I
;I J
public		 

async		 
Task		 
<		 
(		 
Usuario		 
?		 
Usuario		  '
,		' (
string		) /
?		/ 0
Error		1 6
)		6 7
>		7 8
IniciarSesionAsync		9 K
(		K L
LoginDto		L T
dto		U X
)		X Y
{

 
var 
usuario 
= 
await 
repo  
.  !,
 ObtenerPorIdentificadorYRolAsync! A
(A B
dtoB E
.E F
IdentificadorF S
.S T
TrimT X
(X Y
)Y Z
,Z [
dto\ _
._ `
Rol` c
)c d
;d e
if 

( 
usuario 
is 
null 
) 
return #
($ %
null% )
,) *
MsgGenerico+ 6
)6 7
;7 8
if 

( 
usuario 
. 
Estado 
== 
EstadoCuenta *
.* +
PendienteActivacion+ >
)> ?
return 
( 
null 
, 
$str	 î
)
î ï
;
ï ñ
var 
ahora 
= 
DateTime 
. 
UtcNow #
;# $
if 

( 
usuario 
. 
BloqueadoHasta "
is# %
{& '
}( )
hasta* /
)/ 0
{ 	
if 
( 
hasta 
> 
ahora 
) 
{ 
var 
minutos 
= 
( 
int "
)" #
Math# '
.' (
Ceiling( /
(/ 0
(0 1
hasta1 6
-7 8
ahora9 >
)> ?
.? @
TotalMinutes@ L
)L M
;M N
return 
( 
null 
, 
$"  
$str  r
{r s
minutoss z
}z {
$str	{ Ü
"
Ü á
)
á à
;
à â
} 
usuario 
. 
BloqueadoHasta "
=# $
null% )
;) *
usuario   
.   
IntentosFallidos   $
=  % &
$num  ' (
;  ( )
await!! 
repo!! 
.!! 
ActualizarAsync!! &
(!!& '
usuario!!' .
)!!. /
;!!/ 0
}"" 	
var%% 
	resultado%% 
=%% 
hasher%% 
.%%  
VerifyHashedPassword%% 3
(%%3 4
usuario%%4 ;
,%%; <
usuario%%= D
.%%D E
PasswordHash%%E Q
,%%Q R
dto%%S V
.%%V W
Password%%W _
)%%_ `
;%%` a
if&& 

(&& 
	resultado&& 
==&& &
PasswordVerificationResult&& 3
.&&3 4
Failed&&4 :
)&&: ;
{'' 	
usuario(( 
.(( 
IntentosFallidos(( $
++(($ &
;((& '
string)) 
error)) 
=)) 
MsgGenerico)) &
;))& '
if++ 
(++ 
usuario++ 
.++ 
IntentosFallidos++ (
>=++) +
MaxIntentos++, 7
)++7 8
{,, 
usuario-- 
.-- 
BloqueadoHasta-- &
=--' (
ahora--) .
.--. /

AddMinutes--/ 9
(--9 :
MinutosBloqueo--: H
)--H I
;--I J
usuario.. 
... 
IntentosFallidos.. (
=..) *
$num..+ ,
;.., -
error// 
=// 
$"// 
$str// $
{//$ %
MaxIntentos//% 0
}//0 1
$str//1 g
{//g h
MinutosBloqueo//h v
}//v w
$str	//w Ä
"
//Ä Å
;
//Å Ç
}00 
await22 
repo22 
.22 
ActualizarAsync22 &
(22& '
usuario22' .
)22. /
;22/ 0
return33 
(33 
null33 
,33 
error33 
)33  
;33  !
}44 	
var77 

hayCambios77 
=77 
usuario77  
.77  !
IntentosFallidos77! 1
!=772 4
$num775 6
||777 9
usuario77: A
.77A B
BloqueadoHasta77B P
is77Q S
not77T W
null77X \
;77\ ]
usuario88 
.88 
IntentosFallidos88  
=88! "
$num88# $
;88$ %
usuario99 
.99 
BloqueadoHasta99 
=99  
null99! %
;99% &
if== 

(== 
	resultado== 
==== &
PasswordVerificationResult== 3
.==3 4
SuccessRehashNeeded==4 G
)==G H
{>> 	
usuario?? 
.?? 
PasswordHash??  
=??! "
hasher??# )
.??) *
HashPassword??* 6
(??6 7
usuario??7 >
,??> ?
dto??@ C
.??C D
Password??D L
)??L M
;??M N

hayCambios@@ 
=@@ 
true@@ 
;@@ 
}AA 	
ifCC 

(CC 

hayCambiosCC 
)CC 
awaitDD 
repoDD 
.DD 
ActualizarAsyncDD &
(DD& '
usuarioDD' .
)DD. /
;DD/ 0
returnGG 
usuarioGG 
.GG 
EstadoGG 
switchGG $
{HH 	
EstadoCuentaII 
.II 
ActivoII 
=>II  "
(II# $
usuarioII$ +
,II+ ,
nullII- 1
)II1 2
,II2 3
EstadoCuentaJJ 
.JJ 
PendienteValidacionJJ ,
=>JJ- /
(JJ0 1
nullJJ1 5
,JJ5 6
$strJJ7 o
)JJo p
,JJp q
EstadoCuentaKK 
.KK 

SuspendidoKK #
=>KK$ &
(KK' (
nullKK( ,
,KK, -
$strKK. Q
)KKQ R
,KKR S
EstadoCuentaLL 
.LL 
	RechazadoLL "
=>LL# %
(LL& '
nullLL' +
,LL+ ,
$"LL- /
$strLL/ c
{LLc d
usuarioLLd k
.LLk l
MotivoRechazoLLl y
}LLy z
"LLz {
)LL{ |
,LL| }
_MM 
=>MM 
(MM 
nullMM 
,MM 
MsgGenericoMM #
)MM# $
}NN 	
;NN	 

}OO 
}PP ür
]C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\AdministracionService.cs
public 
	interface "
IAdministracionService '
{ 
Task 
< 	
List	 
< 
NegocioAdminDto 
> 
> 
ListarNegociosAsync  3
(3 4
)4 5
;5 6
Task 
< 	
(	 

bool
 
Ok 
, 
bool 
CorreoEnviado %
)% &
>& '
AprobarNegocioAsync( ;
(; <
int< ?
	negocioId@ I
,I J
stringK Q
urlLoginR Z
)Z [
;[ \
Task

 
<

 	
List

	 
<

 
AdministradorDto

 
>

 
>

  &
ListarAdministradoresAsync

! ;
(

; <
)

< =
;

= >
Task 
< 	
ResultadoRegistro	 
> '
RegistrarAdministradorAsync 7
(7 8$
RegistroAdministradorDto8 P
dtoQ T
,T U
FuncV Z
<Z [
string[ a
,a b
stringc i
>i j
construirEnlacek z
)z {
;{ |
Task 
< 	
(	 

bool
 
Ok 
, 
string 
Mensaje !
)! "
>" ##
ReenviarActivacionAsync$ ;
(; <
int< ?
	usuarioId@ I
,I J
FuncK O
<O P
stringP V
,V W
stringX ^
>^ _
construirEnlace` o
)o p
;p q
} 
public 
class !
AdministracionService "
(" #%
IAdministracionRepository 
admins $
,$ %
INegocioRepository 
negocios 
,  
IUsuarioRepository 
usuarios 
,  $
IActivacionCuentaService 

activacion '
,' (
IEmailService 
email 
, 
ILogger 
< !
AdministracionService !
>! "
logger# )
)) *
:+ ,"
IAdministracionService- C
{ 
private 
const 
int '
MaxCorreosActivacionPorHora 1
=2 3
$num4 5
;5 6
public 

Task 
< 
List 
< 
NegocioAdminDto $
>$ %
>% &
ListarNegociosAsync' :
(: ;
); <
=>= ?
admins@ F
.F G
ListarNegociosAsyncG Z
(Z [
)[ \
;\ ]
public 

Task 
< 
List 
< 
AdministradorDto %
>% &
>& '&
ListarAdministradoresAsync( B
(B C
)C D
=>E G
adminsH N
.N O&
ListarAdministradoresAsyncO i
(i j
)j k
;k l
public"" 

async"" 
Task"" 
<"" 
("" 
bool"" 
Ok"" 
,"" 
bool""  $
CorreoEnviado""% 2
)""2 3
>""3 4
AprobarNegocioAsync""5 H
(""H I
int""I L
	negocioId""M V
,""V W
string""X ^
urlLogin""_ g
)""g h
{## 
if$$ 

($$ 
!$$ 
await$$ 
admins$$ 
.$$ 
AprobarNegocioAsync$$ -
($$- .
	negocioId$$. 7
)$$7 8
)$$8 9
return$$: @
($$A B
false$$B G
,$$G H
false$$I N
)$$N O
;$$O P
var&& 
negocio&& 
=&& 
await&& 
negocios&& $
.&&$ %
BuscarPorIdAsync&&% 5
(&&5 6
	negocioId&&6 ?
)&&? @
;&&@ A
var'' 
usuario'' 
='' 
negocio'' 
is''  
null''! %
?''& '
null''( ,
:''- .
await''/ 4
usuarios''5 =
.''= >
ObtenerPorIdAsync''> O
(''O P
negocio''P W
.''W X
	UsuarioId''X a
)''a b
;''b c
if(( 

((( 
negocio(( 
is(( 
null(( 
||(( 
usuario(( &
is((' )
null((* .
)((. /
return((0 6
(((7 8
true((8 <
,((< =
false((> C
)((C D
;((D E
try++ 
{,, 	
await-- 
email-- 
.-- 
EnviarAsync-- #
(--# $
usuario--$ +
.--+ ,
Correo--, 2
,--2 3
$str--4 W
,--W X
PlantillaCorreo--Y h
.--h i
Crear--i n
(--n o
etiqueta.. 
:.. 
$str.. +
,..+ ,
titulo// 
:// 
$str// 5
,//5 6
saludo00 
:00 
$"00 
$str00  
{00  !
negocio00! (
.00( )
Nombre00) /
}00/ 0
"000 1
,001 2
parrafos11 
:11 
[22 
$str33 e
,33e f
$str44 
]55 
,55 
datos66 
:66 
[66 
(66 
$str66 "
,66" #
negocio66$ +
.66+ ,
Nombre66, 2
)662 3
,663 4
(665 6
$str666 >
,66> ?
usuario66@ G
.66G H
Correo66H N
)66N O
,66O P
(66Q R
$str66R ]
,66] ^
usuario66_ f
.66f g
	Documento66g p
)66p q
,66q r
(66s t
$str66t |
,66| }
$str	66~ Ü
)
66Ü á
]
66á à
,
66à â

textoBoton77 
:77 
$str77 ,
,77, -
urlBoton88 
:88 
urlLogin88 "
,88" #
nota99 
:99 
$str99 
,	99 Ä
tipoNota:: 
::: 
TipoNota:: "
.::" #
Exito::# (
,::( )
resumen;; 
:;; 
$";; 
{;; 
negocio;; #
.;;# $
Nombre;;$ *
};;* +
$str;;+ ]
";;] ^
);;^ _
);;_ `
;;;` a
return<< 
(<< 
true<< 
,<< 
true<< 
)<< 
;<<  
}== 	
catch>> 
(>> 
	Exception>> 
ex>> 
)>> 
{?? 	
logger@@ 
.@@ 
LogError@@ 
(@@ 
ex@@ 
,@@ 
$str@@  d
,@@d e
negocio@@f m
.@@m n
Nombre@@n t
)@@t u
;@@u v
returnAA 
(AA 
trueAA 
,AA 
falseAA 
)AA  
;AA  !
}BB 	
}CC 
publicFF 

asyncFF 
TaskFF 
<FF 
ResultadoRegistroFF '
>FF' ('
RegistrarAdministradorAsyncFF) D
(FFD E$
RegistroAdministradorDtoFFE ]
dtoFF^ a
,FFa b
FuncFFc g
<FFg h
stringFFh n
,FFn o
stringFFp v
>FFv w
construirEnlace	FFx á
)
FFá à
{GG 
varHH 
	documentoHH 
=HH 
dtoHH 
.HH 
	DocumentoHH %
.HH% &
TrimHH& *
(HH* +
)HH+ ,
;HH, -
varII 
correoII 
=II 
dtoII 
.II 
CorreoII 
.II  
TrimII  $
(II$ %
)II% &
;II& '
varJJ 
telefonoJJ 
=JJ 
dtoJJ 
.JJ 
TelefonoJJ #
.JJ# $
TrimJJ$ (
(JJ( )
)JJ) *
;JJ* +
ifMM 

(MM 
awaitMM 
negociosMM 
.MM  
ExisteDocumentoAsyncMM /
(MM/ 0
	documentoMM0 9
)MM9 :
||MM; =
awaitMM> C
usuariosMMD L
.MML M!
ObtenerPorCorreoAsyncMMM b
(MMb c
correoMMc i
)MMi j
isMMk m
notMMn q
nullMMr v
)MMv w
returnNN 
newNN 
(NN 
falseNN 
,NN 
$strNN R
,NNR S
falseNNT Y
,NNY Z
nullNN[ _
)NN_ `
;NN` a
ifOO 

(OO 
awaitOO 
adminsOO 
.OO 
TelefonoEnUsoAsyncOO +
(OO+ ,
telefonoOO, 4
)OO4 5
)OO5 6
returnPP 
newPP 
(PP 
falsePP 
,PP 
$strPP L
,PPL M
falsePPN S
,PPS T
nullPPU Y
)PPY Z
;PPZ [
varTT 
usuarioTT 
=TT 
newTT 
UsuarioTT !
{UU 	
CorreoVV 
=VV 
correoVV 
,VV 
	DocumentoWW 
=WW 
	documentoWW !
,WW! "
PasswordHashXX 
=XX 
$strXX 
,XX 
RolYY 
=YY 

RolUsuarioYY 
.YY 
AdministradorYY *
,YY* +
EstadoZZ 
=ZZ 
EstadoCuentaZZ !
.ZZ! "
PendienteActivacionZZ" 5
}[[ 	
;[[	 

var]] 
admin]] 
=]] 
new]] 
Administrador]] %
{]]& '
NombreCompleto]]( 6
=]]7 8
dto]]9 <
.]]< =
NombreCompleto]]= K
.]]K L
Trim]]L P
(]]P Q
)]]Q R
,]]R S
Telefono]]T \
=]]] ^
telefono]]_ g
}]]h i
;]]i j
try__ 
{`` 	
awaitaa 
adminsaa 
.aa '
RegistrarAdministradorAsyncaa 4
(aa4 5
usuarioaa5 <
,aa< =
adminaa> C
)aaC D
;aaD E
}bb 	
catchcc 
(cc 
DbUpdateExceptioncc  
excc! #
)cc# $
{dd 	
loggeree 
.ee 
LogErroree 
(ee 
exee 
,ee 
$stree  N
,eeN O
correoeeP V
)eeV W
;eeW X
returnff 
newff 
(ff 
falseff 
,ff 
$strff ]
,ff] ^
falseff_ d
,ffd e
nullfff j
)ffj k
;ffk l
}gg 	
varjj 
enviadojj 
=jj 
awaitjj 

activacionjj &
.jj& '
EnviarEnlaceAsyncjj' 8
(jj8 9
usuariojj9 @
,jj@ A
adminjjB G
.jjG H
NombreCompletojjH V
,jjV W
nulljjX \
,jj\ ]
construirEnlacejj^ m
)jjm n
;jjn o
returnkk 
newkk 
(kk 
truekk 
,kk 
nullkk 
,kk 
enviadokk &
,kk& '
nullkk( ,
)kk, -
;kk- .
}ll 
publicnn 

asyncnn 
Tasknn 
<nn 
(nn 
boolnn 
Oknn 
,nn 
stringnn  &
Mensajenn' .
)nn. /
>nn/ 0#
ReenviarActivacionAsyncnn1 H
(nnH I
intnnI L
	usuarioIdnnM V
,nnV W
FuncnnX \
<nn\ ]
stringnn] c
,nnc d
stringnne k
>nnk l
construirEnlacennm |
)nn| }
{oo 
varpp 
usuariopp 
=pp 
awaitpp 
usuariospp $
.pp$ %
ObtenerPorIdAsyncpp% 6
(pp6 7
	usuarioIdpp7 @
)pp@ A
;ppA B
ifqq 

(qq 
usuarioqq 
isqq 
nullqq 
||qq 
usuarioqq &
.qq& '
Rolqq' *
!=qq+ -

RolUsuarioqq. 8
.qq8 9
Administradorqq9 F
)qqF G
returnrr 
(rr 
falserr 
,rr 
$strrr 8
)rr8 9
;rr9 :
vartt 
admintt 
=tt 
awaittt 
adminstt  
.tt  !$
ObtenerPorUsuarioIdAsynctt! 9
(tt9 :
usuariott: A
.ttA B
IdttB D
)ttD E
;ttE F
varuu 
nombreuu 
=uu 
adminuu 
?uu 
.uu 
NombreCompletouu *
??uu+ -
usuariouu. 5
.uu5 6
Correouu6 <
;uu< =
ifww 

(ww 
usuarioww 
.ww 
Estadoww 
!=ww 
EstadoCuentaww *
.ww* +
PendienteActivacionww+ >
)ww> ?
returnxx 
(xx 
falsexx 
,xx 
$"xx 
{xx 
nombrexx $
}xx$ %
$strxx% :
"xx: ;
)xx; <
;xx< =
ifzz 

(zz 
awaitzz 

activacionzz 
.zz !
EnviosUltimaHoraAsynczz 2
(zz2 3
usuariozz3 :
.zz: ;
Idzz; =
)zz= >
>=zz? A'
MaxCorreosActivacionPorHorazzB ]
)zz] ^
return{{ 
({{ 
false{{ 
,{{ 
$str	{{ Ä
)
{{Ä Å
;
{{Å Ç
var}} 
enviado}} 
=}} 
await}} 

activacion}} &
.}}& '
EnviarEnlaceAsync}}' 8
(}}8 9
usuario}}9 @
,}}@ A
admin}}B G
?}}G H
.}}H I
NombreCompleto}}I W
??}}X Z
$str}}[ ]
,}}] ^
null}}_ c
,}}c d
construirEnlace}}e t
)}}t u
;}}u v
return~~ 
enviado~~ 
? 
( 
true 
, 
$" 
$str <
{< =
usuario= D
.D E
CorreoE K
}K L
$strL M
"M N
)N O
:
ÄÄ 
(
ÄÄ 
false
ÄÄ 
,
ÄÄ 
$str
ÄÄ Z
)
ÄÄZ [
;
ÄÄ[ \
}
ÅÅ 
}ÇÇ —œ
_C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Services\ActivacionCuentaService.cs
public		 
enum		 "
EstadoEnlaceActivacion		 "
{		# $
Valido		% +
,		+ ,
Invalido		- 5
,		5 6
Vencido		7 >
,		> ?
CuentaYaActiva		@ N
}		O P
public 
record 
InfoActivacion 
( "
EstadoEnlaceActivacion 
Estado !
,! "

RolUsuario 
? 
Rol 
= 
null 
, 
string 

Nombre 
= 
$str 
, 
string 

Correo 
= 
$str 
, 
string 

Negocio 
= 
$str 
) 
; 
public 
	interface $
IActivacionCuentaService )
{ 
Task 
< 	
bool	 
> 
EnviarEnlaceAsync  
(  !
Usuario! (
usuario) 0
,0 1
string2 8
nombre9 ?
,? @
stringA G
?G H
nombreNegocioI V
,V W
FuncX \
<\ ]
string] c
,c d
stringe k
>k l
construirEnlacem |
)| }
;} ~
Task 
< 	
int	 
> !
EnviosUltimaHoraAsync #
(# $
int$ '
	usuarioId( 1
)1 2
;2 3
Task 
< 	
InfoActivacion	 
> 
ConsultarAsync '
(' (
string( .
?. /
token0 5
)5 6
;6 7
Task 
< 	
(	 

bool
 
Ok 
, 
string 
? 
Error  
,  !
InfoActivacion" 0
Info1 5
)5 6
>6 7
ActivarAsync8 D
(D E
string 
? 
token 
, 
string 
? 
password '
,' (
string) /
?/ 0
confirmacion1 =
,= >
Func? C
<C D

RolUsuarioD N
,N O
stringP V
>V W
urlLoginX `
)` a
;a b
}   
public"" 
class"" #
ActivacionCuentaService"" $
(""$ %
IUsuarioRepository## 
usuarios## 
,##  (
ITokenRecuperacionRepository$$  
tokens$$! '
,$$' (!
IRepartidorRepository%% 
repartidores%% &
,%%& '%
IAdministracionRepository&& 
administradores&& -
,&&- .
INegocioRepository'' 
negocios'' 
,''  
IPasswordHasher(( 
<(( 
Usuario(( 
>(( 
hasher(( #
,((# $
IEmailService)) 
email)) 
,)) 
ILogger** 
<** #
ActivacionCuentaService** #
>**# $
logger**% +
)**+ ,
:**- .$
IActivacionCuentaService**/ G
{++ 
public,, 

const,, 
int,, 
HorasVigencia,, "
=,,# $
$num,,% '
;,,' (
public.. 

async.. 
Task.. 
<.. 
bool.. 
>.. 
EnviarEnlaceAsync.. -
(..- .
Usuario... 5
usuario..6 =
,..= >
string..? E
nombre..F L
,..L M
string..N T
?..T U
nombreNegocio..V c
,..c d
Func..e i
<..i j
string..j p
,..p q
string..r x
>..x y
construirEnlace	..z â
)
..â ä
{// 
try00 
{11 	
var22 
token22 
=22 
	TokenUtil22 !
.22! "
Generar22" )
(22) *
)22* +
;22+ ,
await33 
tokens33 
.33 
AgregarAsync33 %
(33% &
new33& )
TokenRecuperacion33* ;
{44 
	UsuarioId55 
=55 
usuario55 #
.55# $
Id55$ &
,55& '
	TokenHash66 
=66 
	TokenUtil66 %
.66% &
Hash66& *
(66* +
token66+ 0
)660 1
,661 2
Expira77 
=77 
DateTime77 !
.77! "
UtcNow77" (
.77( )
AddHours77) 1
(771 2
HorasVigencia772 ?
)77? @
}88 
)88 
;88 
var:: 
enlace:: 
=:: 
construirEnlace:: (
(::( )
token::) .
)::. /
;::/ 0
var;; 
(;; 
asunto;; 
,;; 
correo;; 
);;  
=;;! "
usuario;;# *
.;;* +
Rol;;+ .
==;;/ 1

RolUsuario;;2 <
.;;< =
Administrador;;= J
?<< )
CorreoActivacionAdministrador<< /
(<</ 0
usuario<<0 7
,<<7 8
nombre<<9 ?
,<<? @
enlace<<A G
)<<G H
:== &
CorreoActivacionRepartidor== ,
(==, -
usuario==- 4
,==4 5
nombre==6 <
,==< =
nombreNegocio==> K
??==L N
$str==O Q
,==Q R
enlace==S Y
)==Y Z
;==Z [
await?? 
email?? 
.?? 
EnviarAsync?? #
(??# $
usuario??$ +
.??+ ,
Correo??, 2
,??2 3
asunto??4 :
,??: ;
correo??< B
)??B C
;??C D
return@@ 
true@@ 
;@@ 
}AA 	
catchBB 
(BB 
	ExceptionBB 
exBB 
)BB 
{CC 	
loggerDD 
.DD 
LogErrorDD 
(DD 
exDD 
,DD 
$strDD  V
,DDV W
usuarioDDX _
.DD_ `
CorreoDD` f
)DDf g
;DDg h
returnEE 
falseEE 
;EE 
}FF 	
}GG 
publicII 

TaskII 
<II 
intII 
>II !
EnviosUltimaHoraAsyncII *
(II* +
intII+ .
	usuarioIdII/ 8
)II8 9
=>II: <
tokensJJ 
.JJ 
ContarDesdeAsyncJJ 
(JJ  
	usuarioIdJJ  )
,JJ) *
DateTimeJJ+ 3
.JJ3 4
UtcNowJJ4 :
.JJ: ;
AddHoursJJ; C
(JJC D
-JJD E
$numJJE F
)JJF G
)JJG H
;JJH I
publicLL 

asyncLL 
TaskLL 
<LL 
InfoActivacionLL $
>LL$ %
ConsultarAsyncLL& 4
(LL4 5
stringLL5 ;
?LL; <
tokenLL= B
)LLB C
{MM 
varNN 
(NN 
estadoNN 
,NN 
usuarioNN 
)NN 
=NN 
awaitNN  %
ValidarAsyncNN& 2
(NN2 3
tokenNN3 8
)NN8 9
;NN9 :
returnOO 
awaitOO 
	InfoAsyncOO 
(OO 
estadoOO %
,OO% &
usuarioOO' .
)OO. /
;OO/ 0
}PP 
publicRR 

asyncRR 
TaskRR 
<RR 
(RR 
boolRR 
OkRR 
,RR 
stringRR  &
?RR& '
ErrorRR( -
,RR- .
InfoActivacionRR/ =
InfoRR> B
)RRB C
>RRC D
ActivarAsyncRRE Q
(RRQ R
stringSS 
?SS 
tokenSS 
,SS 
stringSS 
?SS 
passwordSS '
,SS' (
stringSS) /
?SS/ 0
confirmacionSS1 =
,SS= >
FuncSS? C
<SSC D

RolUsuarioSSD N
,SSN O
stringSSP V
>SSV W
urlLoginSSX `
)SS` a
{TT 
varUU 
(UU 
estadoUU 
,UU 
usuarioUU 
)UU 
=UU 
awaitUU  %
ValidarAsyncUU& 2
(UU2 3
tokenUU3 8
)UU8 9
;UU9 :
varVV 
infoVV 
=VV 
awaitVV 
	InfoAsyncVV "
(VV" #
estadoVV# )
,VV) *
usuarioVV+ 2
)VV2 3
;VV3 4
ifWW 

(WW 
estadoWW 
!=WW "
EstadoEnlaceActivacionWW ,
.WW, -
ValidoWW- 3
||WW4 6
usuarioWW7 >
isWW? A
nullWWB F
)WWF G
returnWWH N
(WWO P
falseWWP U
,WWU V
nullWWW [
,WW[ \
infoWW] a
)WWa b
;WWb c
ifZZ 

(ZZ 
stringZZ 
.ZZ 
IsNullOrEmptyZZ  
(ZZ  !
passwordZZ! )
)ZZ) *
||ZZ+ -
stringZZ. 4
.ZZ4 5
IsNullOrEmptyZZ5 B
(ZZB C
confirmacionZZC O
)ZZO P
)ZZP Q
return[[ 
([[ 
false[[ 
,[[ 
$str[[ N
,[[N O
info[[P T
)[[T U
;[[U V
if\\ 

(\\ 
password\\ 
!=\\ 
confirmacion\\ $
)\\$ %
return]] 
(]] 
false]] 
,]] 
$str]] 9
,]]9 :
info]]; ?
)]]? @
;]]@ A
if^^ 

(^^ 
!^^ 
ValidadorPassword^^ 
.^^ 
EsValida^^ '
(^^' (
password^^( 0
)^^0 1
)^^1 2
return__ 
(__ 
false__ 
,__ 
$str__ m
,__m n
info__o s
)__s t
;__t u
usuarioaa 
.aa 
PasswordHashaa 
=aa 
hasheraa %
.aa% &
HashPasswordaa& 2
(aa2 3
usuarioaa3 :
,aa: ;
passwordaa< D
)aaD E
;aaE F
usuariobb 
.bb 
Estadobb 
=bb 
EstadoCuentabb %
.bb% &
Activobb& ,
;bb, -
usuariocc 
.cc 
IntentosFallidoscc  
=cc! "
$numcc# $
;cc$ %
usuariodd 
.dd 
BloqueadoHastadd 
=dd  
nulldd! %
;dd% &
awaitee 
usuariosee 
.ee 
ActualizarAsyncee &
(ee& '
usuarioee' .
)ee. /
;ee/ 0
awaithh 
tokenshh 
.hh $
InvalidarPendientesAsynchh -
(hh- .
usuariohh. 5
.hh5 6
Idhh6 8
)hh8 9
;hh9 :
tryjj 
{kk 	
awaitll 
emailll 
.ll 
EnviarAsyncll #
(ll# $
usuarioll$ +
.ll+ ,
Correoll, 2
,ll2 3
$strll4 U
,llU V 
CorreoCuentaActivadamm $
(mm$ %
usuariomm% ,
,mm, -
infomm. 2
,mm2 3
urlLoginmm4 <
(mm< =
usuariomm= D
.mmD E
RolmmE H
)mmH I
)mmI J
)mmJ K
;mmK L
}nn 	
catchoo 
(oo 
	Exceptionoo 
exoo 
)oo 
{pp 	
loggerrr 
.rr 

LogWarningrr 
(rr 
exrr  
,rr  !
$strrr" ^
,rr^ _
usuariorr` g
.rrg h
Correorrh n
)rrn o
;rro p
}ss 	
returnuu 
(uu 
trueuu 
,uu 
nulluu 
,uu 
infouu  
)uu  !
;uu! "
}vv 
privatezz 
staticzz 
(zz 
stringzz 
Asuntozz !
,zz! "

CorreoHtmlzz# -
Correozz. 4
)zz4 5&
CorreoActivacionRepartidorzz6 P
(zzP Q
UsuariozzQ X
usuariozzY `
,zz` a
stringzzb h
nombrezzi o
,zzo p
stringzzq w
negociozzx 
,	zz Ä
string
zzÅ á
enlace
zzà é
)
zzé è
=>
zzê í
({{ 	
$str{{	 3
,{{3 4
PlantillaCorreo{{5 D
.{{D E
Crear{{E J
({{J K
etiqueta|| 
:|| 
$str|| ,
,||, -
titulo}} 
:}} 
$str}} 4
,}}4 5
saludo~~ 
:~~ 
Saludo~~ 
(~~ 
nombre~~ !
)~~! "
,~~" #
parrafos 
: 
[
ÄÄ 
$"
ÅÅ 
$str
ÅÅ 
{
ÅÅ 
negocio
ÅÅ 
}
ÅÅ 
$strÅÅ ¶
"ÅÅ¶ ß
,ÅÅß ®
$str
ÇÇ e
]
ÉÉ 
,
ÉÉ 
datos
ÑÑ 
:
ÑÑ 
[
ÑÑ 
(
ÑÑ 
$str
ÑÑ 
,
ÑÑ 
negocio
ÑÑ  '
)
ÑÑ' (
,
ÑÑ( )
(
ÑÑ* +
$str
ÑÑ+ 3
,
ÑÑ3 4
usuario
ÑÑ5 <
.
ÑÑ< =
Correo
ÑÑ= C
)
ÑÑC D
,
ÑÑD E
(
ÑÑF G
$str
ÑÑG R
,
ÑÑR S
usuario
ÑÑT [
.
ÑÑ[ \
	Documento
ÑÑ\ e
)
ÑÑe f
]
ÑÑf g
,
ÑÑg h

textoBoton
ÖÖ 
:
ÖÖ 
$str
ÖÖ +
,
ÖÖ+ ,
urlBoton
ÜÜ 
:
ÜÜ 
enlace
ÜÜ 
,
ÜÜ 
nota
áá 
:
áá 
$"
áá 
$str
áá )
{
áá) *
HorasVigencia
áá* 7
}
áá7 8
$stráá8 ¢
"áá¢ £
,áá£ §
tipoNota
àà 
:
àà 
TipoNota
àà 
.
àà 
Aviso
àà $
,
àà$ %
resumen
ââ 
:
ââ 
$"
ââ 
{
ââ 
negocio
ââ 
}
ââ  
$str
ââ  ^
"
ââ^ _
)
ââ_ `
)
ââ` a
;
ââa b
private
ãã 
static
ãã 
(
ãã 
string
ãã 
Asunto
ãã !
,
ãã! "

CorreoHtml
ãã# -
Correo
ãã. 4
)
ãã4 5+
CorreoActivacionAdministrador
ãã6 S
(
ããS T
Usuario
ããT [
usuario
ãã\ c
,
ããc d
string
ããe k
nombre
ããl r
,
ããr s
string
ããt z
enlaceãã{ Å
)ããÅ Ç
=>ããÉ Ö
(
åå 	
$str
åå	 6
,
åå6 7
PlantillaCorreo
åå8 G
.
ååG H
Crear
ååH M
(
ååM N
etiqueta
çç 
:
çç 
$str
çç ,
,
çç, -
titulo
éé 
:
éé 
$str
éé 7
,
éé7 8
saludo
èè 
:
èè 
Saludo
èè 
(
èè 
nombre
èè !
)
èè! "
,
èè" #
parrafos
êê 
:
êê 
[
ëë 
$stríí ¨
,íí¨ ≠
$str
ìì e
]
îî 
,
îî 
datos
ïï 
:
ïï 
[
ïï 
(
ïï 
$str
ïï 
,
ïï 
$str
ïï .
)
ïï. /
,
ïï/ 0
(
ïï1 2
$str
ïï2 :
,
ïï: ;
usuario
ïï< C
.
ïïC D
Correo
ïïD J
)
ïïJ K
,
ïïK L
(
ïïM N
$str
ïïN Y
,
ïïY Z
usuario
ïï[ b
.
ïïb c
	Documento
ïïc l
)
ïïl m
]
ïïm n
,
ïïn o

textoBoton
ññ 
:
ññ 
$str
ññ +
,
ññ+ ,
urlBoton
óó 
:
óó 
enlace
óó 
,
óó 
nota
òò 
:
òò 
$"
òò 
$str
òò )
{
òò) *
HorasVigencia
òò* 7
}
òò7 8
$stròò8 ™
"òò™ ´
,òò´ ¨
tipoNota
ôô 
:
ôô 
TipoNota
ôô 
.
ôô 
Aviso
ôô $
,
ôô$ %
resumen
öö 
:
öö 
$str
öö d
)
ööd e
)
ööe f
;
ööf g
private
úú 
static
úú 

CorreoHtml
úú "
CorreoCuentaActivada
úú 2
(
úú2 3
Usuario
úú3 :
usuario
úú; B
,
úúB C
InfoActivacion
úúD R
info
úúS W
,
úúW X
string
úúY _
urlLogin
úú` h
)
úúh i
{
ùù 
var
ûû 
esAdmin
ûû 
=
ûû 
usuario
ûû 
.
ûû 
Rol
ûû !
==
ûû" $

RolUsuario
ûû% /
.
ûû/ 0
Administrador
ûû0 =
;
ûû= >
var
üü 
perfil
üü 
=
üü 
esAdmin
üü 
?
üü 
$str
üü .
:
üü/ 0
$str
üü1 =
;
üü= >
var
†† 
registro
†† 
=
†† 
esAdmin
†† 
?
°° 
$str
°° ?
:
¢¢ 
string
¢¢ 
.
¢¢  
IsNullOrWhiteSpace
¢¢ '
(
¢¢' (
info
¢¢( ,
.
¢¢, -
Negocio
¢¢- 4
)
¢¢4 5
?
££ 
$str
££ @
:
§§ 
$"
§§ 
$str
§§ ;
{
§§; <
info
§§< @
.
§§@ A
Negocio
§§A H
}
§§H I
$str
§§I V
"
§§V W
;
§§W X
return
¶¶ 
PlantillaCorreo
¶¶ 
.
¶¶ 
Crear
¶¶ $
(
¶¶$ %
etiqueta
ßß 
:
ßß 
$str
ßß '
,
ßß' (
titulo
®® 
:
®® 
$str
®® ,
,
®®, -
saludo
©© 
:
©© 
Saludo
©© 
(
©© 
info
©© 
.
©©  
Nombre
©©  &
)
©©& '
,
©©' (
parrafos
™™ 
:
™™ 
[
´´ 
registro
¨¨ 
+
¨¨ 
$str
¨¨ f
,
¨¨f g
$"
≠≠ 
$str
≠≠ 1
{
≠≠1 2
perfil
≠≠2 8
}
≠≠8 9
$str
≠≠9 i
"
≠≠i j
]
ÆÆ 
,
ÆÆ 
datos
ØØ 
:
ØØ 
[
ØØ 
(
ØØ 
$str
ØØ 
,
ØØ 
perfil
ØØ %
)
ØØ% &
,
ØØ& '
(
ØØ( )
$str
ØØ) 1
,
ØØ1 2
usuario
ØØ3 :
.
ØØ: ;
Correo
ØØ; A
)
ØØA B
,
ØØB C
(
ØØD E
$str
ØØE P
,
ØØP Q
usuario
ØØR Y
.
ØØY Z
	Documento
ØØZ c
)
ØØc d
]
ØØd e
,
ØØe f

textoBoton
∞∞ 
:
∞∞ 
$str
∞∞ (
,
∞∞( )
urlBoton
±± 
:
±± 
urlLogin
±± 
,
±± 
nota
≤≤ 
:
≤≤ 
esAdmin
≤≤ 
?
≥≥ 
$str
≥≥ g
:
¥¥ 
$str
¥¥ c
,
¥¥c d
tipoNota
µµ 
:
µµ 
TipoNota
µµ 
.
µµ 
Info
µµ #
,
µµ# $
resumen
∂∂ 
:
∂∂ 
$"
∂∂ 
$str
∂∂ $
{
∂∂$ %
perfil
∂∂% +
.
∂∂+ ,
ToLowerInvariant
∂∂, <
(
∂∂< =
)
∂∂= >
}
∂∂> ?
$str
∂∂? q
"
∂∂q r
)
∂∂r s
;
∂∂s t
}
∑∑ 
private
ªª 
async
ªª 
Task
ªª 
<
ªª 
(
ªª $
EstadoEnlaceActivacion
ªª .
Estado
ªª/ 5
,
ªª5 6
Usuario
ªª7 >
?
ªª> ?
Usuario
ªª@ G
)
ªªG H
>
ªªH I
ValidarAsync
ªªJ V
(
ªªV W
string
ªªW ]
?
ªª] ^
token
ªª_ d
)
ªªd e
{
ºº 
if
ΩΩ 

(
ΩΩ 
string
ΩΩ 
.
ΩΩ  
IsNullOrWhiteSpace
ΩΩ %
(
ΩΩ% &
token
ΩΩ& +
)
ΩΩ+ ,
)
ΩΩ, -
return
ΩΩ. 4
(
ΩΩ5 6$
EstadoEnlaceActivacion
ΩΩ6 L
.
ΩΩL M
Invalido
ΩΩM U
,
ΩΩU V
null
ΩΩW [
)
ΩΩ[ \
;
ΩΩ\ ]
var
øø 
t
øø 
=
øø 
await
øø 
tokens
øø 
.
øø !
ObtenerPorHashAsync
øø 0
(
øø0 1
	TokenUtil
øø1 :
.
øø: ;
Hash
øø; ?
(
øø? @
token
øø@ E
)
øøE F
)
øøF G
;
øøG H
if
¿¿ 

(
¿¿ 
t
¿¿ 
is
¿¿ 
null
¿¿ 
)
¿¿ 
return
¿¿ 
(
¿¿ $
EstadoEnlaceActivacion
¿¿ 5
.
¿¿5 6
Invalido
¿¿6 >
,
¿¿> ?
null
¿¿@ D
)
¿¿D E
;
¿¿E F
var
√√ 
usuario
√√ 
=
√√ 
await
√√ 
usuarios
√√ $
.
√√$ %
ObtenerPorIdAsync
√√% 6
(
√√6 7
t
√√7 8
.
√√8 9
	UsuarioId
√√9 B
)
√√B C
;
√√C D
if
ƒƒ 

(
ƒƒ 
usuario
ƒƒ 
is
ƒƒ 
null
ƒƒ 
||
ƒƒ 
usuario
ƒƒ &
.
ƒƒ& '
Rol
ƒƒ' *
==
ƒƒ+ -

RolUsuario
ƒƒ. 8
.
ƒƒ8 9
Negocio
ƒƒ9 @
)
ƒƒ@ A
return
ƒƒB H
(
ƒƒI J$
EstadoEnlaceActivacion
ƒƒJ `
.
ƒƒ` a
Invalido
ƒƒa i
,
ƒƒi j
null
ƒƒk o
)
ƒƒo p
;
ƒƒp q
if
∆∆ 

(
∆∆ 
usuario
∆∆ 
.
∆∆ 
Estado
∆∆ 
==
∆∆ 
EstadoCuenta
∆∆ *
.
∆∆* +
Activo
∆∆+ 1
)
∆∆1 2
return
∆∆3 9
(
∆∆: ;$
EstadoEnlaceActivacion
∆∆; Q
.
∆∆Q R
CuentaYaActiva
∆∆R `
,
∆∆` a
usuario
∆∆b i
)
∆∆i j
;
∆∆j k
if
«« 

(
«« 
usuario
«« 
.
«« 
Estado
«« 
!=
«« 
EstadoCuenta
«« *
.
««* +!
PendienteActivacion
««+ >
||
««? A
t
««B C
.
««C D
Usado
««D I
)
««I J
return
««K Q
(
««R S$
EstadoEnlaceActivacion
««S i
.
««i j
Invalido
««j r
,
««r s
usuario
««t {
)
««{ |
;
««| }
if
»» 

(
»» 
t
»» 
.
»» 
Expira
»» 
<=
»» 
DateTime
»»  
.
»»  !
UtcNow
»»! '
)
»»' (
return
»») /
(
»»0 1$
EstadoEnlaceActivacion
»»1 G
.
»»G H
Vencido
»»H O
,
»»O P
usuario
»»Q X
)
»»X Y
;
»»Y Z
return
   
(
   $
EstadoEnlaceActivacion
   &
.
  & '
Valido
  ' -
,
  - .
usuario
  / 6
)
  6 7
;
  7 8
}
ÀÀ 
private
ŒŒ 
async
ŒŒ 
Task
ŒŒ 
<
ŒŒ 
InfoActivacion
ŒŒ %
>
ŒŒ% &
	InfoAsync
ŒŒ' 0
(
ŒŒ0 1$
EstadoEnlaceActivacion
ŒŒ1 G
estado
ŒŒH N
,
ŒŒN O
Usuario
ŒŒP W
?
ŒŒW X
usuario
ŒŒY `
)
ŒŒ` a
{
œœ 
if
–– 

(
–– 
usuario
–– 
is
–– 
null
–– 
)
–– 
return
–– #
new
––$ '
InfoActivacion
––( 6
(
––6 7
estado
––7 =
)
––= >
;
––> ?
if
““ 

(
““ 
usuario
““ 
.
““ 
Rol
““ 
==
““ 

RolUsuario
““ %
.
““% &
Administrador
““& 3
)
““3 4
{
”” 	
var
‘‘ 
administrador
‘‘ 
=
‘‘ 
await
‘‘  %
administradores
‘‘& 5
.
‘‘5 6&
ObtenerPorUsuarioIdAsync
‘‘6 N
(
‘‘N O
usuario
‘‘O V
.
‘‘V W
Id
‘‘W Y
)
‘‘Y Z
;
‘‘Z [
return
’’ 
new
’’ 
InfoActivacion
’’ %
(
’’% &
estado
’’& ,
,
’’, -
usuario
’’. 5
.
’’5 6
Rol
’’6 9
,
’’9 :
administrador
’’; H
?
’’H I
.
’’I J
NombreCompleto
’’J X
??
’’Y [
$str
’’\ ^
,
’’^ _
usuario
’’` g
.
’’g h
Correo
’’h n
)
’’n o
;
’’o p
}
÷÷ 	
var
ÿÿ 

repartidor
ÿÿ 
=
ÿÿ 
await
ÿÿ 
repartidores
ÿÿ +
.
ÿÿ+ ,&
ObtenerPorUsuarioIdAsync
ÿÿ, D
(
ÿÿD E
usuario
ÿÿE L
.
ÿÿL M
Id
ÿÿM O
)
ÿÿO P
;
ÿÿP Q
var
ŸŸ 
negocio
ŸŸ 
=
ŸŸ 

repartidor
ŸŸ  
is
ŸŸ! #
null
ŸŸ$ (
?
ŸŸ) *
null
ŸŸ+ /
:
ŸŸ0 1
await
ŸŸ2 7
negocios
ŸŸ8 @
.
ŸŸ@ A
BuscarPorIdAsync
ŸŸA Q
(
ŸŸQ R

repartidor
ŸŸR \
.
ŸŸ\ ]
	NegocioId
ŸŸ] f
)
ŸŸf g
;
ŸŸg h
return
⁄⁄ 
new
⁄⁄ 
InfoActivacion
⁄⁄ !
(
⁄⁄! "
estado
⁄⁄" (
,
⁄⁄( )
usuario
⁄⁄* 1
.
⁄⁄1 2
Rol
⁄⁄2 5
,
⁄⁄5 6

repartidor
⁄⁄7 A
?
⁄⁄A B
.
⁄⁄B C
NombreCompleto
⁄⁄C Q
??
⁄⁄R T
$str
⁄⁄U W
,
⁄⁄W X
usuario
⁄⁄Y `
.
⁄⁄` a
Correo
⁄⁄a g
,
⁄⁄g h
negocio
⁄⁄i p
?
⁄⁄p q
.
⁄⁄q r
Nombre
⁄⁄r x
??
⁄⁄y {
$str
⁄⁄| ~
)
⁄⁄~ 
;⁄⁄ Ä
}
€€ 
private
›› 
static
›› 
string
›› 
Saludo
››  
(
››  !
string
››! '
?
››' (
nombre
››) /
)
››/ 0
=>
››1 3
string
ﬁﬁ 
.
ﬁﬁ  
IsNullOrWhiteSpace
ﬁﬁ !
(
ﬁﬁ! "
nombre
ﬁﬁ" (
)
ﬁﬁ( )
?
ﬁﬁ* +
$str
ﬁﬁ, 3
:
ﬁﬁ4 5
$"
ﬁﬁ6 8
$str
ﬁﬁ8 >
{
ﬁﬁ> ?
nombre
ﬁﬁ? E
}
ﬁﬁE F
"
ﬁﬁF G
;
ﬁﬁG H
}ﬂﬂ ÿ&
]C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\UsuarioRepository.cs
public 
class 
UsuarioRepository 
( 
AppDbContext +
db, .
). /
:0 1
IUsuarioRepository2 D
{ 
public 

Task 
< 
Usuario 
? 
> ,
 ObtenerPorIdentificadorYRolAsync :
(: ;
string; A
identificadorB O
,O P

RolUsuarioQ [
rol\ _
)_ `
=>a c
db 

.
 
Usuarios 
. 
FirstOrDefaultAsync '
(' (
u( )
=>* ,
u 
. 
Rol 
== 
rol 
&& 
( 
u 
. 
Correo %
==& (
identificador) 6
||7 9
u: ;
.; <
	Documento< E
==F H
identificadorI V
)V W
)W X
;X Y
public		 

Task		 
<		 
Usuario		 
?		 
>		 !
ObtenerPorCorreoAsync		 /
(		/ 0
string		0 6
correo		7 =
)		= >
=>		? A
db

 

.


 
Usuarios

 
.

 
FirstOrDefaultAsync

 '
(

' (
u

( )
=>

* ,
u

- .
.

. /
Correo

/ 5
==

6 8
correo

9 ?
)

? @
;

@ A
public 

Task 
< 
Usuario 
? 
> 
ObtenerPorIdAsync +
(+ ,
int, /
id0 2
)2 3
=>4 6
db 

.
 
Usuarios 
. 
FirstOrDefaultAsync '
(' (
u( )
=>* ,
u- .
.. /
Id/ 1
==2 4
id5 7
)7 8
;8 9
public 

async 
Task 
ActualizarAsync %
(% &
Usuario& -
usuario. 5
)5 6
{ 
db 

.
 
Usuarios 
. 
Update 
( 
usuario "
)" #
;# $
await 
db 
. 
SaveChangesAsync !
(! "
)" #
;# $
} 
public 

Task 
< 
List 
< 
string 
> 
> .
"CorreosAdministradoresActivosAsync @
(@ A
)A B
=>C E
db 

.
 
Usuarios 
. 
AsNoTracking 
( 
) 
. 
Where 
( 
u 
=> 
u 
. 
Rol 
==  

RolUsuario! +
.+ ,
Administrador, 9
&&: <
u= >
.> ?
Estado? E
==F H
EstadoCuentaI U
.U V
ActivoV \
)\ ]
. 
Select 
( 
u 
=> 
u 
. 
Correo !
)! "
. 
ToListAsync 
( 
) 
; 
public 

async 
Task "
LiberarEliminadosAsync ,
(, -
string- 3
correo4 :
,: ;
string< B
	documentoC L
)L M
{ 
var 

eliminados 
= 
await 
db !
.! "
Usuarios" *
. 
Where 
( 
u 
=> 
u 
. 
Estado  
==! #
EstadoCuenta$ 0
.0 1
	Eliminado1 :
&&; =
(> ?
u? @
.@ A
CorreoA G
==H J
correoK Q
||R T
uU V
.V W
	DocumentoW `
==a c
	documentod m
)m n
)n o
.   
ToListAsync   
(   
)   
;   
if!! 

(!! 

eliminados!! 
.!! 
Count!! 
==!! 
$num!!  !
)!!! "
return!!# )
;!!) *
foreach## 
(## 
var## 
u## 
in## 

eliminados## $
)##$ %
u##& '
.##' ("
LiberarIdentificadores##( >
(##> ?
)##? @
;##@ A
await$$ 
db$$ 
.$$ 
SaveChangesAsync$$ !
($$! "
)$$" #
;$$# $
}%% 
}&& ¯
_C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\UbicacionRepository.cs
public 
class 
UbicacionRepository  
(  !
AppDbContext! -
db. 0
)0 1
:2 3 
IUbicacionRepository4 H
{ 
public 

async 
Task 
< 
UbicacionPedido %
?% &
>& '
ObtenerAsync( 4
(4 5
int5 8
pedidoId9 A
)A B
=>C E
await 
db 
. 
UbicacionesPedido "
. 
FirstOrDefaultAsync  
(  !
u! "
=># %
u& '
.' (
PedidoId( 0
==1 3
pedidoId4 <
)< =
;= >
public		 

async		 
Task		 
GuardarAsync		 "
(		" #
int		# &
pedidoId		' /
,		/ 0
decimal		1 8
lat		9 <
,		< =
decimal		> E
lng		F I
)		I J
{

 
var 
	ubicacion 
= 
await 
db  
.  !
UbicacionesPedido! 2
. 
FirstOrDefaultAsync  
(  !
u! "
=># %
u& '
.' (
PedidoId( 0
==1 3
pedidoId4 <
)< =
;= >
if 

( 
	ubicacion 
is 
null 
) 
{ 	
	ubicacion 
= 
new 
UbicacionPedido +
{ 
PedidoId 
= 
pedidoId #
,# $
Latitud 
= 
lat 
, 
Longitud 
= 
lng 
, 
FechaActualizacion "
=# $
DateTime% -
.- .
UtcNow. 4
} 
; 
db 
. 
UbicacionesPedido  
.  !
Add! $
($ %
	ubicacion% .
). /
;/ 0
} 	
else 
{ 	
	ubicacion 
. 
Latitud 
= 
lat  #
;# $
	ubicacion 
. 
Longitud 
=  
lng! $
;$ %
	ubicacion 
. 
FechaActualizacion (
=) *
DateTime+ 3
.3 4
UtcNow4 :
;: ;
db 
. 
UbicacionesPedido  
.  !
Update! '
(' (
	ubicacion( 1
)1 2
;2 3
} 	
await!! 
db!! 
.!! 
SaveChangesAsync!! !
(!!! "
)!!" #
;!!# $
}"" 
}## π
gC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\TokenRecuperacionRepository.cs
public 
class '
TokenRecuperacionRepository (
(( )
AppDbContext) 5
db6 8
)8 9
:: ;(
ITokenRecuperacionRepository< X
{ 
public 

async 
Task 
AgregarAsync "
(" #
TokenRecuperacion# 4
token5 :
): ;
{ 
db 

.
 
TokensRecuperacion 
. 
Add !
(! "
token" '
)' (
;( )
await 
db 
. 
SaveChangesAsync !
(! "
)" #
;# $
}		 
public 

Task 
< 
TokenRecuperacion !
?! "
>" #
ObtenerPorHashAsync$ 7
(7 8
string8 >
hash? C
)C D
=>E G
db 

.
 
TokensRecuperacion 
. 
FirstOrDefaultAsync 1
(1 2
t2 3
=>4 6
t7 8
.8 9
	TokenHash9 B
==C E
hashF J
)J K
;K L
public 

Task 
< 
int 
> 
ContarDesdeAsync %
(% &
int& )
	usuarioId* 3
,3 4
DateTime5 =
desde> C
)C D
=>E G
db 

.
 
TokensRecuperacion 
. 

CountAsync (
(( )
t) *
=>+ -
t. /
./ 0
	UsuarioId0 9
==: <
	usuarioId= F
&&G I
tJ K
.K L
FechaCreacionL Y
>=Z \
desde] b
)b c
;c d
public 

async 
Task 
ActualizarAsync %
(% &
TokenRecuperacion& 7
token8 =
)= >
{ 
db 

.
 
TokensRecuperacion 
. 
Update $
($ %
token% *
)* +
;+ ,
await 
db 
. 
SaveChangesAsync !
(! "
)" #
;# $
} 
public 

async 
Task $
InvalidarPendientesAsync .
(. /
int/ 2
	usuarioId3 <
)< =
{ 
var 

pendientes 
= 
await 
db !
.! "
TokensRecuperacion" 4
. 
Where 
( 
t 
=> 
t 
. 
	UsuarioId #
==$ &
	usuarioId' 0
&&1 3
!4 5
t5 6
.6 7
Usado7 <
)< =
. 
ToListAsync 
( 
) 
; 
if 

( 

pendientes 
. 
Count 
== 
$num  !
)! "
return# )
;) *
foreach 
( 
var 
t 
in 

pendientes $
)$ %
t& '
.' (
Usado( -
=. /
true0 4
;4 5
await 
db 
. 
SaveChangesAsync !
(! "
)" #
;# $
}   
}!! ÑN
`C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\RepartidorRepository.cs
public 
class  
RepartidorRepository !
(! "
AppDbContext" .
db/ 1
)1 2
:3 4!
IRepartidorRepository5 J
{ 
public 

async 
Task $
RegistrarRepartidorAsync .
(. /
Usuario/ 6
usuario7 >
,> ?

Repartidor@ J

repartidorK U
)U V
{ 

repartidor		 
.		 
Usuario		 
=		 
usuario		 $
;		$ %
await

 )
LiberarPlacaDeEliminadosAsync

 +
(

+ ,

repartidor

, 6
.

6 7
Placa

7 <
,

< =
null

> B
)

B C
;

C D
db 

.
 
Repartidores 
. 
Add 
( 

repartidor &
)& '
;' (
await 
db 
. 
SaveChangesAsync !
(! "
)" #
;# $
} 
public 

async 
Task 
< 

Repartidor  
?  !
>! " 
BuscarEliminadoAsync# 7
(7 8
string8 >
correo? E
,E F
stringG M
	documentoN W
)W X
{ 
var 

candidatos 
= 
await 
db !
.! "
Repartidores" .
. 
Include 
( 
r 
=> 
r 
. 
Usuario #
)# $
. 
Where 
( 
r 
=> 
r 
. 
Usuario !
!! "
." #
Estado# )
==* ,
EstadoCuenta- 9
.9 :
	Eliminado: C
&&D F
( 
r 
. 
Usuario 
. 
Correo !
==" $
correo% +
||, .
r/ 0
.0 1
Usuario1 8
.8 9
Correo9 ?
.? @
EndsWith@ H
(H I
$strI L
+M N
correoO U
)U V
||W Y
r 
. 
Usuario 
. 
	Documento $
==% '
	documento( 1
||2 4
r5 6
.6 7
Usuario7 >
.> ?
	Documento? H
.H I
EndsWithI Q
(Q R
$strR U
+V W
	documentoX a
)a b
)b c
)c d
. 
OrderByDescending 
( 
r  
=>! #
r$ %
.% &
Id& (
)( )
. 
ToListAsync 
( 
) 
; 
return 

candidatos 
. 
FirstOrDefault (
(( )
r) *
=>+ -
r 
. 
Usuario 
! 
. 
Correo 
==  
correo! '
||( *
r+ ,
., -
Usuario- 4
.4 5
Correo5 ;
==< >
$"? A
$strA K
{K L
rL M
.M N
	UsuarioIdN W
}W X
$strX Y
{Y Z
correoZ `
}` a
"a b
||c e
r 
. 
Usuario 
. 
	Documento 
==  "
	documento# ,
||- /
r0 1
.1 2
Usuario2 9
.9 :
	Documento: C
==D F
$"G I
$strI J
{J K
rK L
.L M
	UsuarioIdM V
}V W
$strW X
{X Y
	documentoY b
}b c
"c d
)d e
;e f
} 
public 

async 
Task 
ReactivarAsync $
($ %

Repartidor% /

repartidor0 :
): ;
{   
await!! )
LiberarPlacaDeEliminadosAsync!! +
(!!+ ,

repartidor!!, 6
.!!6 7
Placa!!7 <
,!!< =

repartidor!!> H
.!!H I
Id!!I K
)!!K L
;!!L M
await"" 
db"" 
."" 
SaveChangesAsync"" !
(""! "
)""" #
;""# $
}## 
private&& 
async&& 
Task&& )
LiberarPlacaDeEliminadosAsync&& 4
(&&4 5
string&&5 ;
?&&; <
placa&&= B
,&&B C
int&&D G
?&&G H
	excluirId&&I R
)&&R S
{'' 
if(( 

((( 
string(( 
.(( 
IsNullOrEmpty((  
(((  !
placa((! &
)((& '
)((' (
return(() /
;((/ 0
var)) 
conPlaca)) 
=)) 
await)) 
db)) 
.))  
Repartidores))  ,
.** 
Where** 
(** 
r** 
=>** 
r** 
.** 
Placa** 
==**  "
placa**# (
&&**) +
r**, -
.**- .
Usuario**. 5
!**5 6
.**6 7
Estado**7 =
==**> @
EstadoCuenta**A M
.**M N
	Eliminado**N W
&&**X Z
(++ 
	excluirId++ "
==++# %
null++& *
||+++ -
r++. /
.++/ 0
Id++0 2
!=++3 5
	excluirId++6 ?
)++? @
)++@ A
.,, 
ToListAsync,, 
(,, 
),, 
;,, 
foreach-- 
(-- 
var-- 
r-- 
in-- 
conPlaca-- "
)--" #
r--$ %
.--% &
Placa--& +
=--, -
null--. 2
;--2 3
}.. 
public00 

Task00 
<00 
List00 
<00 

Repartidor00 
>00  
>00  !!
ListarPorNegocioAsync00" 7
(007 8
int008 ;
	negocioId00< E
)00E F
=>00G I
db11 

.11
 
Repartidores11 
.22 
AsNoTracking22 
(22 
)22 
.33 
Include33 
(33 
r33 
=>33 
r33 
.33 
Usuario33 #
)33# $
.44 
Where44 
(44 
r44 
=>44 
r44 
.44 
	NegocioId44 #
==44$ &
	negocioId44' 0
&&441 3
r444 5
.445 6
Usuario446 =
!44= >
.44> ?
Estado44? E
!=44F H
EstadoCuenta44I U
.44U V
	Eliminado44V _
)44_ `
.55 
OrderByDescending55 
(55 
r55  
=>55! #
r55$ %
.55% &
FechaRegistro55& 3
)553 4
.66 
ToListAsync66 
(66 
)66 
;66 
public88 

async88 
Task88 
<88 
bool88 
>88 
TelefonoEnUsoAsync88 .
(88. /
string88/ 5
telefono886 >
)88> ?
=>88@ B
await99 
db99 
.99 
Negocios99 
.99 
AnyAsync99 "
(99" #
n99# $
=>99% '
n99( )
.99) *
Telefono99* 2
==993 5
telefono996 >
)99> ?
||99@ B
await;; 
db;; 
.;; 
Repartidores;; 
.;; 
AnyAsync;; &
(;;& '
r;;' (
=>;;) +
r;;, -
.;;- .
Telefono;;. 6
==;;7 9
telefono;;: B
&&;;C E
r;;F G
.;;G H
Usuario;;H O
!;;O P
.;;P Q
Estado;;Q W
!=;;X Z
EstadoCuenta;;[ g
.;;g h
	Eliminado;;h q
);;q r
||;;s u
await<< 
db<< 
.<< 
Administradores<<  
.<<  !
AnyAsync<<! )
(<<) *
a<<* +
=><<, .
a<</ 0
.<<0 1
Telefono<<1 9
==<<: <
telefono<<= E
)<<E F
;<<F G
public>> 

Task>> 
<>> 

Repartidor>> 
?>> 
>>> !
ObtenerDeNegocioAsync>> 2
(>>2 3
int>>3 6
	negocioId>>7 @
,>>@ A
int>>B E
repartidorId>>F R
)>>R S
=>>>T V
db?? 

.??
 
Repartidores?? 
.@@ 
Include@@ 
(@@ 
r@@ 
=>@@ 
r@@ 
.@@ 
Usuario@@ #
)@@# $
.AA 
FirstOrDefaultAsyncAA  
(AA  !
rAA! "
=>AA# %
rAA& '
.AA' (
IdAA( *
==AA+ -
repartidorIdAA. :
&&AA; =
rAA> ?
.AA? @
	NegocioIdAA@ I
==AAJ L
	negocioIdAAM V
)AAV W
;AAW X
publicCC 

TaskCC 
<CC 

RepartidorCC 
?CC 
>CC $
ObtenerPorUsuarioIdAsyncCC 5
(CC5 6
intCC6 9
	usuarioIdCC: C
)CCC D
=>CCE G
dbDD 

.DD
 
RepartidoresDD 
.EE 
AsNoTrackingEE 
(EE 
)EE 
.FF 
FirstOrDefaultAsyncFF  
(FF  !
rFF! "
=>FF# %
rFF& '
.FF' (
	UsuarioIdFF( 1
==FF2 4
	usuarioIdFF5 >
)FF> ?
;FF? @
}GG ≤(
\C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\PedidoRepository.cs
public 
class 
PedidoRepository 
( 
AppDbContext *
db+ -
)- .
:/ 0
IPedidoRepository1 B
{ 
public 

async 
Task 
< 
Pedido 
? 
> 
ObtenerPorIdAsync 0
(0 1
int1 4
id5 7
)7 8
=>9 ;
await 
db 
. 
Pedidos 
. 
Include 
( 
p 
=> 
p 
. 
Cliente #
)# $
. 
FirstOrDefaultAsync  
(  !
p! "
=># %
p& '
.' (
Id( *
==+ -
id. 0
)0 1
;1 2
public

 

async

 
Task

 
<

 
Pedido

 
?

 
>

 !
ObtenerPorCodigoAsync

 4
(

4 5
string

5 ;
codigo

< B
)

B C
=>

D F
await 
db 
. 
Pedidos 
. 
Include 
( 
p 
=> 
p 
. 
Items !
)! "
. 
Include 
( 
p 
=> 
p 
. 
Cliente #
)# $
. 
FirstOrDefaultAsync  
(  !
p! "
=># %
p& '
.' (
Codigo( .
==/ 1
codigo2 8
)8 9
;9 :
public 

async 
Task 
< 
Pedido 
? 
> )
ObtenerUltimoPorTelefonoAsync <
(< =
int= @
	negocioIdA J
,J K
stringL R
telefonoS [
)[ \
=>] _
await 
db 
. 
Pedidos 
. 
Include 
( 
p 
=> 
p 
. 
Cliente #
)# $
. 
Where 
( 
p 
=> 
p 
. 
	NegocioId #
==$ &
	negocioId' 0
&&1 3
p4 5
.5 6
Cliente6 =
!=> @
nullA E
&&F H
pI J
.J K
ClienteK R
.R S
TelefonoS [
==\ ^
telefono_ g
)g h
. 
OrderByDescending 
( 
p  
=>! #
p$ %
.% &
FechaCreacion& 3
)3 4
. 
FirstOrDefaultAsync  
(  !
)! "
;" #
public 

async 
Task 
< 
bool 
> 
ExisteCodigoAsync -
(- .
string. 4
codigo5 ;
); <
=>= ?
await 
db 
. 
Pedidos 
. 
AnyAsync !
(! "
p" #
=>$ &
p' (
.( )
Codigo) /
==0 2
codigo3 9
)9 :
;: ;
public 

async 
Task 
AgregarAsync "
(" #
Pedido# )
pedido* 0
)0 1
{ 
db 

.
 
Pedidos 
. 
Add 
( 
pedido 
) 
; 
await 
db 
. 
SaveChangesAsync !
(! "
)" #
;# $
} 
public   

async   
Task   
ActualizarAsync   %
(  % &
Pedido  & ,
pedido  - 3
)  3 4
{!! 
db"" 

.""
 
Pedidos"" 
."" 
Update"" 
("" 
pedido""  
)""  !
;""! "
await## 
db## 
.## 
SaveChangesAsync## !
(##! "
)##" #
;### $
}$$ 
public&& 

async&& 
Task&& 
<&& 
List&& 
<&& 
Pedido&& !
>&&! "
>&&" #"
ObtenerPorNegocioAsync&&$ :
(&&: ;
int&&; >
	negocioId&&? H
)&&H I
=>&&J L
await'' 
db'' 
.'' 
Pedidos'' 
.(( 
Include(( 
((( 
p(( 
=>(( 
p(( 
.(( 
Cliente(( #
)((# $
.)) 
Where)) 
()) 
p)) 
=>)) 
p)) 
.)) 
	NegocioId)) #
==))$ &
	negocioId))' 0
)))0 1
.** 
ToListAsync** 
(** 
)** 
;** 
}++ ¥(
]C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\NegocioRepository.cs
public 
class 
NegocioRepository 
( 
AppDbContext +
db, .
). /
:0 1
INegocioRepository2 D
{ 
public 

Task 
< 
Negocio 
? 
> 
BuscarPorIdAsync *
(* +
int+ .
id/ 1
)1 2
=>3 5
db 

.
 
Negocios 
. 
FirstOrDefaultAsync '
(' (
n( )
=>* ,
n- .
.. /
Id/ 1
==2 4
id5 7
)7 8
;8 9
public 

Task 
< 
Negocio 
? 
> $
ObtenerPorUsuarioIdAsync 2
(2 3
int3 6
	usuarioId7 @
)@ A
=>B D
db		 

.		
 
Negocios		 
.		 
FirstOrDefaultAsync		 '
(		' (
n		( )
=>		* ,
n		- .
.		. /
	UsuarioId		/ 8
==		9 ;
	usuarioId		< E
)		E F
;		F G
public 

Task 
< 
bool 
>  
ExisteDocumentoAsync *
(* +
string+ 1
	documento2 ;
); <
=>= ?
db 

.
 
Usuarios 
. 
AnyAsync 
( 
u 
=> !
u" #
.# $
	Documento$ -
==. 0
	documento1 :
): ;
;; <
public 

Task 
< 
bool 
> 
ExisteTelefonoAsync )
() *
string* 0
telefono1 9
,9 :
int; >
?> ?
excluirNegocioId@ P
=Q R
nullS W
)W X
=>Y [
db 

.
 
Negocios 
. 
AnyAsync 
( 
n 
=> !
n" #
.# $
Telefono$ ,
==- /
telefono0 8
&&9 ;
( 
excluirNegocioId 
==  
null! %
||& (
n) *
.* +
Id+ -
!=. 0
excluirNegocioId1 A
)A B
)B C
;C D
public 

async 
Task 
RegistrarAsync $
($ %
Usuario% ,
usuario- 4
,4 5
Negocio6 =
negocio> E
)E F
{ 
negocio 
. 
Usuario 
= 
usuario !
;! "
db 

.
 
Negocios 
. 
Add 
( 
negocio 
)  
;  !
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
Task 
ActualizarAsync %
(% &
Negocio& -
negocio. 5
)5 6
{ 
db 

.
 
Negocios 
. 
Update 
( 
negocio "
)" #
;# $
await 
db 
. 
SaveChangesAsync !
(! "
)" #
;# $
} 
public   

Task   
<   
bool   
>   $
TienePedidosActivosAsync   .
(  . /
int  / 2
	negocioId  3 <
)  < =
=>  > @
db!! 

.!!
 
Pedidos!! 
.!! 
AnyAsync!! 
(!! 
p!! 
=>!!  
p!!! "
.!!" #
	NegocioId!!# ,
==!!- /
	negocioId!!0 9
&&!!: <
p"" 
."" 
EstadoPedidoId"" 
!="" 
(""  !
int""! $
)""$ %
EstadoPedido""% 1
.""1 2
	Entregado""2 ;
&&""< >
p""? @
.""@ A
EstadoPedidoId""A O
!=""P R
(""S T
int""T W
)""W X
EstadoPedido""X d
.""d e
	Cancelado""e n
)""n o
;""o p
public%% 

Task%% 
<%% 
bool%% 
>%% ,
 TieneRepartidoresVinculadosAsync%% 6
(%%6 7
int%%7 :
	negocioId%%; D
)%%D E
=>%%F H
db&& 

.&&
 
Repartidores&& 
.&& 
AnyAsync&&  
(&&  !
r&&! "
=>&&# %
r&&& '
.&&' (
	NegocioId&&( 1
==&&2 4
	negocioId&&5 >
&&&&? A
r'' 
.'' 
Usuario'' 
!'' 
.'' 
Estado'' 
!=''  
EstadoCuenta''! -
.''- .
	Eliminado''. 7
)''7 8
;''8 9
}(( Ç
^C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\IUsuarioRepository.cs
public 
	interface 
IUsuarioRepository #
{ 
Task 
< 	
Usuario	 
? 
> ,
 ObtenerPorIdentificadorYRolAsync 3
(3 4
string4 :
identificador; H
,H I

RolUsuarioJ T
rolU X
)X Y
;Y Z
Task 
< 	
Usuario	 
? 
> !
ObtenerPorCorreoAsync (
(( )
string) /
correo0 6
)6 7
;7 8
Task 
< 	
Usuario	 
? 
> 
ObtenerPorIdAsync $
($ %
int% (
id) +
)+ ,
;, -
Task 
ActualizarAsync	 
( 
Usuario  
usuario! (
)( )
;) *
Task		 
<		 	
List			 
<		 
string		 
>		 
>		 .
"CorreosAdministradoresActivosAsync		 9
(		9 :
)		: ;
;		; <
Task "
LiberarEliminadosAsync	 
(  
string  &
correo' -
,- .
string/ 5
	documento6 ?
)? @
;@ A
} ˚
`C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\IUbicacionRepository.cs
public 
	interface  
IUbicacionRepository %
{ 
Task 
< 	
UbicacionPedido	 
? 
> 
ObtenerAsync '
(' (
int( +
pedidoId, 4
)4 5
;5 6
Task 
GuardarAsync	 
( 
int 
pedidoId "
," #
decimal$ +
lat, /
,/ 0
decimal1 8
lng9 <
)< =
;= >
} ª
hC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\ITokenRecuperacionRepository.cs
public 
	interface (
ITokenRecuperacionRepository -
{ 
Task 
AgregarAsync	 
( 
TokenRecuperacion '
token( -
)- .
;. /
Task 
< 	
TokenRecuperacion	 
? 
> 
ObtenerPorHashAsync 0
(0 1
string1 7
hash8 <
)< =
;= >
Task 
< 	
int	 
> 
ContarDesdeAsync 
( 
int "
	usuarioId# ,
,, -
DateTime. 6
desde7 <
)< =
;= >
Task 
ActualizarAsync	 
( 
TokenRecuperacion *
token+ 0
)0 1
;1 2
Task $
InvalidarPendientesAsync	 !
(! "
int" %
	usuarioId& /
)/ 0
;0 1
} ”
aC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\IPersonalRepositories.cs
public 
	interface !
IRepartidorRepository &
{ 
Task $
RegistrarRepartidorAsync	 !
(! "
Usuario" )
usuario* 1
,1 2

Repartidor3 =

repartidor> H
)H I
;I J
Task 
< 	
List	 
< 

Repartidor 
> 
> !
ListarPorNegocioAsync 0
(0 1
int1 4
	negocioId5 >
)> ?
;? @
Task 
< 	
bool	 
> 
TelefonoEnUsoAsync !
(! "
string" (
telefono) 1
)1 2
;2 3
Task 
< 	

Repartidor	 
? 
> !
ObtenerDeNegocioAsync +
(+ ,
int, /
	negocioId0 9
,9 :
int; >
repartidorId? K
)K L
;L M
Task 
< 	

Repartidor	 
? 
> $
ObtenerPorUsuarioIdAsync .
(. /
int/ 2
	usuarioId3 <
)< =
;= >
Task 
< 	

Repartidor	 
? 
>  
BuscarEliminadoAsync *
(* +
string+ 1
correo2 8
,8 9
string: @
	documentoA J
)J K
;K L
Task 
ReactivarAsync	 
( 

Repartidor "

repartidor# -
)- .
;. /
} 
public 
	interface %
IAdministracionRepository *
{ 
Task '
RegistrarAdministradorAsync	 $
($ %
Usuario% ,
usuario- 4
,4 5
Administrador6 C
administradorD Q
)Q R
;R S
Task 
< 	
List	 
< 
AdministradorDto 
> 
>  &
ListarAdministradoresAsync! ;
(; <
)< =
;= >
Task 
< 	
List	 
< 
NegocioAdminDto 
> 
> 
ListarNegociosAsync  3
(3 4
)4 5
;5 6
Task 
< 	
bool	 
> 
AprobarNegocioAsync "
(" #
int# &
	negocioId' 0
)0 1
;1 2
Task 
< 	
bool	 
> 
TelefonoEnUsoAsync !
(! "
string" (
telefono) 1
)1 2
;2 3
Task 
< 	
Administrador	 
? 
> $
ObtenerPorUsuarioIdAsync 1
(1 2
int2 5
	usuarioId6 ?
)? @
;@ A
} Ä
]C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\IPedidoRepository.cs
public 
	interface 
IPedidoRepository "
{ 
Task 
< 	
Pedido	 
? 
> 
ObtenerPorIdAsync #
(# $
int$ '
id( *
)* +
;+ ,
Task 
< 	
Pedido	 
? 
> !
ObtenerPorCodigoAsync '
(' (
string( .
codigo/ 5
)5 6
;6 7
Task 
< 	
Pedido	 
? 
> )
ObtenerUltimoPorTelefonoAsync /
(/ 0
int0 3
	negocioId4 =
,= >
string? E
telefonoF N
)N O
;O P
Task 
< 	
bool	 
> 
ExisteCodigoAsync  
(  !
string! '
codigo( .
). /
;/ 0
Task 
AgregarAsync	 
( 
Pedido 
pedido #
)# $
;$ %
Task 
ActualizarAsync	 
( 
Pedido 
pedido  &
)& '
;' (
Task		 
<		 	
List			 
<		 
Pedido		 
>		 
>		 "
ObtenerPorNegocioAsync		 -
(		- .
int		. 1
	negocioId		2 ;
)		; <
;		< =
}

 ¸
^C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\INegocioRepository.cs
public 
	interface 
INegocioRepository #
{ 
Task 
< 	
Negocio	 
? 
> 
BuscarPorIdAsync #
(# $
int$ '
id( *
)* +
;+ ,
Task 
< 	
Negocio	 
? 
> $
ObtenerPorUsuarioIdAsync +
(+ ,
int, /
	usuarioId0 9
)9 :
;: ;
Task 
< 	
bool	 
>  
ExisteDocumentoAsync #
(# $
string$ *
	documento+ 4
)4 5
;5 6
Task 
< 	
bool	 
> 
ExisteTelefonoAsync "
(" #
string# )
telefono* 2
,2 3
int4 7
?7 8
excluirNegocioId9 I
=J K
nullL P
)P Q
;Q R
Task		 
RegistrarAsync			 
(		 
Usuario		 
usuario		  '
,		' (
Negocio		) 0
negocio		1 8
)		8 9
;		9 :
Task

 
ActualizarAsync

	 
(

 
Negocio

  
negocio

! (
)

( )
;

) *
Task 
< 	
bool	 
> $
TienePedidosActivosAsync '
(' (
int( +
	negocioId, 5
)5 6
;6 7
Task 
< 	
bool	 
> ,
 TieneRepartidoresVinculadosAsync /
(/ 0
int0 3
	negocioId4 =
)= >
;> ?
}  
iC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\ICodigoVerificacionRepository.cs
public 
	interface )
ICodigoVerificacionRepository .
{ 
Task 
AgregarAsync	 
( 
CodigoVerificacion (
codigo) /
)/ 0
;0 1
Task 
< 	
CodigoVerificacion	 
? 
> 
ObtenerUltimoAsync 0
(0 1
int1 4
	usuarioId5 >
)> ?
;? @
Task 
ActualizarAsync	 
( 
CodigoVerificacion +
codigo, 2
)2 3
;3 4
} ö
hC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\CodigoVerificacionRepository.cs
public 
class (
CodigoVerificacionRepository )
() *
AppDbContext* 6
db7 9
)9 :
:; <)
ICodigoVerificacionRepository= Z
{ 
public 

async 
Task 
AgregarAsync "
(" #
CodigoVerificacion# 5
codigo6 <
)< =
{ 
db 

.
 
CodigosVerificacion 
. 
Add "
(" #
codigo# )
)) *
;* +
await 
db 
. 
SaveChangesAsync !
(! "
)" #
;# $
}		 
public 

Task 
< 
CodigoVerificacion "
?" #
># $
ObtenerUltimoAsync% 7
(7 8
int8 ;
	usuarioId< E
)E F
=>G I
db 

.
 
CodigosVerificacion 
. 
Where 
( 
c 
=> 
c 
. 
	UsuarioId #
==$ &
	usuarioId' 0
)0 1
. 
OrderByDescending 
( 
c  
=>! #
c$ %
.% &
FechaCreacion& 3
)3 4
. 
ThenByDescending 
( 
c 
=>  "
c# $
.$ %
Id% '
)' (
. 
FirstOrDefaultAsync  
(  !
)! "
;" #
public 

async 
Task 
ActualizarAsync %
(% &
CodigoVerificacion& 8
codigo9 ?
)? @
{ 
db 

.
 
CodigosVerificacion 
. 
Update %
(% &
codigo& ,
), -
;- .
await 
db 
. 
SaveChangesAsync !
(! "
)" #
;# $
} 
} ”E
dC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Repositories\AdministracionRepository.cs
public 
class $
AdministracionRepository %
(% &
AppDbContext& 2
db3 5
)5 6
:7 8%
IAdministracionRepository9 R
{ 
public 

async 
Task '
RegistrarAdministradorAsync 1
(1 2
Usuario2 9
usuario: A
,A B
AdministradorC P
administradorQ ^
)^ _
{ 
administrador 
. 
Usuario 
= 
usuario  '
;' (
db		 

.		
 
Administradores		 
.		 
Add		 
(		 
administrador		 ,
)		, -
;		- .
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
< 
List 
< 
AdministradorDto %
>% &
>& '&
ListarAdministradoresAsync( B
(B C
)C D
=>E G
( 	
from	 
u 
in 
db 
. 
Usuarios 
where	 
u 
. 
Rol 
== 

RolUsuario "
." #
Administrador# 0
&&1 3
u4 5
.5 6
Estado6 <
!== ?
EstadoCuenta@ L
.L M
	EliminadoM V
join	 
adm 
in 
db 
. 
Administradores '
on( *
u+ ,
., -
Id- /
equals0 6
adm7 :
.: ;
	UsuarioId; D
intoE I
grupoJ O
from	 
a 
in 
grupo 
. 
DefaultIfEmpty '
(' (
)( )
orderby	 
u 
. 
Id 

descending  
select	 
new 
AdministradorDto $
{	 

	UsuarioId 
= 
u 
. 
Id 
, 
NombreCompleto 
= 
a 
!=  "
null# '
?( )
a* +
.+ ,
NombreCompleto, :
:; <
$str= V
,V W
	Documento 
= 
u 
. 
	Documento $
,$ %
Correo 
= 
u 
. 
Correo 
, 
Telefono 
= 
a 
!= 
null !
?" #
a$ %
.% &
Telefono& .
:/ 0
$str1 4
,4 5
Estado 
= 
u 
. 
Estado 
, 
FechaRegistro 
= 
a 
!= !
null" &
?' (
a) *
.* +
FechaRegistro+ 8
:9 :
(; <
DateTime< D
?D E
)E F
nullF J
}	 

)
 
. 
ToListAsync 
( 
) 
; 
public 

Task 
< 
List 
< 
NegocioAdminDto $
>$ %
>% &
ListarNegociosAsync' :
(: ;
); <
=>= ?
db 

.
 
Negocios 
.   
OrderByDescending   
(   
n    
=>  ! #
n  $ %
.  % &
FechaRegistro  & 3
)  3 4
.!! 
Select!! 
(!! 
n!! 
=>!! 
new!! 
NegocioAdminDto!! ,
{"" 
Id## 
=## 
n## 
.## 
Id## 
,## 
Nombre$$ 
=$$ 
n$$ 
.$$ 
Nombre$$ !
,$$! "
TipoActividad%% 
=%% 
n%%  !
.%%! "
TipoActividad%%" /
,%%/ 0
	Documento&& 
=&& 
n&& 
.&& 
Usuario&& %
!&&% &
.&&& '
	Documento&&' 0
,&&0 1
Correo'' 
='' 
n'' 
.'' 
Usuario'' "
.''" #
Correo''# )
,'') *
Telefono(( 
=(( 
n(( 
.(( 
Telefono(( %
,((% &
Estado)) 
=)) 
n)) 
.)) 
Usuario)) "
.))" #
Estado))# )
,))) *
FechaRegistro** 
=** 
n**  !
.**! "
FechaRegistro**" /
}++ 
)++ 
.,, 
ToListAsync,, 
(,, 
),, 
;,, 
public.. 

async.. 
Task.. 
<.. 
bool.. 
>.. 
AprobarNegocioAsync.. /
(../ 0
int..0 3
	negocioId..4 =
)..= >
{// 
var00 
negocio00 
=00 
await00 
db00 
.00 
Negocios00 '
.00' (
Include00( /
(00/ 0
n000 1
=>002 4
n005 6
.006 7
Usuario007 >
)00> ?
.11 
FirstOrDefaultAsync11  
(11  !
n11! "
=>11# %
n11& '
.11' (
Id11( *
==11+ -
	negocioId11. 7
)117 8
;118 9
var22 
usuario22 
=22 
negocio22 
?22 
.22 
Usuario22 &
;22& '
if33 

(33 
negocio33 
is33 
null33 
||33 
usuario33 &
is33' )
null33* .
||33/ 1
usuario332 9
.339 :
Estado33: @
!=33A C
EstadoCuenta33D P
.33P Q
PendienteValidacion33Q d
)33d e
return44 
false44 
;44 
usuario66 
.66 
Estado66 
=66 
EstadoCuenta66 %
.66% &
Activo66& ,
;66, -
usuario77 
.77 
MotivoRechazo77 
=77 
null77  $
;77$ %
db88 

.88
 
Entry88 
(88 
negocio88 
)88 
.88 
Property88 "
(88" #
$str88# 4
)884 5
.885 6
CurrentValue886 B
=88C D
DateTime88E M
.88M N
UtcNow88N T
;88T U
await99 
db99 
.99 
SaveChangesAsync99 !
(99! "
)99" #
;99# $
return:: 
true:: 
;:: 
};; 
public== 

async== 
Task== 
<== 
bool== 
>== 
TelefonoEnUsoAsync== .
(==. /
string==/ 5
telefono==6 >
)==> ?
=>==@ B
await>> 
db>> 
.>> 
Negocios>> 
.>> 
AnyAsync>> "
(>>" #
n>># $
=>>>% '
n>>( )
.>>) *
Telefono>>* 2
==>>3 5
telefono>>6 >
)>>> ?
||>>@ B
await?? 
db?? 
.?? 
Repartidores?? 
.?? 
AnyAsync?? &
(??& '
r??' (
=>??) +
r??, -
.??- .
Telefono??. 6
==??7 9
telefono??: B
&&??C E
r??F G
.??G H
Usuario??H O
!??O P
.??P Q
Estado??Q W
!=??X Z
EstadoCuenta??[ g
.??g h
	Eliminado??h q
)??q r
||??s u
await@@ 
db@@ 
.@@ 
Administradores@@  
.@@  !
AnyAsync@@! )
(@@) *
a@@* +
=>@@, .
a@@/ 0
.@@0 1
Telefono@@1 9
==@@: <
telefono@@= E
)@@E F
;@@F G
publicBB 

TaskBB 
<BB 
AdministradorBB 
?BB 
>BB $
ObtenerPorUsuarioIdAsyncBB  8
(BB8 9
intBB9 <
	usuarioIdBB= F
)BBF G
=>BBH J
dbCC 

.CC
 
AdministradoresCC 
.DD 
AsNoTrackingDD 
(DD 
)DD 
.EE 
FirstOrDefaultAsyncEE  
(EE  !
aEE! "
=>EE# %
aEE& '
.EE' (
	UsuarioIdEE( 1
==EE2 4
	usuarioIdEE5 >
)EE> ?
;EE? @
}FF ÷L
FC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Program.cs
var 
builder 
= 
WebApplication 
. 
CreateBuilder *
(* +
args+ /
)/ 0
;0 1
QuestPDF 
. 	
Settings	 
. 
License 
= 
QuestPDF $
.$ %
Infrastructure% 3
.3 4
LicenseType4 ?
.? @
	Community@ I
;I J
builder

 
.

 
Services

 
.

 #
AddControllersWithViews

 (
(

( )
o

) *
=>

+ -
o

. /
.

/ 0 
ModelBinderProviders

0 D
.

D E
Insert

E K
(

K L
$num

L M
,

M N
new

O R/
#InvariantDecimalModelBinderProvider

S v
(

v w
)

w x
)

x y
)

y z
;

z {
builder 
. 
Services 
. 
AddAntiforgery 
(  
o  !
=>" $
o% &
.& '

HeaderName' 1
=2 3
$str4 N
)N O
;O P
builder 
. 
Services 
. 
AddDbContext 
< 
AppDbContext *
>* +
(+ ,
o, -
=>. 0
o 
. 
UseSqlServer 
( 
builder 
. 
Configuration (
.( )
GetConnectionString) <
(< =
$str= G
)G H
)H I
)I J
;J K
builder 
. 
Services 
. 
	AddScoped 
< 
IUsuarioRepository -
,- .
UsuarioRepository/ @
>@ A
(A B
)B C
;C D
builder 
. 
Services 
. 
	AddScoped 
< (
ITokenRecuperacionRepository 7
,7 8'
TokenRecuperacionRepository9 T
>T U
(U V
)V W
;W X
builder 
. 
Services 
. 
	AddScoped 
< 
INegocioRepository -
,- .
NegocioRepository/ @
>@ A
(A B
)B C
;C D
builder 
. 
Services 
. 
	AddScoped 
< )
ICodigoVerificacionRepository 8
,8 9(
CodigoVerificacionRepository: V
>V W
(W X
)X Y
;Y Z
builder 
. 
Services 
. 
	AddScoped 
< !
IRepartidorRepository 0
,0 1 
RepartidorRepository2 F
>F G
(G H
)H I
;I J
builder 
. 
Services 
. 
	AddScoped 
< %
IAdministracionRepository 4
,4 5$
AdministracionRepository6 N
>N O
(O P
)P Q
;Q R
builder 
. 
Services 
. 
	AddScoped 
< 
IPedidoRepository ,
,, -
PedidoRepository. >
>> ?
(? @
)@ A
;A B
builder 
. 
Services 
. 
	AddScoped 
<  
IUbicacionRepository /
,/ 0
UbicacionRepository1 D
>D E
(E F
)F G
;G H
builder 
. 
Services 
. 
	AddScoped 
< 
IPasswordHasher *
<* +
Usuario+ 2
>2 3
,3 4 
BCryptPasswordHasher5 I
>I J
(J K
)K L
;L M
builder 
. 
Services 
. 
	AddScoped 
< 
IAuthService '
,' (
AuthService) 4
>4 5
(5 6
)6 7
;7 8
builder 
. 
Services 
. 
	AddScoped 
<  
IRecuperacionService /
,/ 0
RecuperacionService1 D
>D E
(E F
)F G
;G H
builder 
. 
Services 
. 
	AddScoped 
< 
INegocioService *
,* +
NegocioService, :
>: ;
(; <
)< =
;= >
builder 
. 
Services 
. 
	AddScoped 
< $
IActivacionCuentaService 3
,3 4#
ActivacionCuentaService5 L
>L M
(M N
)N O
;O P
builder   
.   
Services   
.   
	AddScoped   
<   
IRepartidorService   -
,  - .
RepartidorService  / @
>  @ A
(  A B
)  B C
;  C D
builder!! 
.!! 
Services!! 
.!! 
	AddScoped!! 
<!! $
IPerfilRepartidorService!! 3
,!!3 4#
PerfilRepartidorService!!5 L
>!!L M
(!!M N
)!!N O
;!!O P
builder"" 
."" 
Services"" 
."" 
	AddScoped"" 
<"" "
IAdministracionService"" 1
,""1 2!
AdministracionService""3 H
>""H I
(""I J
)""J K
;""K L
builder## 
.## 
Services## 
.## 
	AddScoped## 
<## 
IEmailService## (
,##( )
EmailSmtpService##* :
>##: ;
(##; <
)##< =
;##= >
builder$$ 
.$$ 
Services$$ 
.$$ 
	AddScoped$$ 
<$$ 
IPedidoService$$ )
,$$) *
PedidoService$$+ 8
>$$8 9
($$9 :
)$$: ;
;$$; <
builder%% 
.%% 
Services%% 
.%% 
	AddScoped%% 
<%% 
IUbicacionService%% ,
,%%, -
UbicacionService%%. >
>%%> ?
(%%? @
)%%@ A
;%%A B
builder&& 
.&& 
Services&& 
.&& 
	AddScoped&& 
<&& 
IReporteService&& *
,&&* +
ReporteService&&, :
>&&: ;
(&&; <
)&&< =
;&&= >
builder'' 
.'' 
Services'' 
.'' 
AddSingleton'' 
<'' 
IExportadorReportes'' 1
,''1 2
ExportadorReportes''3 E
>''E F
(''F G
)''G H
;''H I
builder)) 
.)) 
Services)) 
.)) 
AddAuthentication)) "
())" #(
CookieAuthenticationDefaults))# ?
.))? @ 
AuthenticationScheme))@ T
)))T U
.** 
	AddCookie** 
(** 
o** 
=>** 
{++ 
o,, 	
.,,	 

	LoginPath,,
 
=,, 
$str,, &
;,,& '
o-- 	
.--	 

AccessDeniedPath--
 
=-- 
$str-- -
;--- .
o00 	
.00	 

ExpireTimeSpan00
 
=00 
TimeSpan00 #
.00# $
FromMinutes00$ /
(00/ 0
$num000 2
)002 3
;003 4
o11 	
.11	 

SlidingExpiration11
 
=11 
true11 "
;11" #
o22 	
.22	 

Cookie22
 
.22 
HttpOnly22 
=22 
true22  
;22  !
o33 	
.33	 

Cookie33
 
.33 
SecurePolicy33 
=33 
CookieSecurePolicy33  2
.332 3
SameAsRequest333 @
;33@ A
}44 
)44 
;44 
var66 
app66 
=66 	
builder66
 
.66 
Build66 
(66 
)66 
;66 
if88 
(88 
!88 
app88 
.88 	
Environment88	 
.88 
IsDevelopment88 "
(88" #
)88# $
)88$ %
{99 
app:: 
.:: 
UseExceptionHandler:: 
(:: 
$str:: )
)::) *
;::* +
app;; 
.;; 
UseHsts;; 
(;; 
);; 
;;; 
}<< 
app?? 
.?? +
UseStatusCodePagesWithReExecute?? #
(??# $
$str??$ 6
,??6 7
$str??8 C
)??C D
;??D E
appAA 
.AA 
UseHttpsRedirectionAA 
(AA 
)AA 
;AA 
appBB 
.BB 
UseStaticFilesBB 
(BB 
)BB 
;BB 
appCC 
.CC 

UseRoutingCC 
(CC 
)CC 
;CC 
appDD 
.DD 
UseAuthenticationDD 
(DD 
)DD 
;DD 
appEE 
.EE 
UseAuthorizationEE 
(EE 
)EE 
;EE 
appHH 
.HH 
MapControllerRouteHH 
(HH 
nameII 
:II 	
$strII
 
,II 
patternJJ 
:JJ 
$strJJ 5
)JJ5 6
;JJ6 7
appLL 
.LL 
RunLL 
(LL 
)LL 	
;LL	 
È
MC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\Usuario.cs
public 
enum 

RolUsuario 
{ 
Negocio  
,  !

Repartidor" ,
,, -
Administrador. ;
}< =
public 
enum 
EstadoCuenta 
{ 
PendienteValidacion .
,. /
Activo0 6
,6 7

Suspendido8 B
,B C
	RechazadoD M
,M N
	EliminadoO X
,X Y
PendienteActivacionZ m
}n o
public 
class 
Usuario 
{		 
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

string 
	Documento 
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

string 
PasswordHash 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
$str/ 1
;1 2
public 


RolUsuario 
Rol 
{ 
get 
;  
set! $
;$ %
}& '
public 

EstadoCuenta 
Estado 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
EstadoCuenta/ ;
.; <
PendienteValidacion< O
;O P
public 

string 
? 
MotivoRechazo  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

int 
IntentosFallidos 
{  !
get" %
;% &
set' *
;* +
}, -
public 

DateTime 
? 
BloqueadoHasta #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 

void "
LiberarIdentificadores &
(& '
)' (
{ 
Correo 
= 
Recortar 
( 
$" 
$str &
{& '
Id' )
}) *
$str* +
{+ ,
Correo, 2
}2 3
"3 4
,4 5
$num6 9
)9 :
;: ;
	Documento 
= 
Recortar 
( 
$" 
$str  
{  !
Id! #
}# $
$str$ %
{% &
	Documento& /
}/ 0
"0 1
,1 2
$num3 5
)5 6
;6 7
} 
private 
static 
string 
Recortar "
(" #
string# )
valor* /
,/ 0
int1 4
max5 8
)8 9
=>: <
valor= B
.B C
LengthC I
<=J L
maxM P
?Q R
valorS X
:Y Z
valor[ `
[` a
..a c
maxc f
]f g
;g h
} ≠
UC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\UbicacionPedido.cs
public 
class 
UbicacionPedido 
{ 
public 

int 
PedidoId 
{ 
get 
; 
set "
;" #
}$ %
public 

Pedido 
? 
Pedido 
{ 
get 
;  
set! $
;$ %
}& '
public 

decimal 
Latitud 
{ 
get  
;  !
set" %
;% &
}' (
public 

decimal 
Longitud 
{ 
get !
;! "
set# &
;& '
}( )
public 

DateTime 
FechaActualizacion &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
=5 6
DateTime7 ?
.? @
UtcNow@ F
;F G
} ﬁ	
WC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\TokenRecuperacion.cs
public 
class 
TokenRecuperacion 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
	UsuarioId 
{ 
get 
; 
set  #
;# $
}% &
public 

string 
	TokenHash 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
public 

DateTime 
FechaCreacion !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
DateTime2 :
.: ;
UtcNow; A
;A B
public 

DateTime 
Expira 
{ 
get  
;  !
set" %
;% &
}' (
public 

bool 
Usado 
{ 
get 
; 
set  
;  !
}" #
}		 †
ZC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\SuspensionRepartidor.cs
[ 
Table 
( 
$str 
) 
] 
public 
class  
SuspensionRepartidor !
{ 
[ 
Key 
] 	
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
public

 

int

 
RepartidorId

 
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
public 

int 
AdministradorId 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

string 
Motivo 
{ 
get 
; 
set  #
;# $
}% &
=' (
string) /
./ 0
Empty0 5
;5 6
public 

DateTime 
FechaSuspension #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 

int 
? (
ReactivadoPorAdministradorId ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
public 

DateTime 
? 
FechaReactivacion &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
} ◊
ZC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\SolicitudCancelacion.cs
public 
class  
SolicitudCancelacion !
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
int 
PedidoId 
{ 
get 
; 
set "
;" #
}$ %
public 

Pedido 
? 
Pedido 
{ 
get 
;  
set! $
;$ %
}& '
public 

string 
Motivo 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
public		 

DateTime		 
FechaSolicitud		 "
{		# $
get		% (
;		( )
set		* -
;		- .
}		/ 0
=		1 2
DateTime		3 ;
.		; <
UtcNow		< B
;		B C
}

 ú
NC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\Personal.cs
public 
enum 
TipoVehiculo 
{ 
	Bicicleta $
,$ %
Moto& *
,* +
Carro, 1
,1 2
APie3 7
}8 9
public 
class 

Repartidor 
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

Usuario 
? 
Usuario 
{ 
get !
;! "
set# &
;& '
}( )
public		 

int		 
	NegocioId		 
{		 
get		 
;		 
set		  #
;		# $
}		% &
public

 

string

 
NombreCompleto

  
{

! "
get

# &
;

& '
set

( +
;

+ ,
}

- .
=

/ 0
$str

1 3
;

3 4
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
} 
public 
class 
Administrador 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
	UsuarioId 
{ 
get 
; 
set  #
;# $
}% &
public 

Usuario 
? 
Usuario 
{ 
get !
;! "
set# &
;& '
}( )
public 

string 
NombreCompleto  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
$str1 3
;3 4
public 

string 
Telefono 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
public 

DateTime 
FechaRegistro !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
DateTime2 :
.: ;
UtcNow; A
;A B
} ∫
LC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\Pedido.cs
public 
class 
Pedido 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
Codigo 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
public 

int 
	NegocioId 
{ 
get 
; 
set  #
;# $
}% &
public 

Negocio 
? 
Negocio 
{ 
get !
;! "
set# &
;& '
}( )
public 

int 
	ClienteId 
{ 
get 
; 
set  #
;# $
}% &
public		 

Cliente		 
?		 
Cliente		 
{		 
get		 !
;		! "
set		# &
;		& '
}		( )
public 

int 
? 
RepartidorId 
{ 
get "
;" #
set$ '
;' (
}) *
public 


Repartidor 
? 

Repartidor !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 

string 
DireccionEntrega "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
$str3 5
;5 6
public 

int 
MetodoPagoId 
{ 
get !
;! "
set# &
;& '
}( )
public 

int 
EstadoPedidoId 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
$num. /
;/ 0
public 

DateTime 
FechaCreacion !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
DateTime2 :
.: ;
UtcNow; A
;A B
public 

List 
< 

ItemPedido 
> 
Items !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
[2 3
]3 4
;4 5
} 
public 
class 

ItemPedido 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
PedidoId 
{ 
get 
; 
set "
;" #
}$ %
public 

Pedido 
? 
Pedido 
{ 
get 
;  
set! $
;$ %
}& '
public 

string 
Descripcion 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
$str. 0
;0 1
public 

int 
Cantidad 
{ 
get 
; 
set "
;" #
}$ %
public 

decimal 
PrecioUnitario !
{" #
get$ '
;' (
set) ,
;, -
}. /
}   
public"" 
enum"" 
EstadoPedido"" 
{## 
Recibido$$ 
,$$ 
EnPreparacion%% 
,%% 
ListoParaEntrega&& 
,&& 
Asignado'' 
,'' 
EnCamino(( 
,(( 
	Entregado)) 
,)) 
	Cancelado** 
}++ π
SC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\NovedadPedido.cs
public 
class 
NovedadPedido 
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
int 
PedidoId 
{ 
get 
; 
set "
;" #
}$ %
public 

Pedido 
? 
Pedido 
{ 
get 
;  
set! $
;$ %
}& '
public 

int 
TipoNovedadId 
{ 
get "
;" #
set$ '
;' (
}) *
public		 

string		 
?		 
Observaciones		  
{		! "
get		# &
;		& '
set		( +
;		+ ,
}		- .
public

 

DateTime

 
Fecha

 
{

 
get

 
;

  
set

! $
;

$ %
}

& '
=

( )
DateTime

* 2
.

2 3
UtcNow

3 9
;

9 :
} 
public 
enum 
TipoNovedad 
{ 
ClienteAusente 
, 
DireccionIncorrecta 
,  
ProductoNoDisponible 
, 
Otro 
} ©
MC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\Negocio.cs
public 
class 
Negocio 
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

Usuario 
? 
Usuario 
{ 
get !
;! "
set# &
;& '
}( )
public 

string 
Nombre 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
public		 

string		 
TipoActividad		 
{		  !
get		" %
;		% &
set		' *
;		* +
}		, -
=		. /
$str		0 2
;		2 3
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
string 
	Direccion 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
public 

DateTime 
FechaRegistro !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
DateTime2 :
.: ;
UtcNow; A
;A B
} ø
TC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\ErrorViewModel.cs
public 
class 
ErrorViewModel 
{ 
public 

string 
? 
	RequestId 
{ 
get "
;" #
set$ '
;' (
}) *
public 

bool 
ShowRequestId 
=>  
!! "
string" (
.( )
IsNullOrEmpty) 6
(6 7
	RequestId7 @
)@ A
;A B
} …
XC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\CodigoVerificacion.cs
public 
class 
CodigoVerificacion 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

int 
	UsuarioId 
{ 
get 
; 
set  #
;# $
}% &
public 

string 

CodigoHash 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
$str- /
;/ 0
public 

DateTime 
FechaCreacion !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
DateTime2 :
.: ;
UtcNow; A
;A B
public 

DateTime 
Expira 
{ 
get  
;  !
set" %
;% &
}' (
public		 

int		 
Intentos		 
{		 
get		 
;		 
set		 "
;		" #
}		$ %
public

 

DateTime

 
?

 
BloqueadoHasta

 #
{

$ %
get

& )
;

) *
set

+ .
;

. /
}

0 1
public 

bool 

Verificado 
{ 
get  
;  !
set" %
;% &
}' (
public 

bool 
Usado 
{ 
get 
; 
set  
;  !
}" #
} Õ
MC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Models\Cliente.cs
public 
class 
Cliente 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
NombreCompleto  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
$str1 3
;3 4
public 

string 
Telefono 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
public 

string 
? #
DireccionPredeterminada *
{+ ,
get- 0
;0 1
set2 5
;5 6
}7 8
public 

DateTime 
FechaRegistro !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
DateTime2 :
.: ;
UtcNow; A
;A B
public 

int 
	NegocioId 
{ 
get 
; 
set  #
;# $
}% &
public		 

Negocio		 
?		 
Negocio		 
{		 
get		 !
;		! "
set		# &
;		& '
}		( )
}

 …
VC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\VerificarCodigoDto.cs
public 
class 
VerificarCodigoDto 
{ 
[ 
Display 
( 
Name 
= 
$str ,
), -
]- .
[ 
Required 
( 
ErrorMessage 
= 
$str >
)> ?
]? @
[ 
RegularExpression 
( 
$str !
,! "
ErrorMessage# /
=0 1
$str2 M
)M N
]N O
public 

string 
Codigo 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
}		 û
RC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\RestablecerDto.cs
public 
class 
RestablecerDto 
{ 
public 

string 
Token 
{ 
get 
; 
set "
;" #
}$ %
=& '
$str( *
;* +
public 

string 
NuevaPassword 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$str0 2
;2 3
public 

string 
ConfirmarPassword #
{$ %
get& )
;) *
set+ .
;. /
}0 1
=2 3
$str4 6
;6 7
} ∞a
YC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\RergistroPersonalDtos.cs
public 
record 
ResultadoRegistro 
(  
bool  $
Ok% '
,' (
string) /
?/ 0
Error1 6
,6 7
bool8 <
CorreoEnviado= J
,J K
stringL R
?R S
PasswordTemporalT d
,d e
stringf l
?l m
Campon s
=t u
nullv z
)z {
;{ |
public 
class !
RegistroRepartidorDto "
:# $
IValidatableObject% 7
{ 
[		 
Display		 
(		 
Name		 
=		 
$str		 %
)		% &
]		& '
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
 
RegistroNegocioDto

 /
.

/ 0
Obligatorio

0 ;
)

; <
]

< =
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
]_ `
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
NombrePersona( 5
,5 6
ErrorMessage7 C
=D E
ReglasValidacionF V
.V W 
NombrePersonaMensajeW k
)k l
]l m
public 

string 
NombreCompleto  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
$str1 3
;3 4
[ 
Display 
( 
Name 
= 
$str )
)) *
]* +
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
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
	Documento( 1
,1 2
ErrorMessage3 ?
=@ A
ReglasValidacionB R
.R S
DocumentoMensajeS c
)c d
]d e
public 

string 
	Documento 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
[ 
Display 
( 
Name 
= 
$str 
) 
]  
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
Telefono( 0
,0 1
ErrorMessage2 >
=? @
ReglasValidacionA Q
.Q R
TelefonoMensajeR a
)a b
]b c
public 

string 
Telefono 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
[ 
Display 
( 
Name 
= 
$str (
)( )
]) *
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
Correo( .
,. /
ErrorMessage0 <
== >
ReglasValidacion? O
.O P
CorreoMensajeP ]
)] ^
]^ _
[ 
StringLength 
( 
$num 
, 
ErrorMessage #
=$ %
$str& =
)= >
]> ?
public 

string 
Correo 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
[ 
Display 
( 
Name 
= 
$str &
)& '
]' (
[   
Required   
(   
ErrorMessage   
=   
RegistroNegocioDto   /
.  / 0
Obligatorio  0 ;
)  ; <
]  < =
public!! 

TipoVehiculo!! 
?!! 
Vehiculo!! !
{!!" #
get!!$ '
;!!' (
set!!) ,
;!!, -
}!!. /
[## 
Display## 
(## 
Name## 
=## 
$str## 
)## 
]## 
public$$ 

string$$ 
?$$ 
Placa$$ 
{$$ 
get$$ 
;$$ 
set$$  #
;$$# $
}$$% &
public'' 

IEnumerable'' 
<'' 
ValidationResult'' '
>''' (
Validate'') 1
(''1 2
ValidationContext''2 C
context''D K
)''K L
{(( 
return)) 
ReglasValidacion)) 
.))  
ValidarVehiculo))  /
())/ 0
Vehiculo))0 8
,))8 9
Placa)): ?
)))? @
;))@ A
}** 
}++ 
public.. 
class.. $
RegistroAdministradorDto.. %
{// 
[00 
Display00 
(00 
Name00 
=00 
$str00 %
)00% &
]00& '
[11 
Required11 
(11 
ErrorMessage11 
=11 
RegistroNegocioDto11 /
.11/ 0
Obligatorio110 ;
)11; <
]11< =
[22 
StringLength22 
(22 
$num22 
,22 
MinimumLength22 $
=22% &
$num22' (
,22( )
ErrorMessage22* 6
=227 8
$str229 ^
)22^ _
]22_ `
[33 
RegularExpression33 
(33 
ReglasValidacion33 '
.33' (
NombrePersona33( 5
,335 6
ErrorMessage337 C
=33D E
ReglasValidacion33F V
.33V W 
NombrePersonaMensaje33W k
)33k l
]33l m
public44 

string44 
NombreCompleto44  
{44! "
get44# &
;44& '
set44( +
;44+ ,
}44- .
=44/ 0
$str441 3
;443 4
[66 
Display66 
(66 
Name66 
=66 
$str66 )
)66) *
]66* +
[77 
Required77 
(77 
ErrorMessage77 
=77 
RegistroNegocioDto77 /
.77/ 0
Obligatorio770 ;
)77; <
]77< =
[88 
RegularExpression88 
(88 
ReglasValidacion88 '
.88' (
	Documento88( 1
,881 2
ErrorMessage883 ?
=88@ A
ReglasValidacion88B R
.88R S
DocumentoMensaje88S c
)88c d
]88d e
public99 

string99 
	Documento99 
{99 
get99 !
;99! "
set99# &
;99& '
}99( )
=99* +
$str99, .
;99. /
[;; 
Display;; 
(;; 
Name;; 
=;; 
$str;; (
);;( )
];;) *
[<< 
Required<< 
(<< 
ErrorMessage<< 
=<< 
RegistroNegocioDto<< /
.<</ 0
Obligatorio<<0 ;
)<<; <
]<<< =
[== 
RegularExpression== 
(== 
ReglasValidacion== '
.==' (
Correo==( .
,==. /
ErrorMessage==0 <
==== >
ReglasValidacion==? O
.==O P
CorreoMensaje==P ]
)==] ^
]==^ _
[>> 
StringLength>> 
(>> 
$num>> 
,>> 
ErrorMessage>> #
=>>$ %
$str>>& =
)>>= >
]>>> ?
public?? 

string?? 
Correo?? 
{?? 
get?? 
;?? 
set??  #
;??# $
}??% &
=??' (
$str??) +
;??+ ,
[AA 
DisplayAA 
(AA 
NameAA 
=AA 
$strAA 
)AA 
]AA  
[BB 
RequiredBB 
(BB 
ErrorMessageBB 
=BB 
RegistroNegocioDtoBB /
.BB/ 0
ObligatorioBB0 ;
)BB; <
]BB< =
[CC 
RegularExpressionCC 
(CC 
ReglasValidacionCC '
.CC' (
TelefonoCC( 0
,CC0 1
ErrorMessageCC2 >
=CC? @
ReglasValidacionCCA Q
.CCQ R
TelefonoMensajeCCR a
)CCa b
]CCb c
publicDD 

stringDD 
TelefonoDD 
{DD 
getDD  
;DD  !
setDD" %
;DD% &
}DD' (
=DD) *
$strDD+ -
;DD- .
}EE 
publicHH 
classHH 
NegocioAdminDtoHH 
{II 
publicJJ 

intJJ 
IdJJ 
{JJ 
getJJ 
;JJ 
setJJ 
;JJ 
}JJ 
publicKK 

stringKK 
NombreKK 
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

stringLL 
TipoActividadLL 
{LL  !
getLL" %
;LL% &
setLL' *
;LL* +
}LL, -
=LL. /
$strLL0 2
;LL2 3
publicMM 

stringMM 
	DocumentoMM 
{MM 
getMM !
;MM! "
setMM# &
;MM& '
}MM( )
=MM* +
$strMM, .
;MM. /
publicNN 

stringNN 
CorreoNN 
{NN 
getNN 
;NN 
setNN  #
;NN# $
}NN% &
=NN' (
$strNN) +
;NN+ ,
publicOO 

stringOO 
TelefonoOO 
{OO 
getOO  
;OO  !
setOO" %
;OO% &
}OO' (
=OO) *
$strOO+ -
;OO- .
publicPP 

EstadoCuentaPP 
EstadoPP 
{PP  
getPP! $
;PP$ %
setPP& )
;PP) *
}PP+ ,
publicQQ 

DateTimeQQ 
FechaRegistroQQ !
{QQ" #
getQQ$ '
;QQ' (
setQQ) ,
;QQ, -
}QQ. /
}RR 
publicTT 
classTT 
AdministradorDtoTT 
{UU 
publicVV 

intVV 
	UsuarioIdVV 
{VV 
getVV 
;VV 
setVV  #
;VV# $
}VV% &
publicWW 

stringWW 
NombreCompletoWW  
{WW! "
getWW# &
;WW& '
setWW( +
;WW+ ,
}WW- .
=WW/ 0
$strWW1 3
;WW3 4
publicXX 

stringXX 
	DocumentoXX 
{XX 
getXX !
;XX! "
setXX# &
;XX& '
}XX( )
=XX* +
$strXX, .
;XX. /
publicYY 

stringYY 
CorreoYY 
{YY 
getYY 
;YY 
setYY  #
;YY# $
}YY% &
=YY' (
$strYY) +
;YY+ ,
publicZZ 

stringZZ 
TelefonoZZ 
{ZZ 
getZZ  
;ZZ  !
setZZ" %
;ZZ% &
}ZZ' (
=ZZ) *
$strZZ+ -
;ZZ- .
public[[ 

EstadoCuenta[[ 
Estado[[ 
{[[  
get[[! $
;[[$ %
set[[& )
;[[) *
}[[+ ,
public\\ 

DateTime\\ 
?\\ 
FechaRegistro\\ "
{\\# $
get\\% (
;\\( )
set\\* -
;\\- .
}\\/ 0
}]] Âs
OC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\ReporteDtos.cs
public 
class 
FilaEstadoReporte 
{ 
public 

int 
EstadoId 
{ 
get 
; 
set "
;" #
}$ %
public 

string 
Estado 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
public 

string 
Color 
{ 
get 
; 
set "
;" #
}$ %
=& '
$str( 1
;1 2
public 

int 
Cantidad 
{ 
get 
; 
set "
;" #
}$ %
public 

decimal 

Porcentaje 
{ 
get  #
;# $
set% (
;( )
}* +
}		 
public 
class 
FilaMesReporte 
{ 
public 

string 
Mes 
{ 
get 
; 
set  
;  !
}" #
=$ %
$str& (
;( )
public 

int 
Total 
{ 
get 
; 
set 
;  
}! "
public 

int 

Entregados 
{ 
get 
;  
set! $
;$ %
}& '
public 

int 

Cancelados 
{ 
get 
;  
set! $
;$ %
}& '
public 

decimal 
ValorEntregado !
{" #
get$ '
;' (
set) ,
;, -
}. /
} 
public 
class 
FilaPedidoReporte 
{ 
public 

string 
Codigo 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
public 

string 
Cliente 
{ 
get 
;  
set! $
;$ %
}& '
=( )
$str* ,
;, -
public 

DateTime 
Fecha 
{ 
get 
;  
set! $
;$ %
}& '
public 

string 
Estado 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
public 

string 

Repartidor 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
$str- /
;/ 0
public 

decimal 

ValorTotal 
{ 
get  #
;# $
set% (
;( )
}* +
} 
public 
class 
ReporteNegocioDto 
{   
public!! 

string!! 
NombreNegocio!! 
{!!  !
get!!" %
;!!% &
set!!' *
;!!* +
}!!, -
=!!. /
$str!!0 2
;!!2 3
public"" 

DateTime"" 
Desde"" 
{"" 
get"" 
;""  
set""! $
;""$ %
}""& '
public## 

DateTime## 
Hasta## 
{## 
get## 
;##  
set##! $
;##$ %
}##& '
public$$ 

DateTime$$ 

GeneradoEn$$ 
{$$  
get$$! $
;$$$ %
set$$& )
;$$) *
}$$+ ,
public&& 

int&& 
TotalPedidos&& 
{&& 
get&& !
;&&! "
set&&# &
;&&& '
}&&( )
public'' 

int'' 

Entregados'' 
{'' 
get'' 
;''  
set''! $
;''$ %
}''& '
public(( 

int(( 

Cancelados(( 
{(( 
get(( 
;((  
set((! $
;(($ %
}((& '
public)) 

decimal)) 
TasaEntrega)) 
{))  
get))! $
;))$ %
set))& )
;))) *
}))+ ,
public** 

decimal** 
ValorEntregado** !
{**" #
get**$ '
;**' (
set**) ,
;**, -
}**. /
public,, 

List,, 
<,, 
FilaEstadoReporte,, !
>,,! "
	PorEstado,,# ,
{,,- .
get,,/ 2
;,,2 3
set,,4 7
;,,7 8
},,9 :
=,,; <
[,,= >
],,> ?
;,,? @
public-- 

List-- 
<-- 
FilaMesReporte-- 
>-- 
PorMes--  &
{--' (
get--) ,
;--, -
set--. 1
;--1 2
}--3 4
=--5 6
[--7 8
]--8 9
;--9 :
public.. 

List.. 
<.. 
FilaPedidoReporte.. !
>..! "
Pedidos..# *
{..+ ,
get..- 0
;..0 1
set..2 5
;..5 6
}..7 8
=..9 :
[..; <
]..< =
;..= >
}// 
public22 
class22 
HistorialExportDto22 
{33 
public44 

string44 
NombreNegocio44 
{44  !
get44" %
;44% &
set44' *
;44* +
}44, -
=44. /
$str440 2
;442 3
public55 

DateTime55 
Desde55 
{55 
get55 
;55  
set55! $
;55$ %
}55& '
public66 

DateTime66 
Hasta66 
{66 
get66 
;66  
set66! $
;66$ %
}66& '
public77 

DateTime77 

GeneradoEn77 
{77  
get77! $
;77$ %
set77& )
;77) *
}77+ ,
public88 

List88 
<88 
FilaPedidoReporte88 !
>88! "
Filas88# (
{88) *
get88+ .
;88. /
set880 3
;883 4
}885 6
=887 8
[889 :
]88: ;
;88; <
}99 
public<< 
class<< 
FilaConteoReporte<< 
{== 
public>> 

string>> 
Etiqueta>> 
{>> 
get>>  
;>>  !
set>>" %
;>>% &
}>>' (
=>>) *
$str>>+ -
;>>- .
public?? 

string?? 
Color?? 
{?? 
get?? 
;?? 
set?? "
;??" #
}??$ %
=??& '
$str??( 1
;??1 2
public@@ 

int@@ 
Cantidad@@ 
{@@ 
get@@ 
;@@ 
set@@ "
;@@" #
}@@$ %
publicAA 

decimalAA 

PorcentajeAA 
{AA 
getAA  #
;AA# $
setAA% (
;AA( )
}AA* +
}BB 
publicDD 
classDD 
FilaNegocioReporteDD 
{EE 
publicFF 

stringFF 
NombreFF 
{FF 
getFF 
;FF 
setFF  #
;FF# $
}FF% &
=FF' (
$strFF) +
;FF+ ,
publicGG 

stringGG 
	ActividadGG 
{GG 
getGG !
;GG! "
setGG# &
;GG& '
}GG( )
=GG* +
$strGG, .
;GG. /
publicHH 

stringHH 
	DocumentoHH 
{HH 
getHH !
;HH! "
setHH# &
;HH& '
}HH( )
=HH* +
$strHH, .
;HH. /
publicII 

stringII 
CorreoII 
{II 
getII 
;II 
setII  #
;II# $
}II% &
=II' (
$strII) +
;II+ ,
publicJJ 

DateTimeJJ 
FechaRegistroJJ !
{JJ" #
getJJ$ '
;JJ' (
setJJ) ,
;JJ, -
}JJ. /
publicKK 

stringKK 
EstadoKK 
{KK 
getKK 
;KK 
setKK  #
;KK# $
}KK% &
=KK' (
$strKK) +
;KK+ ,
}LL 
publicNN 
classNN !
FilaTopNegocioReporteNN "
{OO 
publicPP 

stringPP 
NombrePP 
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

intQQ 
PedidosQQ 
{QQ 
getQQ 
;QQ 
setQQ !
;QQ! "
}QQ# $
publicRR 

intRR 

EntregadosRR 
{RR 
getRR 
;RR  
setRR! $
;RR$ %
}RR& '
publicSS 

decimalSS 
ValorEntregadoSS !
{SS" #
getSS$ '
;SS' (
setSS) ,
;SS, -
}SS. /
}TT 
publicVV 
classVV 
ReporteAdminDtoVV 
{WW 
publicXX 

DateTimeXX 
DesdeXX 
{XX 
getXX 
;XX  
setXX! $
;XX$ %
}XX& '
publicYY 

DateTimeYY 
HastaYY 
{YY 
getYY 
;YY  
setYY! $
;YY$ %
}YY& '
publicZZ 

DateTimeZZ 

GeneradoEnZZ 
{ZZ  
getZZ! $
;ZZ$ %
setZZ& )
;ZZ) *
}ZZ+ ,
public]] 

int]] 
NegociosRegistrados]] "
{]]# $
get]]% (
;]]( )
set]]* -
;]]- .
}]]/ 0
public^^ 

int^^  
NegociosActivosTotal^^ #
{^^$ %
get^^& )
;^^) *
set^^+ .
;^^. /
}^^0 1
public__ 

int__ #
RepartidoresRegistrados__ &
{__' (
get__) ,
;__, -
set__. 1
;__1 2
}__3 4
public`` 

int`` 
TotalPedidos`` 
{`` 
get`` !
;``! "
set``# &
;``& '
}``( )
publicaa 

intaa 
PedidosEntregadosaa  
{aa! "
getaa# &
;aa& '
setaa( +
;aa+ ,
}aa- .
publicbb 

decimalbb 
ValorEntregadobb !
{bb" #
getbb$ '
;bb' (
setbb) ,
;bb, -
}bb. /
publicdd 

Listdd 
<dd 
FilaMesReportedd 
>dd 
NegociosPorMesdd  .
{dd/ 0
getdd1 4
;dd4 5
setdd6 9
;dd9 :
}dd; <
=dd= >
[dd? @
]dd@ A
;ddA B
publicee 

Listee 
<ee 
FilaConteoReporteee !
>ee! "
NegociosPorEstadoee# 4
{ee5 6
getee7 :
;ee: ;
setee< ?
;ee? @
}eeA B
=eeC D
[eeE F
]eeF G
;eeG H
publicff 

Listff 
<ff 
FilaConteoReporteff !
>ff! " 
NegociosPorActividadff# 7
{ff8 9
getff: =
;ff= >
setff? B
;ffB C
}ffD E
=ffF G
[ffH I
]ffI J
;ffJ K
publicgg 

Listgg 
<gg 
FilaEstadoReportegg !
>gg! "
PedidosPorEstadogg# 3
{gg4 5
getgg6 9
;gg9 :
setgg; >
;gg> ?
}gg@ A
=ggB C
[ggD E
]ggE F
;ggF G
publichh 

Listhh 
<hh !
FilaTopNegocioReportehh %
>hh% &
TopNegocioshh' 2
{hh3 4
gethh5 8
;hh8 9
sethh: =
;hh= >
}hh? @
=hhA B
[hhC D
]hhD E
;hhE F
publicii 

Listii 
<ii 
FilaNegocioReporteii "
>ii" #
Negociosii$ ,
{ii- .
getii/ 2
;ii2 3
setii4 7
;ii7 8
}ii9 :
=ii; <
[ii= >
]ii> ?
;ii? @
}jj 
publicmm 
classmm 
ReporteNegocioVistamm  
{nn 
publicoo 

DateTimeoo 
Desdeoo 
{oo 
getoo 
;oo  
setoo! $
;oo$ %
}oo& '
publicpp 

DateTimepp 
Hastapp 
{pp 
getpp 
;pp  
setpp! $
;pp$ %
}pp& '
publicqq 

ReporteNegocioDtoqq 
?qq 
Reporteqq %
{qq& '
getqq( +
;qq+ ,
setqq- 0
;qq0 1
}qq2 3
publicrr 

stringrr 
?rr 
Errorrr 
{rr 
getrr 
;rr 
setrr  #
;rr# $
}rr% &
publicss 

stringss 
?ss 
Avisoss 
{ss 
getss 
;ss 
setss  #
;ss# $
}ss% &
}tt 
publicvv 
classvv 
ReporteAdminVistavv 
{ww 
publicxx 

DateTimexx 
Desdexx 
{xx 
getxx 
;xx  
setxx! $
;xx$ %
}xx& '
publicyy 

DateTimeyy 
Hastayy 
{yy 
getyy 
;yy  
setyy! $
;yy$ %
}yy& '
publiczz 

ReporteAdminDtozz 
?zz 
Reportezz #
{zz$ %
getzz& )
;zz) *
setzz+ .
;zz. /
}zz0 1
public{{ 

string{{ 
?{{ 
Error{{ 
{{{ 
get{{ 
;{{ 
set{{  #
;{{# $
}{{% &
public|| 

string|| 
?|| 
Aviso|| 
{|| 
get|| 
;|| 
set||  #
;||# $
}||% &
}}} 
publicÄÄ 
record
ÄÄ 
BarraGrafica
ÄÄ 
(
ÄÄ 
string
ÄÄ !
Etiqueta
ÄÄ" *
,
ÄÄ* +
int
ÄÄ, /
Cantidad
ÄÄ0 8
,
ÄÄ8 9
string
ÄÄ: @
Color
ÄÄA F
)
ÄÄF G
;
ÄÄG Hë&
TC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\ReglasValidacion.cs
public 
static 
class 
ReglasValidacion $
{ 
public		 

const		 
string		 
Telefono		  
=		! "
$str		# .
;		. /
public

 

const

 
string

 
TelefonoMensaje

 '
=

( )
$str

* s
;

s t
public 

const 
string 
	Documento !
=" #
$str$ 1
;1 2
public 

const 
string 
DocumentoMensaje (
=) *
$str+ p
;p q
public 

const 
string 
Correo 
=  
$str! h
;h i
public 

const 
string 
CorreoMensaje %
=& '
$str( b
;b c
public 

const 
string 
NombrePersona %
=& '
$str( _
;_ `
public 

const 
string  
NombrePersonaMensaje ,
=- .
$str/ l
;l m
public 

const 
string 

PlacaCarro "
=# $
$str% 7
;7 8
public 

const 
string 
	PlacaMoto !
=" #
$str$ ;
;; <
public 

const 
string 
PlacaMensajeCarro )
=* +
$str, i
;i j
public 

const 
string 
PlacaMensajeMoto (
=) *
$str+ p
;p q
public!! 

static!! 
string!! 
NormalizarPlaca!! (
(!!( )
string!!) /
?!!/ 0
placa!!1 6
)!!6 7
=>!!8 :
("" 	
placa""	 
??"" 
$str"" 
)"" 
."" 
Trim"" 
("" 
)"" 
."" 
Replace"" $
(""$ %
$str""% (
,""( )
$str""* ,
)"", -
.""- .
Replace"". 5
(""5 6
$str""6 9
,""9 :
$str""; =
)""= >
.""> ?
ToUpperInvariant""? O
(""O P
)""P Q
;""Q R
public%% 

static%% 
IEnumerable%% 
<%% 
ValidationResult%% .
>%%. /
ValidarVehiculo%%0 ?
(%%? @
TipoVehiculo%%@ L
?%%L M
vehiculo%%N V
,%%V W
string%%X ^
?%%^ _
placa%%` e
)%%e f
{&& 
if'' 

('' 
vehiculo'' 
=='' 
TipoVehiculo'' $
.''$ %
APie''% )
)'') *
{(( 	
yield)) 
return)) 
new)) 
ValidationResult)) -
())- .
$str)). R
,))R S
[))T U
$str))U _
]))_ `
)))` a
;))a b
yield** 
break** 
;** 
}++ 	
if-- 

(-- 
vehiculo-- 
is-- 
not-- 
(-- 
TipoVehiculo-- )
.--) *
Moto--* .
or--/ 1
TipoVehiculo--2 >
.--> ?
Carro--? D
)--D E
)--E F
yield--G L
break--M R
;--R S
if// 

(// 
string// 
.// 
IsNullOrWhiteSpace// %
(//% &
placa//& +
)//+ ,
)//, -
{00 	
yield11 
return11 
new11 
ValidationResult11 -
(11- .
RegistroNegocioDto11. @
.11@ A
Obligatorio11A L
,11L M
[11N O
$str11O V
]11V W
)11W X
;11X Y
yield22 
break22 
;22 
}33 	
var55 
esMoto55 
=55 
vehiculo55 
==55  
TipoVehiculo55! -
.55- .
Moto55. 2
;552 3
if66 

(66 
!66 
Regex66 
.66 
IsMatch66 
(66 
NormalizarPlaca66 *
(66* +
placa66+ 0
)660 1
,661 2
esMoto663 9
?66: ;
	PlacaMoto66< E
:66F G

PlacaCarro66H R
)66R S
)66S T
yield77 
return77 
new77 
ValidationResult77 -
(77- .
esMoto77. 4
?775 6
PlacaMensajeMoto777 G
:77H I
PlacaMensajeCarro77J [
,77[ \
[77] ^
$str77^ e
]77e f
)77f g
;77g h
}88 
}99 ã/
VC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\RegistroNegocioDto.cs
public 
class 
RegistroNegocioDto 
{ 
public 

const 
string 
Obligatorio #
=$ %
$str& 9
;9 :
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
= 
Obligatorio (
)( )
]) *
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
]		_ `
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
+ ,
[ 
Display 
( 
Name 
= 
$str 1
)1 2
]2 3
[ 
Required 
( 
ErrorMessage 
= 
Obligatorio (
)( )
]) *
public 

string 
TipoActividad 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$str0 2
;2 3
[ 
Display 
( 
Name 
= 
$str 2
)2 3
]3 4
[ 
Required 
( 
ErrorMessage 
= 
Obligatorio (
)( )
]) *
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
	Documento( 1
,1 2
ErrorMessage3 ?
=@ A
ReglasValidacionB R
.R S
DocumentoMensajeS c
)c d
]d e
public 

string 
	Documento 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
[ 
Display 
( 
Name 
= 
$str 4
)4 5
]5 6
[ 
Required 
( 
ErrorMessage 
= 
Obligatorio (
)( )
]) *
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
Correo( .
,. /
ErrorMessage0 <
== >
ReglasValidacion? O
.O P
CorreoMensajeP ]
)] ^
]^ _
[ 
StringLength 
( 
$num 
, 
ErrorMessage #
=$ %
$str& =
)= >
]> ?
public 

string 
Correo 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
[ 
Display 
( 
Name 
= 
$str *
)* +
]+ ,
[ 
Required 
( 
ErrorMessage 
= 
Obligatorio (
)( )
]) *
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
Telefono( 0
,0 1
ErrorMessage2 >
=? @
ReglasValidacionA Q
.Q R
TelefonoMensajeR a
)a b
]b c
public 

string 
Telefono 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
[   
Display   
(   
Name   
=   
$str   /
)  / 0
]  0 1
[!! 
Required!! 
(!! 
ErrorMessage!! 
=!! 
Obligatorio!! (
)!!( )
]!!) *
["" 
StringLength"" 
("" 
$num"" 
,"" 
MinimumLength"" $
=""% &
$num""' (
,""( )
ErrorMessage""* 6
=""7 8
$str""9 ^
)""^ _
]""_ `
public## 

string## 
	Direccion## 
{## 
get## !
;##! "
set### &
;##& '
}##( )
=##* +
$str##, .
;##. /
[%% 
Display%% 
(%% 
Name%% 
=%% 
$str%%  
)%%  !
]%%! "
[&& 
Required&& 
(&& 
ErrorMessage&& 
=&& 
Obligatorio&& (
)&&( )
]&&) *
['' 
DataType'' 
('' 
DataType'' 
.'' 
Password'' 
)''  
]''  !
public(( 

string(( 
Password(( 
{(( 
get((  
;((  !
set((" %
;((% &
}((' (
=(() *
$str((+ -
;((- .
[** 
Display** 
(** 
Name** 
=** 
$str** *
)*** +
]**+ ,
[++ 
Required++ 
(++ 
ErrorMessage++ 
=++ 
Obligatorio++ (
)++( )
]++) *
[,, 
DataType,, 
(,, 
DataType,, 
.,, 
Password,, 
),,  
],,  !
public-- 

string-- 
ConfirmarPassword-- #
{--$ %
get--& )
;--) *
set--+ .
;--. /
}--0 1
=--2 3
$str--4 6
;--6 7
}.. §/
VC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\RegistrarPedidoDto.cs
public 
class 
RegistrarPedidoDto 
{ 
[ 
Display 
( 
Name 
= 
$str (
)( )
]) *
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
[ 
StringLength 
( 
$num 
, 
MinimumLength $
=% &
$num' (
,( )
ErrorMessage* 6
=7 8
$str9 ^
)^ _
]_ `
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
NombrePersona( 5
,5 6
ErrorMessage7 C
=D E
ReglasValidacionF V
.V W 
NombrePersonaMensajeW k
)k l
]l m
public		 

string		 
ClienteNombre		 
{		  !
get		" %
;		% &
set		' *
;		* +
}		, -
=		. /
$str		0 2
;		2 3
[ 
Display 
( 
Name 
= 
$str *
)* +
]+ ,
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
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
Telefono( 0
,0 1
ErrorMessage2 >
=? @
ReglasValidacionA Q
.Q R
TelefonoMensajeR a
)a b
]b c
public 

string 
ClienteTelefono !
{" #
get$ '
;' (
set) ,
;, -
}. /
=0 1
$str2 4
;4 5
[ 
Display 
( 
Name 
= 
$str *
)* +
]+ ,
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
[ 
StringLength 
( 
$num 
, 
MinimumLength $
=% &
$num' (
,( )
ErrorMessage* 6
=7 8
$str9 ^
)^ _
]_ `
public 

string 
DireccionEntrega "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
$str3 5
;5 6
[ 
Display 
( 
Name 
= 
$str $
)$ %
]% &
[ 
Required 
( 
ErrorMessage 
= 
$str ;
); <
]< =
public 


MetodoPago 
? 

MetodoPago !
{" #
get$ '
;' (
set) ,
;, -
}. /
[ 
	MinLength 
( 
$num 
, 
ErrorMessage 
=  
$str! >
)> ?
]? @
public 

List 
< 
ItemPedidoDto 
> 
	Productos (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
=7 8
[9 :
]: ;
;; <
} 
public 
class 
ItemPedidoDto 
{ 
[ 
Display 
( 
Name 
= 
$str !
)! "
]" #
[   
Required   
(   
ErrorMessage   
=   
RegistroNegocioDto   /
.  / 0
Obligatorio  0 ;
)  ; <
]  < =
[!! 
StringLength!! 
(!! 
$num!! 
,!! 
ErrorMessage!! #
=!!$ %
$str!!& =
)!!= >
]!!> ?
public"" 

string"" 
Descripcion"" 
{"" 
get""  #
;""# $
set""% (
;""( )
}""* +
="", -
$str"". 0
;""0 1
[$$ 
Range$$ 

($$
 
$num$$ 
,$$ 
$num$$ 
,$$ 
ErrorMessage$$  
=$$! "
$str$$# Y
)$$Y Z
]$$Z [
public%% 

int%% 
Cantidad%% 
{%% 
get%% 
;%% 
set%% "
;%%" #
}%%$ %
=%%& '
$num%%( )
;%%) *
['' 
Range'' 

(''
 
$num'' 
,'' 
$num'' 
,'' 
ErrorMessage'' (
='') *
$str''+ I
)''I J
]''J K
public(( 

decimal(( 
PrecioUnitario(( !
{((" #
get(($ '
;((' (
set(() ,
;((, -
}((. /
})) 
public++ 
class++ #
ClienteAutocompletarDto++ $
{,, 
public-- 

string-- 
Nombre-- 
{-- 
get-- 
;-- 
set--  #
;--# $
}--% &
=--' (
$str--) +
;--+ ,
public.. 

string.. 
	Direccion.. 
{.. 
get.. !
;..! "
set..# &
;..& '
}..( )
=..* +
$str.., .
;... /
}// 
public11 
enum11 

MetodoPago11 
{22 
Efectivo33 
,33 
Transferencia44 
,44 
Tarjeta55 
}66 ¢
PC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\RecuperarDto.cs
public 
class 
RecuperarDto 
{ 
[ 
Display 
( 
Name 
= 
$str 3
)3 4
]4 5
[ 
Required 
( 
ErrorMessage 
= 
$str <
)< =
]= >
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
Correo( .
,. /
ErrorMessage0 <
== >
ReglasValidacion? O
.O P
CorreoMensajeP ]
)] ^
]^ _
public 

string 
Correo 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
}		 †1
XC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\PerfilRepartidorDtos.cs
public 
class 
PerfilRepartidorDto  
{ 
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
string 
	Documento 
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

string 
Telefono 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
public		 

string		 
Correo		 
{		 
get		 
;		 
set		  #
;		# $
}		% &
=		' (
$str		) +
;		+ ,
public

 

TipoVehiculo

 
Vehiculo

  
{

! "
get

# &
;

& '
set

( +
;

+ ,
}

- .
public 

string 
? 
Placa 
{ 
get 
; 
set  #
;# $
}% &
public 

string 
Negocio 
{ 
get 
;  
set! $
;$ %
}& '
=( )
$str* ,
;, -
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
}+ ,
public 

int 
PedidosPendientes  
{! "
get# &
;& '
set( +
;+ ,
}- .
} 
public 
class 
EditarRepartidorDto  
:! "
IValidatableObject# 5
{ 
[ 
Display 
( 
Name 
= 
$str %
)% &
]& '
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
[ 
StringLength 
( 
$num 
, 
MinimumLength $
=% &
$num' (
,( )
ErrorMessage* 6
=7 8
$str9 ^
)^ _
]_ `
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
NombrePersona( 5
,5 6
ErrorMessage7 C
=D E
ReglasValidacionF V
.V W 
NombrePersonaMensajeW k
)k l
]l m
public 

string 
NombreCompleto  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
$str1 3
;3 4
[ 
Display 
( 
Name 
= 
$str 
) 
]  
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
.' (
Telefono( 0
,0 1
ErrorMessage2 >
=? @
ReglasValidacionA Q
.Q R
TelefonoMensajeR a
)a b
]b c
public 

string 
Telefono 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
[   
Display   
(   
Name   
=   
$str   (
)  ( )
]  ) *
[!! 
Required!! 
(!! 
ErrorMessage!! 
=!! 
RegistroNegocioDto!! /
.!!/ 0
Obligatorio!!0 ;
)!!; <
]!!< =
["" 
RegularExpression"" 
("" 
ReglasValidacion"" '
.""' (
Correo""( .
,"". /
ErrorMessage""0 <
=""= >
ReglasValidacion""? O
.""O P
CorreoMensaje""P ]
)""] ^
]""^ _
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
string$$ 
Correo$$ 
{$$ 
get$$ 
;$$ 
set$$  #
;$$# $
}$$% &
=$$' (
$str$$) +
;$$+ ,
[&& 
Display&& 
(&& 
Name&& 
=&& 
$str&& &
)&&& '
]&&' (
['' 
Required'' 
('' 
ErrorMessage'' 
='' 
RegistroNegocioDto'' /
.''/ 0
Obligatorio''0 ;
)''; <
]''< =
public(( 

TipoVehiculo(( 
?(( 
Vehiculo(( !
{((" #
get(($ '
;((' (
set(() ,
;((, -
}((. /
[** 
Display** 
(** 
Name** 
=** 
$str** 
)** 
]** 
public++ 

string++ 
?++ 
Placa++ 
{++ 
get++ 
;++ 
set++  #
;++# $
}++% &
public.. 

IEnumerable.. 
<.. 
ValidationResult.. '
>..' (
Validate..) 1
(..1 2
ValidationContext..2 C
context..D K
)..K L
{// 
return00 
ReglasValidacion00 
.00  
ValidarVehiculo00  /
(00/ 0
Vehiculo000 8
,008 9
Placa00: ?
)00? @
;00@ A
}11 
}22 ò	
[C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\PerfilPublicoNegocioDto.cs
public 
class #
PerfilPublicoNegocioDto $
{ 
public 

string 
Nombre 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
public 

string 
TipoActividad 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
$str0 2
;2 3
public 

string 
	Direccion 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
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

DateTime 
FechaRegistro !
{" #
get$ '
;' (
set) ,
;, -
}. /
}		 ‘
TC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\PerfilNegocioDto.cs
public 
class 
PerfilNegocioDto 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
Nombre 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
public 

string 
TipoActividad 
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
string 
	Documento 
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

string 
Correo 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
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

string

 
	Direccion

 
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
( )
=

* +
$str

, .
;

. /
public 

DateTime 
FechaRegistro !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 

EstadoCuenta 
Estado 
{  
get! $
;$ %
set& )
;) *
}+ ,
} ñ
LC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\LoginDto.cs
public 
class 
LoginDto 
{ 
public 


RolUsuario 
Rol 
{ 
get 
;  
set! $
;$ %
}& '
=( )

RolUsuario* 4
.4 5
Negocio5 <
;< =
[ 
Display 
( 
Name 
= 
$str 2
)2 3
]3 4
[ 
Required 
( 
ErrorMessage 
= 
$str @
)@ A
]A B
[		 
StringLength		 
(		 
$num		 
,		 
ErrorMessage		 #
=		$ %
$str		& =
)		= >
]		> ?
public

 

string

 
Identificador

 
{

  !
get

" %
;

% &
set

' *
;

* +
}

, -
=

. /
$str

0 2
;

2 3
[ 
Display 
( 
Name 
= 
$str  
)  !
]! "
[ 
Required 
( 
ErrorMessage 
= 
$str @
)@ A
]A B
[ 
DataType 
( 
DataType 
. 
Password 
)  
]  !
public 

string 
Password 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
} ü
UC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\EliminarCuentaDto.cs
public 
class 
EliminarCuentaDto 
{ 
[ 
Display 
( 
Name 
= 
$str  
)  !
]! "
[ 
Required 
( 
ErrorMessage 
= 
$str 4
)4 5
]5 6
[ 
DataType 
( 
DataType 
. 
Password 
)  
]  !
public 

string 
Password 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
}		 ¸
TC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\EditarNegocioDto.cs
public 
class 
EditarNegocioDto 
{ 
[ 
Display 
( 
Name 
= 
$str &
)& '
]' (
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
[ 
StringLength 
( 
$num 
, 
MinimumLength $
=% &
$num' (
,( )
ErrorMessage* 6
=7 8
$str9 ^
)^ _
]_ `
public		 

string		 
Nombre		 
{		 
get		 
;		 
set		  #
;		# $
}		% &
=		' (
$str		) +
;		+ ,
[ 
Display 
( 
Name 
= 
$str ,
), -
]- .
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
public 

string 
TipoActividad 
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
$str (
)( )
]) *
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
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
Correo( .
,. /
ErrorMessage0 <
== >
ReglasValidacion? O
.O P
CorreoMensajeP ]
)] ^
]^ _
[ 
StringLength 
( 
$num 
, 
ErrorMessage #
=$ %
$str& =
)= >
]> ?
public 

string 
Correo 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
[ 
Display 
( 
Name 
= 
$str *
)* +
]+ ,
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
[ 
RegularExpression 
( 
ReglasValidacion '
.' (
Telefono( 0
,0 1
ErrorMessage2 >
=? @
ReglasValidacionA Q
.Q R
TelefonoMensajeR a
)a b
]b c
public 

string 
Telefono 
{ 
get  
;  !
set" %
;% &
}' (
=) *
$str+ -
;- .
[ 
Display 
( 
Name 
= 
$str 
)  
]  !
[ 
Required 
( 
ErrorMessage 
= 
RegistroNegocioDto /
./ 0
Obligatorio0 ;
); <
]< =
[ 
StringLength 
( 
$num 
, 
MinimumLength $
=% &
$num' (
,( )
ErrorMessage* 6
=7 8
$str9 ^
)^ _
]_ `
public 

string 
	Direccion 
{ 
get !
;! "
set# &
;& '
}( )
=* +
$str, .
;. /
} â
TC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Dtos\ActivarCuentaDto.cs
public 
class 
ActivarCuentaDto 
{ 
public 

string 
Token 
{ 
get 
; 
set "
;" #
}$ %
=& '
$str( *
;* +
[ 
Display 
( 
Name 
= 
$str  
)  !
]! "
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
 
DataType

 
(

 
DataType

 
.

 
Password

 
)

  
]

  !
public 

string 
NuevaPassword 
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
[ 
DataType 
( 
DataType 
. 
Password 
)  
]  !
[ 
Compare 
( 
nameof 
( 
NuevaPassword !
)! "
," #
ErrorMessage$ 0
=1 2
$str3 Q
)Q R
]R S
public 

string 
ConfirmarPassword #
{$ %
get& )
;) *
set+ .
;. /
}0 1
=2 3
$str4 6
;6 7
public 


RolUsuario 
Rol 
{ 
get 
;  
set! $
;$ %
}& '
=( )

RolUsuario* 4
.4 5

Repartidor5 ?
;? @
public 

string 
Nombre 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
public 

string 
Correo 
{ 
get 
; 
set  #
;# $
}% &
=' (
$str) +
;+ ,
public 

string 
Negocio 
{ 
get 
;  
set! $
;$ %
}& '
=( )
$str* ,
;, -
} ƒª
PC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Data\appDBcontext.cs
public 
class 
AppDbContext 
( 
DbContextOptions *
<* +
AppDbContext+ 7
>7 8
options9 @
)@ A
:B C
	DbContextD M
(M N
optionsN U
)U V
{ 
public 

DbSet 
< 
Usuario 
> 
Usuarios "
=># %
Set& )
<) *
Usuario* 1
>1 2
(2 3
)3 4
;4 5
public 

DbSet 
< 
TokenRecuperacion "
>" #
TokensRecuperacion$ 6
=>7 9
Set: =
<= >
TokenRecuperacion> O
>O P
(P Q
)Q R
;R S
public 

DbSet 
< 
Negocio 
> 
Negocios "
=># %
Set& )
<) *
Negocio* 1
>1 2
(2 3
)3 4
;4 5
public 

DbSet 
< 
CodigoVerificacion #
># $
CodigosVerificacion% 8
=>9 ;
Set< ?
<? @
CodigoVerificacion@ R
>R S
(S T
)T U
;U V
public		 

DbSet		 
<		 

Repartidor		 
>		 
Repartidores		 )
=>		* ,
Set		- 0
<		0 1

Repartidor		1 ;
>		; <
(		< =
)		= >
;		> ?
public

 

DbSet

 
<

 
Administrador

 
>

 
Administradores

  /
=>

0 2
Set

3 6
<

6 7
Administrador

7 D
>

D E
(

E F
)

F G
;

G H
public 

DbSet 
< 
Pedido 
> 
Pedidos  
=>! #
Set$ '
<' (
Pedido( .
>. /
(/ 0
)0 1
;1 2
public 

DbSet 
< 

ItemPedido 
> 
ItemsPedido (
=>) +
Set, /
</ 0

ItemPedido0 :
>: ;
(; <
)< =
;= >
public 

DbSet 
<  
SuspensionRepartidor %
>% & 
SuspensionRepartidor' ;
{< =
get> A
;A B
setC F
;F G
}H I
public 

DbSet 
< 
UbicacionPedido  
>  !
UbicacionesPedido" 3
=>4 6
Set7 :
<: ;
UbicacionPedido; J
>J K
(K L
)L M
;M N
public 

DbSet 
<  
SolicitudCancelacion %
>% &"
SolicitudesCancelacion' =
=>> @
SetA D
<D E 
SolicitudCancelacionE Y
>Y Z
(Z [
)[ \
;\ ]
public 

DbSet 
< 
NovedadPedido 
> 
NovedadesPedido  /
=>0 2
Set3 6
<6 7
NovedadPedido7 D
>D E
(E F
)F G
;G H
	protected 
override 
void 
OnModelCreating +
(+ ,
ModelBuilder, 8
modelBuilder9 E
)E F
{ 
modelBuilder 
. 
Entity 
< 
Usuario #
># $
($ %
e% &
=>' )
{ 	
e 
. 
ToTable 
( 
$str 
,  
t! "
=># %
t& '
.' (

HasTrigger( 2
(2 3
$str3 R
)R S
)S T
;T U
e 
. 
Property 
( 
u 
=> 
u 
. 
PasswordHash *
)* +
.+ ,
HasColumnName, 9
(9 :
$str: J
)J K
;K L
e 
. 
Property 
( 
u 
=> 
u 
. 
Rol !
)! "
." #
HasColumnName# 0
(0 1
$str1 8
)8 9
;9 :
e 
. 
Property 
( 
u 
=> 
u 
. 
Estado $
)$ %
.% &
HasColumnName& 3
(3 4
$str4 D
)D E
;E F
e 
. 
Property 
( 
u 
=> 
u 
. 
Correo $
)$ %
.% &
HasMaxLength& 2
(2 3
$num3 6
)6 7
;7 8
e 
. 
Property 
( 
u 
=> 
u 
. 
	Documento '
)' (
.( )
HasMaxLength) 5
(5 6
$num6 8
)8 9
.9 :
	IsUnicode: C
(C D
falseD I
)I J
;J K
e 
. 
HasIndex 
( 
u 
=> 
u 
. 
Correo $
)$ %
.% &
IsUnique& .
(. /
)/ 0
;0 1
e 
. 
HasIndex 
( 
u 
=> 
u 
. 
	Documento '
)' (
.( )
IsUnique) 1
(1 2
)2 3
;3 4
}   	
)  	 

;  
 
modelBuilder"" 
."" 
Entity"" 
<"" 
TokenRecuperacion"" -
>""- .
("". /
e""/ 0
=>""1 3
{## 	
e$$ 
.$$ 
ToTable$$ 
($$ 
$str$$ )
)$$) *
;$$* +
e%% 
.%% 
Property%% 
(%% 
t%% 
=>%% 
t%% 
.%% 
Expira%% $
)%%$ %
.%%% &
HasColumnName%%& 3
(%%3 4
$str%%4 E
)%%E F
;%%F G
e&& 
.&& 
Property&& 
(&& 
t&& 
=>&& 
t&& 
.&& 
	TokenHash&& '
)&&' (
.&&( )
HasMaxLength&&) 5
(&&5 6
$num&&6 8
)&&8 9
;&&9 :
e'' 
.'' 
HasIndex'' 
('' 
t'' 
=>'' 
t'' 
.'' 
	TokenHash'' '
)''' (
.''( )
IsUnique'') 1
(''1 2
)''2 3
;''3 4
}(( 	
)((	 

;((
 
modelBuilder** 
.** 
Entity** 
<** 
Negocio** #
>**# $
(**$ %
e**% &
=>**' )
{++ 	
e,, 
.,, 
ToTable,, 
(,, 
$str,, 
),,  
;,,  !
e-- 
.-- 
Property-- 
(-- 
n-- 
=>-- 
n-- 
.-- 
Nombre-- $
)--$ %
.--% &
HasMaxLength--& 2
(--2 3
$num--3 6
)--6 7
;--7 8
e.. 
... 
Property.. 
(.. 
n.. 
=>.. 
n.. 
... 
TipoActividad.. +
)..+ ,
..., -
HasMaxLength..- 9
(..9 :
$num..: =
)..= >
;..> ?
e// 
.// 
Property// 
(// 
n// 
=>// 
n// 
.// 
Telefono// &
)//& '
.//' (
HasMaxLength//( 4
(//4 5
$num//5 7
)//7 8
.//8 9
	IsUnicode//9 B
(//B C
false//C H
)//H I
;//I J
e00 
.00 
Property00 
(00 
n00 
=>00 
n00 
.00 
	Direccion00 '
)00' (
.00( )
HasMaxLength00) 5
(005 6
$num006 9
)009 :
;00: ;
e22 
.22 
Property22 
<22 
DateTime22 
?22  
>22  !
(22! "
$str22" 3
)223 4
;224 5
e33 
.33 
HasIndex33 
(33 
n33 
=>33 
n33 
.33 
Telefono33 &
)33& '
.33' (
IsUnique33( 0
(330 1
)331 2
;332 3
e44 
.44 
HasOne44 
(44 
n44 
=>44 
n44 
.44 
Usuario44 #
)44# $
.44$ %
WithOne44% ,
(44, -
)44- .
.55 
HasForeignKey55 
<55 
Negocio55 &
>55& '
(55' (
n55( )
=>55* ,
n55- .
.55. /
	UsuarioId55/ 8
)558 9
.66 
OnDelete66 
(66 
DeleteBehavior66 (
.66( )
Restrict66) 1
)661 2
;662 3
}77 	
)77	 

;77
 
modelBuilder99 
.99 
Entity99 
<99 
CodigoVerificacion99 .
>99. /
(99/ 0
e990 1
=>992 4
{:: 	
e;; 
.;; 
ToTable;; 
(;; 
$str;; *
);;* +
;;;+ ,
e<< 
.<< 
Property<< 
(<< 
c<< 
=><< 
c<< 
.<< 
Expira<< $
)<<$ %
.<<% &
HasColumnName<<& 3
(<<3 4
$str<<4 E
)<<E F
;<<F G
e== 
.== 
Property== 
(== 
c== 
=>== 
c== 
.== 

CodigoHash== (
)==( )
.==) *
HasMaxLength==* 6
(==6 7
$num==7 9
)==9 :
;==: ;
e>> 
.>> 
HasIndex>> 
(>> 
c>> 
=>>> 
c>> 
.>> 
	UsuarioId>> '
)>>' (
;>>( )
}?? 	
)??	 

;??
 
modelBuilderAA 
.AA 
EntityAA 
<AA 

RepartidorAA &
>AA& '
(AA' (
eAA( )
=>AA* ,
{BB 	
eCC 
.CC 
ToTableCC 
(CC 
$strCC "
)CC" #
;CC# $
eDD 
.DD 
PropertyDD 
(DD 
rDD 
=>DD 
rDD 
.DD 
VehiculoDD &
)DD& '
.DD' (
HasColumnNameDD( 5
(DD5 6
$strDD6 F
)DDF G
;DDG H
eEE 
.EE 
PropertyEE 
(EE 
rEE 
=>EE 
rEE 
.EE 
NombreCompletoEE ,
)EE, -
.EE- .
HasMaxLengthEE. :
(EE: ;
$numEE; >
)EE> ?
;EE? @
eFF 
.FF 
PropertyFF 
(FF 
rFF 
=>FF 
rFF 
.FF 
TelefonoFF &
)FF& '
.FF' (
HasMaxLengthFF( 4
(FF4 5
$numFF5 7
)FF7 8
.FF8 9
	IsUnicodeFF9 B
(FFB C
falseFFC H
)FFH I
;FFI J
eGG 
.GG 
PropertyGG 
(GG 
rGG 
=>GG 
rGG 
.GG 
PlacaGG #
)GG# $
.GG$ %
HasMaxLengthGG% 1
(GG1 2
$numGG2 4
)GG4 5
.GG5 6
	IsUnicodeGG6 ?
(GG? @
falseGG@ E
)GGE F
;GGF G
eHH 
.HH 
HasOneHH 
(HH 
rHH 
=>HH 
rHH 
.HH 
UsuarioHH #
)HH# $
.HH$ %
WithManyHH% -
(HH- .
)HH. /
.II 
HasForeignKeyII 
(II 
rII  
=>II! #
rII$ %
.II% &
	UsuarioIdII& /
)II/ 0
.JJ 
OnDeleteJJ 
(JJ 
DeleteBehaviorJJ (
.JJ( )
RestrictJJ) 1
)JJ1 2
;JJ2 3
}KK 	
)KK	 

;KK
 
modelBuilderMM 
.MM 
EntityMM 
<MM 
AdministradorMM )
>MM) *
(MM* +
eMM+ ,
=>MM- /
{NN 	
eOO 
.OO 
ToTableOO 
(OO 
$strOO %
)OO% &
;OO& '
ePP 
.PP 
PropertyPP 
(PP 
aPP 
=>PP 
aPP 
.PP 
NombreCompletoPP ,
)PP, -
.PP- .
HasMaxLengthPP. :
(PP: ;
$numPP; >
)PP> ?
;PP? @
eQQ 
.QQ 
PropertyQQ 
(QQ 
aQQ 
=>QQ 
aQQ 
.QQ 
TelefonoQQ &
)QQ& '
.QQ' (
HasMaxLengthQQ( 4
(QQ4 5
$numQQ5 7
)QQ7 8
.QQ8 9
	IsUnicodeQQ9 B
(QQB C
falseQQC H
)QQH I
;QQI J
eRR 
.RR 
HasOneRR 
(RR 
aRR 
=>RR 
aRR 
.RR 
UsuarioRR #
)RR# $
.RR$ %
WithManyRR% -
(RR- .
)RR. /
.SS 
HasForeignKeySS 
(SS 
aSS  
=>SS! #
aSS$ %
.SS% &
	UsuarioIdSS& /
)SS/ 0
.TT 
OnDeleteTT 
(TT 
DeleteBehaviorTT (
.TT( )
RestrictTT) 1
)TT1 2
;TT2 3
}UU 	
)UU	 

;UU
 
modelBuilderWW 
.WW 
EntityWW 
<WW 
PedidoWW "
>WW" #
(WW# $
eWW$ %
=>WW& (
{XX 	
eZZ 
.ZZ 
ToTableZZ 
(ZZ 
$strZZ 
,ZZ 
tZZ  !
=>ZZ" $
{[[ 
t\\ 
.\\ 

HasTrigger\\ 
(\\ 
$str\\ =
)\\= >
;\\> ?
t]] 
.]] 

HasTrigger]] 
(]] 
$str]] 8
)]]8 9
;]]9 :
}^^ 
)^^ 
;^^ 
e__ 
.__ 
Property__ 
(__ 
p__ 
=>__ 
p__ 
.__ 
Codigo__ $
)__$ %
.__% &
HasMaxLength__& 2
(__2 3
$num__3 4
)__4 5
.__5 6
IsFixedLength__6 C
(__C D
)__D E
.__E F
	IsUnicode__F O
(__O P
false__P U
)__U V
;__V W
e`` 
.`` 
Property`` 
(`` 
p`` 
=>`` 
p`` 
.`` 
DireccionEntrega`` .
)``. /
.``/ 0
HasMaxLength``0 <
(``< =
$num``= @
)``@ A
;``A B
ebb 
.bb 
HasOnebb 
(bb 
pbb 
=>bb 
pbb 
.bb 
Negociobb #
)bb# $
.bb$ %
WithManybb% -
(bb- .
)bb. /
.cc 
HasForeignKeycc 
(cc 
pcc  
=>cc! #
pcc$ %
.cc% &
	NegocioIdcc& /
)cc/ 0
.dd 
OnDeletedd 
(dd 
DeleteBehaviordd (
.dd( )
Restrictdd) 1
)dd1 2
;dd2 3
eff 
.ff 
HasOneff 
(ff 
pff 
=>ff 
pff 
.ff 
Clienteff #
)ff# $
.ff$ %
WithManyff% -
(ff- .
)ff. /
.gg 
HasForeignKeygg 
(gg 
pgg  
=>gg! #
pgg$ %
.gg% &
	ClienteIdgg& /
)gg/ 0
.hh 
OnDeletehh 
(hh 
DeleteBehaviorhh (
.hh( )
Restricthh) 1
)hh1 2
;hh2 3
ejj 
.jj 
HasManyjj 
(jj 
pjj 
=>jj 
pjj 
.jj 
Itemsjj "
)jj" #
.jj# $
WithOnejj$ +
(jj+ ,
ijj, -
=>jj. 0
ijj1 2
.jj2 3
Pedidojj3 9
)jj9 :
.kk 
HasForeignKeykk 
(kk 
ikk  
=>kk! #
ikk$ %
.kk% &
PedidoIdkk& .
)kk. /
.ll 
OnDeletell 
(ll 
DeleteBehaviorll (
.ll( )
Cascadell) 0
)ll0 1
;ll1 2
}mm 	
)mm	 

;mm
 
modelBuilderoo 
.oo 
Entityoo 
<oo 

ItemPedidooo &
>oo& '
(oo' (
eoo( )
=>oo* ,
{pp 	
eqq 
.qq 
ToTableqq 
(qq 
$strqq "
)qq" #
;qq# $
err 
.rr 
Propertyrr 
(rr 
irr 
=>rr 
irr 
.rr 
Descripcionrr )
)rr) *
.rr* +
HasMaxLengthrr+ 7
(rr7 8
$numrr8 ;
)rr; <
;rr< =
ess 
.ss 
Propertyss 
(ss 
iss 
=>ss 
iss 
.ss 
PrecioUnitarioss ,
)ss, -
.ss- .
HasPrecisionss. :
(ss: ;
$numss; =
,ss= >
$numss? @
)ss@ A
;ssA B
}tt 	
)tt	 

;tt
 
modelBuilderww 
.ww 
Entityww 
<ww  
SolicitudCancelacionww 0
>ww0 1
(ww1 2
eww2 3
=>ww4 6
{xx 	
eyy 
.yy 
ToTableyy 
(yy 
$stryy ,
)yy, -
;yy- .
ezz 
.zz 
Propertyzz 
(zz 
szz 
=>zz 
szz 
.zz 
Motivozz $
)zz$ %
.zz% &
HasMaxLengthzz& 2
(zz2 3
$numzz3 6
)zz6 7
;zz7 8
e{{ 
.{{ 
HasIndex{{ 
({{ 
s{{ 
=>{{ 
s{{ 
.{{ 
PedidoId{{ &
){{& '
.{{' (
IsUnique{{( 0
({{0 1
){{1 2
;{{2 3
e|| 
.|| 
HasOne|| 
(|| 
s|| 
=>|| 
s|| 
.|| 
Pedido|| "
)||" #
.||# $
WithMany||$ ,
(||, -
)||- .
.}} 
HasForeignKey}} 
(}} 
s}}  
=>}}! #
s}}$ %
.}}% &
PedidoId}}& .
)}}. /
.~~ 
OnDelete~~ 
(~~ 
DeleteBehavior~~ (
.~~( )
Restrict~~) 1
)~~1 2
;~~2 3
} 	
)	 

;
 
modelBuilder
ÇÇ 
.
ÇÇ 
Entity
ÇÇ 
<
ÇÇ 
NovedadPedido
ÇÇ )
>
ÇÇ) *
(
ÇÇ* +
e
ÇÇ+ ,
=>
ÇÇ- /
{
ÉÉ 	
e
ÑÑ 
.
ÑÑ 
ToTable
ÑÑ 
(
ÑÑ 
$str
ÑÑ %
)
ÑÑ% &
;
ÑÑ& '
e
ÖÖ 
.
ÖÖ 
Property
ÖÖ 
(
ÖÖ 
n
ÖÖ 
=>
ÖÖ 
n
ÖÖ 
.
ÖÖ 
Observaciones
ÖÖ +
)
ÖÖ+ ,
.
ÖÖ, -
HasMaxLength
ÖÖ- 9
(
ÖÖ9 :
$num
ÖÖ: =
)
ÖÖ= >
;
ÖÖ> ?
e
ÜÜ 
.
ÜÜ 
Property
ÜÜ 
(
ÜÜ 
n
ÜÜ 
=>
ÜÜ 
n
ÜÜ 
.
ÜÜ 
Fecha
ÜÜ #
)
ÜÜ# $
.
ÜÜ$ %
HasColumnType
ÜÜ% 2
(
ÜÜ2 3
$str
ÜÜ3 A
)
ÜÜA B
;
ÜÜB C
e
áá 
.
áá 
HasIndex
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
áá 
PedidoId
áá &
)
áá& '
;
áá' (
e
àà 
.
àà 
HasOne
àà 
(
àà 
n
àà 
=>
àà 
n
àà 
.
àà 
Pedido
àà "
)
àà" #
.
àà# $
WithMany
àà$ ,
(
àà, -
)
àà- .
.
ââ 
HasForeignKey
ââ 
(
ââ 
n
ââ  
=>
ââ! #
n
ââ$ %
.
ââ% &
PedidoId
ââ& .
)
ââ. /
.
ää 
OnDelete
ää 
(
ää 
DeleteBehavior
ää (
.
ää( )
Restrict
ää) 1
)
ää1 2
;
ää2 3
}
ãã 	
)
ãã	 

;
ãã
 
modelBuilder
çç 
.
çç 
Entity
çç 
<
çç 
UbicacionPedido
çç +
>
çç+ ,
(
çç, -
e
çç- .
=>
çç/ 1
{
éé 	
e
èè 
.
èè 
ToTable
èè 
(
èè 
$str
èè '
)
èè' (
;
èè( )
e
êê 
.
êê 
HasKey
êê 
(
êê 
u
êê 
=>
êê 
u
êê 
.
êê 
PedidoId
êê $
)
êê$ %
;
êê% &
e
ëë 
.
ëë 
Property
ëë 
(
ëë 
u
ëë 
=>
ëë 
u
ëë 
.
ëë 
PedidoId
ëë &
)
ëë& '
.
ëë' (!
ValueGeneratedNever
ëë( ;
(
ëë; <
)
ëë< =
;
ëë= >
e
íí 
.
íí 
Property
íí 
(
íí 
u
íí 
=>
íí 
u
íí 
.
íí 
Latitud
íí %
)
íí% &
.
íí& '
HasPrecision
íí' 3
(
íí3 4
$num
íí4 5
,
íí5 6
$num
íí7 8
)
íí8 9
;
íí9 :
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
Longitud
ìì &
)
ìì& '
.
ìì' (
HasPrecision
ìì( 4
(
ìì4 5
$num
ìì5 6
,
ìì6 7
$num
ìì8 9
)
ìì9 :
;
ìì: ;
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
îî  
FechaActualizacion
îî 0
)
îî0 1
.
îî1 2
HasColumnType
îî2 ?
(
îî? @
$str
îî@ N
)
îîN O
;
îîO P
e
ññ 
.
ññ 
HasOne
ññ 
(
ññ 
u
ññ 
=>
ññ 
u
ññ 
.
ññ 
Pedido
ññ "
)
ññ" #
.
óó 
WithOne
óó 
(
óó 
)
óó 
.
òò 
HasForeignKey
òò 
<
òò 
UbicacionPedido
òò .
>
òò. /
(
òò/ 0
u
òò0 1
=>
òò2 4
u
òò5 6
.
òò6 7
PedidoId
òò7 ?
)
òò? @
.
ôô 
OnDelete
ôô 
(
ôô 
DeleteBehavior
ôô (
.
ôô( )
Cascade
ôô) 0
)
ôô0 1
;
ôô1 2
}
öö 	
)
öö	 

;
öö
 
}
õõ 
}úú ≤¢
\C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Controllers\UsuarioController.cs
public 
class 
UsuarioController 
( 
IAuthService 
auth 
,  
IRecuperacionService 
recuperacion %
,% &$
IActivacionCuentaService		 

activacion		 '
)		' (
:		) *

Controller		+ 5
{

 
[ 
HttpGet 
] 
public 

IActionResult 
Login 
( 
string %
?% &
rol' *
=+ ,
null- 1
,1 2
string3 9
?9 :
	returnUrl; D
=E F
nullG K
)K L
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
;\ ]
var 
dto 
= 
new 
LoginDto 
( 
)  
;  !
var 
volverA 
= 
Url 
. 

IsLocalUrl $
($ %
	returnUrl% .
). /
?0 1
	returnUrl2 ;
:< =
null> B
;B C
if 

( 
Enum 
. 
TryParse 
< 

RolUsuario $
>$ %
(% &
rol& )
,) *
true+ /
,/ 0
out1 4
var5 8
perfil9 ?
)? @
&&A C
EnumD H
.H I
	IsDefinedI R
(R S
perfilS Y
)Y Z
)Z [
dto 
. 
Rol 
= 
perfil 
; 
else 
if 
( 
volverA 
? 
. 

StartsWith $
($ %
$str% -
,- .
StringComparison/ ?
.? @
OrdinalIgnoreCase@ Q
)Q R
==S U
trueV Z
)Z [
dto 
. 
Rol 
= 

RolUsuario  
.  !
Administrador! .
;. /
if 

( 
TempData 
[ 
$str $
]$ %
is& (
string) /
identificador0 =
)= >
dto? B
.B C
IdentificadorC P
=Q R
identificadorS `
;` a
ViewData 
[ 
$str 
] 
= 
volverA  '
;' (
return 
View 
( 
dto 
) 
; 
} 
[!! 
HttpPost!! 
,!! $
ValidateAntiForgeryToken!! '
]!!' (
public"" 

async"" 
Task"" 
<"" 
IActionResult"" #
>""# $
Login""% *
(""* +
LoginDto""+ 3
dto""4 7
,""7 8
string""9 ?
?""? @
	returnUrl""A J
=""K L
null""M Q
)""Q R
{## 
if$$ 

($$ 
User$$ 
.$$ 
Identity$$ 
?$$ 
.$$ 
IsAuthenticated$$ *
==$$+ -
true$$. 2
)$$2 3
return$$4 :
RedirectToAction$$; K
($$K L
$str$$L S
,$$S T
$str$$U [
)$$[ \
;$$\ ]
var&& 
volverA&& 
=&& 
Url&& 
.&& 

IsLocalUrl&& $
(&&$ %
	returnUrl&&% .
)&&. /
?&&0 1
	returnUrl&&2 ;
:&&< =
null&&> B
;&&B C
ViewData'' 
['' 
$str'' 
]'' 
='' 
volverA''  '
;''' (
if(( 

((( 
!(( 

ModelState(( 
.(( 
IsValid(( 
)((  
return((! '
View((( ,
(((, -
dto((- 0
)((0 1
;((1 2
var** 
(** 
usuario** 
,** 
error** 
)** 
=** 
await** $
auth**% )
.**) *
IniciarSesionAsync*** <
(**< =
dto**= @
)**@ A
;**A B
if++ 

(++ 
usuario++ 
is++ 
null++ 
)++ 
{,, 	

ModelState-- 
.-- 
AddModelError-- $
(--$ %
$str--% '
,--' (
error--) .
!--. /
)--/ 0
;--0 1
return.. 
View.. 
(.. 
dto.. 
).. 
;.. 
}// 	
var11 
claims11 
=11 
new11 
List11 
<11 
Claim11 #
>11# $
{22 	
new33 
(33 

ClaimTypes33 
.33 
NameIdentifier33 )
,33) *
usuario33+ 2
.332 3
Id333 5
.335 6
ToString336 >
(33> ?
)33? @
)33@ A
,33A B
new44 
(44 

ClaimTypes44 
.44 
Email44  
,44  !
usuario44" )
.44) *
Correo44* 0
)440 1
,441 2
new55 
(55 

ClaimTypes55 
.55 
Role55 
,55  
usuario55! (
.55( )
Rol55) ,
.55, -
ToString55- 5
(555 6
)556 7
)557 8
}66 	
;66	 

var77 
identity77 
=77 
new77 
ClaimsIdentity77 )
(77) *
claims77* 0
,770 1(
CookieAuthenticationDefaults772 N
.77N O 
AuthenticationScheme77O c
)77c d
;77d e
var;; 
propiedades;; 
=;; 
new;; $
AuthenticationProperties;; 6
{;;7 8
IsPersistent;;9 E
=;;F G
false;;H M
};;N O
;;;O P
await<< 
HttpContext<< 
.<< 
SignInAsync<< %
(<<% &(
CookieAuthenticationDefaults<<& B
.<<B C 
AuthenticationScheme<<C W
,<<W X
new== 
ClaimsPrincipal== 
(==  
identity==  (
)==( )
,==) *
propiedades==+ 6
)==6 7
;==7 8
if@@ 

(@@ 
volverA@@ 
is@@ 
not@@ 
null@@ 
)@@  
return@@! '
LocalRedirect@@( 5
(@@5 6
volverA@@6 =
)@@= >
;@@> ?
returnCC 
RedirectToActionCC 
(CC  
$strCC  '
,CC' (
$strCC) /
)CC/ 0
;CC0 1
}DD 
[GG 
HttpPostGG 
,GG $
ValidateAntiForgeryTokenGG '
]GG' (
publicHH 

asyncHH 
TaskHH 
<HH 
IActionResultHH #
>HH# $
LogoutHH% +
(HH+ ,
)HH, -
{II 
tryJJ 
{KK 	
awaitLL 
HttpContextLL 
.LL 
SignOutAsyncLL *
(LL* +(
CookieAuthenticationDefaultsLL+ G
.LLG H 
AuthenticationSchemeLLH \
)LL\ ]
;LL] ^
}MM 	
catchNN 
(NN 
	ExceptionNN 
)NN 
{OO 	
TempDataQQ 
[QQ 
$strQQ 
]QQ 
=QQ 
$strQQ  U
;QQU V
returnRR 
RedirectToActionRR #
(RR# $
$strRR$ +
,RR+ ,
$strRR- 3
)RR3 4
;RR4 5
}SS 	
TempDataVV 
[VV 
$strVV 
]VV 
=VV 
$strVV F
;VVF G
returnWW 
RedirectToActionWW 
(WW  
$strWW  '
,WW' (
$strWW) /
)WW/ 0
;WW0 1
}XX 
[[[ 
HttpGet[[ 
][[ 
public\\ 

IActionResult\\ 
RecuperarContrasena\\ ,
(\\, -
)\\- .
{]] 
if^^ 

(^^ 
User^^ 
.^^ 
Identity^^ 
?^^ 
.^^ 
IsAuthenticated^^ *
==^^+ -
true^^. 2
)^^2 3
return^^4 :
RedirectToAction^^; K
(^^K L
$str^^L S
,^^S T
$str^^U [
)^^[ \
;^^\ ]
return__ 
View__ 
(__ 
new__ 
RecuperarDto__ $
(__$ %
)__% &
)__& '
;__' (
}`` 
[bb 
HttpPostbb 
,bb $
ValidateAntiForgeryTokenbb '
]bb' (
publiccc 

asynccc 
Taskcc 
<cc 
IActionResultcc #
>cc# $
RecuperarContrasenacc% 8
(cc8 9
RecuperarDtocc9 E
dtoccF I
)ccI J
{dd 
ifee 

(ee 
!ee 

ModelStateee 
.ee 
IsValidee 
)ee  
returnee! '
Viewee( ,
(ee, -
dtoee- 0
)ee0 1
;ee1 2
vargg 
	resultadogg 
=gg 
awaitgg 
recuperaciongg *
.gg* +
SolicitarAsyncgg+ 9
(gg9 :
dtogg: =
.gg= >
Correogg> D
,ggD E
tokenhh 
=>hh 
Urlhh 
.hh 
Actionhh 
(hh  
nameofhh  &
(hh& '!
RestablecerContrasenahh' <
)hh< =
,hh= >
$strhh? H
,hhH I
newhhJ M
{hhN O
tokenhhP U
}hhV W
,hhW X
RequesthhY `
.hh` a
Schemehha g
)hhg h
!hhh i
)hhi j
;hhj k
ifjj 

(jj 
	resultadojj 
==jj 
ResultadoSolicitudjj +
.jj+ ,
LimiteSuperadojj, :
)jj: ;
{kk 	

ModelStatell 
.ll 
AddModelErrorll $
(ll$ %
$strll% '
,ll' (
$strll) n
)lln o
;llo p
returnmm 
Viewmm 
(mm 
dtomm 
)mm 
;mm 
}nn 	
TempDatapp 
[pp 
$strpp 
]pp 
=pp 
$strpp o
;ppo p
returnqq 
RedirectToActionqq 
(qq  
nameofqq  &
(qq& '
Loginqq' ,
)qq, -
)qq- .
;qq. /
}rr 
[tt 
HttpGettt 
]tt 
publicuu 

asyncuu 
Taskuu 
<uu 
IActionResultuu #
>uu# $!
RestablecerContrasenauu% :
(uu: ;
stringuu; A
tokenuuB G
)uuG H
{vv 
ifww 

(ww 
!ww 
awaitww 
recuperacionww 
.ww  
TokenVigenteAsyncww  1
(ww1 2
tokenww2 7
)ww7 8
)ww8 9
returnww: @
ViewwwA E
(wwE F
$strwwF U
)wwU V
;wwV W
returnxx 
Viewxx 
(xx 
newxx 
RestablecerDtoxx &
{xx' (
Tokenxx) .
=xx/ 0
tokenxx1 6
}xx7 8
)xx8 9
;xx9 :
}yy 
[{{ 
HttpPost{{ 
,{{ $
ValidateAntiForgeryToken{{ '
]{{' (
public|| 

async|| 
Task|| 
<|| 
IActionResult|| #
>||# $!
RestablecerContrasena||% :
(||: ;
RestablecerDto||; I
dto||J M
)||M N
{}} 
var~~ 
(~~ 
ok~~ 
,~~ 
error~~ 
)~~ 
=~~ 
await~~ 
recuperacion~~  ,
.~~, -
RestablecerAsync~~- =
(~~= >
dto~~> A
.~~A B
Token~~B G
,~~G H
dto~~I L
.~~L M
NuevaPassword~~M Z
,~~Z [
dto~~\ _
.~~_ `
ConfirmarPassword~~` q
)~~q r
;~~r s
if
ÄÄ 

(
ÄÄ 
ok
ÄÄ 
)
ÄÄ 
{
ÅÅ 	
TempData
ÇÇ 
[
ÇÇ 
$str
ÇÇ 
]
ÇÇ 
=
ÇÇ  !
$str
ÇÇ" S
;
ÇÇS T
return
ÉÉ 
RedirectToAction
ÉÉ #
(
ÉÉ# $
nameof
ÉÉ$ *
(
ÉÉ* +
Login
ÉÉ+ 0
)
ÉÉ0 1
)
ÉÉ1 2
;
ÉÉ2 3
}
ÑÑ 	
if
ÜÜ 

(
ÜÜ 
error
ÜÜ 
==
ÜÜ !
RecuperacionService
ÜÜ (
.
ÜÜ( )"
MensajeTokenInvalido
ÜÜ) =
)
ÜÜ= >
return
ÜÜ? E
View
ÜÜF J
(
ÜÜJ K
$str
ÜÜK Z
)
ÜÜZ [
;
ÜÜ[ \

ModelState
àà 
.
àà 
AddModelError
àà  
(
àà  !
$str
àà! #
,
àà# $
error
àà% *
!
àà* +
)
àà+ ,
;
àà, -
return
ââ 
View
ââ 
(
ââ 
dto
ââ 
)
ââ 
;
ââ 
}
ää 
[
çç 
HttpGet
çç 
]
çç 
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
éé# $
ActivarCuenta
éé% 2
(
éé2 3
string
éé3 9
?
éé9 :
token
éé; @
)
éé@ A
{
èè 
var
êê 
info
êê 
=
êê 
await
êê 

activacion
êê #
.
êê# $
ConsultarAsync
êê$ 2
(
êê2 3
token
êê3 8
)
êê8 9
;
êê9 :
if
ëë 

(
ëë 
info
ëë 
.
ëë 
Estado
ëë 
!=
ëë $
EstadoEnlaceActivacion
ëë 1
.
ëë1 2
Valido
ëë2 8
)
ëë8 9
return
ëë: @
View
ëëA E
(
ëëE F
$str
ëëF `
,
ëë` a
info
ëëb f
)
ëëf g
;
ëëg h
return
ìì 
View
ìì 
(
ìì 
ConDatos
ìì 
(
ìì 
new
ìì  
ActivarCuentaDto
ìì! 1
{
ìì2 3
Token
ìì4 9
=
ìì: ;
token
ìì< A
!
ììA B
}
ììC D
,
ììD E
info
ììF J
)
ììJ K
)
ììK L
;
ììL M
}
îî 
[
ññ 
HttpPost
ññ 
,
ññ &
ValidateAntiForgeryToken
ññ '
]
ññ' (
public
óó 

async
óó 
Task
óó 
<
óó 
IActionResult
óó #
>
óó# $
ActivarCuenta
óó% 2
(
óó2 3
ActivarCuentaDto
óó3 C
dto
óóD G
)
óóG H
{
òò 
if
ôô 

(
ôô 
!
ôô 

ModelState
ôô 
.
ôô 
IsValid
ôô 
)
ôô  
{
öö 	
var
õõ 
datos
õõ 
=
õõ 
await
õõ 

activacion
õõ (
.
õõ( )
ConsultarAsync
õõ) 7
(
õõ7 8
dto
õõ8 ;
.
õõ; <
Token
õõ< A
)
õõA B
;
õõB C
if
úú 
(
úú 
datos
úú 
.
úú 
Estado
úú 
!=
úú $
EstadoEnlaceActivacion
úú  6
.
úú6 7
Valido
úú7 =
)
úú= >
return
úú? E
View
úúF J
(
úúJ K
$str
úúK e
,
úúe f
datos
úúg l
)
úúl m
;
úúm n
return
ùù 
View
ùù 
(
ùù 
ConDatos
ùù  
(
ùù  !
dto
ùù! $
,
ùù$ %
datos
ùù& +
)
ùù+ ,
)
ùù, -
;
ùù- .
}
ûû 	
var
†† 
(
†† 
ok
†† 
,
†† 
error
†† 
,
†† 
info
†† 
)
†† 
=
†† 
await
††  %

activacion
††& 0
.
††0 1
ActivarAsync
††1 =
(
††= >
dto
††> A
.
††A B
Token
††B G
,
††G H
dto
††I L
.
††L M
NuevaPassword
††M Z
,
††Z [
dto
††\ _
.
††_ `
ConfirmarPassword
††` q
,
††q r
UrlLogin
††s {
)
††{ |
;
††| }
if
¢¢ 

(
¢¢ 
ok
¢¢ 
)
¢¢ 
{
££ 	
var
§§ 
perfil
§§ 
=
§§ 
info
§§ 
.
§§ 
Rol
§§ !
??
§§" $

RolUsuario
§§% /
.
§§/ 0

Repartidor
§§0 :
;
§§: ;
var
•• 
nombrePerfil
•• 
=
•• 
perfil
•• %
==
••& (

RolUsuario
••) 3
.
••3 4
Administrador
••4 A
?
••B C
$str
••D S
:
••T U
$str
••V b
;
••b c
TempData
¶¶ 
[
¶¶ 
$str
¶¶ 
]
¶¶ 
=
¶¶  !
$"
¶¶" $
$str
¶¶$ [
{
¶¶[ \
nombrePerfil
¶¶\ h
}
¶¶h i
$str
¶¶i j
"
¶¶j k
;
¶¶k l
TempData
ßß 
[
ßß 
$str
ßß $
]
ßß$ %
=
ßß& '
info
ßß( ,
.
ßß, -
Correo
ßß- 3
;
ßß3 4
return
®® 
RedirectToAction
®® #
(
®®# $
nameof
®®$ *
(
®®* +
Login
®®+ 0
)
®®0 1
,
®®1 2
new
®®3 6
{
®®7 8
rol
®®9 <
=
®®= >
perfil
®®? E
.
®®E F
ToString
®®F N
(
®®N O
)
®®O P
}
®®Q R
)
®®R S
;
®®S T
}
©© 	
if
´´ 

(
´´ 
info
´´ 
.
´´ 
Estado
´´ 
!=
´´ $
EstadoEnlaceActivacion
´´ 1
.
´´1 2
Valido
´´2 8
)
´´8 9
return
´´: @
View
´´A E
(
´´E F
$str
´´F `
,
´´` a
info
´´b f
)
´´f g
;
´´g h

ModelState
≠≠ 
.
≠≠ 
AddModelError
≠≠  
(
≠≠  !
$str
≠≠! #
,
≠≠# $
error
≠≠% *
!
≠≠* +
)
≠≠+ ,
;
≠≠, -
return
ÆÆ 
View
ÆÆ 
(
ÆÆ 
ConDatos
ÆÆ 
(
ÆÆ 
dto
ÆÆ  
,
ÆÆ  !
info
ÆÆ" &
)
ÆÆ& '
)
ÆÆ' (
;
ÆÆ( )
}
ØØ 
private
±± 
static
±± 
ActivarCuentaDto
±± #
ConDatos
±±$ ,
(
±±, -
ActivarCuentaDto
±±- =
dto
±±> A
,
±±A B
InfoActivacion
±±C Q
info
±±R V
)
±±V W
{
≤≤ 
dto
≥≥ 
.
≥≥ 
Nombre
≥≥ 
=
≥≥ 
info
≥≥ 
.
≥≥ 
Nombre
≥≥  
;
≥≥  !
dto
¥¥ 
.
¥¥ 
Correo
¥¥ 
=
¥¥ 
info
¥¥ 
.
¥¥ 
Correo
¥¥  
;
¥¥  !
dto
µµ 
.
µµ 
Negocio
µµ 
=
µµ 
info
µµ 
.
µµ 
Negocio
µµ "
;
µµ" #
dto
∂∂ 
.
∂∂ 
Rol
∂∂ 
=
∂∂ 
info
∂∂ 
.
∂∂ 
Rol
∂∂ 
??
∂∂ 

RolUsuario
∂∂ (
.
∂∂( )

Repartidor
∂∂) 3
;
∂∂3 4
return
∑∑ 
dto
∑∑ 
;
∑∑ 
}
∏∏ 
private
ªª 
string
ªª 
UrlLogin
ªª 
(
ªª 

RolUsuario
ªª &
rol
ªª' *
)
ªª* +
=>
ªª, .
Url
ºº 
.
ºº 
Action
ºº 
(
ºº 
nameof
ºº 
(
ºº 
Login
ºº 
)
ºº  
,
ºº  !
$str
ºº" +
,
ºº+ ,
new
ºº- 0
{
ºº1 2
rol
ºº3 6
=
ºº7 8
rol
ºº9 <
.
ºº< =
ToString
ºº= E
(
ººE F
)
ººF G
}
ººH I
,
ººI J
Request
ººK R
.
ººR S
Scheme
ººS Y
)
ººY Z
!
ººZ [
;
ºº[ \
}ΩΩ ∑k
\C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Controllers\ReporteController.cs
[ 
	Authorize 

(
 
Roles 
= 
$str 
) 
] 
public 
class 
ReporteController 
( 
IReporteService 
reportes 
, 
IExportadorReportes		 

exportador		 "
,		" #
ILogger

 
<

 
ReporteController

 
>

 
logger

 %
)

% &
:

' (

Controller

) 3
{ 
private 
const 
string 
	MimeExcel "
=# $
$str% h
;h i
private 
const 
string 
MimePdf  
=! "
$str# 4
;4 5
private 
const 
string 
MimeCsv  
=! "
$str# -
;- .
private 
const 
string 

SinPedidos #
=$ %
$str& h
;h i
private 
int 
	UsuarioId 
=> 
int  
.  !
Parse! &
(& '
User' +
.+ ,
FindFirstValue, :
(: ;

ClaimTypes; E
.E F
NameIdentifierF T
)T U
!U V
)V W
;W X
private 
static 
string 
Dia 
( 
DateTime &
?& '
d( )
)) *
=>+ -
d. /
!/ 0
.0 1
Value1 6
.6 7
ToString7 ?
(? @
$str@ L
)L M
;M N
[ 
HttpGet 
] 
public 

async 
Task 
< 
IActionResult #
># $
Index% *
(* +
DateTime+ 3
?3 4
desde5 :
,: ;
DateTime< D
?D E
hastaF K
)K L
{ 
var 
hoy 
= 
DateTime 
. 
Today  
;  !
var 
vista 
= 
new 
ReporteNegocioVista +
{ 	
Desde 
= 
desde 
? 
. 
Date 
??  "
new# &
DateTime' /
(/ 0
hoy0 3
.3 4
Year4 8
,8 9
hoy: =
.= >
Month> C
,C D
$numE F
)F G
,G H
Hasta 
= 
hasta 
? 
. 
Date 
??  "
hoy# &
} 	
;	 

if!! 

(!! 
desde!! 
is!! 
null!! 
&&!! 
hasta!! "
is!!# %
null!!& *
)!!* +
return!!, 2
View!!3 7
(!!7 8
vista!!8 =
)!!= >
;!!> ?
vista$$ 
.$$ 
Error$$ 
=$$ 
RangoReporte$$ "
.$$" #
Validar$$# *
($$* +
desde$$+ 0
,$$0 1
hasta$$2 7
)$$7 8
;$$8 9
if%% 

(%% 
vista%% 
.%% 
Error%% 
is%% 
not%% 
null%% #
)%%# $
return%%% +
View%%, 0
(%%0 1
vista%%1 6
)%%6 7
;%%7 8
try'' 
{(( 	
var)) 
reporte)) 
=)) 
await)) 
reportes))  (
.))( )&
GenerarReporteNegocioAsync))) C
())C D
	UsuarioId))D M
,))M N
desde))O T
!))T U
.))U V
Value))V [
,))[ \
hasta))] b
!))b c
.))c d
Value))d i
)))i j
;))j k
if** 
(** 
reporte** 
is** 
null** 
)**  
vista++ 
.++ 
Error++ 
=++ 
$str++ E
;++E F
else,, 
if,, 
(,, 
reporte,, 
.,, 
TotalPedidos,, )
==,,* ,
$num,,- .
),,. /
vista-- 
.-- 
Aviso-- 
=-- 

SinPedidos-- (
;--( )
else.. 
vista// 
.// 
Reporte// 
=// 
reporte//  '
;//' (
}00 	
catch11 
(11 
	Exception11 
ex11 
)11 
{22 	
logger33 
.33 
LogError33 
(33 
ex33 
,33 
$str33  `
,33` a
	UsuarioId33b k
)33k l
;33l m
vista44 
.44 
Error44 
=44 
$str44 Q
;44Q R
}55 	
return77 
View77 
(77 
vista77 
)77 
;77 
}88 
[;; 
HttpGet;; 
];; 
public<< 

async<< 
Task<< 
<<< 
IActionResult<< #
><<# $
	Descargar<<% .
(<<. /
DateTime<</ 7
?<<7 8
desde<<9 >
,<<> ?
DateTime<<@ H
?<<H I
hasta<<J O
,<<O P
string<<Q W
formato<<X _
=<<` a
$str<<b i
)<<i j
{== 
var>> 
error>> 
=>> 
RangoReporte>>  
.>>  !
Validar>>! (
(>>( )
desde>>) .
,>>. /
hasta>>0 5
)>>5 6
;>>6 7
if?? 

(?? 
error?? 
is?? 
not?? 
null?? 
)?? 
{@@ 	
TempDataAA 
[AA 
$strAA 
]AA 
=AA 
errorAA  %
;AA% &
returnBB 
RedirectToActionBB #
(BB# $
nameofBB$ *
(BB* +
IndexBB+ 0
)BB0 1
)BB1 2
;BB2 3
}CC 	
tryEE 
{FF 	
varGG 
reporteGG 
=GG 
awaitGG 
reportesGG  (
.GG( )&
GenerarReporteNegocioAsyncGG) C
(GGC D
	UsuarioIdGGD M
,GGM N
desdeGGO T
!GGT U
.GGU V
ValueGGV [
,GG[ \
hastaGG] b
!GGb c
.GGc d
ValueGGd i
)GGi j
;GGj k
ifHH 
(HH 
reporteHH 
isHH 
nullHH 
||HH  "
reporteHH# *
.HH* +
TotalPedidosHH+ 7
==HH8 :
$numHH; <
)HH< =
{II 
TempDataJJ 
[JJ 
$strJJ  
]JJ  !
=JJ" #

SinPedidosJJ$ .
;JJ. /
returnKK 
RedirectToActionKK '
(KK' (
nameofKK( .
(KK. /
IndexKK/ 4
)KK4 5
,KK5 6
newKK7 :
{KK; <
desdeKK= B
=KKC D
DiaKKE H
(KKH I
desdeKKI N
)KKN O
,KKO P
hastaKKQ V
=KKW X
DiaKKY \
(KK\ ]
hastaKK] b
)KKb c
}KKd e
)KKe f
;KKf g
}LL 
varNN 
nombreNN 
=NN 
$"NN 
$strNN +
{NN+ ,
desdeNN, 1
.NN1 2
ValueNN2 7
:NN7 8
$strNN8 @
}NN@ A
$strNNA B
{NNB C
hastaNNC H
.NNH I
ValueNNI N
:NNN O
$strNNO W
}NNW X
"NNX Y
;NNY Z
returnOO 
formatoOO 
.OO 
EqualsOO !
(OO! "
$strOO" '
,OO' (
StringComparisonOO) 9
.OO9 :
OrdinalIgnoreCaseOO: K
)OOK L
?PP 
FilePP 
(PP 

exportadorPP !
.PP! "
ReporteNegocioPdfPP" 3
(PP3 4
reportePP4 ;
)PP; <
,PP< =
MimePdfPP> E
,PPE F
nombrePPG M
+PPN O
$strPPP V
)PPV W
:QQ 
FileQQ 
(QQ 

exportadorQQ !
.QQ! "
ReporteNegocioExcelQQ" 5
(QQ5 6
reporteQQ6 =
)QQ= >
,QQ> ?
	MimeExcelQQ@ I
,QQI J
nombreQQK Q
+QQR S
$strQQT [
)QQ[ \
;QQ\ ]
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
$strUU  a
,UUa b
	UsuarioIdUUc l
)UUl m
;UUm n
TempDataVV 
[VV 
$strVV 
]VV 
=VV 
$strVV  W
;VVW X
returnWW 
RedirectToActionWW #
(WW# $
nameofWW$ *
(WW* +
IndexWW+ 0
)WW0 1
,WW1 2
newWW3 6
{WW7 8
desdeWW9 >
=WW? @
DiaWWA D
(WWD E
desdeWWE J
)WWJ K
,WWK L
hastaWWM R
=WWS T
DiaWWU X
(WWX Y
hastaWWY ^
)WW^ _
}WW` a
)WWa b
;WWb c
}XX 	
}YY 
[\\ 
HttpGet\\ 
]\\ 
public]] 

async]] 
Task]] 
<]] 
IActionResult]] #
>]]# $
ExportarHistorial]]% 6
(]]6 7
DateTime]]7 ?
?]]? @
desde]]A F
,]]F G
DateTime]]H P
?]]P Q
hasta]]R W
,]]W X
string]]Y _
formato]]` g
=]]h i
$str]]j q
)]]q r
{^^ 
var`` 
error`` 
=`` 
RangoReporte``  
.``  !
Validar``! (
(``( )
desde``) .
,``. /
hasta``0 5
)``5 6
;``6 7
ifaa 

(aa 
erroraa 
isaa 
notaa 
nullaa 
)aa 
{bb 	
TempDatacc 
[cc 
$strcc 
]cc 
=cc 
errorcc  %
;cc% &
returndd 
RedirectToActiondd #
(dd# $
$strdd$ /
,dd/ 0
$strdd1 9
)dd9 :
;dd: ;
}ee 	
trygg 
{hh 	
varii 
	historialii 
=ii 
awaitii !
reportesii" *
.ii* +!
ObtenerHistorialAsyncii+ @
(ii@ A
	UsuarioIdiiA J
,iiJ K
desdeiiL Q
!iiQ R
.iiR S
ValueiiS X
,iiX Y
hastaiiZ _
!ii_ `
.ii` a
Valueiia f
)iif g
;iig h
ifll 
(ll 
	historialll 
isll 
nullll !
||ll" $
	historialll% .
.ll. /
Filasll/ 4
.ll4 5
Countll5 :
==ll; =
$numll> ?
)ll? @
{mm 
TempDatann 
[nn 
$strnn  
]nn  !
=nn" #
$strnn$ Y
;nnY Z
returnoo 
RedirectToActionoo '
(oo' (
$stroo( 3
,oo3 4
$stroo5 =
)oo= >
;oo> ?
}pp 
varrr 
nombrerr 
=rr 
$"rr 
$strrr -
{rr- .
desderr. 3
.rr3 4
Valuerr4 9
:rr9 :
$strrr: B
}rrB C
$strrrC D
{rrD E
hastarrE J
.rrJ K
ValuerrK P
:rrP Q
$strrrQ Y
}rrY Z
"rrZ [
;rr[ \
returnss 
formatoss 
.ss 
ToLowerInvariantss +
(ss+ ,
)ss, -
switchss. 4
{tt 
$struu 
=>uu 
Fileuu 
(uu 

exportadoruu (
.uu( )
HistorialPdfuu) 5
(uu5 6
	historialuu6 ?
)uu? @
,uu@ A
MimePdfuuB I
,uuI J
nombreuuK Q
+uuR S
$struuT Z
)uuZ [
,uu[ \
$strvv 
=>vv 
Filevv 
(vv 

exportadorvv (
.vv( )
HistorialCsvvv) 5
(vv5 6
	historialvv6 ?
)vv? @
,vv@ A
MimeCsvvvB I
,vvI J
nombrevvK Q
+vvR S
$strvvT Z
)vvZ [
,vv[ \
_ww 
=>ww 
Fileww 
(ww 

exportadorww $
.ww$ %
HistorialExcelww% 3
(ww3 4
	historialww4 =
)ww= >
,ww> ?
	MimeExcelww@ I
,wwI J
nombrewwK Q
+wwR S
$strwwT [
)ww[ \
}xx 
;xx 
}yy 	
catchzz 
(zz 
	Exceptionzz 
exzz 
)zz 
{{{ 	
logger}} 
.}} 
LogError}} 
(}} 
ex}} 
,}} 
$str}}  c
,}}c d
	UsuarioId}}e n
)}}n o
;}}o p
TempData~~ 
[~~ 
$str~~ 
]~~ 
=~~ 
$str~~  W
;~~W X
return 
RedirectToAction #
(# $
$str$ /
,/ 0
$str1 9
)9 :
;: ;
}
ÄÄ 	
}
ÅÅ 
}ÇÇ É‘
_C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Controllers\RepartidorController.cs
[ 
	Authorize 

]
 
public		 
class		  
RepartidorController		 !
(		! "!
IRepartidorRepository

 
repartidorRepo

 (
,

( )
INegocioRepository 
negocioRepo "
," #
IRepartidorService 
repartidorService (
,( )
IWebHostEnvironment 
env 
, 
AppDbContext 
context 
, 
IPedidoService 
pedidos 
, 
IUbicacionService 
ubicacionService &
,& '$
IPerfilRepartidorService 
perfilService *
,* +
ILogger 
<  
RepartidorController  
>  !
logger" (
)( )
:* +

Controller, 6
{ 
private 
int 
	UsuarioId 
=> 
int  
.  !
Parse! &
(& '
User' +
.+ ,
FindFirstValue, :
(: ;

ClaimTypes; E
.E F
NameIdentifierF T
)T U
!U V
)V W
;W X
private 
string 
EnlaceActivacion #
(# $
string$ *
token+ 0
)0 1
=>2 4
Url 
. 
Action 
( 
$str "
," #
$str$ -
,- .
new/ 2
{3 4
token5 :
}; <
,< =
Request> E
.E F
SchemeF L
)L M
!M N
;N O
[ 
HttpGet 
] 
[ 
	Authorize 
( 
Roles 
= 
$str  
)  !
]! "
public 

async 
Task 
< 
IActionResult #
># $
Index% *
(* +
)+ ,
{ 
var 
negocio 
= 
await 
negocioRepo '
.' ($
ObtenerPorUsuarioIdAsync( @
(@ A
	UsuarioIdA J
)J K
;K L
if 

( 
negocio 
== 
null 
) 
return #
View$ (
(( )
new) ,
List- 1
<1 2

Repartidor2 <
>< =
(= >
)> ?
)? @
;@ A
var!! 
repartidores!! 
=!! 
await!!  
repartidorRepo!!! /
.!!/ 0!
ListarPorNegocioAsync!!0 E
(!!E F
negocio!!F M
.!!M N
Id!!N P
)!!P Q
;!!Q R
return"" 
View"" 
("" 
repartidores""  
)""  !
;""! "
}## 
[%% 
HttpGet%% 
]%% 
[&& 
	Authorize&& 
(&& 
Roles&& 
=&& 
$str&&  
)&&  !
]&&! "
public'' 

IActionResult'' 
	Registrar'' "
(''" #
)''# $
{(( 
return)) 
View)) 
()) 
new)) !
RegistroRepartidorDto)) -
())- .
))). /
)))/ 0
;))0 1
}** 
[,, 
HttpPost,, 
,,, $
ValidateAntiForgeryToken,, '
],,' (
[-- 
	Authorize-- 
(-- 
Roles-- 
=-- 
$str--  
)--  !
]--! "
public.. 

async.. 
Task.. 
<.. 
IActionResult.. #
>..# $
	Registrar..% .
(... /!
RegistroRepartidorDto../ D
dto..E H
)..H I
{// 
if00 

(00 
!00 

ModelState00 
.00 
IsValid00 
)00  
{11 	
return22 
View22 
(22 
dto22 
)22 
;22 
}33 	
var66 
	resultado66 
=66 
await66 
repartidorService66 /
.66/ 0
RegistrarAsync660 >
(66> ?
	UsuarioId66? H
,66H I
dto66J M
,66M N
EnlaceActivacion66O _
)66_ `
;66` a
if77 

(77 
!77 
	resultado77 
.77 
Ok77 
)77 
{88 	

ModelState99 
.99 
AddModelError99 $
(99$ %
	resultado99% .
.99. /
Campo99/ 4
??995 7
string998 >
.99> ?
Empty99? D
,99D E
	resultado99F O
.99O P
Error99P U
!99U V
)99V W
;99W X
return:: 
View:: 
(:: 
dto:: 
):: 
;:: 
};; 	
var== 
correo== 
=== 
dto== 
.== 
Correo== 
.==  
Trim==  $
(==$ %
)==% &
;==& '
if>> 

(>> 
	resultado>> 
.>> 
CorreoEnviado>> #
)>># $
TempData?? 
[?? 
$str?? 
]?? 
=??  !
$"??" $
$str??$ T
{??T U
correo??U [
}??[ \
$str	??\ å
"
??å ç
;
??ç é
else@@ 
TempDataAA 
[AA 
$strAA 
]AA 
=AA 
$"AA  "
$strAA" s
{AAs t
correoAAt z
}AAz {
$str	AA{ Æ
"
AAÆ Ø
;
AAØ ∞
returnCC 
RedirectToActionCC 
(CC  
nameofCC  &
(CC& '
IndexCC' ,
)CC, -
)CC- .
;CC. /
}DD 
[FF 
HttpPostFF 
,FF $
ValidateAntiForgeryTokenFF '
]FF' (
[GG 
	AuthorizeGG 
(GG 
RolesGG 
=GG 
$strGG  
)GG  !
]GG! "
publicHH 

asyncHH 
TaskHH 
<HH 
IActionResultHH #
>HH# $
ReenviarActivacionHH% 7
(HH7 8
intHH8 ;
idHH< >
)HH> ?
{II 
varJJ 
(JJ 
okJJ 
,JJ 
mensajeJJ 
)JJ 
=JJ 
awaitJJ !
repartidorServiceJJ" 3
.JJ3 4#
ReenviarActivacionAsyncJJ4 K
(JJK L
	UsuarioIdJJL U
,JJU V
idJJW Y
,JJY Z
EnlaceActivacionJJ[ k
)JJk l
;JJl m
TempDataKK 
[KK 
okKK 
?KK 
$strKK 
:KK  !
$strKK" )
]KK) *
=KK+ ,
mensajeKK- 4
;KK4 5
returnLL 
RedirectToActionLL 
(LL  
nameofLL  &
(LL& '
IndexLL' ,
)LL, -
)LL- .
;LL. /
}MM 
[OO 
HttpPostOO 
,OO $
ValidateAntiForgeryTokenOO '
]OO' (
[PP 
	AuthorizePP 
(PP 
RolesPP 
=PP 
$strPP  
)PP  !
]PP! "
publicQQ 

asyncQQ 
TaskQQ 
<QQ 
IActionResultQQ #
>QQ# $
CambiarEstadoQQ% 2
(QQ2 3
intQQ3 6
idQQ7 9
)QQ9 :
{RR 
varSS 
negocioSS 
=SS 
awaitSS 
negocioRepoSS '
.SS' ($
ObtenerPorUsuarioIdAsyncSS( @
(SS@ A
	UsuarioIdSSA J
)SSJ K
;SSK L
ifTT 

(TT 
negocioTT 
==TT 
nullTT 
)TT 
returnTT #
NotFoundTT$ ,
(TT, -
)TT- .
;TT. /
varVV 

repartidorVV 
=VV 
awaitVV 
contextVV &
.VV& '
SetVV' *
<VV* +

RepartidorVV+ 5
>VV5 6
(VV6 7
)VV7 8
.WW 
IncludeWW 
(WW 
rWW 
=>WW 
rWW 
.WW 
UsuarioWW #
)WW# $
.XX 
FirstOrDefaultAsyncXX  
(XX  !
rXX! "
=>XX# %
rXX& '
.XX' (
IdXX( *
==XX+ -
idXX. 0
&&XX1 3
rXX4 5
.XX5 6
	NegocioIdXX6 ?
==XX@ B
negocioXXC J
.XXJ K
IdXXK M
)XXM N
;XXN O
ifZZ 

(ZZ 

repartidorZZ 
==ZZ 
nullZZ 
||ZZ !

repartidorZZ" ,
.ZZ, -
UsuarioZZ- 4
==ZZ5 7
nullZZ8 <
)ZZ< =
{[[ 	
TempData\\ 
[\\ 
$str\\ 
]\\ 
=\\ 
$str\\  V
;\\V W
return]] 
RedirectToAction]] #
(]]# $
nameof]]$ *
(]]* +
Index]]+ 0
)]]0 1
)]]1 2
;]]2 3
}^^ 	
ifaa 

(aa 

repartidoraa 
.aa 
Usuarioaa 
.aa 
Estadoaa %
==aa& (
EstadoCuentaaa) 5
.aa5 6
PendienteActivacionaa6 I
)aaI J
{bb 	
TempDatacc 
[cc 
$strcc 
]cc 
=cc 
$"cc  "
{cc" #

repartidorcc# -
.cc- .
NombreCompletocc. <
}cc< =
$str	cc= Ü
"
ccÜ á
;
ccá à
returndd 
RedirectToActiondd #
(dd# $
nameofdd$ *
(dd* +
Indexdd+ 0
)dd0 1
)dd1 2
;dd2 3
}ee 	
ifii 

(ii 

repartidorii 
.ii 
Usuarioii 
.ii 
Estadoii %
!=ii& (
EstadoCuentaii) 5
.ii5 6
Activoii6 <
&&ii= ?
stringii@ F
.iiF G
IsNullOrEmptyiiG T
(iiT U

repartidoriiU _
.ii_ `
Usuarioii` g
.iig h
PasswordHashiih t
)iit u
)iiu v
{jj 	

repartidorkk 
.kk 
Usuariokk 
.kk 
Estadokk %
=kk& '
EstadoCuentakk( 4
.kk4 5
PendienteActivacionkk5 H
;kkH I
awaitll 
contextll 
.ll 
SaveChangesAsyncll *
(ll* +
)ll+ ,
;ll, -
varnn 
(nn 
enviadonn 
,nn 
_nn 
)nn 
=nn 
awaitnn $
repartidorServicenn% 6
.nn6 7#
ReenviarActivacionAsyncnn7 N
(nnN O
	UsuarioIdnnO X
,nnX Y

repartidornnZ d
.nnd e
Idnne g
,nng h
EnlaceActivacionnni y
)nny z
;nnz {
ifoo 
(oo 
enviadooo 
)oo 
TempDatapp 
[pp 
$strpp "
]pp" #
=pp$ %
$"pp& (
{pp( )

repartidorpp) 3
.pp3 4
NombreCompletopp4 B
}ppB C
$str	ppC ç
"
ppç é
;
ppé è
elseqq 
TempDatarr 
[rr 
$strrr  
]rr  !
=rr" #
$"rr$ &
{rr& '

repartidorrr' 1
.rr1 2
NombreCompletorr2 @
}rr@ A
$str	rrA °
"
rr° ¢
;
rr¢ £
returnss 
RedirectToActionss #
(ss# $
nameofss$ *
(ss* +
Indexss+ 0
)ss0 1
)ss1 2
;ss2 3
}tt 	

repartidorvv 
.vv 
Usuariovv 
.vv 
Estadovv !
=vv" #

repartidorvv$ .
.vv. /
Usuariovv/ 6
.vv6 7
Estadovv7 =
==vv> @
EstadoCuentavvA M
.vvM N
ActivovvN T
?ww 
EstadoCuentaww 
.ww 

Suspendidoww %
:xx 
EstadoCuentaxx 
.xx 
Activoxx !
;xx! "
contextzz 
.zz 
Entryzz 
(zz 

repartidorzz  
.zz  !
Usuariozz! (
)zz( )
.zz) *
Statezz* /
=zz0 1
EntityStatezz2 =
.zz= >
Modifiedzz> F
;zzF G
await|| 
context|| 
.|| 
SaveChangesAsync|| &
(||& '
)||' (
;||( )
TempData~~ 
[~~ 
$str~~ 
]~~ 
=~~ 
$str~~ [
;~~[ \
return 
RedirectToAction 
(  
nameof  &
(& '
Index' ,
), -
)- .
;. /
}
ÄÄ 
[
ÇÇ 
HttpGet
ÇÇ 
]
ÇÇ 
[
ÉÉ 
	Authorize
ÉÉ 
(
ÉÉ 
Roles
ÉÉ 
=
ÉÉ 
$str
ÉÉ #
)
ÉÉ# $
]
ÉÉ$ %
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
ÑÑ# $

MisPedidos
ÑÑ% /
(
ÑÑ/ 0
)
ÑÑ0 1
{
ÖÖ 
try
ÜÜ 
{
áá 	
var
àà 

repartidor
àà 
=
àà 
await
àà "
context
àà# *
.
àà* +
Repartidores
àà+ 7
.
ââ 
AsNoTracking
ââ 
(
ââ 
)
ââ 
.
ää !
FirstOrDefaultAsync
ää $
(
ää$ %
r
ää% &
=>
ää' )
r
ää* +
.
ää+ ,
	UsuarioId
ää, 5
==
ää6 8
	UsuarioId
ää9 B
)
ääB C
;
ääC D
if
åå 
(
åå 

repartidor
åå 
==
åå 
null
åå "
)
åå" #
{
çç 
TempData
éé 
[
éé 
$str
éé  
]
éé  !
=
éé" #
$str
éé$ \
;
éé\ ]
return
èè 
View
èè 
(
èè 
new
èè 
List
èè  $
<
èè$ %
Pedido
èè% +
>
èè+ ,
(
èè, -
)
èè- .
)
èè. /
;
èè/ 0
}
êê 
var
íí 

misPedidos
íí 
=
íí 
await
íí "
context
íí# *
.
íí* +
Pedidos
íí+ 2
.
ìì 
AsNoTracking
ìì 
(
ìì 
)
ìì 
.
îî 
Include
îî 
(
îî 
p
îî 
=>
îî 
p
îî 
.
îî  
Items
îî  %
)
îî% &
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
ïï  
Cliente
ïï  '
)
ïï' (
.
ññ 
Where
ññ 
(
ññ 
p
ññ 
=>
ññ 
p
ññ 
.
ññ 
RepartidorId
ññ *
==
ññ+ -

repartidor
ññ. 8
.
ññ8 9
Id
ññ9 ;
&&
ññ< >
(
óó 
p
óó 
.
óó 
EstadoPedidoId
óó ,
==
óó- /
(
óó0 1
int
óó1 4
)
óó4 5
EstadoPedido
óó5 A
.
óóA B
Asignado
óóB J
||
óóK M
p
óóN O
.
óóO P
EstadoPedidoId
óóP ^
==
óó_ a
(
óób c
int
óóc f
)
óóf g
EstadoPedido
óóg s
.
óós t
EnCamino
óót |
)
óó| }
)
óó} ~
.
òò 
OrderByDescending
òò "
(
òò" #
p
òò# $
=>
òò% '
p
òò( )
.
òò) *
FechaCreacion
òò* 7
)
òò7 8
.
ôô 
ToListAsync
ôô 
(
ôô 
)
ôô 
;
ôô 
ViewBag
úú 
.
úú 
	Novedades
úú 
=
úú 
await
úú  %
NovedadesDeAsync
úú& 6
(
úú6 7

misPedidos
úú7 A
.
úúA B
Select
úúB H
(
úúH I
p
úúI J
=>
úúK M
p
úúN O
.
úúO P
Id
úúP R
)
úúR S
.
úúS T
ToList
úúT Z
(
úúZ [
)
úú[ \
)
úú\ ]
;
úú] ^
return
ûû 
View
ûû 
(
ûû 

misPedidos
ûû "
)
ûû" #
;
ûû# $
}
üü 	
catch
†† 
(
†† 
	Exception
†† 
ex
†† 
)
†† 
{
°° 	
logger
££ 
.
££ 
LogError
££ 
(
££ 
ex
££ 
,
££ 
$str
££  b
,
££b c
	UsuarioId
££d m
)
££m n
;
££n o
return
§§ 
View
§§ 
(
§§ 
(
§§ 
List
§§ 
<
§§ 
Pedido
§§ $
>
§§$ %
?
§§% &
)
§§& '
null
§§' +
)
§§+ ,
;
§§, -
}
•• 	
}
¶¶ 
[
®® 
HttpPost
®® 
,
®® &
ValidateAntiForgeryToken
®® '
]
®®' (
[
©© 
	Authorize
©© 
(
©© 
Roles
©© 
=
©© 
$str
©© #
)
©©# $
]
©©$ %
public
™™ 

async
™™ 
Task
™™ 
<
™™ 
IActionResult
™™ #
>
™™# $
ActualizarEstado
™™% 5
(
™™5 6
int
™™6 9
id
™™: <
,
™™< =
int
™™> A
nuevoEstadoId
™™B O
)
™™O P
{
´´ 
if
≠≠ 

(
≠≠ 
nuevoEstadoId
≠≠ 
!=
≠≠ 
(
≠≠ 
int
≠≠ !
)
≠≠! "
EstadoPedido
≠≠" .
.
≠≠. /
EnCamino
≠≠/ 7
&&
≠≠8 :
nuevoEstadoId
≠≠; H
!=
≠≠I K
(
≠≠L M
int
≠≠M P
)
≠≠P Q
EstadoPedido
≠≠Q ]
.
≠≠] ^
	Entregado
≠≠^ g
)
≠≠g h
{
ÆÆ 	
TempData
ØØ 
[
ØØ 
$str
ØØ 
]
ØØ 
=
ØØ 
$str
ØØ  G
;
ØØG H
return
∞∞ 
RedirectToAction
∞∞ #
(
∞∞# $
nameof
∞∞$ *
(
∞∞* +

MisPedidos
∞∞+ 5
)
∞∞5 6
)
∞∞6 7
;
∞∞7 8
}
±± 	
try
≥≥ 
{
¥¥ 	
var
µµ 
(
µµ 
ok
µµ 
,
µµ 
error
µµ 
)
µµ 
=
µµ 
await
µµ #
pedidos
µµ$ +
.
µµ+ ,#
ActualizarEstadoAsync
µµ, A
(
µµA B
	UsuarioId
µµB K
,
µµK L
id
µµM O
,
µµO P
nuevoEstadoId
µµQ ^
)
µµ^ _
;
µµ_ `
if
∂∂ 
(
∂∂ 
!
∂∂ 
ok
∂∂ 
)
∂∂ 
{
∑∑ 
TempData
∏∏ 
[
∏∏ 
$str
∏∏  
]
∏∏  !
=
∏∏" #
error
∏∏$ )
??
∏∏* ,
$str
∏∏- T
;
∏∏T U
}
ππ 
else
∫∫ 
{
ªª 
TempData
ºº 
[
ºº 
$str
ºº "
]
ºº" #
=
ºº$ %
nuevoEstadoId
ºº& 3
==
ºº4 6
(
ºº7 8
int
ºº8 ;
)
ºº; <
EstadoPedido
ºº< H
.
ººH I
EnCamino
ººI Q
?
ΩΩ 
$str
ΩΩ I
:
ææ 
$str
ææ 7
;
ææ7 8
}
øø 
}
¿¿ 	
catch
¡¡ 
(
¡¡ 
	Exception
¡¡ 
ex
¡¡ 
)
¡¡ 
{
¬¬ 	
logger
√√ 
.
√√ 
LogError
√√ 
(
√√ 
ex
√√ 
,
√√ 
$str
√√  U
,
√√U V
id
√√W Y
)
√√Y Z
;
√√Z [
TempData
ƒƒ 
[
ƒƒ 
$str
ƒƒ 
]
ƒƒ 
=
ƒƒ 
$str
ƒƒ  e
;
ƒƒe f
}
≈≈ 	
return
«« 
RedirectToAction
«« 
(
««  
nameof
««  &
(
««& '

MisPedidos
««' 1
)
««1 2
)
««2 3
;
««3 4
}
»» 
[
   
HttpPost
   
,
   &
ValidateAntiForgeryToken
   '
]
  ' (
[
ÀÀ 
	Authorize
ÀÀ 
(
ÀÀ 
Roles
ÀÀ 
=
ÀÀ 
$str
ÀÀ #
)
ÀÀ# $
]
ÀÀ$ %
public
ÃÃ 

async
ÃÃ 
Task
ÃÃ 
<
ÃÃ 
IActionResult
ÃÃ #
>
ÃÃ# $
IniciarEntrega
ÃÃ% 3
(
ÃÃ3 4
int
ÃÃ4 7
id
ÃÃ8 :
)
ÃÃ: ;
=>
ÃÃ< >
await
ÕÕ 
ActualizarEstado
ÕÕ 
(
ÕÕ 
id
ÕÕ !
,
ÕÕ! "
(
ÕÕ# $
int
ÕÕ$ '
)
ÕÕ' (
EstadoPedido
ÕÕ( 4
.
ÕÕ4 5
EnCamino
ÕÕ5 =
)
ÕÕ= >
;
ÕÕ> ?
[
œœ 
HttpPost
œœ 
,
œœ &
ValidateAntiForgeryToken
œœ '
]
œœ' (
[
–– 
	Authorize
–– 
(
–– 
Roles
–– 
=
–– 
$str
–– #
)
––# $
]
––$ %
public
—— 

async
—— 
Task
—— 
<
—— 
IActionResult
—— #
>
——# $
MarcarEntregado
——% 4
(
——4 5
int
——5 8
id
——9 ;
)
——; <
=>
——= ?
await
““ 
ActualizarEstado
““ 
(
““ 
id
““ !
,
““! "
(
““# $
int
““$ '
)
““' (
EstadoPedido
““( 4
.
““4 5
	Entregado
““5 >
)
““> ?
;
““? @
[
÷÷ 
HttpPost
÷÷ 
,
÷÷ &
ValidateAntiForgeryToken
÷÷ '
]
÷÷' (
[
◊◊ 
	Authorize
◊◊ 
(
◊◊ 
Roles
◊◊ 
=
◊◊ 
$str
◊◊ #
)
◊◊# $
]
◊◊$ %
public
ÿÿ 

async
ÿÿ 
Task
ÿÿ 
<
ÿÿ 
IActionResult
ÿÿ #
>
ÿÿ# $
ReportarNovedad
ÿÿ% 4
(
ÿÿ4 5
int
ÿÿ5 8
id
ÿÿ9 ;
,
ÿÿ; <
int
ÿÿ= @
?
ÿÿ@ A
tipoNovedadId
ÿÿB O
,
ÿÿO P
string
ÿÿQ W
?
ÿÿW X
observaciones
ÿÿY f
)
ÿÿf g
{
ŸŸ 
var
⁄⁄ 
(
⁄⁄ 
ok
⁄⁄ 
,
⁄⁄ 
error
⁄⁄ 
)
⁄⁄ 
=
⁄⁄ 
await
⁄⁄ 
pedidos
⁄⁄  '
.
⁄⁄' (#
RegistrarNovedadAsync
⁄⁄( =
(
⁄⁄= >
	UsuarioId
⁄⁄> G
,
⁄⁄G H
id
⁄⁄I K
,
⁄⁄K L
tipoNovedadId
⁄⁄M Z
,
⁄⁄Z [
observaciones
⁄⁄\ i
)
⁄⁄i j
;
⁄⁄j k
if
€€ 

(
€€ 
ok
€€ 
)
€€ 
TempData
‹‹ 
[
‹‹ 
$str
‹‹ 
]
‹‹ 
=
‹‹  !
$str
‹‹" C
;
‹‹C D
else
›› 
TempData
ﬁﬁ 
[
ﬁﬁ 
$str
ﬁﬁ 
]
ﬁﬁ 
=
ﬁﬁ 
error
ﬁﬁ  %
??
ﬁﬁ& (
$str
ﬁﬁ) b
;
ﬁﬁb c
return
‡‡ 
RedirectToAction
‡‡ 
(
‡‡  
nameof
‡‡  &
(
‡‡& '

MisPedidos
‡‡' 1
)
‡‡1 2
)
‡‡2 3
;
‡‡3 4
}
·· 
private
‰‰ 
async
‰‰ 
Task
‰‰ 
<
‰‰ 
ILookup
‰‰ 
<
‰‰ 
int
‰‰ "
,
‰‰" #
NovedadPedido
‰‰$ 1
>
‰‰1 2
>
‰‰2 3
NovedadesDeAsync
‰‰4 D
(
‰‰D E
List
‰‰E I
<
‰‰I J
int
‰‰J M
>
‰‰M N
	pedidoIds
‰‰O X
)
‰‰X Y
{
ÂÂ 
try
ÊÊ 
{
ÁÁ 	
var
ËË 
	novedades
ËË 
=
ËË 
await
ËË !
context
ËË" )
.
ËË) *
NovedadesPedido
ËË* 9
.
ÈÈ 
AsNoTracking
ÈÈ 
(
ÈÈ 
)
ÈÈ 
.
ÍÍ 
Where
ÍÍ 
(
ÍÍ 
n
ÍÍ 
=>
ÍÍ 
	pedidoIds
ÍÍ %
.
ÍÍ% &
Contains
ÍÍ& .
(
ÍÍ. /
n
ÍÍ/ 0
.
ÍÍ0 1
PedidoId
ÍÍ1 9
)
ÍÍ9 :
)
ÍÍ: ;
.
ÎÎ 
OrderBy
ÎÎ 
(
ÎÎ 
n
ÎÎ 
=>
ÎÎ 
n
ÎÎ 
.
ÎÎ  
Fecha
ÎÎ  %
)
ÎÎ% &
.
ÏÏ 
ToListAsync
ÏÏ 
(
ÏÏ 
)
ÏÏ 
;
ÏÏ 
return
ÌÌ 
	novedades
ÌÌ 
.
ÌÌ 
ToLookup
ÌÌ %
(
ÌÌ% &
n
ÌÌ& '
=>
ÌÌ( *
n
ÌÌ+ ,
.
ÌÌ, -
PedidoId
ÌÌ- 5
)
ÌÌ5 6
;
ÌÌ6 7
}
ÓÓ 	
catch
ÔÔ 
(
ÔÔ 
	Exception
ÔÔ 
ex
ÔÔ 
)
ÔÔ 
{
 	
logger
ÒÒ 
.
ÒÒ 

LogWarning
ÒÒ 
(
ÒÒ 
ex
ÒÒ  
,
ÒÒ  !
$str
ÒÒ" {
,
ÒÒ{ |
	UsuarioIdÒÒ} Ü
)ÒÒÜ á
;ÒÒá à
return
ÚÚ 

Enumerable
ÚÚ 
.
ÚÚ 
Empty
ÚÚ #
<
ÚÚ# $
NovedadPedido
ÚÚ$ 1
>
ÚÚ1 2
(
ÚÚ2 3
)
ÚÚ3 4
.
ÚÚ4 5
ToLookup
ÚÚ5 =
(
ÚÚ= >
n
ÚÚ> ?
=>
ÚÚ@ B
n
ÚÚC D
.
ÚÚD E
PedidoId
ÚÚE M
)
ÚÚM N
;
ÚÚN O
}
ÛÛ 	
}
ÙÙ 
[
ˆˆ 
HttpPost
ˆˆ 
,
ˆˆ &
ValidateAntiForgeryToken
ˆˆ '
]
ˆˆ' (
[
˜˜ 
	Authorize
˜˜ 
(
˜˜ 
Roles
˜˜ 
=
˜˜ 
$str
˜˜ #
)
˜˜# $
]
˜˜$ %
public
¯¯ 

async
¯¯ 
Task
¯¯ 
<
¯¯ 
IActionResult
¯¯ #
>
¯¯# $!
ActualizarUbicacion
¯¯% 8
(
¯¯8 9
int
¯¯9 <
pedidoId
¯¯= E
,
¯¯E F
decimal
¯¯G N
lat
¯¯O R
,
¯¯R S
decimal
¯¯T [
lng
¯¯\ _
)
¯¯_ `
{
˘˘ 
var
˙˙ 
(
˙˙ 
ok
˙˙ 
,
˙˙ 
error
˙˙ 
)
˙˙ 
=
˙˙ 
await
˙˙ 
ubicacionService
˙˙  0
.
˙˙0 1
ActualizarAsync
˙˙1 @
(
˙˙@ A
	UsuarioId
˙˙A J
,
˙˙J K
pedidoId
˙˙L T
,
˙˙T U
lat
˙˙V Y
,
˙˙Y Z
lng
˙˙[ ^
)
˙˙^ _
;
˙˙_ `
return
˚˚ 
Json
˚˚ 
(
˚˚ 
new
˚˚ 
{
˚˚ 
ok
˚˚ 
,
˚˚ 
error
˚˚ #
}
˚˚$ %
)
˚˚% &
;
˚˚& '
}
¸¸ 
[
ÅÅ 
HttpGet
ÅÅ 
]
ÅÅ 
[
ÇÇ 
	Authorize
ÇÇ 
(
ÇÇ 
Roles
ÇÇ 
=
ÇÇ 
$str
ÇÇ #
)
ÇÇ# $
]
ÇÇ$ %
public
ÉÉ 

async
ÉÉ 
Task
ÉÉ 
<
ÉÉ 
IActionResult
ÉÉ #
>
ÉÉ# $
Perfil
ÉÉ% +
(
ÉÉ+ ,
)
ÉÉ, -
{
ÑÑ 
var
ÖÖ 
perfil
ÖÖ 
=
ÖÖ 
await
ÖÖ 
perfilService
ÖÖ (
.
ÖÖ( ) 
ObtenerPerfilAsync
ÖÖ) ;
(
ÖÖ; <
	UsuarioId
ÖÖ< E
)
ÖÖE F
;
ÖÖF G
if
ÜÜ 

(
ÜÜ 
perfil
ÜÜ 
is
ÜÜ 
null
ÜÜ 
)
ÜÜ 
return
ÜÜ "
NotFound
ÜÜ# +
(
ÜÜ+ ,
)
ÜÜ, -
;
ÜÜ- .
return
áá 
View
áá 
(
áá 
perfil
áá 
)
áá 
;
áá 
}
àà 
[
åå 
HttpPost
åå 
,
åå &
ValidateAntiForgeryToken
åå '
]
åå' (
[
çç 
	Authorize
çç 
(
çç 
Roles
çç 
=
çç 
$str
çç #
)
çç# $
]
çç$ %
public
éé 

async
éé 
Task
éé 
<
éé 
IActionResult
éé #
>
éé# $
EnviarCodigo
éé% 1
(
éé1 2
)
éé2 3
{
èè 
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
êê 
perfilService
êê  -
.
êê- ."
SolicitarCodigoAsync
êê. B
(
êêB C
	UsuarioId
êêC L
)
êêL M
;
êêM N
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
ëë 
{
íí 	
TempData
ìì 
[
ìì 
$str
ìì 
]
ìì 
=
ìì 
error
ìì  %
;
ìì% &
return
ïï 
error
ïï 
==
ïï %
PerfilRepartidorService
ïï 3
.
ïï3 4
MensajeConPedidos
ïï4 E
?
ññ 
RedirectToAction
ññ "
(
ññ" #
$str
ññ# *
,
ññ* +
$str
ññ, 2
)
ññ2 3
:
óó 
RedirectToAction
óó "
(
óó" #
nameof
óó# )
(
óó) *
Perfil
óó* 0
)
óó0 1
)
óó1 2
;
óó2 3
}
òò 	
TempData
öö 
[
öö 
$str
öö 
]
öö 
=
öö 
$str
öö Q
;
ööQ R
return
õõ 
RedirectToAction
õõ 
(
õõ  
nameof
õõ  &
(
õõ& '
VerificarCodigo
õõ' 6
)
õõ6 7
)
õõ7 8
;
õõ8 9
}
úú 
[
ûû 
HttpGet
ûû 
]
ûû 
[
üü 
	Authorize
üü 
(
üü 
Roles
üü 
=
üü 
$str
üü #
)
üü# $
]
üü$ %
public
†† 

IActionResult
†† 
VerificarCodigo
†† (
(
††( )
)
††) *
=>
††+ -
View
††. 2
(
††2 3
new
††3 6 
VerificarCodigoDto
††7 I
(
††I J
)
††J K
)
††K L
;
††L M
[
££ 
HttpPost
££ 
,
££ &
ValidateAntiForgeryToken
££ '
]
££' (
[
§§ 
	Authorize
§§ 
(
§§ 
Roles
§§ 
=
§§ 
$str
§§ #
)
§§# $
]
§§$ %
public
•• 

async
•• 
Task
•• 
<
•• 
IActionResult
•• #
>
••# $
VerificarCodigo
••% 4
(
••4 5 
VerificarCodigoDto
••5 G
dto
••H K
)
••K L
{
¶¶ 
if
ßß 

(
ßß 
!
ßß 

ModelState
ßß 
.
ßß 
IsValid
ßß 
)
ßß  
return
ßß! '
View
ßß( ,
(
ßß, -
dto
ßß- 0
)
ßß0 1
;
ßß1 2
var
©© 
(
©© 
ok
©© 
,
©© 
error
©© 
)
©© 
=
©© 
await
©© 
perfilService
©©  -
.
©©- ."
VerificarCodigoAsync
©©. B
(
©©B C
	UsuarioId
©©C L
,
©©L M
dto
©©N Q
.
©©Q R
Codigo
©©R X
)
©©X Y
;
©©Y Z
if
™™ 

(
™™ 
!
™™ 
ok
™™ 
)
™™ 
{
´´ 	

ModelState
¨¨ 
.
¨¨ 
AddModelError
¨¨ $
(
¨¨$ %
$str
¨¨% '
,
¨¨' (
error
¨¨) .
!
¨¨. /
)
¨¨/ 0
;
¨¨0 1
return
≠≠ 
View
≠≠ 
(
≠≠ 
dto
≠≠ 
)
≠≠ 
;
≠≠ 
}
ÆÆ 	
return
∞∞ 
RedirectToAction
∞∞ 
(
∞∞  
nameof
∞∞  &
(
∞∞& '
Editar
∞∞' -
)
∞∞- .
)
∞∞. /
;
∞∞/ 0
}
±± 
[
≥≥ 
HttpGet
≥≥ 
]
≥≥ 
[
¥¥ 
	Authorize
¥¥ 
(
¥¥ 
Roles
¥¥ 
=
¥¥ 
$str
¥¥ #
)
¥¥# $
]
¥¥$ %
public
µµ 

async
µµ 
Task
µµ 
<
µµ 
IActionResult
µµ #
>
µµ# $
Editar
µµ% +
(
µµ+ ,
)
µµ, -
{
∂∂ 
if
∑∑ 

(
∑∑ 
!
∑∑ 
await
∑∑ 
perfilService
∑∑  
.
∑∑  !$
EdicionAutorizadaAsync
∑∑! 7
(
∑∑7 8
	UsuarioId
∑∑8 A
)
∑∑A B
)
∑∑B C
{
∏∏ 	
TempData
ππ 
[
ππ 
$str
ππ 
]
ππ 
=
ππ %
PerfilRepartidorService
ππ  7
.
ππ7 8$
MensajeSinVerificacion
ππ8 N
;
ππN O
return
∫∫ 
RedirectToAction
∫∫ #
(
∫∫# $
nameof
∫∫$ *
(
∫∫* +
Perfil
∫∫+ 1
)
∫∫1 2
)
∫∫2 3
;
∫∫3 4
}
ªª 	
var
ΩΩ 
dto
ΩΩ 
=
ΩΩ 
await
ΩΩ 
perfilService
ΩΩ %
.
ΩΩ% &$
ObtenerParaEditarAsync
ΩΩ& <
(
ΩΩ< =
	UsuarioId
ΩΩ= F
)
ΩΩF G
;
ΩΩG H
if
ææ 

(
ææ 
dto
ææ 
is
ææ 
null
ææ 
)
ææ 
return
ææ 
NotFound
ææ  (
(
ææ( )
)
ææ) *
;
ææ* +
return
øø 
View
øø 
(
øø 
dto
øø 
)
øø 
;
øø 
}
¿¿ 
[
√√ 
HttpPost
√√ 
,
√√ &
ValidateAntiForgeryToken
√√ '
]
√√' (
[
ƒƒ 
	Authorize
ƒƒ 
(
ƒƒ 
Roles
ƒƒ 
=
ƒƒ 
$str
ƒƒ #
)
ƒƒ# $
]
ƒƒ$ %
public
≈≈ 

async
≈≈ 
Task
≈≈ 
<
≈≈ 
IActionResult
≈≈ #
>
≈≈# $
Editar
≈≈% +
(
≈≈+ ,!
EditarRepartidorDto
≈≈, ?
dto
≈≈@ C
)
≈≈C D
{
∆∆ 
if
«« 

(
«« 
!
«« 

ModelState
«« 
.
«« 
IsValid
«« 
)
««  
return
««! '
View
««( ,
(
««, -
dto
««- 0
)
««0 1
;
««1 2
var
…… 
(
…… 
ok
…… 
,
…… 
error
…… 
)
…… 
=
…… 
await
…… 
perfilService
……  -
.
……- .
EditarAsync
……. 9
(
……9 :
	UsuarioId
……: C
,
……C D
dto
……E H
)
……H I
;
……I J
if
   

(
   
!
   
ok
   
)
   
{
ÀÀ 	
if
ÃÃ 
(
ÃÃ 
error
ÃÃ 
==
ÃÃ %
PerfilRepartidorService
ÃÃ 0
.
ÃÃ0 1$
MensajeSinVerificacion
ÃÃ1 G
||
ÃÃH J
error
ÃÃK P
==
ÃÃQ S%
PerfilRepartidorService
ÃÃT k
.
ÃÃk l
MensajeSuspendido
ÃÃl }
)
ÃÃ} ~
{
ÕÕ 
TempData
ŒŒ 
[
ŒŒ 
$str
ŒŒ  
]
ŒŒ  !
=
ŒŒ" #
error
ŒŒ$ )
;
ŒŒ) *
return
œœ 
RedirectToAction
œœ '
(
œœ' (
nameof
œœ( .
(
œœ. /
Perfil
œœ/ 5
)
œœ5 6
)
œœ6 7
;
œœ7 8
}
–– 
if
—— 
(
—— 
error
—— 
==
—— %
PerfilRepartidorService
—— 0
.
——0 1
MensajeConPedidos
——1 B
)
——B C
{
““ 
TempData
”” 
[
”” 
$str
””  
]
””  !
=
””" #
error
””$ )
;
””) *
return
‘‘ 
RedirectToAction
‘‘ '
(
‘‘' (
$str
‘‘( /
,
‘‘/ 0
$str
‘‘1 7
)
‘‘7 8
;
‘‘8 9
}
’’ 

ModelState
◊◊ 
.
◊◊ 
AddModelError
◊◊ $
(
◊◊$ %
$str
◊◊% '
,
◊◊' (
error
◊◊) .
!
◊◊. /
)
◊◊/ 0
;
◊◊0 1
return
ÿÿ 
View
ÿÿ 
(
ÿÿ 
dto
ÿÿ 
)
ÿÿ 
;
ÿÿ 
}
ŸŸ 	
TempData
€€ 
[
€€ 
$str
€€ 
]
€€ 
=
€€ 
$str
€€ K
;
€€K L
return
‹‹ 
RedirectToAction
‹‹ 
(
‹‹  
nameof
‹‹  &
(
‹‹& '
Perfil
‹‹' -
)
‹‹- .
)
‹‹. /
;
‹‹/ 0
}
›› 
[
·· 
HttpPost
·· 
,
·· &
ValidateAntiForgeryToken
·· '
]
··' (
[
‚‚ 
	Authorize
‚‚ 
(
‚‚ 
Roles
‚‚ 
=
‚‚ 
$str
‚‚ #
)
‚‚# $
]
‚‚$ %
public
„„ 

async
„„ 
Task
„„ 
<
„„ 
IActionResult
„„ #
>
„„# $"
VerificarEliminacion
„„% 9
(
„„9 :
)
„„: ;
{
‰‰ 
var
ÂÂ 
(
ÂÂ 
ok
ÂÂ 
,
ÂÂ 
error
ÂÂ 
)
ÂÂ 
=
ÂÂ 
await
ÂÂ 
perfilService
ÂÂ  -
.
ÂÂ- .+
ValidarEliminacionPropiaAsync
ÂÂ. K
(
ÂÂK L
	UsuarioId
ÂÂL U
)
ÂÂU V
;
ÂÂV W
return
ÊÊ 
Json
ÊÊ 
(
ÊÊ 
new
ÊÊ 
{
ÊÊ 
ok
ÊÊ 
,
ÊÊ 
error
ÊÊ #
}
ÊÊ$ %
)
ÊÊ% &
;
ÊÊ& '
}
ÁÁ 
[
ÍÍ 
HttpPost
ÍÍ 
,
ÍÍ &
ValidateAntiForgeryToken
ÍÍ '
]
ÍÍ' (
[
ÎÎ 
	Authorize
ÎÎ 
(
ÎÎ 
Roles
ÎÎ 
=
ÎÎ 
$str
ÎÎ #
)
ÎÎ# $
]
ÎÎ$ %
public
ÏÏ 

async
ÏÏ 
Task
ÏÏ 
<
ÏÏ 
IActionResult
ÏÏ #
>
ÏÏ# $
EliminarCuenta
ÏÏ% 3
(
ÏÏ3 4
EliminarCuentaDto
ÏÏ4 E
dto
ÏÏF I
)
ÏÏI J
{
ÌÌ 
if
ÓÓ 

(
ÓÓ 
!
ÓÓ 

ModelState
ÓÓ 
.
ÓÓ 
IsValid
ÓÓ 
)
ÓÓ  
{
ÔÔ 	
TempData
 
[
 
$str
 
]
 
=
 
$str
  7
;
7 8
return
ÒÒ 
RedirectToAction
ÒÒ #
(
ÒÒ# $
nameof
ÒÒ$ *
(
ÒÒ* +
Perfil
ÒÒ+ 1
)
ÒÒ1 2
)
ÒÒ2 3
;
ÒÒ3 4
}
ÚÚ 	
var
ÙÙ 
(
ÙÙ 
ok
ÙÙ 
,
ÙÙ 
error
ÙÙ 
)
ÙÙ 
=
ÙÙ 
await
ÙÙ 
perfilService
ÙÙ  -
.
ÙÙ- .'
EliminarCuentaPropiaAsync
ÙÙ. G
(
ÙÙG H
	UsuarioId
ÙÙH Q
,
ÙÙQ R
dto
ÙÙS V
.
ÙÙV W
Password
ÙÙW _
)
ÙÙ_ `
;
ÙÙ` a
if
ıı 

(
ıı 
!
ıı 
ok
ıı 
)
ıı 
{
ˆˆ 	
TempData
˜˜ 
[
˜˜ 
$str
˜˜ 
]
˜˜ 
=
˜˜ 
error
˜˜  %
;
˜˜% &
return
¯¯ 
RedirectToAction
¯¯ #
(
¯¯# $
nameof
¯¯$ *
(
¯¯* +
Perfil
¯¯+ 1
)
¯¯1 2
)
¯¯2 3
;
¯¯3 4
}
˘˘ 	
await
˚˚ 
HttpContext
˚˚ 
.
˚˚ 
SignOutAsync
˚˚ &
(
˚˚& '*
CookieAuthenticationDefaults
˚˚' C
.
˚˚C D"
AuthenticationScheme
˚˚D X
)
˚˚X Y
;
˚˚Y Z
TempData
¸¸ 
[
¸¸ 
$str
¸¸ 
]
¸¸ 
=
¸¸ 
$str
¸¸ ;
;
¸¸; <
return
˝˝ 
RedirectToAction
˝˝ 
(
˝˝  
$str
˝˝  '
,
˝˝' (
$str
˝˝) /
)
˝˝/ 0
;
˝˝0 1
}
˛˛ 
[
ÅÅ 
HttpPost
ÅÅ 
,
ÅÅ &
ValidateAntiForgeryToken
ÅÅ '
]
ÅÅ' (
[
ÇÇ 
	Authorize
ÇÇ 
(
ÇÇ 
Roles
ÇÇ 
=
ÇÇ 
$str
ÇÇ  
)
ÇÇ  !
]
ÇÇ! "
public
ÉÉ 

async
ÉÉ 
Task
ÉÉ 
<
ÉÉ 
IActionResult
ÉÉ #
>
ÉÉ# $,
VerificarEliminacionRepartidor
ÉÉ% C
(
ÉÉC D
int
ÉÉD G
id
ÉÉH J
)
ÉÉJ K
{
ÑÑ 
var
ÖÖ 
(
ÖÖ 
ok
ÖÖ 
,
ÖÖ 
error
ÖÖ 
)
ÖÖ 
=
ÖÖ 
await
ÖÖ 
perfilService
ÖÖ  -
.
ÖÖ- ./
!ValidarEliminacionPorNegocioAsync
ÖÖ. O
(
ÖÖO P
	UsuarioId
ÖÖP Y
,
ÖÖY Z
id
ÖÖ[ ]
)
ÖÖ] ^
;
ÖÖ^ _
return
ÜÜ 
Json
ÜÜ 
(
ÜÜ 
new
ÜÜ 
{
ÜÜ 
ok
ÜÜ 
,
ÜÜ 
error
ÜÜ #
}
ÜÜ$ %
)
ÜÜ% &
;
ÜÜ& '
}
áá 
[
ââ 
HttpPost
ââ 
,
ââ &
ValidateAntiForgeryToken
ââ '
]
ââ' (
[
ää 
	Authorize
ää 
(
ää 
Roles
ää 
=
ää 
$str
ää  
)
ää  !
]
ää! "
public
ãã 

async
ãã 
Task
ãã 
<
ãã 
IActionResult
ãã #
>
ãã# $ 
EliminarRepartidor
ãã% 7
(
ãã7 8
int
ãã8 ;
id
ãã< >
,
ãã> ?
EliminarCuentaDto
ãã@ Q
dto
ããR U
)
ããU V
{
åå 
if
çç 

(
çç 
!
çç 

ModelState
çç 
.
çç 
IsValid
çç 
)
çç  
{
éé 	
TempData
èè 
[
èè 
$str
èè 
]
èè 
=
èè 
$str
èè  U
;
èèU V
return
êê 
RedirectToAction
êê #
(
êê# $
nameof
êê$ *
(
êê* +
Index
êê+ 0
)
êê0 1
)
êê1 2
;
êê2 3
}
ëë 	
var
ìì 
(
ìì 
ok
ìì 
,
ìì 
error
ìì 
,
ìì 
nombre
ìì 
)
ìì 
=
ìì  !
await
ìì" '
perfilService
ìì( 5
.
ìì5 6%
EliminarPorNegocioAsync
ìì6 M
(
ììM N
	UsuarioId
ììN W
,
ììW X
id
ììY [
,
ìì[ \
dto
ìì] `
.
ìì` a
Password
ììa i
)
ììi j
;
ììj k
TempData
îî 
[
îî 
ok
îî 
?
îî 
$str
îî 
:
îî  !
$str
îî" )
]
îî) *
=
îî+ ,
ok
îî- /
?
îî0 1
$"
îî2 4
$str
îî4 B
{
îîB C
nombre
îîC I
}
îîI J
$str
îîJ X
"
îîX Y
:
îîZ [
error
îî\ a
;
îîa b
return
ïï 
RedirectToAction
ïï 
(
ïï  
nameof
ïï  &
(
ïï& '
Index
ïï' ,
)
ïï, -
)
ïï- .
;
ïï. /
}
ññ 
}óó Íó
[C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Controllers\PedidoController.cs
[ 
	Authorize 

(
 
Roles 
= 
$str 
) 
] 
public 
class 
PedidoController 
( 
IPedidoService 
pedidos 
, 
INegocioRepository		 
negocios		 
,		  
AppDbContext

 
context

 
,

 
IUbicacionService 
ubicaciones !
)! "
:# $

Controller% /
{ 
private 
int 
	UsuarioId 
=> 
int  
.  !
Parse! &
(& '
User' +
.+ ,
FindFirstValue, :
(: ;

ClaimTypes; E
.E F
NameIdentifierF T
)T U
!U V
)V W
;W X
[ 
HttpGet 
] 
public 

IActionResult 
	Registrar "
(" #
)# $
=>% '
View( ,
(, -
new- 0
RegistrarPedidoDto1 C
(C D
)D E
)E F
;F G
[ 
HttpPost 
, $
ValidateAntiForgeryToken '
]' (
public 

async 
Task 
< 
IActionResult #
># $
	Registrar% .
(. /
RegistrarPedidoDto/ A
dtoB E
)E F
{ 
if 

( 
! 

ModelState 
. 
IsValid 
)  
return! '
View( ,
(, -
dto- 0
)0 1
;1 2
var 
( 
ok 
, 
error 
, 
codigo 
) 
=  !
await" '
pedidos( /
./ 0
RegistrarAsync0 >
(> ?
	UsuarioId? H
,H I
dtoJ M
)M N
;N O
if 

( 
! 
ok 
) 
{ 	

ModelState 
. 
AddModelError $
($ %
$str% '
,' (
error) .
!. /
)/ 0
;0 1
return 
View 
( 
dto 
) 
; 
} 	
TempData 
[ 
$str 
] 
= 
$"  
$str  @
{@ A
codigoA G
}G H
"H I
;I J
return 
RedirectToAction 
(  
nameof  &
(& '
Activos' .
). /
)/ 0
;0 1
}   
["" 
HttpGet"" 
]"" 
public## 

async## 
Task## 
<## 
IActionResult## #
>### $
BuscarCliente##% 2
(##2 3
string##3 9
telefono##: B
)##B C
{$$ 
var%% 
cliente%% 
=%% 
await%% 
pedidos%% #
.%%# $'
BuscarClienteFrecuenteAsync%%$ ?
(%%? @
	UsuarioId%%@ I
,%%I J
telefono%%K S
)%%S T
;%%T U
return&& 
Json&& 
(&& 
cliente&& 
)&& 
;&& 
}'' 
[)) 
HttpGet)) 
])) 
public** 

async** 
Task** 
<** 
IActionResult** #
>**# $
Activos**% ,
(**, -
)**- .
{++ 
var,, 
negocio,, 
=,, 
await,, 
negocios,, $
.,,$ %$
ObtenerPorUsuarioIdAsync,,% =
(,,= >
	UsuarioId,,> G
),,G H
;,,H I
var-- 
pedidosActivos-- 
=-- 
await-- "
pedidos--# *
.--* +&
ObtenerPedidosActivosAsync--+ E
(--E F
	UsuarioId--F O
)--O P
;--P Q
List// 
<// 

Repartidor// 
>// 
listaRepartidores// *
=//+ ,
[//- .
]//. /
;/// 0
if00 

(00 
negocio00 
!=00 
null00 
)00 
{11 	
listaRepartidores22 
=22 
await22  %
context22& -
.22- .
Set22. 1
<221 2

Repartidor222 <
>22< =
(22= >
)22> ?
.33 
Include33 
(33 
r33 
=>33 
r33 
.33  
Usuario33  '
)33' (
.44 
Where44 
(44 
r44 
=>44 
r44 
.44 
	NegocioId44 '
==44( *
negocio44+ 2
.442 3
Id443 5
&&446 8
r449 :
.44: ;
Usuario44; B
.44B C
Estado44C I
==44J L
EstadoCuenta44M Y
.44Y Z
Activo44Z `
)44` a
.55 
ToListAsync55 
(55 
)55 
;55 
}66 	
ViewBag88 
.88 
Repartidores88 
=88 
listaRepartidores88 0
;880 1
return99 
View99 
(99 
pedidosActivos99 "
)99" #
;99# $
}:: 
[<< 
HttpGet<< 
]<< 
public== 

async== 
Task== 
<== 
IActionResult== #
>==# $
	Historial==% .
(==. /
)==/ 0
{>> 
var?? 
historialPedidos?? 
=?? 
await?? $
pedidos??% ,
.??, -(
ObtenerHistorialPedidosAsync??- I
(??I J
	UsuarioId??J S
)??S T
;??T U
return@@ 
View@@ 
(@@ 
historialPedidos@@ $
)@@$ %
;@@% &
}AA 
[CC 
HttpPostCC 
,CC $
ValidateAntiForgeryTokenCC '
]CC' (
publicDD 

asyncDD 
TaskDD 
<DD 
IActionResultDD #
>DD# $
ActualizarEstadoDD% 5
(DD5 6
intDD6 9
idDD: <
,DD< =
intDD> A
nuevoEstadoIdDDB O
,DDO P
intDDQ T
?DDT U
repartidorIdDDV b
)DDb c
{EE 
varFF 
(FF 
okActualizacionFF 
,FF 
errorMsgFF &
)FF& '
=FF( )
awaitFF* /
pedidosFF0 7
.FF7 8!
ActualizarEstadoAsyncFF8 M
(FFM N
	UsuarioIdFFN W
,FFW X
idFFY [
,FF[ \
nuevoEstadoIdFF] j
,FFj k
repartidorIdFFl x
)FFx y
;FFy z
ifHH 

(HH 
!HH 
okActualizacionHH 
)HH 
{II 	
TempDataJJ 
[JJ 
$strJJ 
]JJ 
=JJ 
errorMsgJJ  (
??JJ) +
$strJJ, R
;JJR S
}KK 	
elseLL 
{MM 	
TempDataNN 
[NN 
$strNN 
]NN 
=NN  !
$strNN" Z
;NNZ [
}OO 	
returnQQ 
RedirectToActionQQ 
(QQ  
nameofQQ  &
(QQ& '
ActivosQQ' .
)QQ. /
)QQ/ 0
;QQ0 1
}RR 
[XX 
AllowAnonymousXX 
]XX 
[YY 
HttpGetYY 
]YY 
publicZZ 

IActionResultZZ 
	ConsultarZZ "
(ZZ" #
)ZZ# $
{[[ 
return\\ 
View\\ 
(\\ 
)\\ 
;\\ 
}]] 
[__ 
AllowAnonymous__ 
]__ 
[`` 
HttpPost`` 
,`` $
ValidateAntiForgeryToken`` '
]``' (
publicaa 

Taskaa 
<aa 
IActionResultaa 
>aa 
	Consultaraa (
(aa( )
stringaa) /
codigoaa0 6
)aa6 7
=>aa8 :
MostrarPedidoAsyncaa; M
(aaM N
codigoaaN T
)aaT U
;aaU V
[ee 
AllowAnonymousee 
]ee 
[ff 
HttpPostff 
,ff $
ValidateAntiForgeryTokenff '
]ff' (
publicgg 

asyncgg 
Taskgg 
<gg 
IActionResultgg #
>gg# $
Cancelargg% -
(gg- .
stringgg. 4
codigogg5 ;
,gg; <
stringgg= C
?ggC D
motivoggE K
)ggK L
{hh 
varii 
(ii 
okii 
,ii 
errorii 
)ii 
=ii 
awaitii 
pedidosii  '
.ii' (#
CancelarPorClienteAsyncii( ?
(ii? @
codigoii@ F
,iiF G
motivoiiH N
)iiN O
;iiO P
ifkk 

(kk 
!kk 
okkk 
&&kk 
errorkk 
==kk 
PedidoServicekk )
.kk) *%
MensajeCodigoNoEncontradokk* C
)kkC D
{ll 	

ModelStatemm 
.mm 
AddModelErrormm $
(mm$ %
$strmm% '
,mm' (
errormm) .
)mm. /
;mm/ 0
returnnn 
Viewnn 
(nn 
nameofnn 
(nn 
	Consultarnn (
)nn( )
)nn) *
;nn* +
}oo 	
ifqq 

(qq 
okqq 
)qq 
ViewBagrr 
.rr 
MensajeCancelacionrr &
=rr' (
$strrr) H
;rrH I
elsess 

ModelStatett 
.tt 
AddModelErrortt $
(tt$ %
$strtt% '
,tt' (
errortt) .
!tt. /
)tt/ 0
;tt0 1
returnww 
awaitww 
MostrarPedidoAsyncww '
(ww' (
codigoww( .
)ww. /
;ww/ 0
}xx 
private{{ 
async{{ 
Task{{ 
<{{ 
IActionResult{{ $
>{{$ %
MostrarPedidoAsync{{& 8
({{8 9
string{{9 ?
?{{? @
codigo{{A G
){{G H
{|| 
const}} 
string}} 
CodigoNoEncontrado}} '
=}}( )
$str}}* _
;}}_ `
var
ÄÄ 
codigoLimpio
ÄÄ 
=
ÄÄ 
codigo
ÄÄ !
?
ÄÄ! "
.
ÄÄ" #
Trim
ÄÄ# '
(
ÄÄ' (
)
ÄÄ( )
.
ÄÄ) *
ToUpperInvariant
ÄÄ* :
(
ÄÄ: ;
)
ÄÄ; <
??
ÄÄ= ?
$str
ÄÄ@ B
;
ÄÄB C
if
ÅÅ 

(
ÅÅ 
!
ÅÅ 
System
ÅÅ 
.
ÅÅ 
Text
ÅÅ 
.
ÅÅ  
RegularExpressions
ÅÅ +
.
ÅÅ+ ,
Regex
ÅÅ, 1
.
ÅÅ1 2
IsMatch
ÅÅ2 9
(
ÅÅ9 :
codigoLimpio
ÅÅ: F
,
ÅÅF G
$str
ÅÅH W
)
ÅÅW X
)
ÅÅX Y
{
ÇÇ 	

ModelState
ÉÉ 
.
ÉÉ 
AddModelError
ÉÉ $
(
ÉÉ$ %
$str
ÉÉ% '
,
ÉÉ' ( 
CodigoNoEncontrado
ÉÉ) ;
)
ÉÉ; <
;
ÉÉ< =
return
ÑÑ 
View
ÑÑ 
(
ÑÑ 
nameof
ÑÑ 
(
ÑÑ 
	Consultar
ÑÑ (
)
ÑÑ( )
)
ÑÑ) *
;
ÑÑ* +
}
ÖÖ 	
try
áá 
{
àà 	
var
ââ 
pedido
ââ 
=
ââ 
await
ââ 
context
ââ &
.
ââ& '
Pedidos
ââ' .
.
ää 
AsNoTracking
ää 
(
ää 
)
ää 
.
ãã 
Include
ãã 
(
ãã 
p
ãã 
=>
ãã 
p
ãã 
.
ãã  
Items
ãã  %
)
ãã% &
.
åå 
Include
åå 
(
åå 
p
åå 
=>
åå 
p
åå 
.
åå  
Negocio
åå  '
)
åå' (
.
åå( )
ThenInclude
åå) 4
(
åå4 5
n
åå5 6
=>
åå7 9
n
åå: ;
!
åå; <
.
åå< =
Usuario
åå= D
)
ååD E
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
çç  

Repartidor
çç  *
)
çç* +
.
éé !
FirstOrDefaultAsync
éé $
(
éé$ %
p
éé% &
=>
éé' )
p
éé* +
.
éé+ ,
Codigo
éé, 2
==
éé3 5
codigoLimpio
éé6 B
)
ééB C
;
ééC D
if
êê 
(
êê 
pedido
êê 
==
êê 
null
êê 
)
êê 
{
ëë 

ModelState
íí 
.
íí 
AddModelError
íí (
(
íí( )
$str
íí) +
,
íí+ , 
CodigoNoEncontrado
íí- ?
)
íí? @
;
íí@ A
return
ìì 
View
ìì 
(
ìì 
nameof
ìì "
(
ìì" #
	Consultar
ìì# ,
)
ìì, -
)
ìì- .
;
ìì. /
}
îî 
ViewBag
óó 
.
óó 
	Historial
óó 
=
óó 
await
óó  %
context
óó& -
.
óó- .
Database
óó. 6
.
òò 
SqlQuery
òò 
<
òò !
HistorialEstadoItem
òò -
>
òò- .
(
òò. /
$"
òò/ 1
$stròò1 Ñ
{òòÑ Ö
pedidoòòÖ ã
.òòã å
Idòòå é
}òòé è
$stròòè §
"òò§ •
)òò• ¶
.
ôô 
ToListAsync
ôô 
(
ôô 
)
ôô 
;
ôô 
if
ùù 
(
ùù 
pedido
ùù 
.
ùù 
EstadoPedidoId
ùù %
==
ùù& (
(
ùù) *
int
ùù* -
)
ùù- .
EstadoPedido
ùù. :
.
ùù: ;
	Cancelado
ùù; D
)
ùùD E
{
ûû 
try
üü 
{
†† 
ViewBag
°° 
.
°° 
Cancelacion
°° '
=
°°( )
await
°°* /
context
°°0 7
.
°°7 8$
SolicitudesCancelacion
°°8 N
.
¢¢ 
AsNoTracking
¢¢ %
(
¢¢% &
)
¢¢& '
.
££ !
FirstOrDefaultAsync
££ ,
(
££, -
s
££- .
=>
££/ 1
s
££2 3
.
££3 4
PedidoId
££4 <
==
££= ?
pedido
££@ F
.
££F G
Id
££G I
)
££I J
;
££J K
}
§§ 
catch
•• 
(
•• 
	Exception
••  
)
••  !
{
¶¶ 
ViewBag
ßß 
.
ßß 
Cancelacion
ßß '
=
ßß( )
null
ßß* .
;
ßß. /
}
®® 
}
©© 
return
´´ 
View
´´ 
(
´´ 
nameof
´´ 
(
´´ 
	Consultar
´´ (
)
´´( )
,
´´) *
pedido
´´+ 1
)
´´1 2
;
´´2 3
}
¨¨ 	
catch
≠≠ 
(
≠≠ 
	Exception
≠≠ 
)
≠≠ 
{
ÆÆ 	

ModelState
∞∞ 
.
∞∞ 
AddModelError
∞∞ $
(
∞∞$ %
$str
∞∞% '
,
∞∞' (
$str
∞∞) c
)
∞∞c d
;
∞∞d e
return
±± 
View
±± 
(
±± 
nameof
±± 
(
±± 
	Consultar
±± (
)
±±( )
)
±±) *
;
±±* +
}
≤≤ 	
}
≥≥ 
[
µµ 
AllowAnonymous
µµ 
]
µµ 
[
∂∂ 
HttpGet
∂∂ 
]
∂∂ 
public
∑∑ 

async
∑∑ 
Task
∑∑ 
<
∑∑ 
IActionResult
∑∑ #
>
∑∑# $
	Ubicacion
∑∑% .
(
∑∑. /
string
∑∑/ 5
codigo
∑∑6 <
)
∑∑< =
{
∏∏ 
if
ππ 

(
ππ 
string
ππ 
.
ππ  
IsNullOrWhiteSpace
ππ %
(
ππ% &
codigo
ππ& ,
)
ππ, -
||
ππ. 0
!
ππ1 2
System
ππ2 8
.
ππ8 9
Text
ππ9 =
.
ππ= > 
RegularExpressions
ππ> P
.
ππP Q
Regex
ππQ V
.
ππV W
IsMatch
ππW ^
(
ππ^ _
codigo
ππ_ e
.
ππe f
Trim
ππf j
(
ππj k
)
ππk l
,
ππl m
$strππn Ä
)ππÄ Å
)ππÅ Ç
{
∫∫ 	
return
ªª 
Json
ªª 
(
ªª 
new
ªª 
{
ªª 

disponible
ªª (
=
ªª) *
false
ªª+ 0
}
ªª1 2
)
ªª2 3
;
ªª3 4
}
ºº 	
var
ææ 
(
ææ 
ok
ææ 
,
ææ 
_
ææ 
,
ææ 
lat
ææ 
,
ææ 
lng
ææ 
,
ææ 
fechaUtc
ææ &
,
ææ& '
estado
ææ( .
)
ææ. /
=
ææ0 1
await
ææ2 7
ubicaciones
ææ8 C
.
ææC D#
ObtenerPorCodigoAsync
ææD Y
(
ææY Z
codigo
ææZ `
.
ææ` a
Trim
ææa e
(
ææe f
)
ææf g
.
ææg h
ToUpperInvariant
ææh x
(
ææx y
)
ææy z
)
ææz {
;
ææ{ |
if
¿¿ 

(
¿¿ 
ok
¿¿ 
&&
¿¿ 
lat
¿¿ 
.
¿¿ 
HasValue
¿¿ 
&&
¿¿ !
lng
¿¿" %
.
¿¿% &
HasValue
¿¿& .
&&
¿¿/ 1
fechaUtc
¿¿2 :
.
¿¿: ;
HasValue
¿¿; C
)
¿¿C D
{
¡¡ 	
return
¬¬ 
Json
¬¬ 
(
¬¬ 
new
¬¬ 
{
√√ 

disponible
ƒƒ 
=
ƒƒ 
true
ƒƒ !
,
ƒƒ! "
lat
≈≈ 
=
≈≈ 
lat
≈≈ 
.
≈≈ 
Value
≈≈ 
,
≈≈  
lng
∆∆ 
=
∆∆ 
lng
∆∆ 
.
∆∆ 
Value
∆∆ 
,
∆∆  
fechaUtc
«« 
=
«« 
fechaUtc
«« #
.
««# $
Value
««$ )
.
««) *
ToString
««* 2
(
««2 3
$str
««3 K
)
««K L
,
««L M
estado
»» 
}
…… 
)
…… 
;
…… 
}
   	
return
ÃÃ 
Json
ÃÃ 
(
ÃÃ 
new
ÃÃ 
{
ÕÕ 	

disponible
ŒŒ 
=
ŒŒ 
false
ŒŒ 
,
ŒŒ 
estado
œœ 
}
–– 	
)
––	 

;
––
 
}
—— 
}““ 
public’’ 
class
’’ !
HistorialEstadoItem
’’  
{÷÷ 
public
◊◊ 

int
◊◊ 
EstadoPedidoId
◊◊ 
{
◊◊ 
get
◊◊  #
;
◊◊# $
set
◊◊% (
;
◊◊( )
}
◊◊* +
public
ÿÿ 

DateTime
ÿÿ 
FechaCambio
ÿÿ 
{
ÿÿ  !
get
ÿÿ" %
;
ÿÿ% &
set
ÿÿ' *
;
ÿÿ* +
}
ÿÿ, -
}ŸŸ ’
\C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Controllers\NegocioController.cs
[ 
	Authorize 

(
 
Roles 
= 
$str 
) 
] 
public 
class 
NegocioController 
( 
INegocioService .
negocios/ 7
)7 8
:9 :

Controller; E
{		 
private

 
int

 
	UsuarioId

 
=>

 
int

  
.

  !
Parse

! &
(

& '
User

' +
.

+ ,
FindFirstValue

, :
(

: ;

ClaimTypes

; E
.

E F
NameIdentifier

F T
)

T U
!

U V
)

V W
;

W X
[ 
AllowAnonymous 
, 
HttpGet 
] 
public 

IActionResult 
	Registrar "
(" #
)# $
{ 
if 

( 
User 
. 
Identity 
? 
. 
IsAuthenticated *
==+ -
true. 2
)2 3
return4 :
RedirectToAction; K
(K L
$strL S
,S T
$strU [
)[ \
;\ ]
return 
View 
( 
new 
RegistroNegocioDto *
(* +
)+ ,
), -
;- .
} 
[ 
AllowAnonymous 
, 
HttpPost 
, $
ValidateAntiForgeryToken 7
]7 8
public 

async 
Task 
< 
IActionResult #
># $
	Registrar% .
(. /
RegistroNegocioDto/ A
dtoB E
)E F
{ 
if 

( 
User 
. 
Identity 
? 
. 
IsAuthenticated *
==+ -
true. 2
)2 3
return4 :
RedirectToAction; K
(K L
$strL S
,S T
$strU [
)[ \
;\ ]
if 

( 
! 

ModelState 
. 
IsValid 
)  
{ 	
if 
( 

ModelState 
. 
Values !
.! "

SelectMany" ,
(, -
v- .
=>/ 1
v2 3
.3 4
Errors4 :
): ;
.; <
Any< ?
(? @
e@ A
=>B D
eE F
.F G
ErrorMessageG S
==T V
RegistroNegocioDtoW i
.i j
Obligatorioj u
)u v
)v w

ModelState 
. 
AddModelError (
(( )
$str) +
,+ ,
$str- P
)P Q
;Q R
return 
View 
( 
dto 
) 
; 
} 	
var!! 
urlRevision!! 
=!! 
Url!! 
.!! 
Action!! $
(!!$ %
$str!!% /
,!!/ 0
$str!!1 8
,!!8 9
null!!: >
,!!> ?
Request!!@ G
.!!G H
Scheme!!H N
)!!N O
!!!O P
;!!P Q
var"" 
("" 
ok"" 
,"" 
error"" 
,"" 
correoEnviado"" %
)""% &
=""' (
await"") .
negocios""/ 7
.""7 8
RegistrarAsync""8 F
(""F G
dto""G J
,""J K
urlRevision""L W
)""W X
;""X Y
if## 

(## 
!## 
ok## 
)## 
{$$ 	

ModelState%% 
.%% 
AddModelError%% $
(%%$ %
$str%%% '
,%%' (
error%%) .
!%%. /
)%%/ 0
;%%0 1
return&& 
View&& 
(&& 
dto&& 
)&& 
;&& 
}'' 	
var)) 
mensaje)) 
=)) 
$str)) V
;))V W
if** 

(** 
!** 
correoEnviado** 
)** 
mensaje++ 
+=++ 
$str++ c
;++c d
TempData-- 
[-- 
$str-- 
]-- 
=-- 
mensaje-- %
;--% &
return.. 
RedirectToAction.. 
(..  
$str..  '
,..' (
$str..) 2
)..2 3
;..3 4
}// 
[22 
HttpGet22 
]22 
public33 

async33 
Task33 
<33 
IActionResult33 #
>33# $
Perfil33% +
(33+ ,
)33, -
{44 
var55 
perfil55 
=55 
await55 
negocios55 #
.55# $
ObtenerPerfilAsync55$ 6
(556 7
	UsuarioId557 @
)55@ A
;55A B
if66 

(66 
perfil66 
is66 
null66 
)66 
return66 "
NotFound66# +
(66+ ,
)66, -
;66- .
return77 
View77 
(77 
perfil77 
)77 
;77 
}88 
[;; 
HttpPost;; 
,;; $
ValidateAntiForgeryToken;; '
];;' (
public<< 

async<< 
Task<< 
<<< 
IActionResult<< #
><<# $
EnviarCodigo<<% 1
(<<1 2
)<<2 3
{== 
var>> 
(>> 
ok>> 
,>> 
error>> 
)>> 
=>> 
await>> 
negocios>>  (
.>>( ) 
SolicitarCodigoAsync>>) =
(>>= >
	UsuarioId>>> G
)>>G H
;>>H I
if?? 

(?? 
!?? 
ok?? 
)?? 
{@@ 	
TempDataAA 
[AA 
$strAA 
]AA 
=AA 
errorAA  %
;AA% &
returnBB 
RedirectToActionBB #
(BB# $
nameofBB$ *
(BB* +
PerfilBB+ 1
)BB1 2
)BB2 3
;BB3 4
}CC 	
TempDataEE 
[EE 
$strEE 
]EE 
=EE 
$strEE Q
;EEQ R
returnFF 
RedirectToActionFF 
(FF  
nameofFF  &
(FF& '
VerificarCodigoFF' 6
)FF6 7
)FF7 8
;FF8 9
}GG 
[II 
HttpGetII 
]II 
publicJJ 

IActionResultJJ 
VerificarCodigoJJ (
(JJ( )
)JJ) *
=>JJ+ -
ViewJJ. 2
(JJ2 3
newJJ3 6
VerificarCodigoDtoJJ7 I
(JJI J
)JJJ K
)JJK L
;JJL M
[LL 
HttpPostLL 
,LL $
ValidateAntiForgeryTokenLL '
]LL' (
publicMM 

asyncMM 
TaskMM 
<MM 
IActionResultMM #
>MM# $
VerificarCodigoMM% 4
(MM4 5
VerificarCodigoDtoMM5 G
dtoMMH K
)MMK L
{NN 
ifOO 

(OO 
!OO 

ModelStateOO 
.OO 
IsValidOO 
)OO  
returnOO! '
ViewOO( ,
(OO, -
dtoOO- 0
)OO0 1
;OO1 2
varQQ 
(QQ 
okQQ 
,QQ 
errorQQ 
)QQ 
=QQ 
awaitQQ 
negociosQQ  (
.QQ( ) 
VerificarCodigoAsyncQQ) =
(QQ= >
	UsuarioIdQQ> G
,QQG H
dtoQQI L
.QQL M
CodigoQQM S
)QQS T
;QQT U
ifRR 

(RR 
!RR 
okRR 
)RR 
{SS 	

ModelStateTT 
.TT 
AddModelErrorTT $
(TT$ %
$strTT% '
,TT' (
errorTT) .
!TT. /
)TT/ 0
;TT0 1
returnUU 
ViewUU 
(UU 
dtoUU 
)UU 
;UU 
}VV 	
returnXX 
RedirectToActionXX 
(XX  
nameofXX  &
(XX& '
EditarXX' -
)XX- .
)XX. /
;XX/ 0
}YY 
[[[ 
HttpGet[[ 
][[ 
public\\ 

async\\ 
Task\\ 
<\\ 
IActionResult\\ #
>\\# $
Editar\\% +
(\\+ ,
)\\, -
{]] 
if^^ 

(^^ 
!^^ 
await^^ 
negocios^^ 
.^^ "
EdicionAutorizadaAsync^^ 2
(^^2 3
	UsuarioId^^3 <
)^^< =
)^^= >
{__ 	
TempData`` 
[`` 
$str`` 
]`` 
=`` 
NegocioService``  .
.``. /"
MensajeSinVerificacion``/ E
;``E F
returnaa 
RedirectToActionaa #
(aa# $
nameofaa$ *
(aa* +
Perfilaa+ 1
)aa1 2
)aa2 3
;aa3 4
}bb 	
vardd 
dtodd 
=dd 
awaitdd 
negociosdd  
.dd  !"
ObtenerParaEditarAsyncdd! 7
(dd7 8
	UsuarioIddd8 A
)ddA B
;ddB C
ifee 

(ee 
dtoee 
isee 
nullee 
)ee 
returnee 
NotFoundee  (
(ee( )
)ee) *
;ee* +
returnff 
Viewff 
(ff 
dtoff 
)ff 
;ff 
}gg 
[ii 
HttpPostii 
,ii $
ValidateAntiForgeryTokenii '
]ii' (
publicjj 

asyncjj 
Taskjj 
<jj 
IActionResultjj #
>jj# $
Editarjj% +
(jj+ ,
EditarNegocioDtojj, <
dtojj= @
)jj@ A
{kk 
ifll 

(ll 
!ll 

ModelStatell 
.ll 
IsValidll 
)ll  
returnll! '
Viewll( ,
(ll, -
dtoll- 0
)ll0 1
;ll1 2
varnn 
(nn 
oknn 
,nn 
errornn 
)nn 
=nn 
awaitnn 
negociosnn  (
.nn( )
EditarAsyncnn) 4
(nn4 5
	UsuarioIdnn5 >
,nn> ?
dtonn@ C
)nnC D
;nnD E
ifoo 

(oo 
!oo 
okoo 
)oo 
{pp 	
ifqq 
(qq 
errorqq 
==qq 
NegocioServiceqq '
.qq' ("
MensajeSinVerificacionqq( >
)qq> ?
{rr 
TempDatass 
[ss 
$strss  
]ss  !
=ss" #
errorss$ )
;ss) *
returntt 
RedirectToActiontt '
(tt' (
nameoftt( .
(tt. /
Perfiltt/ 5
)tt5 6
)tt6 7
;tt7 8
}uu 

ModelStateww 
.ww 
AddModelErrorww $
(ww$ %
$strww% '
,ww' (
errorww) .
!ww. /
)ww/ 0
;ww0 1
returnxx 
Viewxx 
(xx 
dtoxx 
)xx 
;xx 
}yy 	
TempData{{ 
[{{ 
$str{{ 
]{{ 
={{ 
$str{{ K
;{{K L
return|| 
RedirectToAction|| 
(||  
nameof||  &
(||& '
Perfil||' -
)||- .
)||. /
;||/ 0
}}} 
[
ÅÅ 
HttpPost
ÅÅ 
,
ÅÅ &
ValidateAntiForgeryToken
ÅÅ '
]
ÅÅ' (
public
ÇÇ 

async
ÇÇ 
Task
ÇÇ 
<
ÇÇ 
IActionResult
ÇÇ #
>
ÇÇ# $"
VerificarEliminacion
ÇÇ% 9
(
ÇÇ9 :
EliminarCuentaDto
ÇÇ: K
dto
ÇÇL O
)
ÇÇO P
{
ÉÉ 
if
ÑÑ 

(
ÑÑ 
!
ÑÑ 

ModelState
ÑÑ 
.
ÑÑ 
IsValid
ÑÑ 
)
ÑÑ  
return
ÑÑ! '
Json
ÑÑ( ,
(
ÑÑ, -
new
ÑÑ- 0
{
ÑÑ1 2
ok
ÑÑ3 5
=
ÑÑ6 7
false
ÑÑ8 =
,
ÑÑ= >
error
ÑÑ? D
=
ÑÑE F
$str
ÑÑG ^
}
ÑÑ_ `
)
ÑÑ` a
;
ÑÑa b
var
ÜÜ 
(
ÜÜ 
ok
ÜÜ 
,
ÜÜ 
error
ÜÜ 
)
ÜÜ 
=
ÜÜ 
await
ÜÜ 
negocios
ÜÜ  (
.
ÜÜ( )%
ValidarEliminacionAsync
ÜÜ) @
(
ÜÜ@ A
	UsuarioId
ÜÜA J
,
ÜÜJ K
dto
ÜÜL O
.
ÜÜO P
Password
ÜÜP X
)
ÜÜX Y
;
ÜÜY Z
return
áá 
Json
áá 
(
áá 
new
áá 
{
áá 
ok
áá 
,
áá 
error
áá #
}
áá$ %
)
áá% &
;
áá& '
}
àà 
[
ãã 
HttpPost
ãã 
,
ãã &
ValidateAntiForgeryToken
ãã '
]
ãã' (
public
åå 

async
åå 
Task
åå 
<
åå 
IActionResult
åå #
>
åå# $
EliminarCuenta
åå% 3
(
åå3 4
EliminarCuentaDto
åå4 E
dto
ååF I
)
ååI J
{
çç 
if
éé 

(
éé 
!
éé 

ModelState
éé 
.
éé 
IsValid
éé 
)
éé  
{
èè 	
TempData
êê 
[
êê 
$str
êê 
]
êê 
=
êê 
$str
êê  7
;
êê7 8
return
ëë 
RedirectToAction
ëë #
(
ëë# $
nameof
ëë$ *
(
ëë* +
Perfil
ëë+ 1
)
ëë1 2
)
ëë2 3
;
ëë3 4
}
íí 	
var
îî 
(
îî 
ok
îî 
,
îî 
error
îî 
)
îî 
=
îî 
await
îî 
negocios
îî  (
.
îî( )!
EliminarCuentaAsync
îî) <
(
îî< =
	UsuarioId
îî= F
,
îîF G
dto
îîH K
.
îîK L
Password
îîL T
)
îîT U
;
îîU V
if
ïï 

(
ïï 
!
ïï 
ok
ïï 
)
ïï 
{
ññ 	
TempData
óó 
[
óó 
$str
óó 
]
óó 
=
óó 
error
óó  %
;
óó% &
return
òò 
RedirectToAction
òò #
(
òò# $
nameof
òò$ *
(
òò* +
Perfil
òò+ 1
)
òò1 2
)
òò2 3
;
òò3 4
}
ôô 	
await
õõ 
HttpContext
õõ 
.
õõ 
SignOutAsync
õõ &
(
õõ& '*
CookieAuthenticationDefaults
õõ' C
.
õõC D"
AuthenticationScheme
õõD X
)
õõX Y
;
õõY Z
TempData
úú 
[
úú 
$str
úú 
]
úú 
=
úú 
$str
úú ;
;
úú; <
return
ùù 
RedirectToAction
ùù 
(
ùù  
$str
ùù  '
,
ùù' (
$str
ùù) /
)
ùù/ 0
;
ùù0 1
}
ûû 
[
°° 
AllowAnonymous
°° 
,
°° 
HttpGet
°° 
]
°° 
public
¢¢ 

async
¢¢ 
Task
¢¢ 
<
¢¢ 
IActionResult
¢¢ #
>
¢¢# $
Publico
¢¢% ,
(
¢¢, -
int
¢¢- 0
id
¢¢1 3
)
¢¢3 4
{
££ 
var
§§ 
perfil
§§ 
=
§§ 
await
§§ 
negocios
§§ #
.
§§# $'
ObtenerPerfilPublicoAsync
§§$ =
(
§§= >
id
§§> @
)
§§@ A
;
§§A B
if
•• 

(
•• 
perfil
•• 
is
•• 
null
•• 
)
•• 
return
•• "
NotFound
••# +
(
••+ ,
)
••, -
;
••- .
return
¶¶ 
View
¶¶ 
(
¶¶ 
perfil
¶¶ 
)
¶¶ 
;
¶¶ 
}
ßß 
}®® ˆ
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
public 
IActionResult 

StatusCode '
(' (
int( +
code, 0
)0 1
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
}%% òá
ZC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Controllers\AdminController.cs
[ 
	Authorize 

(
 
Roles 
= 
$str "
)" #
]# $
public 
class 
AdminController 
( "
IAdministracionService 
admin  
,  !
IReporteService 
reportes 
, 
IExportadorReportes 

exportador "
," #
ILogger		 
<		 
AdminController		 
>		 
logger		 #
)		# $
:		% &

Controller		' 1
{

 
private 
string 
EnlaceActivacion #
(# $
string$ *
token+ 0
)0 1
=>2 4
Url 
. 
Action 
( 
$str "
," #
$str$ -
,- .
new/ 2
{3 4
token5 :
}; <
,< =
Request> E
.E F
SchemeF L
)L M
!M N
;N O
[ 
HttpGet 
] 
public 

async 
Task 
< 
IActionResult #
># $
Negocios% -
(- .
). /
=>0 2
View3 7
(7 8
await8 =
admin> C
.C D
ListarNegociosAsyncD W
(W X
)X Y
)Y Z
;Z [
[ 
HttpPost 
, $
ValidateAntiForgeryToken '
]' (
public 

async 
Task 
< 
IActionResult #
># $
AprobarNegocio% 3
(3 4
int4 7
id8 :
): ;
{ 
var 
urlLogin 
= 
Url 
. 
Action !
(! "
$str" )
,) *
$str+ 4
,4 5
new6 9
{: ;
rol< ?
=@ A
nameofB H
(H I

RolUsuarioI S
.S T
NegocioT [
)[ \
}] ^
,^ _
Request` g
.g h
Schemeh n
)n o
!o p
;p q
var 
( 
ok 
, 
correoEnviado 
) 
=  !
await" '
admin( -
.- .
AprobarNegocioAsync. A
(A B
idB D
,D E
urlLoginF N
)N O
;O P
if 

( 
! 
ok 
) 
{ 	
TempData 
[ 
$str 
] 
= 
$str  C
;C D
} 	
else 
if 
( 
correoEnviado 
) 
{ 	
TempData 
[ 
$str 
] 
=  !
$str" x
;x y
}   	
else!! 
{"" 	
TempData## 
[## 
$str## 
]## 
=##  !
$str##" B
;##B C
TempData$$ 
[$$ 
$str$$ 
]$$ 
=$$ 
$str$$  w
;$$w x
}%% 	
return'' 
RedirectToAction'' 
(''  
nameof''  &
(''& '
Negocios''' /
)''/ 0
)''0 1
;''1 2
}(( 
[++ 
HttpGet++ 
]++ 
public,, 

async,, 
Task,, 
<,, 
IActionResult,, #
>,,# $
Administradores,,% 4
(,,4 5
),,5 6
=>,,7 9
View,,: >
(,,> ?
await,,? D
admin,,E J
.,,J K&
ListarAdministradoresAsync,,K e
(,,e f
),,f g
),,g h
;,,h i
[.. 
HttpGet.. 
].. 
public// 

IActionResult// "
RegistrarAdministrador// /
(/// 0
)//0 1
=>//2 4
View//5 9
(//9 :
new//: =$
RegistroAdministradorDto//> V
(//V W
)//W X
)//X Y
;//Y Z
[11 
HttpPost11 
,11 $
ValidateAntiForgeryToken11 '
]11' (
public22 

async22 
Task22 
<22 
IActionResult22 #
>22# $"
RegistrarAdministrador22% ;
(22; <$
RegistroAdministradorDto22< T
dto22U X
)22X Y
{33 
if44 

(44 
!44 

ModelState44 
.44 
IsValid44 
)44  
{55 	
if77 
(77 

ModelState77 
.77 
Values77 !
.77! "

SelectMany77" ,
(77, -
v77- .
=>77/ 1
v772 3
.773 4
Errors774 :
)77: ;
.77; <
Any77< ?
(77? @
e77@ A
=>77B D
e77E F
.77F G
ErrorMessage77G S
==77T V
RegistroNegocioDto77W i
.77i j
Obligatorio77j u
)77u v
)77v w

ModelState88 
.88 
AddModelError88 (
(88( )
$str88) +
,88+ ,
$str88- \
)88\ ]
;88] ^
return99 
View99 
(99 
dto99 
)99 
;99 
}:: 	
var== 
r== 
=== 
await== 
admin== 
.== '
RegistrarAdministradorAsync== 7
(==7 8
dto==8 ;
,==; <
EnlaceActivacion=== M
)==M N
;==N O
if>> 

(>> 
!>> 
r>> 
.>> 
Ok>> 
)>> 
{?? 	

ModelState@@ 
.@@ 
AddModelError@@ $
(@@$ %
$str@@% '
,@@' (
r@@) *
.@@* +
Error@@+ 0
!@@0 1
)@@1 2
;@@2 3
returnAA 
ViewAA 
(AA 
dtoAA 
)AA 
;AA 
}BB 	
varDD 
correoDD 
=DD 
dtoDD 
.DD 
CorreoDD 
.DD  
TrimDD  $
(DD$ %
)DD% &
;DD& '
ifEE 

(EE 
rEE 
.EE 
CorreoEnviadoEE 
)EE 
TempDataFF 
[FF 
$strFF 
]FF 
=FF  !
$"FF" $
$strFF$ V
{FFV W
correoFFW ]
}FF] ^
$str	FF^ é
"
FFé è
;
FFè ê
elseGG 
TempDataHH 
[HH 
$strHH 
]HH 
=HH 
$"HH  "
$strHH" v
{HHv w
correoHHw }
}HH} ~
$str	HH~ ±
"
HH± ≤
;
HH≤ ≥
returnJJ 
RedirectToActionJJ 
(JJ  
nameofJJ  &
(JJ& '
AdministradoresJJ' 6
)JJ6 7
)JJ7 8
;JJ8 9
}KK 
[MM 
HttpPostMM 
,MM $
ValidateAntiForgeryTokenMM '
]MM' (
publicNN 

asyncNN 
TaskNN 
<NN 
IActionResultNN #
>NN# $
ReenviarActivacionNN% 7
(NN7 8
intNN8 ;
idNN< >
)NN> ?
{OO 
varPP 
(PP 
okPP 
,PP 
mensajePP 
)PP 
=PP 
awaitPP !
adminPP" '
.PP' (#
ReenviarActivacionAsyncPP( ?
(PP? @
idPP@ B
,PPB C
EnlaceActivacionPPD T
)PPT U
;PPU V
TempDataQQ 
[QQ 
okQQ 
?QQ 
$strQQ 
:QQ  !
$strQQ" )
]QQ) *
=QQ+ ,
mensajeQQ- 4
;QQ4 5
returnRR 
RedirectToActionRR 
(RR  
nameofRR  &
(RR& '
AdministradoresRR' 6
)RR6 7
)RR7 8
;RR8 9
}SS 
privateVV 
constVV 
stringVV 
	MimeExcelVV "
=VV# $
$strVV% h
;VVh i
privateWW 
constWW 
stringWW 
MimePdfWW  
=WW! "
$strWW# 4
;WW4 5
privateXX 
constXX 
stringXX 
SinInformacionXX '
=XX( )
$strXX* o
;XXo p
privateZZ 
staticZZ 
stringZZ 
DiaZZ 
(ZZ 
DateTimeZZ &
?ZZ& '
dZZ( )
)ZZ) *
=>ZZ+ -
dZZ. /
!ZZ/ 0
.ZZ0 1
ValueZZ1 6
.ZZ6 7
ToStringZZ7 ?
(ZZ? @
$strZZ@ L
)ZZL M
;ZZM N
[\\ 
HttpGet\\ 
]\\ 
public]] 

async]] 
Task]] 
<]] 
IActionResult]] #
>]]# $
Reportes]]% -
(]]- .
DateTime]]. 6
?]]6 7
desde]]8 =
,]]= >
DateTime]]? G
?]]G H
hasta]]I N
)]]N O
{^^ 
var__ 
hoy__ 
=__ 
DateTime__ 
.__ 
Today__  
;__  !
var`` 
vista`` 
=`` 
new`` 
ReporteAdminVista`` )
{aa 	
Desdebb 
=bb 
desdebb 
?bb 
.bb 
Datebb 
??bb  "
newbb# &
DateTimebb' /
(bb/ 0
hoybb0 3
.bb3 4
Yearbb4 8
,bb8 9
hoybb: =
.bb= >
Monthbb> C
,bbC D
$numbbE F
)bbF G
,bbG H
Hastacc 
=cc 
hastacc 
?cc 
.cc 
Datecc 
??cc  "
hoycc# &
}dd 	
;dd	 

ifff 

(ff 
desdeff 
isff 
nullff 
&&ff 
hastaff "
isff# %
nullff& *
)ff* +
returnff, 2
Viewff3 7
(ff7 8
vistaff8 =
)ff= >
;ff> ?
vistahh 
.hh 
Errorhh 
=hh 
RangoReportehh "
.hh" #
Validarhh# *
(hh* +
desdehh+ 0
,hh0 1
hastahh2 7
)hh7 8
;hh8 9
ifii 

(ii 
vistaii 
.ii 
Errorii 
isii 
notii 
nullii #
)ii# $
returnii% +
Viewii, 0
(ii0 1
vistaii1 6
)ii6 7
;ii7 8
trykk 
{ll 	
varmm 
reportemm 
=mm 
awaitmm 
reportesmm  (
.mm( )$
GenerarReporteAdminAsyncmm) A
(mmA B
desdemmB G
!mmG H
.mmH I
ValuemmI N
,mmN O
hastammP U
!mmU V
.mmV W
ValuemmW \
)mm\ ]
;mm] ^
ifnn 
(nn 
reportenn 
.nn 
NegociosRegistradosnn +
==nn, .
$numnn/ 0
&&nn1 3
reportenn4 ;
.nn; <#
RepartidoresRegistradosnn< S
==nnT V
$numnnW X
&&nnY [
reportenn\ c
.nnc d
TotalPedidosnnd p
==nnq s
$numnnt u
)nnu v
vistaoo 
.oo 
Avisooo 
=oo 
SinInformacionoo ,
;oo, -
elsepp 
vistaqq 
.qq 
Reporteqq 
=qq 
reporteqq  '
;qq' (
}rr 	
catchss 
(ss 
	Exceptionss 
exss 
)ss 
{tt 	
loggeruu 
.uu 
LogErroruu 
(uu 
exuu 
,uu 
$struu  V
)uuV W
;uuW X
vistavv 
.vv 
Errorvv 
=vv 
$strvv Q
;vvQ R
}ww 	
returnyy 
Viewyy 
(yy 
vistayy 
)yy 
;yy 
}zz 
[|| 
HttpGet|| 
]|| 
public}} 

async}} 
Task}} 
<}} 
IActionResult}} #
>}}# $
DescargarReporte}}% 5
(}}5 6
DateTime}}6 >
?}}> ?
desde}}@ E
,}}E F
DateTime}}G O
?}}O P
hasta}}Q V
,}}V W
string}}X ^
formato}}_ f
=}}g h
$str}}i p
)}}p q
{~~ 
var 
error 
= 
RangoReporte  
.  !
Validar! (
(( )
desde) .
,. /
hasta0 5
)5 6
;6 7
if
ÄÄ 

(
ÄÄ 
error
ÄÄ 
is
ÄÄ 
not
ÄÄ 
null
ÄÄ 
)
ÄÄ 
{
ÅÅ 	
TempData
ÇÇ 
[
ÇÇ 
$str
ÇÇ 
]
ÇÇ 
=
ÇÇ 
error
ÇÇ  %
;
ÇÇ% &
return
ÉÉ 
RedirectToAction
ÉÉ #
(
ÉÉ# $
nameof
ÉÉ$ *
(
ÉÉ* +
Reportes
ÉÉ+ 3
)
ÉÉ3 4
)
ÉÉ4 5
;
ÉÉ5 6
}
ÑÑ 	
try
ÜÜ 
{
áá 	
var
àà 
reporte
àà 
=
àà 
await
àà 
reportes
àà  (
.
àà( )&
GenerarReporteAdminAsync
àà) A
(
ààA B
desde
ààB G
!
ààG H
.
ààH I
Value
ààI N
,
ààN O
hasta
ààP U
!
ààU V
.
ààV W
Value
ààW \
)
àà\ ]
;
àà] ^
if
ââ 
(
ââ 
reporte
ââ 
.
ââ !
NegociosRegistrados
ââ +
==
ââ, .
$num
ââ/ 0
&&
ââ1 3
reporte
ââ4 ;
.
ââ; <%
RepartidoresRegistrados
ââ< S
==
ââT V
$num
ââW X
&&
ââY [
reporte
ââ\ c
.
ââc d
TotalPedidos
ââd p
==
ââq s
$num
âât u
)
ââu v
{
ää 
TempData
ãã 
[
ãã 
$str
ãã  
]
ãã  !
=
ãã" #
SinInformacion
ãã$ 2
;
ãã2 3
return
åå 
RedirectToAction
åå '
(
åå' (
nameof
åå( .
(
åå. /
Reportes
åå/ 7
)
åå7 8
,
åå8 9
new
åå: =
{
åå> ?
desde
åå@ E
=
ååF G
Dia
ååH K
(
ååK L
desde
ååL Q
)
ååQ R
,
ååR S
hasta
ååT Y
=
ååZ [
Dia
åå\ _
(
åå_ `
hasta
åå` e
)
ååe f
}
ååg h
)
ååh i
;
ååi j
}
çç 
var
èè 
nombre
èè 
=
èè 
$"
èè 
$str
èè .
{
èè. /
desde
èè/ 4
.
èè4 5
Value
èè5 :
:
èè: ;
$str
èè; C
}
èèC D
$str
èèD E
{
èèE F
hasta
èèF K
.
èèK L
Value
èèL Q
:
èèQ R
$str
èèR Z
}
èèZ [
"
èè[ \
;
èè\ ]
return
êê 
formato
êê 
.
êê 
Equals
êê !
(
êê! "
$str
êê" '
,
êê' (
StringComparison
êê) 9
.
êê9 :
OrdinalIgnoreCase
êê: K
)
êêK L
?
ëë 
File
ëë 
(
ëë 

exportador
ëë !
.
ëë! "
ReporteAdminPdf
ëë" 1
(
ëë1 2
reporte
ëë2 9
)
ëë9 :
,
ëë: ;
MimePdf
ëë< C
,
ëëC D
nombre
ëëE K
+
ëëL M
$str
ëëN T
)
ëëT U
:
íí 
File
íí 
(
íí 

exportador
íí !
.
íí! "
ReporteAdminExcel
íí" 3
(
íí3 4
reporte
íí4 ;
)
íí; <
,
íí< =
	MimeExcel
íí> G
,
ííG H
nombre
ííI O
+
ííP Q
$str
ííR Y
)
ííY Z
;
ííZ [
}
ìì 	
catch
îî 
(
îî 
	Exception
îî 
ex
îî 
)
îî 
{
ïï 	
logger
ññ 
.
ññ 
LogError
ññ 
(
ññ 
ex
ññ 
,
ññ 
$str
ññ  W
)
ññW X
;
ññX Y
TempData
óó 
[
óó 
$str
óó 
]
óó 
=
óó 
$str
óó  W
;
óóW X
return
òò 
RedirectToAction
òò #
(
òò# $
nameof
òò$ *
(
òò* +
Reportes
òò+ 3
)
òò3 4
,
òò4 5
new
òò6 9
{
òò: ;
desde
òò< A
=
òòB C
Dia
òòD G
(
òòG H
desde
òòH M
)
òòM N
,
òòN O
hasta
òòP U
=
òòV W
Dia
òòX [
(
òò[ \
hasta
òò\ a
)
òòa b
}
òòc d
)
òòd e
;
òòe f
}
ôô 	
}
öö 
}õõ 
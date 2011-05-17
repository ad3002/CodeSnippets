# Примеры подключения рекламного модуля

## До установки

**ПРОВЕРИТЬ ЧТО НЕ СТОИТ ADBLOCK!!!**

Добавить в проект приложения модуль nwm.swc (прописать путь к модулю в путях сборки/добавить путь к swc в Library path).

## Варианты установки:

1. Самый простой вариант установки - вы сами передаете данные о пользователе (ExampleYourUserInfo.as).
2. Вы не используете wrapper и хотите, чтобы модуль сам получил данные о пользователе (ExampleWithNoWrapper.as)
3. Вы используете wrapper и хотите, чтобы модуль сам получил данные о пользователе (ExampleWithWrapper.as) 

## Порядок установки:

1. Импортировать классы модуля
	
	import nwm.NWM;
	import nwm.NWMEvent;

2. Для начала необходимо подготовить объект NWMParameters, которым инициализируется модуль (описание его параметров смотрите ниже, примеры в примерах)

3. В функции инициализации приложения (Init), в прелоадере либо месте программы, где вы планируете инициализировать модуль, разместить код вызова PreRoll-a. 


## Параметры NWMParameters

Все параметры __обязательны__, если не указано обратное.

**width** - ширина области показа рекламы
**height** - высота области показа рекламы

Width И height желательно делать как размер вашего приложения.

**flashVars** - flashVars или null

Нужно указывать вместе с social_network, если вы только хотите, чтобы модуль сам запрашивал информацию о пользователе.

**appIdNWM** - appIdNWM, обратите внимание, что appIdNWM – не app_id вконтактовский, а id, который вы получаете для модуля NWM.

Тестовый appIdNWM - 172483.

**userParameters** - null или Object с данными пользователя

Если вы передаете userParameters, вам нужно поставить social_network и flashVars равным null
Если вы хотите, чтобы модуль сам получал эти данные, то null

**skip_button** - null или ваша кнопка

**callback** - null или функция которая, будет отлавливать события в модуле (альтернатива обычным addEventListener)

**social_network** - "vkontakte" или null
 
**background_alpha** - прозрачность затемнения фона при показе рекламы (от нуля до единицы)

**show_debugger** - показывать или нет debugger (значение true или false)

## События модуля

Можно отлавливать следующие события

nwm_clip.addEventListener(NWMEvent.FINISHED , function(e:Event) {});
nwm_clip.addEventListener(NWMEvent.SKIPPED , function(e:Event) {});
nwm_clip.addEventListener(NWMEvent.CLICKED , function(e:Event) {});
nwm_clip.addEventListener(NWMEvent.FAILED , function(e:Event) {});
nwm_clip.addEventListener(NWMEvent.SUCCESS , function(e:Event) {});

Если не удалось запустить рекламу, то идет событие **NWMEvent.FAILED**, если релама запустилась, то **NWMEvent.SUCCESS**.
Дальше два варианта развития событий: **NWMEvent.SKIPPED** или **NWMEvent.CLICKED**. 
В конце идет событие **NWMEvent.FINISHED**.

## Дополнительные примеры:

1. Использование своего курсора (ExampleCursor.as)


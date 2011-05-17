# Примеры подключения рекламного модуля

## До установки

**ПРОВЕРИТЬ ЧТО НЕ СТОИТ ADBLOCK!!!**

**Узнайте, **настроена** ли ваша рекламная компания или используйте тестовый appIdNWM.**

Добавить в проект приложения модуль **nwm.swc** (прописать путь к модулю в путях сборки/добавить путь к swc в Library path).


## Варианты установки:

1. Самый простой вариант установки - вы сами передаете данные о пользователе (ExampleYourUserInfo.as).
2. Вы не используете wrapper и хотите, чтобы модуль сам получил данные о пользователе (ExampleWithNoWrapper.as)
3. Вы используете wrapper и хотите, чтобы модуль сам получил данные о пользователе (ExampleWithWrapper.as) 

## Порядок установки:

**Шаг раз**. Импортировать классы модуля
	
    import nwm.NWM;
    import nwm.NWMEvent;

**Шаг два**. Для начала необходимо подготовить объект NWMParameters, которым инициализируется модуль (описание его параметров смотрите ниже, примеры в примерах)

    var NWMParameters:Object = {
        width: 800,
        height: 600,
        flashVars: null,
        appIdNWM: 172483,
        userParameters: userParameters,
        skip_button: null,
        callback : null,
        social_network: null,
        background_alpha: 0.7,
        show_debugger: false
    };

Пример userParameters:

    userParameters = {
        uid: 1,
        sex: 2,
        city_name: "Санкт-Петербург",
        country_name: "Россия",
        bdate: "1917-01-09"
    }

Все параметры userParameters обязательны, если вконтакт не возвратил какое-либо значений, то ставьте пустую строку.

**Шаг три**. В функции инициализации приложения (Init), в прелоадере либо месте программы, где вы планируете инициализировать модуль, разместить код вызова PreRoll-a. 
Для отображения рекламы, ее необходимо добавить на сцену. Модуль требует инициализации, таким образом, это добавляет еще 3 строчки кода.

    nwm_clip = new NWM();
    NWM.instance().init(userParameters);
    addChild(nwm_clip);

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

**callback** - null или функция которая, будет отлавливать события в модуле (альтернатива обычным addEventListener). Пример использование смотрите ниже.

**social_network** - "vkontakte" или null
 
**background_alpha** - прозрачность затемнения фона при показе рекламы (от нуля до единицы)

**show_debugger** - показывать или нет debugger (значение true или false)

## События модуля

Можно отлавливать следующие события

    nwm_clip.addEventListener(NWMEvent.FINISHED , onFinished);
    nwm_clip.addEventListener(NWMEvent.SKIPPED , onSkipped);
    nwm_clip.addEventListener(NWMEvent.CLICKED , onClicked);
    nwm_clip.addEventListener(NWMEvent.FAILED , onFailed);
    nwm_clip.addEventListener(NWMEvent.SUCCESS , onSucces);

Если не удалось запустить рекламу, то идет событие **NWMEvent.FAILED**, если релама запустилась, то **NWMEvent.SUCCESS**.
Дальше два варианта развития событий: **NWMEvent.SKIPPED** или **NWMEvent.CLICKED**. 
В конце идет событие **NWMEvent.FINISHED**.

## Использование функции callback

Это функция, которая будет обрабатывать ответы от модуля.  
Т.е. при наступлении определенного события, или, если в дальнейшем модуль будет изменяться и понадобится передавать некторые данные,  
модуль будет вызывать эту функцию – соответственно, ваше приложение будет эти данные получать. 
Если данные вам неинтересны/не нужны, напишите  'callback' : null. Или исопльзуйте addEventListener (см. выше)

Поймать можно теже пять событий:  NWMEvent.FINISHED, NWMEvent.SUCCESS, NWMEvent.FAILED, NWMEvent.SKIPPED, NWMEvent.CLICKED.

Пример:

    private function NWMCallback (result:Object):void {
        trace('\nRESPONSE: '+ result.toString());
        if (result == NWMEvent.SUCCESS) {
            addChild(nwm_clip); // как пример
        } else {
            // your code
        }
    };


## Дополнительные примеры:

1. Использование своего курсора (ExampleCursor.as)
package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import nwm.NWM;
	import nwm.NWMEvent;
	
	public class ExampleYourUserInfo extends Sprite
	{
		// Пример использования рекламного модуля, 
		// когда данные о пользователе вы передаете сами
		// Нужно, например, если у вас получает несколько запрос к API в секунду из-за модуля
		
		private var initObject : Object;
		private var nwm_clip:NWM;
		private var flashVars:Object;
		private var wrapper: Object;
		
		public function ExampleYourUserInfo()
		{			
			start_ad();
		}
		
		public function start_ad():void {
			
			userParameters = {
				country_name: "Россия",
				sex: 2,
				uid: 1,
				city_name: "Санкт-Петербург",
				bdate: "1917-01-09"
			}
			
			var NWMParametesMock:Object = {
				width: 800,
				height: 600,
				flashVars: null, // не передаем flashVars
				appIdNWM: 172483, // тестовый id
				userParameters: userParameters, // зато передаем userParameters
				skip_button: null,
				callback : null,
				social_network: null, // говорим, что НЕ хотим, чтобы модуль исользовал API
				background_alpha: 0.7,
				show_debugger: true
			};
			
			nwm_clip = new NWM();
			NWM.instance().init(NWMParametesMock);
			addChild(nwm_clip);
			
			nwm_clip.addEventListener(NWMEvent.FINISHED , function(e:Event) {});
			nwm_clip.addEventListener(NWMEvent.SKIPPED , function(e:Event) {});
			nwm_clip.addEventListener(NWMEvent.CLICKED , function(e:Event) {});
			nwm_clip.addEventListener(NWMEvent.FAILED , function(e:Event) {});
			nwm_clip.addEventListener(NWMEvent.SUCCESS , function(e:Event) {});
			
		}
	}
}
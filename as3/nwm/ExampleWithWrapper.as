package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import nwm.NWM;
	import nwm.NWMEvent;
	
	public class ExampleWithWrapper extends Sprite
	{
		// Пример использования рекламного модуля с враппером вконтакта
		// Модуль САМ получает данные о пользователе с вконтакта
		// ВАЖНО!!! Помните по ОДИН запрос к API в секунду
		// ВАЖНО!!! Этот вариант НЕ БУДЕТ работать локально
		
		private var initObject : Object;
		private var nwm_clip:NWM;
		private var flashVars:Object;
		private var wrapper: Object;
		
		public function ExampleWithWrapper()
		{			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		
			// Получаем flashVars
			// ВАЖНО!!! Это нужно минимум делать на onAddedToStage
			wrapper = Object(parent.parent);
			flashVars = wrapper.application.parameters;
			
			start_ad();
		}
		
		public function start_ad():void {
			
			var NWMParameters:Object = {
				width: 800,
				height: 600,
				flashVars: flashVars, // передаем полученные flashVars
				appIdNWM: 172483, // тестовый id
				userParameters: null, // Модуль сам получит эти данные
				skip_button: null,
				callback : null,
				social_network: "vkontakte", // говорим, что хотим, чтобы модуль исользовал API
				background_alpha: 0.7,
				show_debugger: true
			};
			
			nwm_clip = new NWM();
			NWM.instance().init(NWMParameters);
			addChild(nwm_clip);
			
			nwm_clip.addEventListener(NWMEvent.FINISHED , function(e:Event) {});
			nwm_clip.addEventListener(NWMEvent.SKIPPED , function(e:Event) {});
			nwm_clip.addEventListener(NWMEvent.CLICKED , function(e:Event) {});
			nwm_clip.addEventListener(NWMEvent.FAILED , function(e:Event) {});
			nwm_clip.addEventListener(NWMEvent.SUCCESS , function(e:Event) {});
			
		}
	}
}
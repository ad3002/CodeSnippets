package
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	import nwm.NWM;
	import nwm.NWMEvent;
	
	public class ExampleCursor extends Sprite
	{
		// Пример использования рекламного модуля и своего курсора
		
		private var initObject : Object;
		private var nwm_clip:NWM;
        
		// Курсор
		public var newCursor:Sprite = null;
		
		public function ExampleCursor()
		{			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addCustomCursor();
			start_ad();
		}
		
		private function addCustomCursor(e:Event=null):void {
			
			// Рисуем искусственый курсор
			if (!newCursor) {
				newCursor = new Sprite();
				newCursor.graphics.beginFill(0x000000);
				newCursor.graphics.moveTo(0,0);
				newCursor.graphics.lineTo(20,10);
				newCursor.graphics.lineTo(10,10);
				newCursor.graphics.lineTo(10,20);
				newCursor.graphics.lineTo(0,0);
				newCursor.graphics.endFill();
			}
			
			// Не ловим им события и рисуем его как битмам для быстроты
			newCursor.mouseEnabled = false;
			newCursor.cacheAsBitmap = true;
			
			addChild(newCursor);
			
			// Ловим события нового курсора
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			// Прячем системный курсор
			Mouse.hide();
		}
		
		private function removeCustomCursor(e:Event=null):void {
			// Функция убирает наш курсор
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			
			newCursor.mouseEnabled = true;
			removeChild(newCursor);
			Mouse.show();
		}
		
		public function mouseMove(e:MouseEvent):void
		{
			// Обработка позиции искусственного курсора
			newCursor.x = mouseX;
			newCursor.y = mouseY;
			e.updateAfterEvent();
		}
			
		public function start_ad(e:MouseEvent=null):void {
			
			try {
				stage.removeEventListener(MouseEvent.CLICK, start_ad);
			} catch (e:*) {
				
			}
			
			var userInfoMock:Object = {
				sex: 1,
				bdate: "1917-01-09",
				uid: 1,
				city_name: "st.petersburg",
				country_name: "russia"
			};
			
           	var NWMParameters:Object = {
				width: 800,
				height: 600,
				flashVars: null,
				appIdNWM: 172483,
				userParameters: userInfoMock,
				skip_button: null,
				callback : null,
				social_network: null,
				background_alpha: 0,
				show_debugger: true
			};
			
			nwm_clip = new NWM();
			NWM.instance().init(NWMParameters);
			removeCustomCursor();
			addChild(nwm_clip);
			
			// Для того чтобы вернуть свой курсор после показа рекламы,
			// нужно обрабатывать следующие события:
			
			nwm_clip.addEventListener(NWMEvent.FINISHED , addCustomCursor);
			nwm_clip.addEventListener(NWMEvent.SKIPPED , addCustomCursor);
			nwm_clip.addEventListener(NWMEvent.CLICKED , addCustomCursor);
			nwm_clip.addEventListener(NWMEvent.FAILED , addCustomCursor);
			nwm_clip.addEventListener(NWMEvent.SUCCESS , addCustomCursor);
									
		}
			
	}
}
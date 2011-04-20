package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	import nwm.NWM;
	import nwm.NWMEvent;
	
	public class ExampleWithCursor extends Sprite
	{
		// Пример использования рекламного модуля и своего курсора
		
		private var initObject : Object;
		private static const VK_API_SECRET_SHORT:String = "AUe9i7fS5AeMbwIW7ZXu";
		private static const VK_API_ID:Number = 2030957;
                private static const SID:String = 'bca0e67e6c7a77c0f713bd9fa4468db92ce4c858830aebe1f60d8c83bcb60e';
		
		private var nwm_clip:NWM;
                private var flashVarsMock:Object;
		
		// Курсор
		public var newCursor:Sprite = null;
		
		public function ExampleWithCursor()
		{			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			flashVarsMock = stage.loaderInfo.parameters as Object;
			// Добавляем курсор
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
			
			stage.removeEventListener(MouseEvent.CLICK, start_ad);
			
			var userInfoMock:Object = {
				sex: 2,
				bdate: "1917-01-09",
				uid: 1,
				city_name: "st.petersburg",
				country_name: "russia"
			};
			
                        if (!flashVarsMock) {

				flashVarsMock = {
					api_id : VK_API_ID,
					viewer_id : '170898',
					user_id : '170898',
					sid : SID,
					secret : VK_API_SECRET_SHORT,
					is_app_user : 1,
					api_url : 'http://api.vkontakte.ru/api.php'
				};
			}

			var NWMParametesMock:Object = {
				width: 800,
				height: 600,
				flashVars: flashVarsMock,
				appIdNWM: 170207,
				userParameters: userInfoMock,
				skip_button: null,
				callback : null
			};
			
			
			
			nwm_clip = new NWM();
			NWM.instance().init(NWMParametesMock);
			removeCustomCursor();
			addChild(nwm_clip);
			
			// Для того чтобы вернуть свой курсор после показа рекламы,
			// нужно обрабатывать следующие события:
			
			nwm_clip.addEventListener(NWMEvent.FINISHED , addCustomCursor);
			nwm_clip.addEventListener(NWMEvent.SKIPPED , addCustomCursor);
			nwm_clip.addEventListener(NWMEvent.CLICKED , addCustomCursor);
			nwm_clip.addEventListener(NWMEvent.FAILED , addCustomCursor);
			nwm_clip.addEventListener(NWMEvent.SUCCESS , function() {});
									
		}
	}
}
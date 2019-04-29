<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <link rel="stylesheet" href="/css/test/app.css">
  <div class="chat-column">
	<div id="scrollingChat">
		<div class="segments load">
			<div class="from-watson top">
				<div class="message-inner">
					<p>Hello, I am the bank's Virtual Agentㅁ.</p>
				</div>
			</div>
		</div>
		<div class="segments load">
			<div class="from-watson sub">
				<div class="message-inner">
					<p>
						I can help you with a number of banking tasks:<ul>
						<li><div class="options-list"
								onclick="ConversationPanel.sendMessage('I want to make a credit card payment');">Making a credit card payment</div></li>
						<li><div class="options-list"
								onclick="ConversationPanel.sendMessage('I want to book an appointment with a banker');">Booking an appointment with a banker</div></li>
						<li><div class="options-list"
								onclick="ConversationPanel.sendMessage('Help me choose a credit card');">Choosing a credit card</div></li>
					</ul>
					</p>
				</div>
			</div>
		</div>
		</div>
        <label
							for="textInput" class="inputOutline"> <input
							id="textInput" class="input responsive-column"
							placeholder="Type something" type="text"
							onkeydown="ConversationPanel.inputKeyDown(event, this)"
							autofocus="" style="width:100%">
        </label>
        
					<div class="disclaimer">
          * This system is for demonstration purposes only and is not intended to process Personal Data. No Personal
          Data is to be entered
          into this system as it may not have the necessary controls in place to meet the requirements of the General
          Data Protection
          Regulation (EU) 2016/679.
        </div>
        
     </div>
      <script>

</script>
  <script src="/css/test/common.js"></script>
  <script src="/css/test/api.js"></script>
  <script src="/css/test/conversation.js"></script>
  <script src="/css/test/payload.js"></script>
  <script src="/css/test/global.js"></script>
  <script type="text/javascript" src="https://cdn.rawgit.com/watson-developer-cloud/watson-developer-cloud.github.io/master/analytics.js"></script>
 

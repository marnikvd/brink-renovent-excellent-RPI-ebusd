# brink renovent excellent + Raspberry Pi + ebusd</br>
<p>sources
<ul>
	<li><a href="https://forum.fhem.de/index.php/topic,84636.0.html">Raspberry pi extension board</a><img src="https://forum.fhem.de/index.php?action=dlattach;topic=84636.0;attach=96686;image"></li>
	<li>https://github.com/john30/ebusd</li>
	<li>https://github.com/eBUS/ttyebus</li>
	<li>https://github.com/timd93/ebusd-config-brink-renovent-excellent-300</li>
	<li>mosquitto</li>
	<li>node.js</li>
	<li>android mqtt dash
	<ul>
		<li>button 1 (handled by setvent_1.js)
		<ul>
			<li>Topic = renovent</li>
			<li>Options =
			<ul>
				<li>Payload = Minimal</li>
				<li>Payload = Reduced</li>
				<li>Payload = Normal</li>
				<li>Payload = Intensive</li>
			</ul></li>    
		</ul></li>
		<li>button 2 (<a href="https://github.com/john30/ebusd/wiki/3.3.-MQTT-client">handled by ebusd</a>)
		<ul>
			<li>Topic = ebusd/kwl/FanSpeed</li>
			<li>JSON path = $.0.value</li>
		</ul></li>
	</ul></li>
</ul></p>

package com.talagroups.card;


import org.junit.Test;

public class ScrollingActivityTest {
	@Test
	public void onColorSelected() {
		ScrollingActivity s = new ScrollingActivity();
		int dialogId = 123;
		int color = 123;
		s.onColorSelected(dialogId, color);
	}
}

package com.talagroups.card;
import android.app.Activity;
import android.content.SharedPreferences;
import android.graphics.PixelFormat;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import com.jrummyapps.android.colorpicker.ColorPanelView;
import com.jrummyapps.android.colorpicker.ColorPickerView;
import com.jrummyapps.android.colorpicker.ColorPickerView.OnColorChangedListener;
/**
 * Created by a7med on 05/17/2017.
 */

public class ColorPickerActivity extends Activity implements OnColorChangedListener, View.OnClickListener {
    private ColorPickerView colorPickerView;
    private ColorPanelView newColorPanelView;

    @Override protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFormat(PixelFormat.RGBA_8888);

        setContentView(R.layout.activity_color_picker);

        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(this);
        int initialColor = prefs.getInt("color_3", 0xFF000000);

        colorPickerView = (ColorPickerView) findViewById(com.jrummyapps.android.colorpicker.R.id.cpv_color_picker_view);
        ColorPanelView colorPanelView = (ColorPanelView) findViewById(com.jrummyapps.android.colorpicker.R.id.cpv_color_panel_old);
        newColorPanelView = (ColorPanelView) findViewById(com.jrummyapps.android.colorpicker.R.id.cpv_color_panel_new);

        Button btnOK = (Button) findViewById(R.id.okButton);
        Button btnCancel = (Button) findViewById(R.id.cancelButton);

        ((LinearLayout) colorPanelView.getParent())
                .setPadding(colorPickerView.getPaddingLeft(), 0, colorPickerView.getPaddingRight(), 0);

        colorPickerView.setOnColorChangedListener(this);
        colorPickerView.setColor(initialColor, true);
        colorPanelView.setColor(initialColor);

        btnOK.setOnClickListener(this);
        btnCancel.setOnClickListener(this);

    }

    @Override
    public void onClick(View view) {

    }

    @Override
    public void onColorChanged(int newColor) {

    }
}

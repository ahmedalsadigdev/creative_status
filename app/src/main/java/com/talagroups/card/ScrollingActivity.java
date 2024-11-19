package com.talagroups.card;

import android.Manifest;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.graphics.Typeface;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.provider.MediaStore;
import android.util.Log;
import android.util.TypedValue;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;
import androidx.annotation.ColorInt;
import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.core.app.ActivityCompat;
import androidx.databinding.DataBindingUtil;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.jrummyapps.android.colorpicker.ColorPickerDialog;
import com.jrummyapps.android.colorpicker.ColorPickerDialogListener;
import com.talagroups.card.model.TextCard;
import java.io.ByteArrayOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import io.realm.Realm;
import io.realm.exceptions.RealmError;


public class ScrollingActivity extends AppCompatActivity implements ColorPickerDialogListener  {
ImageView img_txt_clr , img_bg_clr , img_txt_pluse, img_txt_minse ,img_txt_bold,img_txt_italy;
    Toolbar toolbar;
    EditText txt_card;
    FloatingActionButton fab;
    private static  int A = 0;
    private static final String TAG ="logs permission" ;
    private static final int DIALOG_ID = 0;
    public static  float size= 0;
    boolean click = true;
    boolean Iclick = true;
    Realm realms;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        DataBindingUtil.setContentView(this,R.layout.activity_scrolling);
        // admob

        iniView();

        isStoragePermissionGranted();
        setSupportActionBar(toolbar);
// database
        realms = Realm.getDefaultInstance();

        // Read Database Card
      txt_card.setText(DisplayLastCard());


        //region share button image
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                if (txt_card.getText().length() >0){
               if (isStoragePermissionGranted()){

                txt_card.setFocusable(false);

                txt_card.setDrawingCacheEnabled(true);
                txt_card.destroyDrawingCache();
                txt_card.buildDrawingCache();
                Bitmap bitmap = getTransparentBitmapCopy(txt_card.getDrawingCache());
                share_bitMap_to_Apps(bitmap);
                   // Save Card in Database
                   WriteToDB(txt_card.getText().toString());

                   txt_card.setFocusable(true);
                   txt_card.setFocusableInTouchMode(true);
               }
                }else {
                    Toast.makeText(getApplicationContext(), "Please write text to share",Toast.LENGTH_LONG).show();
                }
            }
        });
        //endregion

        //region btn color
        img_txt_clr.setOnClickListener(new View.OnClickListener() {
         @Override
         public void onClick(View view) {
             A = 1;
             ColorPickerDialog.newBuilder()
                     .setDialogType(ColorPickerDialog.TYPE_PRESETS)
                     .setAllowPresets(false)
                     .setDialogId(DIALOG_ID)
                     .setColor(Color.BLACK)
                     .setShowAlphaSlider(true)
                     .show(ScrollingActivity.this);
         }
     });

        img_bg_clr.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                A =2;
                ColorPickerDialog.newBuilder()
                        .setDialogType(ColorPickerDialog.TYPE_PRESETS)
                        .setAllowPresets(false)
                        .setDialogId(DIALOG_ID)
                        .setColor(Color.BLACK)
                        .setShowAlphaSlider(true)
                        .show(ScrollingActivity.this);
            }
        });
        //endregion

        //region font size
        size  = getResources().getDimension(R.dimen.textsize1);
        img_txt_pluse.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                txt_card.setTextSize(TypedValue.COMPLEX_UNIT_SP , size +=2);
                Toast.makeText(getApplicationContext() , size +"", Toast.LENGTH_LONG).show();
            }
        });
        img_txt_minse.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                txt_card.setTextSize(TypedValue.COMPLEX_UNIT_SP,size -=2);
                Toast.makeText(getApplicationContext() , size +"", Toast.LENGTH_LONG).show();
            }
        });
        //endregion


        //region text bold italy
        img_txt_bold.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (click  && !Iclick){
                    txt_card.setTypeface(null , Typeface.BOLD_ITALIC);
                 //   bind.btnBold.setTypeface(null , Typeface.BOLD);
                    click = false;
                }
                else if (click  && Iclick ){
                    txt_card.setTypeface(null , Typeface.BOLD);
                   // bind.btnBold.setTypeface(null , Typeface.BOLD);
                    click = false;
                }
                else if (!click && !Iclick){
                    txt_card.setTypeface(null , Typeface.ITALIC);
                   // bind.btnBold.setTypeface(null , Typeface.NORMAL);
                    click = true;
                }
                else {

                    txt_card.setTypeface(null , Typeface.NORMAL);
                  //  bind.btnBold.setTypeface(null , Typeface.NORMAL);
                    click = true;
                }
            }
        });

        img_txt_italy.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                if (Iclick && !click) {
                    txt_card.setTypeface(null , Typeface.BOLD_ITALIC);
                 //   bind.btnItaly.setTypeface(Typeface.MONOSPACE , Typeface.ITALIC);
                    Iclick = false;

                }
                else if (Iclick && click) {
                    txt_card.setTypeface(null , Typeface.ITALIC);
                 //   bind.btnItaly.setTypeface(Typeface.MONOSPACE , Typeface.ITALIC);
                    Iclick = false;

                }
                else if (!Iclick && !click) {
                    txt_card.setTypeface(null , Typeface.BOLD);
               //     bind.btnItaly.setTypeface(Typeface.MONOSPACE , Typeface.NORMAL);
                    Iclick = true;

                }
                else {

                    txt_card.setTypeface(null , Typeface.NORMAL);
               //     bind.btnItaly.setTypeface(Typeface.MONOSPACE , Typeface.NORMAL);
                    Iclick = true;
                }

            }
        });
        //endregion


    }



    void iniView(){
        toolbar = (Toolbar) findViewById(R.id.toolbar);
        fab = (FloatingActionButton) findViewById(R.id.fab);
        img_txt_clr = (ImageView) findViewById(R.id.img_txt_clr);
        img_bg_clr = (ImageView) findViewById(R.id.img_bg_clr);
        img_txt_pluse = (ImageView) findViewById(R.id.img_txt_pluse);
        img_txt_minse = (ImageView) findViewById(R.id.img_txt_minse);
        img_txt_bold = (ImageView) findViewById(R.id.img_txt_bold);
        img_txt_italy = (ImageView) findViewById(R.id.img_txt_italy);
        txt_card = (EditText) findViewById(R.id.txt_card);

    }

    //region image manipulation and share
    private Bitmap getTransparentBitmapCopy(Bitmap source)
    {
        int width =  source.getWidth();
        int height = source.getHeight();
        Bitmap copy = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
        int[] pixels = new int[width * height];
        source.getPixels(pixels, 0, width, 0, 0, width, height);
        copy.setPixels(pixels, 0, width, 0, 0, width, height);
        return copy;
    }

    public void share_bitMap_to_Apps(Bitmap bitmap) {

        Intent i = new Intent(Intent.ACTION_SEND);

        i.setType("image/*");

        i.putExtra(Intent.EXTRA_STREAM, getImageUri(getApplicationContext(), bitmap));



        try {
            startActivity(Intent.createChooser(i, "My Profile ..."));
        } catch (android.content.ActivityNotFoundException ex) {

            ex.printStackTrace();
        }


    }

    public Uri getImageUri(Context inContext, Bitmap inImage) {
        ByteArrayOutputStream bytes = new ByteArrayOutputStream();
        inImage.compress(Bitmap.CompressFormat.JPEG, 100, bytes);
        Date currentDate = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        String formattedDate = dateFormat.format(currentDate);
        String path = MediaStore.Images.Media.insertImage(inContext.getContentResolver(), inImage,  formattedDate, "Created By Creative Status App");


        return Uri.parse(path);
    }
    //endregion

    //region fragment color
    @Override
    public void onColorSelected(int dialogId, @ColorInt int color) {
        switch (dialogId) {
            case DIALOG_ID:
                // We got result from the dialog that is shown when clicking on the icon in the action bar.
                //    Toast.makeText(MainActivity.this, "Selected Color: #" + Integer.toHexString(color), Toast.LENGTH_SHORT).show();
                switch (A){
                    case 1:{
                        txt_card.setTextColor(color);
                        break;
                    }
                    case 2:{
                        txt_card.setBackgroundColor(color);
                        break;
                    }
                }


                break;
        }
    }

    @Override
    public void onDialogDismissed(int dialogId) {

    }
    //endregion


    //region isStoragePermissionGranted
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if(grantResults[0]== PackageManager.PERMISSION_GRANTED){
            Log.v(TAG,"Permission: "+permissions[0]+ "was "+grantResults[0]);
            //resume tasks needing this permission
        }
    }


    public  boolean isStoragePermissionGranted() {
        if (Build.VERSION.SDK_INT >= 23) {
            if (checkSelfPermission(android.Manifest.permission.WRITE_EXTERNAL_STORAGE)
                    == PackageManager.PERMISSION_GRANTED) {
                Log.v(TAG,"Permission is granted");
                return true;
            } else {

                Log.v(TAG,"Permission is revoked");
                ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE}, 1);
                return false;
            }
        }
        else { //permission is automatically granted on sdk<23 upon installation
            Log.v(TAG,"Permission is granted");
            return true;
        }
    }
    //endregion



    //region local database
    public void WriteToDB(final String txt){
try {
    realms.executeTransactionAsync(new Realm.Transaction() {
        @Override
        public void execute(Realm realm) {
            TextCard obj = realm.createObject(TextCard.class);
            obj.text = txt;
        }
    }, new Realm.Transaction.OnSuccess() {
        @Override
        public void onSuccess() {
            Toast.makeText(getApplicationContext(),"Add..." , Toast.LENGTH_LONG).show();

        }
    }, new Realm.Transaction.OnError() {
        @Override
        public void onError(Throwable error) {
            Log.d("error",error.getMessage());
        }
    });
}catch (RealmError i){
    Log.d("error",i.getMessage());
}

    }

    public String DisplayLastCard(){
        String  last_txt = "";
            long count = realms.where(TextCard.class).count();
          if (count >0) {
              TextCard obj = realms.where(TextCard.class).findAll().last();
              realms.beginTransaction();
              last_txt = obj.text;
              realms.commitTransaction();
          }
        return last_txt;
    }
    //endregion









    //endregion


    //region Main Implement
    @Override
    protected void onDestroy() {
        realms.close();

        super.onDestroy();

    }
    @Override
    public void onResume() {
        super.onResume();
    }

    @Override
    public void onPause() {
        super.onPause();
    }
    //endregion




}


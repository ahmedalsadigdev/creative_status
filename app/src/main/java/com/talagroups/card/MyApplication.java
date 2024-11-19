package com.talagroups.card;

import android.app.Application;

import io.realm.Realm;
import io.realm.RealmConfiguration;


/**
 * Created by a7med on 12/14/2017.
 */

public class MyApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        // The default Realm file is "default.realm" in Context.getFilesDir();
        // we'll change it to "myrealm.realm"

        Realm.init(this);
        RealmConfiguration config = new RealmConfiguration.Builder()
                .name("myrealm.realm")
                .deleteRealmIfMigrationNeeded()
                .build();

        Realm.setDefaultConfiguration(config);
    }
}
